package heapdb;

import java.nio.ByteBuffer;

public class TypeInt implements IType {
	
	private String columnName;
	
	public TypeInt(String name) {
		this.columnName = name;
	}

	@Override
	public String getColumnName() {
		return columnName;
	}

	@Override
	public int getMaxSizeBytes() {
		return 4;
	}
	
	@Override
	public int getMaxSQLLength() {
		return 4;
	}

	
	@Override
	public String getExternalName() {
		return "int";
	}
	
	@Override
	public int getInternalType() {
		return 1;
	}
	
	@Override
	public Object readValue(ByteBuffer buffer) {
		return buffer.getInt();
	}
	
	@Override
	public void writeValue(Object value, ByteBuffer buffer) {
		int ivalue = (int)value;
		buffer.putInt(ivalue);		
	}
	
	@Override
	public boolean equals(Object obj) {
		if (obj instanceof TypeInt) {
			TypeInt other = (TypeInt)obj;
			return other.columnName.equals(this.columnName);
		}
		return false;
	}

}
