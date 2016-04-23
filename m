From: Eduardo Valentin <edubezval@gmail.com>
Subject: [RFC PATCH 00/11] thermal: sysfs rework
Date: Sat, 23 Apr 2016 16:34:19 -0700
Message-ID: <1461454470-27714-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33213 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbcDWXep (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 23 Apr 2016 19:34:45 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Hello Linux PM, Rui,

This is a series of patches for review. In this series I am proposing
to rework how we do sysfs, mainly for thermal zone attributes.

Currently, as many features have been added recently, there are more
than one way of attribute handling. This series is an attempt to
standardize the sysfs handling. Essentially, this will move all
attributes to the dev.groups field, so sysfs core code handles the
attributes properly. Apart from the obvious code organization benefit,
this change should also take care properly of attribute destruction,
when thermal zones are removed. 

The cooling device attributes are more or less handled in this manner.
But they still require some piece of rework. In this series, I am not
touching them yet.

I don't expect any impact on userspace.

The only change in behavior is that now, thermal zones with empty
.type will not be allowed to be registered. 

Please give your inputs. 

BR,

Eduardo Valentin
------
Eduardo Valentin (11):
  thermal: prevent zones with no types to be registered
  thermal: group thermal_zone DEVICE_ATTR's declarations
  thermal: group device_create_file() calls that are always created
  thermal: use dev.groups to manage always present tz attributes
  thermal: move emul_temp creation to tz->device.groups
  thermal: move mode attribute to tz->device.groups
  thermal: move passive attr to tz->device.groups
  thermal: move power actor code out of sysfs I/F section
  thermal: move the trip attrs to the tz sysfs I/F section
  thermal: create tz->device.groups dynamically
  thermal: move trips attributes to tz->device.groups

 drivers/thermal/thermal_core.c | 549 ++++++++++++++++++++++-------------------
 include/linux/thermal.h        |   2 +
 2 files changed, 295 insertions(+), 256 deletions(-)

-- 
2.1.4

