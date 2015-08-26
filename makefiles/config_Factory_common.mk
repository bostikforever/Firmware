ROMFS_ROOT ?= $(PX4_BASE)/ROMFS/factory/0/

#
# Factory modules
#

#
# Minimal required module set
#
MODULES += drivers/device
MODULES += drivers/led
MODULES += drivers/stm32
MODULES += drivers/stm32/adc
MODULES += drivers/stm32/tone_alarm
MODULES += modules/systemlib
MODULES += modules/uORB
MODULES += systemcmds/boardinfo
MODULES += systemcmds/nshterm
MODULES += systemcmds/reboot
MODULES += systemcmds/ver

#
# Transitional support - add commands from the NuttX export archive.
#
# In general, these should move to modules over time.
#
# Each entry here is <command>.<priority>.<stacksize>.<entrypoint> but we use a helper macro
# to make the table a bit more readable.
#
define _B
	$(strip $1).$(or $(strip $2),SCHED_PRIORITY_DEFAULT).$(or $(strip $3),CONFIG_PTHREAD_STACK_DEFAULT).$(strip $4)
endef

#                  command                 priority                   stack  entrypoint
BUILTIN_COMMANDS := \
	$(call _B, sercon,                 ,                          2048,  sercon_main                ) \
	$(call _B, serdis,                 ,                          2048,  serdis_main                )