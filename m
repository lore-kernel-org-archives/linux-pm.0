From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 00/49] thermal: reorganizing thermal core
Date: Mon,  7 Nov 2016 21:08:38 -0800
Message-ID: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33591 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbcKHFJe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Nov 2016 00:09:34 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Folks, Rui,

After some radio silence time, here is a refreshed series of patches
of the thermal sysfs code refactoring.

The only change in behavior is that now, thermal zones with empty
.type will not be allowed to be registered.

After this series, thermal core is split into the following files:
- thermal_sysfs.c: contains the functions handling the sysfs nodes
- thermal_helpers.c: groups functions that do not need to touch thermal
core internal data structures, such as internal lists, and list locks.
- thermal_core.c: functions to handle the lifecycle of the subsystem,
its governors, cooling devices, thermal zone devices, and their
interactions.

Most of these changes are moving code. Because of that some patches
may have checkpatch.pl warns, but I believe they are existing warns.

I don't expect any impact on userspace.

I intentionally avoided sending the locking rework. I noticed that
it will require further analysis, as many drivers have stronger
dependency with the tz->lock, and therefore, would need to be
carefully reworked.

As for the testing aspect of this series, I have compile tested and
boot tested using a x86 laptop, an OMAP4 panda device, and with help
from Keerthy, a DRA7 device. The testing was done to check if the sysfs
nodes were still working. On top of that I have also boot tested
different devices using kernel CI infrastructure and the 0-day testing.

BR,

Eduardo Valentin (49):
  thermal: core: prevent zones with no types to be registered
  thermal: core: group thermal_zone DEVICE_ATTR's declarations
  thermal: core: group device_create_file() calls that are always
    created
  thermal: core: use dev.groups to manage always present tz attributes
  thermal: core: move emul_temp creation to tz->device.groups
  thermal: core: move mode attribute to tz->device.groups
  thermal: core: move passive attr to tz->device.groups
  thermal: core: improve power actor documentation
  thermal: core: move power actor code out of sysfs I/F section
  thermal: core: remove useless empty line
  thermal: core: fix style on remove_trip_attrs()
  thermal: core: move the trip attrs to the tz sysfs I/F section
  thermal: core: create tz->device.groups dynamically
  thermal: core: move trips attributes to tz->device.groups
  thermal: core: remove unnecessary device_remove() calls
  thermal: core: split passive_store
  thermal: core: split policy_store
  thermal: core: split available_policies_show()
  thermal: core: move to_thermal_zone() macro to header file
  thermal: core: treat correctly the return value of *scanf calls
  thermal: core: match parenthesis on code alignment
  thermal: core: move thermal_zone sysfs to thermal_sysfs.c
  thermal: core: move to_cooling_device macro to header file
  thermal: core: move cooling device sysfs to thermal_sysfs.c
  thermal: core: remove a couple of style issues on helpers
  thermal: core: introduce thermal_helpers.c
  thermal: core: group functions related to governor handling
  thermal: core: move idr handling to device management section
  thermal: core: small style fix on __unbind() helper
  thermal: core: move __unbind() helper to where it is used
  thermal: core: move bind_cdev() to where it is used
  thermal: core: move bind_tz() to where it is used
  thermal: core: fix couple of style issues on __bind() helper
  thermal: core: move __bind() to where it is used
  thermal: core: add inline to print_bind_err_msg()
  thermal: core: move notify to the zone update section
  thermal: core: add a comment describing the main update loop
  thermal: core: add a comment describing the power actor section
  thermal: core: add a comment describing the device management section
  thermal: sysfs: remove symbols of emul_temp when config is disabled
  thermal: core: remove FSF address in the GPL notice
  thermal: core: small style fix when checking for __find_governor()
  thermal: core: standardize line breaking alignment
  thermal: core: remove void function return statements
  thermal: core: remove style warnings and checks
  thermal: core: improve kerneldoc entry of
    thermal_cooling_device_unregister
  thermal: core: use kzalloc(sizeof(*ptr),...)
  thermal: sysfs: use kcalloc() instead of kzalloc()
  thermal: core: move slop and offset helpers to thermal_helpers.c

 drivers/thermal/Makefile          |    3 +-
 drivers/thermal/thermal_core.c    | 1446 ++++++++-----------------------------
 drivers/thermal/thermal_core.h    |   26 +
 drivers/thermal/thermal_helpers.c |  226 ++++++
 drivers/thermal/thermal_sysfs.c   |  771 ++++++++++++++++++++
 include/linux/thermal.h           |    2 +
 6 files changed, 1334 insertions(+), 1140 deletions(-)
 create mode 100644 drivers/thermal/thermal_helpers.c
 create mode 100644 drivers/thermal/thermal_sysfs.c

-- 
2.1.4

