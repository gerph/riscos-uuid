# Makefile for UUID
#

#
# Program specific options:
#
COMPONENT  = UUID
EXPORTS    = ${EXP_C_H}.${COMPONENT}
RESOURCES  = 
LIBS       = \
             ${ASMLIB_ZM} \
             ${LONGLONGLIB_ZM} \
             <Lib$Dir>.MD5.o.libMD5zm \
             <Lib$Dir>.SHA1.o.libSHA1zm
INCLUDES   = <Lib$Dir>.Asm.,<Lib$Dir>.LongLong.,<Lib$Dir>.MD5.,<Lib$Dir>.SHA1.
CDEFINES   = 
OBJS       = \
             o.modhead \
             o.sysdep \
             o.uuid \
             o.vars \
             o.veneer

# FORTIFY = yes
FORTIFY = no
             
include CModule

${OZDIR}.veneer: h.modhead

${EXP_C_H}.${COMPONENT}: h.uuidmod h.modhead
       ${MERGEMODSWIS} h.modhead h.uuidmod $@

#---------------------------------------------------------------------------
# Dynamic dependencies:
