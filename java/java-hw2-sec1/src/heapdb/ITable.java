package heapdb;


public interface ITable extends Iterable<Tuple> {
	
	/**
	 * Return the schema for this table.
	 */
	public Schema getSchema();
	
	/**
	 * Return count of rows in table
	 */
	public int size();
	

	/**
	 * Insert tuple to this table. 
	 * @param tuple must have same schema as table.
	 * If schema has a key, check for duplicate key.
	 * return false on duplicate key or other error.
	 * Otherwise return true.
	 */
	public boolean insert(Tuple rec);
	
	/**
	 * Delete tuple given the primary key value.
	 * Table schema must have a primary key.
	 * @param key
	 * return false if key not found or other error. 
	 * otherwise return true.
	 */
	public boolean delete(Object key);
	
	/**
	 * Return the tuple in the table having the primary key value. 
	 * Return null if no such record found.
	 * @param key
	 */
	public Tuple lookup(Object key);
	
	/**
	 * Return a subset of tuples from this table 
	 * that satisfy the predicate "colname = value"
	 * @param name of column
	 * @param column value  
	 */
	public ITable lookup(String colname, Object value);
	
	/**
	 * For implementation that have a file backed table, 
	 * flush buffers to disk and close file.
	 */
	public void close();
	
}
