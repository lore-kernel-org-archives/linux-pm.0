From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 00/40]
Date: Mon, 30 May 2016 14:27:19 -0700
Message-ID: <1464643679-2733-1-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Folks,

This is V2 of a patch series to improve thermal core. The idea
here is to reorganize the code and improve the way we
handle sysfs entries.

The change in behavior is that now, thermal zones with empty
.type will not be allowed to be registered. Also, the way
we handle scanf's return code is now checking for
number of successful inputs.

After this series, thermal core is split into the following files:
- thermal_sysfs.c: contains the functions handling the sysfs nodes
- thermal_helpers.c: groups functions that do not need to touch thermal
core internal data structures, such as internal lists, and list locks.
- thermal_core.c: functions to handle the lifecycle of the subsystem,
its governors, cooling devices, thermal zone devices, and their
interactions.

I don't expect any impact on userspace.

Please give your inputs.

V1->V2:
- Removed all checkpatch issues in the existing code that was
moved/changed.

Rui, it would be great if you could review these earlier. I will be
sending two extra patch series on top of this one.

BR,

Eduardo Valentin (40):
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

 drivers/thermal/Makefile          |    3 +-
 drivers/thermal/thermal_core.c    | 1279 ++++++++-----------------------------
 drivers/thermal/thermal_core.h    |   26 +
 drivers/thermal/thermal_helpers.c |  144 +++++
 drivers/thermal/thermal_sysfs.c   |  749 ++++++++++++++++++++++
 include/linux/thermal.h           |    2 +
 6 files changed, 1194 insertions(+), 1009 deletions(-)
 create mode 100644 drivers/thermal/thermal_helpers.c
 create mode 100644 drivers/thermal/thermal_sysfs.c

-- 
2.1.4
