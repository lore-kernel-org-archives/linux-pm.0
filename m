From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] cpufreq: powernv: Export frequency throttle state of the chip through sysfs
Date: Thu, 27 Aug 2015 14:43:26 +0530
Message-ID: <1440666806-11760-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp02.in.ibm.com ([122.248.162.2]:51063 "EHLO
	e28smtp02.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbbH0JNf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2015 05:13:35 -0400
Received: from /spool/local
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
	Thu, 27 Aug 2015 14:43:33 +0530
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: stewart@linux.vnet.ibm.com, viresh.kumar@linaro.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

Create a sysfs 'throttle' attribute per-chip(per-numa-node) to reflect
the throttle state of the chip. The usersapce programs can poll on
this attribute to keep an eye on the throttle state. Currently we
print a log message to notify the user of throttling event. The
performance-sensitive applications can monitor the throttle state
using this attribute.

Following file is created in sysfs:
/sys/devices/system/node/nodeN/throttle
'throttle' attribute has the following values:
0 : frequency is unthrottled
1 : frequency is throttled

Suggested-by: Stewart Smith <stewart@linux.vnet.ibm.com>
Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
This patch is based on top of linux-next/master 

 drivers/cpufreq/powernv-cpufreq.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 64994e1..aed6c34 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -28,6 +28,8 @@
 #include <linux/of.h>
 #include <linux/reboot.h>
 #include <linux/slab.h>
+#include <linux/device.h>
+#include <linux/node.h>
 
 #include <asm/cputhreads.h>
 #include <asm/firmware.h>
@@ -413,6 +415,23 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
 	.notifier_call = powernv_cpufreq_reboot_notifier,
 };
 
+static ssize_t throttle_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	int i;
+
+	for (i = 0; i < nr_chips; i++)
+		if (chips[i].id == dev->id) {
+			smp_call_function_any(&chips[i].mask,
+					      powernv_cpufreq_throttle_check,
+					      NULL, 1);
+			return sprintf(buf, "%d\n", throttled ||
+						    chips[i].throttled);
+		}
+}
+
+static DEVICE_ATTR(throttle, 0400, throttle_show, NULL);
+
 void powernv_cpufreq_work_fn(struct work_struct *work)
 {
 	struct chip *chip = container_of(work, struct chip, throttle);
@@ -570,6 +589,8 @@ static int init_chip_info(void)
 		cpumask_copy(&chips[i].mask, cpumask_of_node(chip[i]));
 		INIT_WORK(&chips[i].throttle, powernv_cpufreq_work_fn);
 		chips[i].restore = false;
+		device_create_file(&node_devices[chip[i]]->dev,
+				   &dev_attr_throttle);
 	}
 
 	return 0;
-- 
1.9.3

