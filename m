From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 0/6] ACPI bus conversion
Date: Wed, 25 Sep 2013 20:39:44 +0800
Message-ID: <1380112790-2321-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi,

Currently, all the ACPI device objects are enumerated in ACPI bus.
Some of them are used as real devices, while some of them are used
as shadow devices.

This is misleading and confusing because we have several instances
in Linux driver model for a single device.
So Rafael proposed to stop using ACPI as a shadow bus.
To do this, we need to:
1. for the devices that already have physical nodes, just leave them
   as they are today.
2. for the devices that are not associated with any physical nodes,
   make them platform bus devices.
3. create the sysfs subtree of ACPI objects under /sys/firmware/acpi/
4. remove ACPI bus from driver model.

This patch set, which converts two different kinds of ACPI
devices/drivers to platform bus, is an experimentation of Step 2 above.
And in general, so far so good. I do not see anything can really stuck
us so far, although I do get a couple of problems when converting
the ideapad_laptop driver and rewrite the patches for a few times.

I've tested the patches on an Lenovo U300s, which has a VPC2004 device.
Both the AC adapter and the ideapad_laptop drivers work well.
They are shown in platform bus, and their sysfs/debugfs work well.

thanks,
rui

-----------------------------------------------------------------------
 drivers/acpi/ac.c                     |  163 ++++++++--------
 drivers/acpi/acpi_platform.c          |    3 +-
 drivers/platform/x86/ideapad-laptop.c |  344 ++++++++++++++++++---------------
 3 files changed, 266 insertions(+), 244 deletions(-)

