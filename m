From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: Lock CPU online/offline in cpufreq_register_driver()
Date: Thu, 30 Jul 2015 01:45:07 +0200
Message-ID: <2126034.7irFieEIfi@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:40959 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753499AbbG2XSL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2015 19:18:11 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Russell King <linux@arm.linux.org.co.uk>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

To protect against races with concurrent CPU online/offline, call
get_online_cpus() before registering a cpufreq driver.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -2471,10 +2471,14 @@ int cpufreq_register_driver(struct cpufr
 
 	pr_debug("trying to register driver %s\n", driver_data->name);
 
+	/* Protect against concurrent CPU online/offline. */
+	get_online_cpus();
+
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 	if (cpufreq_driver) {
 		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
-		return -EEXIST;
+		ret = -EEXIST;
+		goto out;
 	}
 	cpufreq_driver = driver_data;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
@@ -2513,7 +2517,10 @@ int cpufreq_register_driver(struct cpufr
 	register_hotcpu_notifier(&cpufreq_cpu_notifier);
 	pr_debug("driver %s up and running\n", driver_data->name);
 
-	return 0;
+out:
+	put_online_cpus();
+	return ret;
+
 err_if_unreg:
 	subsys_interface_unregister(&cpufreq_interface);
 err_boost_unreg:
@@ -2523,7 +2530,7 @@ err_null_driver:
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 	cpufreq_driver = NULL;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
-	return ret;
+	goto out;
 }
 EXPORT_SYMBOL_GPL(cpufreq_register_driver);
 

