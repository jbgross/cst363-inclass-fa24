package heapdb;

import java.nio.ByteBuffer;

import java.util.ArrayList;
import java.util.List;

import static heapdb.Constants.MAX_COLUMN_NAME_LENGTH;

public class Schema {

	/*
	 * Lists of column names, data types. a key column is optional.
	 */
	private List<IType> columns;
	String key; // key column (null if there is no key)

	/*
	 * Create schema with no key
	 */
	public Schema() {
		columns = new ArrayList<>();
		key = null;
	}

	/**
	 * add a varchar type column
	 * 
	 * @param column name
	 */
	public void addVarCharType(String fname, int max_size) {
		if (fname.length() > MAX_COLUMN_NAME_LENGTH) {
			throw new IllegalArgumentException(
					"column name " + fname + " is more than " + MAX_COLUMN_NAME_LENGTH + " in length");
		}
		TypeVarchar column = new TypeVarchar(fname, max_size);
		columns.add(column);
	}

	/**
	 * add a varchar type column that is also the primary key
	 * 
	 * @param column name
	 */
	public void addKeyVarCharType(String fname, int max_size) {
		addVarCharType(fname, max_size);
		key = fname;
	}

	/**
	 * add an int type column
	 * 
	 * @param column name
	 */
	public void addIntType(String fname) {
		TypeInt column = new TypeInt(fname);
		columns.add(column);
	}

	/**
	 * add an int type column that is also the primary key
	 * 
	 * @param column name
	 */
	public void addKeyIntType(String fname) {
		addIntType(fname);
		key = fname;
	}

	/**
	 * Return the column name of the key. Null if there is no key.
	 */
	public String getKey() {
		return key;
	}

	/**
	 * Return the index of the column with the given name or -1 if the column name
	 * does not exist in schema.
	 * 
	 * @param column name
	 */
	public int getColumnIndex(String fname) {
		for (int i=0; i<columns.size(); i++) {
			if (columns.get(i).getColumnName().equals(fname)) return i;
		}
		return -1;
	}

	/**
	 * Return the type of the ith field.
	 * 
	 * @param i
	 */
	public IType getType(int i) {
		return columns.get(i);
	}

	/**
	 * return the name of the ith column
	 * 
	 * @param i
	 */
	public String getName(int i) {
		if (i < 0 || i >= columns.size()) {
			throw new IllegalArgumentException("No field i in schema: " + this);
		}
		return columns.get(i).getColumnName();
	}
	
	/**
	 * return the max size of the column
	 */
	public int getMaxSQLSize(int i) {
		
		return columns.get(i).getMaxSQLLength();
	}

	/**
	 * Return the number of columns in the schema
	 */
	public int size() {
		return columns.size();
	}
	
	public int getTupleSizeInBytes() {
		int size = 0;
		for (IType t : columns) {
			size=size+t.getMaxSizeBytes();
		}
		return size;
	}

	/**
	 * return Schema containing a projection of the given list of columns.
	 * 
	 * @param attrs is array of columns names to project.
	 */
	public Schema project(String[] attrs) {
		Schema result = new Schema();
		for (int i = 0; i < attrs.length; i++) {
			int k = getColumnIndex(attrs[i]);
			if (k < 0) {
				throw new IllegalArgumentException("Error: No such column in Schema " + attrs[i]);
			}
			result.columns.add(this.getType(k));
		}
		return result;
	}

	/**
	 * Return a Schema that is the schema for a natural join of this schema and the
	 * given schema. The returned Schema contains all the columns of this schema
	 * plus those column which are unique to schema s. The returned schema has no
	 * key.
	 * 
	 * @param schema
	 */
	public Schema naturaljoin(Schema s) {
		// copy columns from this schema to new schema
		Schema result = new Schema(); // result schema has no key
		for (int i = 0; i < columns.size(); i++) {
			result.columns.add(this.columns.get(i));
		}
		// add columns from schema s that are not already in result
		for (int i = 0; i < s.columns.size(); i++) {
			if (this.columns.contains(s.columns.get(i)))
				continue;
			result.columns.add(s.columns.get(i));
		}
		return result;
	}

	/*-
	 * Serialize this schema to the given byte buffer
	 * 
	 * each column entry is written to buffer as series of bytes as follows
	 * 4 bytes integer length of column name 
	 * bytes[]  column name 
	 * 4 bytes integer value of column data type 
	 * 4 bytes integer 1=primary key, 0=not 
	 */
	public void serialize(ByteBuffer byte_buffer) {
		// serialize schema as tuple (name varchar, type int, isKey int 0=no, 1=yes)
		for (int i = 0; i < columns.size(); i++) {
			IType column = columns.get(i);
			byte_buffer.putInt(column.getColumnName().length());
			byte_buffer.put(column.getColumnName().getBytes());
			byte_buffer.putInt(column.getInternalType());
			byte_buffer.putInt(column.getMaxSQLLength());
			if (key == null || !column.getColumnName().equals(key))
				byte_buffer.putInt(0);
			else
				byte_buffer.putInt(1);
		}

	}

	/**
	 * Create a schema from the given binary data at the current position of the
	 * ByteBuffer.
	 * 
	 * @param byte buffer
	 */
	public static Schema deserialize(ByteBuffer byte_buffer) {
		Schema s = new Schema();
		while (byte_buffer.position() < byte_buffer.limit()) {
			int slen = byte_buffer.getInt();
			byte[] bytes = new byte[slen];
			byte_buffer.get(bytes);
			String columnName = new String(bytes);
			int type = byte_buffer.getInt();
			int size = byte_buffer.getInt();
			int isKey = byte_buffer.getInt();
			IType column;
			switch(type) {
			case 1:
				column = new TypeInt(columnName);
				break;
			case 2:
				column = new TypeVarchar(columnName, size);
				break;
			default:
				throw new RuntimeException("Invalid type reading schema from block 0.");
			}
			s.columns.add(column);		
			if (isKey == 1) {
				s.key = columnName;
			}
		}
		return s;
	}

	@Override
	public String toString() {
		StringBuilder s = new StringBuilder("[");
		for (int i = 0; i < columns.size(); i++) {
			s.append(columns.get(i).getColumnName());
			s.append(" ");
			s.append(columns.get(i).getExternalName());
			if (key !=null && columns.get(i).getColumnName().equals(key)) {
				s.append(" PRIMARY KEY");
			}
			if (i < columns.size() - 1)
				s.append(", ");
		}
		s.append("]");
		return s.toString();
	}

}
