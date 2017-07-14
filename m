From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH 0/2] User-friendly description for thermal zones
Date: Fri, 14 Jul 2017 11:48:53 -0600
Message-ID: <1500054535-975-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: rui.zhang@intel.com, edubezval@gmail.com, Prashanth Prakash <pprakash@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

ACPI 6.2 spec allows a _STR(string) object to be defined under a thermal
zone optionally, which return a string name/description for that thermal
zone. See section 11.4 of ACPI spec 6.2 for more details.

This series adds support to read the _STR object under a thermal zone and
expose it to the userspace via sysfs interface.


Prashanth Prakash (2):
  thermal: add a sysfs entry for thermal zone description
  ACPI/thermal: support for thermal zone description

 Documentation/thermal/sysfs-api.txt |  6 ++++++
 drivers/acpi/thermal.c              | 38 +++++++++++++++++++++++++++++++++++++
 drivers/thermal/thermal_sysfs.c     | 19 +++++++++++++++++++
 include/linux/thermal.h             |  4 ++++
 4 files changed, 67 insertions(+)

-- 
Qualcomm Datacenter Technologies on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

