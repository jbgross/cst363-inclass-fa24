package heapdb;

import java.nio.ByteBuffer;

public class Tuple {
	
	protected Object[] values;
	protected Schema schema;    
	
	/**
	 * Create a tuple given a schema and column values.
	 * @param schema
	 * @param values
	 */
	public Tuple(Schema schema, Object ...values) {
		if (values.length != schema.size()) {
			throw new IllegalArgumentException("Error: Number of values does not match size of schema.");
		}
		this.schema = schema;
		this.values = new Object[schema.size()];
		for (int k=0; k<values.length; k++) {
			set(k, values[k]); 
		}
		
	}
	
	/**
	 * Create a tuple with null values for all columns.
	 * @param schema
	 */
	public Tuple(Schema schema) {
		this.schema = schema;
		this.values = new Object[schema.size()];
	}
	
	/**
	 * Copy constructor
	 */
	public Tuple(Tuple rec) {
		this.schema=rec.schema;
		this.values = new Object[schema.size()];
		for (int k=0; k<schema.size(); k++) {
			this.values[k] = rec.values[k];
		}
	}
	
	/**
	 * Based on the schema for the joined table
	 * return a join of the given tuples
	 */
	public static Tuple joinTuple(Schema s, Tuple t1, Tuple t2) {
		Tuple r = new Tuple(s);
		int t1size = t1.getSchema().size();
		for (int k=0; k<s.size(); k++) {
			if (k<t1size) {
				r.values[k]=t1.values[k];
			} else {
				r.values[k]=t2.get(s.getName(k));
			}
		}
		return r;
	}
	
	/**
	 * get the schema of this tuple
	 */
	public Schema getSchema() {
		return schema;
	}
	
	/**
	 * Return the value of the ith column  i=0, 1, . . .   
	 */
	public Object get(int i) {	
		if (i < 0 || i > schema.size()) {
			throw new IllegalArgumentException("Error: invalid column index. "+i);
		}
		return values[i];
	}
	
	/**
	 * Return the integer value of the ith column    
	 */
	public int getInt(int i) {	
		Object value = get(i);
		
		if (! (schema.getType(i) instanceof TypeInt)) {
			throw new IllegalArgumentException("Error: invalid column type. "+i);
		}
		return (int)value;
	}
	
	/**
	 * Return the String value of the ith column    
	 */
	public String getString(int i) {	
		Object value = get(i);
		
		if (!(schema.getType(i) instanceof TypeVarchar)) {
			throw new IllegalArgumentException("Error: invalid column type. "+i);
		}
		return (String)value;
	}
	
	/**
	 * Return the value of column by column name 
	 */
	public Object get(String name) {
		int i = schema.getColumnIndex(name);
		if (i < 0) {
			throw new IllegalArgumentException("Error: invalid column name. "+name);
		}
		return get(i);
	}
	
	/**
	 * Set the value of the ith column 
	 */
	public void set(int i, Object value) {
		if (i < 0 || i >= schema.size()) {
			throw new IllegalArgumentException("Error: column index out of bounds.");
		}
		if (schema.getType(i) instanceof TypeVarchar && ((String)value).length() > (schema.getMaxSQLSize(i))) {
				throw new RuntimeException("String too long. ");
		}
		values[i] = value;
	}
	
	/**
	 * Return the value of the key column.
	 * key is single column value
	 */
	public Object getKey() {
		return get(schema.getKey());
	}
	
	/** 
	 * Return subset of column values based on column names in schema.
	 */
	public Tuple project(Schema schema) {
		Object[] values = new Object[schema.size()];
		for (int i=0; i<schema.size(); i++) {
			values[i] = this.values[this.schema.getColumnIndex(schema.getName(i))];
		}
		Tuple result = new Tuple(schema);
		result.values = values;
		return result;
	}
	
	/**
	 * read the buffer and return a Tuple.
	 */
	public static Tuple deserialize(Schema schema, ByteBuffer byte_buffer) {
		Tuple t = new Tuple(schema);
		for (int icol=0; icol < schema.size(); icol++) {
			t.set(icol,  schema.getType(icol).readValue(byte_buffer));
		}
		return t;
	}
	
	/**
	 * write this tuple to the buffer.
	 */
	public void serialize(ByteBuffer byte_buffer) {
		for (int icol=0; icol<schema.size(); icol++) {
			schema.getType(icol).writeValue(values[icol], byte_buffer);
		}
	}
	
	
	/**
	 * Return a printable string from this tuple
	 */
	@Override
	public String toString() {
		StringBuilder s = new StringBuilder("[");
		for (int i=0; i<values.length; i++) {
			s.append(values[i].toString());
			if (i < values.length-1) s.append(", ");
		}
		s.append("]");
		return s.toString();
	}
}
