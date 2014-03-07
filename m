From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] PowerCap / RAPL : Use async init
Date: Fri,  7 Mar 2014 09:48:49 -0800
Message-ID: <1394214529-11369-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16819 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751818AbaCGRqB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 7 Mar 2014 12:46:01 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

The rapl_init function takes around 58ms per domain. This change
reduce this by introducing async_schedule. Only disadvanatge is
that only presence of RAPL feature is checked for succesful module
init. If there is any other error, it will simply not create powercap
sysfs files, but module will still return success.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/powercap/intel_rapl.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 61b51e1..3b11c6f 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -29,6 +29,7 @@
 #include <linux/sysfs.h>
 #include <linux/cpu.h>
 #include <linux/powercap.h>
+#include <linux/async.h>
 
 #include <asm/processor.h>
 #include <asm/cpu_device_id.h>
@@ -1364,16 +1365,10 @@ static struct notifier_block rapl_cpu_notifier = {
 	.notifier_call = rapl_cpu_callback,
 };
 
-static int __init rapl_init(void)
+static void __init rapl_init_async(void *unused, async_cookie_t cookie)
 {
 	int ret = 0;
 
-	if (!x86_match_cpu(rapl_ids)) {
-		pr_err("driver does not support CPU family %d model %d\n",
-			boot_cpu_data.x86, boot_cpu_data.x86_model);
-
-		return -ENODEV;
-	}
 	/* prevent CPU hotplug during detection */
 	get_online_cpus();
 	ret = rapl_detect_topology();
@@ -1382,14 +1377,27 @@ static int __init rapl_init(void)
 
 	if (rapl_register_powercap()) {
 		rapl_cleanup_data();
-		ret = -ENODEV;
 		goto done;
 	}
 	register_hotcpu_notifier(&rapl_cpu_notifier);
 done:
 	put_online_cpus();
 
-	return ret;
+}
+
+static int __init rapl_init(void)
+{
+
+	if (!x86_match_cpu(rapl_ids)) {
+		pr_err("driver does not support CPU family %d model %d\n",
+			boot_cpu_data.x86, boot_cpu_data.x86_model);
+
+		return -ENODEV;
+	}
+
+	async_schedule(rapl_init_async, NULL);
+
+	return 0;
 }
 
 static void __exit rapl_exit(void)
-- 
1.7.11.7

