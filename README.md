# RISC OS UUID module

## Introduction

The UUID module provides a means of generating 'Universally Unique
Identifiers' in a number of forms. These identifiers are statistically
likely to be uniquely assigned without requiring a central registration
database. Identifiers are usually written in the form :

    f81d4fae-7dec-11d0-a765-00a0c91e6bf6

The use of UUIDs has been standardised through a URN namespace 'uuid',
thus :

    urn:uuid:f81d4fae-7dec-11d0-a765-00a0c91e6bf6

It is common that UUIDs be held within applications using them as a binary
block defining their value. This block is 128 bits long (16 bytes). The
block format and more information about UUIDs can be found within RFC4122.


## Interface
Since there are three major representations which the UUID may take, these
are supported within the module by a 'representation' type :

| Type |  Meaning |
|------|----------|
|  0   | Binary data block (16 bytes) |
|  1   | Zero-terminated regular string (37 bytes) |
|  2   | Zero-terminated RFC4122 URN string (46 bytes) |

There are a number of means by which a UUID may be generated. The most
common form is that of a time-based identifier. This version of UUID uses a
time sequence, and the MAC address of the system upon which the module is
running. Should a MAC address be unavailable, a random number will be used
in its place. This version of UUID requires no further information be
supplied by the user.

Namespace-based UUIDs may be generated for use with certain applications. 
This allows UUIDs to be assigned within a given namespace and thus allows
particular tools or applications with given names to be uniquely
identifiable. In this form, the UUID is effectively a hash within the UUID
space. Two forms of namespace UUIDs may be used - those that use MD5 and
those that use SHA1.

The full list of the UUID versions which can be generated is as follows :

|  Version  | Meaning |
|-----------|---------|
|    1      | Time-based UUID |
|    2      | DCE Security (not supported by this module) |
|    3      | Namespace based UUID, using MD5 hashing |
|    4      | Random UUID (not supported by this module) |
|    5      | Namespace based UUID, using SHA1 hashing |


## SWIs

`UUID_Convert` (&582C0)

*Converts between Universally Unique Indentifier representations*

On entry:

* `R0` = input representation type
* `R1` = pointer to input representation data
* `R2` = output representation type
* `R3` = pointer to output representation data

This SWI is used to convert between the representation forms of UUID. It is
intentionally similar to the MimeMap_Translate SWI. The SWI may also be
used to perform a syntax check on the string-representation UUIDs.


`UUID_Create` (&582C1)

*Creates a new Universally Unique Identifier*


On entry:
* `R0` = flags :
  b0-4 = output representation type
  b4-7 = UUID version to create
* `R1` = pointer to block to fill with output data
* `R2` = pointer to namespace to use as a binary UUID representation, for namespace-based UUID versions
* `R3` = pointer to name to use, for namespace-based UUID versions
* `R4` = length of name, or 0 if the name is a 0-terminated string, for namespace-based UUID versions

This SWI is used to generate a new UUID.


`UUID_Compare` (&582C2)

*Compares two Universally Unique Indentifiers for equality*

On entry:
* `R0` = first UUID representation type
* `R1` = pointer to first UUID data
* `R2` = second representation type
* `R3` = pointer to second UUID data

On exit:
* `R0` = 0 for equality, -1 or +1 for lexicographic ordering

This SWI is used to compare two UUID representations for equivilence.


## System variable

The system variable `UUID$Generate` is a code variable which contains a new
UUID value, using the Time-based UUID generation algorithm, represented as a
string 36 character. This means that a client can read the variable to
obtain a new unique identifier. Clients should be aware that they must take
a copy of this variable before attempting to use it as subsequent reads will
return different values.
