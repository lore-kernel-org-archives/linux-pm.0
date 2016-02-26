From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v10 1/2] cpufreq: powernv: Fix bugs in powernv_cpufreq_{init/exit}
Date: Fri, 26 Feb 2016 16:06:51 +0530
Message-ID: <1456483012-29466-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1456483012-29466-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:40613 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154AbcBZKiO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2016 05:38:14 -0500
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
	Fri, 26 Feb 2016 20:38:11 +1000
In-Reply-To: <1456483012-29466-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

Unregister the notifiers if cpufreq_driver_register() fails in
powernv_cpufreq_init(). Re-arrange the unregistration and cleanup routines
in powernv_cpufreq_exit() to free all the resources after the driver
has unregistered.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 40 ++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 1bbc10a..50bf120 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -595,6 +595,19 @@ out:
 	return ret;
 }
 
+static inline void clean_chip_info(void)
+{
+	kfree(chips);
+	kfree(core_to_chip_map);
+}
+
+static inline void unregister_all_notifiers(void)
+{
+	opal_message_notifier_unregister(OPAL_MSG_OCC,
+					 &powernv_cpufreq_opal_nb);
+	unregister_reboot_notifier(&powernv_cpufreq_reboot_nb);
+}
+
 static int __init powernv_cpufreq_init(void)
 {
 	int rc = 0;
@@ -605,30 +618,35 @@ static int __init powernv_cpufreq_init(void)
 
 	/* Discover pstates from device tree and init */
 	rc = init_powernv_pstates();
-	if (rc) {
-		pr_info("powernv-cpufreq disabled. System does not support PState control\n");
-		return rc;
-	}
+	if (rc)
+		goto out;
 
 	/* Populate chip info */
 	rc = init_chip_info();
 	if (rc)
-		return rc;
+		goto out;
 
 	register_reboot_notifier(&powernv_cpufreq_reboot_nb);
 	opal_message_notifier_register(OPAL_MSG_OCC, &powernv_cpufreq_opal_nb);
-	return cpufreq_register_driver(&powernv_cpufreq_driver);
+
+	rc = cpufreq_register_driver(&powernv_cpufreq_driver);
+	if (!rc)
+		return 0;
+
+	pr_info("Failed to register the cpufreq driver (%d)\n", rc);
+	unregister_all_notifiers();
+	clean_chip_info();
+out:
+	pr_info("Platform driver disabled. System does not support PState control\n");
+	return rc;
 }
 module_init(powernv_cpufreq_init);
 
 static void __exit powernv_cpufreq_exit(void)
 {
-	unregister_reboot_notifier(&powernv_cpufreq_reboot_nb);
-	opal_message_notifier_unregister(OPAL_MSG_OCC,
-					 &powernv_cpufreq_opal_nb);
-	kfree(chips);
-	kfree(core_to_chip_map);
 	cpufreq_unregister_driver(&powernv_cpufreq_driver);
+	unregister_all_notifiers();
+	clean_chip_info();
 }
 module_exit(powernv_cpufreq_exit);
 
-- 
1.9.3

