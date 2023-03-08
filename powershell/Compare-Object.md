# Compare-Object 

Compare-Object compares two sets of objects and returns the differences between them. 

The output of Compare-Object has two main properties: InputObject and SideIndicator.

## InputObject

This property contains the objects being compared. 
When comparing two sets of objects, 
the InputObject property will contain the objects from the reference set.

## SideIndicator

This property contains a character indicating whether an object is 
in the reference set (<=) or the difference set (=>). 

If an object is in both sets, it will have an == side indicator.

## Additional Properties

Additional properties can be included in the output of 
Compare-Object by using the -Property parameter. 

For example, when comparing two sets of files using the -Property Hash parameter, 
the output of Compare-Object will include a Hash property with the hash value of each file.


# Example

Suppose hashes_evidence.csv is as follows.

```
"BaseName","Hash"
"file_1","759808B727295AD2E8AEA7C22BDC709DB78487511C9FB1190A26433E1E7D11BF"
"file_2","2A1DAC963980DC655AA0248727028553FBEEC2BC809E2B1D4196EEA50C3DD7E2"
"file_3","336E551FC3A5E0EDFE92D481ACC6F89AABA6AD047AC547F70C0C20CEFF146DB4"
"file_4","8E57338BFA01B26951CFAA8564999E748FAA956B64131A9788D3BB95B31D6584"
"file_5","142793A5181833C9E72DA6D797ACA765743A03019E5E5D79CB8118B79308E4B5"


```

After comparing, recheck-diff.csv (with a difference detected in file_1) might be as follows.

Note the side indicators in the output. 
There are two lines for each difference (one for each side of the equality).

```
"Hash","BaseName","SideIndicator"
"5D04ABD1FAE18B138D1571086E1ABCDAAEE4034F1B552EFF9A831BD0EB96AB4E","file_1","=>"
"759808B727295AD2E8AEA7C22BDC709DB78487511C9FB1190A26433E1E7D11BF","file_1","<="
```

