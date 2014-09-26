From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] cpufreq: integrator: fix integrator_cpufreq_remove return type
Date: Fri, 26 Sep 2014 22:19:12 +0200
Message-ID: <1845195.odREGsY0qB@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:55610 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755205AbaIZUTq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Sep 2014 16:19:46 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

When building this driver as a module, we get a helpful warning
about the return type:

drivers/cpufreq/integrator-cpufreq.c:232:2: warning: initialization from incompatible pointer type
  .remove = __exit_p(integrator_cpufreq_remove),

If the remove callback returns void, the caller gets an undefined
value as it expects an integer to be returned. This fixes the
problem by passing down the value from cpufreq_unregister_driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Found while testing the integrator multiplatform patches from Linus Walleij,
this shows up as a new warning in allmodconfig.

diff --git a/drivers/cpufreq/integrator-cpufreq.c b/drivers/cpufreq/integrator-cpufreq.c
index c1320528b9d0..6bd69adc3c5e 100644
--- a/drivers/cpufreq/integrator-cpufreq.c
+++ b/drivers/cpufreq/integrator-cpufreq.c
@@ -213,9 +213,9 @@ static int __init integrator_cpufreq_probe(struct platform_device *pdev)
 	return cpufreq_register_driver(&integrator_driver);
 }
 
-static void __exit integrator_cpufreq_remove(struct platform_device *pdev)
+static int __exit integrator_cpufreq_remove(struct platform_device *pdev)
 {
-	cpufreq_unregister_driver(&integrator_driver);
+	return cpufreq_unregister_driver(&integrator_driver);
 }
 
 static const struct of_device_id integrator_cpufreq_match[] = {

