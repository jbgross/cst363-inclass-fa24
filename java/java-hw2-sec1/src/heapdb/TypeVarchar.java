package heapdb;

import java.nio.ByteBuffer;

public class TypeVarchar implements IType {
	
	private String columnName;
	private int maxSize;
	
	public TypeVarchar(String name, int max_size) {
		this.columnName = name;
		this.maxSize = max_size;		
	}
	
	@Override
	public String getColumnName() {
		return columnName;
	}
	
	@Override
	public int getMaxSizeBytes() {
		return maxSize+4;
	}
	
	@Override
	public int getMaxSQLLength() {
		return maxSize;
	}
	
	
	@Override
	public String getExternalName() {
		return "varchar("+maxSize+")";
	}
	
	@Override
	public int getInternalType() {
		return 2;
	}
	
	@Override
	public Object readValue(ByteBuffer buffer) {
		int strlen = buffer.getInt();  // string length
		byte[] bytes = new byte[strlen];
		buffer.get(bytes);
		String s = new String(bytes);
		// skip over string padding
		int pad_size = maxSize-strlen;
		if (pad_size > 0) buffer.position(buffer.position()+pad_size);
		return s;
	}
	
	@Override
	public void writeValue(Object value, ByteBuffer buffer) {
		String svalue = (String)value;
		buffer.putInt(svalue.length());
		buffer.put(svalue.getBytes());
		// pad to max length
		int pad = maxSize-svalue.length();
		if (pad>0) buffer.position(buffer.position()+pad);
	}
	
	@Override
	public boolean equals(Object obj) {
		if (obj instanceof TypeVarchar) {
			TypeVarchar other = (TypeVarchar)obj;
			return other.columnName.equals(this.columnName) && other.maxSize==this.maxSize;
		}
		return false;
	}

}
