From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2 v2] cpufreq: s3c: remove incorrect __init annotations
Date: Wed, 18 Feb 2015 21:55:03 +0100
Message-ID: <5656184.2Gy4xoRSJb@wuerfel>
References: <7331404.XKGG8rohnR@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:60288 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbbBRUzm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Feb 2015 15:55:42 -0500
In-Reply-To: <7331404.XKGG8rohnR@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org

The two functions s3c2416_cpufreq_driver_init and s3c_cpufreq_register
are marked init but are called from a context that might be run after
the __init sections are discarded, as the compiler points out:

WARNING: vmlinux.o(.data+0x1ad9dc): Section mismatch in reference from the variable s3c2416_cpufreq_driver to the function .init.text:s3c2416_cpufreq_driver_init()
WARNING: drivers/built-in.o(.text+0x35b5dc): Section mismatch in reference from the function s3c2410a_cpufreq_add() to the function .init.text:s3c_cpufreq_register()

This removes the __init markings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: stable@vger.kernel.org

diff --git a/drivers/cpufreq/s3c2416-cpufreq.c b/drivers/cpufreq/s3c2416-cpufreq.c
index 2fd53eaaec20..d6d425773fa4 100644
--- a/drivers/cpufreq/s3c2416-cpufreq.c
+++ b/drivers/cpufreq/s3c2416-cpufreq.c
@@ -263,7 +263,7 @@ out:
 }
 
 #ifdef CONFIG_ARM_S3C2416_CPUFREQ_VCORESCALE
-static void __init s3c2416_cpufreq_cfg_regulator(struct s3c2416_data *s3c_freq)
+static void s3c2416_cpufreq_cfg_regulator(struct s3c2416_data *s3c_freq)
 {
 	int count, v, i, found;
 	struct cpufreq_frequency_table *pos;
@@ -333,7 +333,7 @@ static struct notifier_block s3c2416_cpufreq_reboot_notifier = {
 	.notifier_call = s3c2416_cpufreq_reboot_notifier_evt,
 };
 
-static int __init s3c2416_cpufreq_driver_init(struct cpufreq_policy *policy)
+static int s3c2416_cpufreq_driver_init(struct cpufreq_policy *policy)
 {
 	struct s3c2416_data *s3c_freq = &s3c2416_cpufreq;
 	struct cpufreq_frequency_table *pos;
diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
index d00f1cee4509..bd340a1ca87d 100644
--- a/drivers/cpufreq/s3c24xx-cpufreq.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq.c
@@ -454,7 +454,7 @@ static struct cpufreq_driver s3c24xx_driver = {
 };
 
 
-int __init s3c_cpufreq_register(struct s3c_cpufreq_info *info)
+int s3c_cpufreq_register(struct s3c_cpufreq_info *info)
 {
 	if (!info || !info->name) {
 		printk(KERN_ERR "%s: failed to pass valid information\n",

