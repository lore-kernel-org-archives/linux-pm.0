From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 00/31] thermal: reorganizing thermal core
Date: Tue,  3 May 2016 23:02:14 -0700
Message-ID: <1462341765-13268-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35106 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbcEDGCw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 May 2016 02:02:52 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Folks,

Here is a series of patches I am proposing to add to thermal core
with the intent to have a better code organization. It started
as an RFC for sysfs handling [1]. But now, on top of the sysfs
organization, I added a code split as well.

The only change in behavior is that now, thermal zones with empty
.type will not be allowed to be registered.

After this series, thermal core is split into the following files:
- thermal_sysfs.c: contains the functions handling the sysfs nodes
- thermal_helpers.c: groups functions that do not need to touch thermal
core internal data structures, such as internal lists, and list locks.
- thermal_core.c: functions to handle the lifecycle of the subsystem,
its governors, cooling devices, thermal zone devices, and their
interactions.

I don't expect any impact on userspace.

Please give your inputs.

BR,


Eduardo Valentin (31):
  thermal: core: prevent zones with no types to be registered
  thermal: core: group thermal_zone DEVICE_ATTR's declarations
  thermal: core: group device_create_file() calls that are always
    created
  thermal: core: use dev.groups to manage always present tz attributes
  thermal: core: move emul_temp creation to tz->device.groups
  thermal: core: move mode attribute to tz->device.groups
  thermal: core: move passive attr to tz->device.groups
  thermal: core:  move power actor code out of sysfs I/F section
  thermal: core: move the trip attrs to the tz sysfs I/F section
  thermal: core: create tz->device.groups dynamically
  thermal: core: move trips attributes to tz->device.groups
  thermal: core: remove unnecessary device_remove() calls
  thermal: core: split passive_store
  thermal: core: split policy_store
  thermal: core: split available_policies_show()
  thermal: core: move to_thermal_zone() macro to header file
  thermal: core: move thermal_zone sysfs to thermal_sysfs.c
  thermal: core: move to_cooling_device macro to header file
  thermal: core: move cooling device sysfs to thermal_sysfs.c
  thermal: core: introduce thermal_helpers.c
  thermal: core: group functions related to governor handling
  thermal: core: move idr handling to device management section
  thermal: core: move __unbind() helper to where it is used
  thermal: core: move bind_cdev() to where it is used
  thermal: core: move bind_tz() to where it is used
  thermal: core: move __bind() to where it is used
  thermal: core: add inline to print_bind_err_msg()
  thermal: core: move notify to the zone update section
  thermal: core: add a comment describing the main update loop
  thermal: core: add a comment describing the power actor section
  thermal: core: add a comment describing the device management section

 drivers/thermal/Makefile          |    3 +-
 drivers/thermal/thermal_core.c    | 1313 ++++++++-----------------------------
 drivers/thermal/thermal_core.h    |   23 +
 drivers/thermal/thermal_helpers.c |  143 ++++
 drivers/thermal/thermal_sysfs.c   |  734 +++++++++++++++++++++
 include/linux/thermal.h           |    2 +
 6 files changed, 1191 insertions(+), 1027 deletions(-)
 create mode 100644 drivers/thermal/thermal_helpers.c
 create mode 100644 drivers/thermal/thermal_sysfs.c

-- 
2.1.4

