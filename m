From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/4] thermal: INT340x: common thermal zone handler
Date: Fri, 16 Jan 2015 15:59:02 -0800
Message-ID: <1421452746-2975-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38396 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751512AbbAPX77 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 16 Jan 2015 18:59:59 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

v2
Forgot to update copyright year to 2015

v1
If thermal zone device creation fails, fail the INT340x zone
creation

v0
Base version 

Srinivas Pandruvada (4):
  Thermal/int340x: Add common thermal zone handler
  Thermal/int340x/int3402: Use int340x thermal API
  Thermal/int340x/int3403: Use int340x thermal API
  Thermal/int340x/processor_thermal: Add thermal zone support

 drivers/thermal/int340x_thermal/Makefile           |   1 +
 drivers/thermal/int340x_thermal/int3402_thermal.c  | 189 +--------------
 drivers/thermal/int340x_thermal/int3403_thermal.c  | 208 +---------------
 .../thermal/int340x_thermal/int340x_thermal_zone.c | 262 +++++++++++++++++++++
 .../thermal/int340x_thermal/int340x_thermal_zone.h |  65 +++++
 .../int340x_thermal/processor_thermal_device.c     |  90 +++++++
 6 files changed, 439 insertions(+), 376 deletions(-)
 create mode 100644 drivers/thermal/int340x_thermal/int340x_thermal_zone.c
 create mode 100644 drivers/thermal/int340x_thermal/int340x_thermal_zone.h

-- 
1.9.1

