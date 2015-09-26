From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/6] thermal: documentation update
Date: Sat, 26 Sep 2015 15:05:07 -0700
Message-ID: <1443305111-28272-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1443305111-28272-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:4616 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932491AbbIZWFm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 26 Sep 2015 18:05:42 -0400
In-Reply-To: <1443305111-28272-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: jic23@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Added description for thermal_zone_device_update, which is
already used by thermal core and client drivers.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/thermal/sysfs-api.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index 10f062e..16770f0 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -494,3 +494,13 @@ platform data is provided, this uses the step_wise throttling policy.
 This function serves as an arbitrator to set the state of a cooling
 device. It sets the cooling device to the deepest cooling state if
 possible.
+
+5.5:thermal_zone_device_update:
+This function is used by thermal core and thermal client drivers to trigger
+temperature read and governor specific processing for thermal trip violation.
+Using event type parameter, the caller can specify the reason for this call.
+This reason can be
+THERMAL_DEVICE_EVENT_NONE for unspecified reason
+THERMAL_DEVICE_EVENT_THRESHOLD for temp threshold event
+THERMAL_DEVICE_EVENT_TEMP_SAMPLE for new temperature sample notification
+THERMAL_DEVICE_TRIP_TEMP_CHANGE for notifying trip point temperature change
-- 
2.4.3

