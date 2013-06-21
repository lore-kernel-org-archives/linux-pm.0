From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [Resend PATCH] PM/Qos: Update Documentation/power/pm_qos_interface.txt
Date: Fri, 21 Jun 2013 10:09:15 +0800
Message-ID: <1371780555-13157-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:41753 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161377Ab3FUCQV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 20 Jun 2013 22:16:21 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

This patch updates new changes of PM QoS function.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
Cc linux-pm maillist

 Documentation/power/pm_qos_interface.txt |   50 +++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/Documentation/power/pm_qos_interface.txt b/Documentation/power/pm_qos_interface.txt
index 79a2a58..4836320 100644
--- a/Documentation/power/pm_qos_interface.txt
+++ b/Documentation/power/pm_qos_interface.txt
@@ -7,7 +7,7 @@ one of the parameters.
 Two different PM QoS frameworks are available:
 1. PM QoS classes for cpu_dma_latency, network_latency, network_throughput.
 2. the per-device PM QoS framework provides the API to manage the per-device latency
-constraints.
+constraints and PM QoS flags.
 
 Each parameters have defined units:
  * latency: usec
@@ -86,13 +86,17 @@ To remove the user mode request for a target value simply close the device
 node.
 
 
-2. PM QoS per-device latency framework
+2. PM QoS per-device latency and flags framework
+
+For each device, there are two lists of PM QoS requests. One is maintained
+along with the aggregated target of latency value and the other is for PM QoS
+flags. Values are updated in response to changes of the request list.
+
+Target latency value is simply the minimum of the request values held in the
+parameter list elements.  The PM QoS flags aggregate value is a gather (bitwise
+OR) of all list elements' values. Two device PM QoS flags are defined currently:
+PM_QOS_FLAG_NO_POWER_OFF and PM_QOS_FLAG_REMOTE_WAKEUP.
 
-For each device a list of performance requests is maintained along with
-an aggregated target value.  The aggregated target value is updated with
-changes to the request list or elements of the list.  Typically the
-aggregated target value is simply the max or min of the request values held
-in the parameter list elements.
 Note: the aggregated target value is implemented as an atomic variable so that
 reading the aggregated value does not require any locking mechanism.
 
@@ -119,6 +123,38 @@ the request.
 s32 dev_pm_qos_read_value(device):
 Returns the aggregated value for a given device's constraints list.
 
+enum pm_qos_flags_status dev_pm_qos_flags(device, mask)
+Check PM QoS flags of the given device against the given mask of flags.
+The meaning of the return values is as follows:
+	PM_QOS_FLAGS_ALL: All flags from the mask are set
+	PM_QOS_FLAGS_SOME: Some flags from the mask are set
+	PM_QOS_FLAGS_NONE: No flags from the mask are set
+	PM_QOS_FLAGS_UNDEFINED: The device's PM QoS structure has not been
+			initialized or the list of requests is empty.
+
+int dev_pm_qos_add_ancestor_request(dev, handle, value)
+Add a PM QoS request for the first direct ancestor of the given device whose
+power.ignore_children flag is unset.
+
+int dev_pm_qos_expose_latency_limit(device, value)
+Add a request to the device's PM QoS list of latency constraints and create
+a sysfs attribute pm_qos_resume_latency_us under the device's power directory
+allowing user space to manipulate that request.
+
+void dev_pm_qos_hide_latency_limit(device)
+Drop the request added by dev_pm_qos_expose_latency_limit() from the device's
+PM QoS list of latency constraints and remove sysfs attribute pm_qos_resume_latency_us
+from the device's power directory.
+
+int dev_pm_qos_expose_flags(device, value)
+Add a request to the device's PM QoS list of flags and create sysfs attributes
+pm_qos_no_power_off and pm_qos_remote_wakeup under the device's power directory
+allowing user space to change these flags' value.
+
+void dev_pm_qos_hide_flags(device)
+Drop the request added by dev_pm_qos_expose_flags() from the device's PM QoS list
+of flags and remove sysfs attributes pm_qos_no_power_off and pm_qos_remote_wakeup
+under the device's power directory.
 
 Notification mechanisms:
 The per-device PM QoS framework has 2 different and distinct notification trees:
-- 
1.7.10.4

