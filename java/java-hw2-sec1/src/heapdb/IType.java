package heapdb;

import java.nio.ByteBuffer;

public interface IType {
	
	String getColumnName();
	
	int getMaxSizeBytes();
	
	int getMaxSQLLength();
	
	String getExternalName();
	
	int getInternalType();
	
	Object readValue(ByteBuffer buffer);
	
	void writeValue(Object value, ByteBuffer buffer);

}
