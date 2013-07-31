From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 10/15] cpufreq: s3c24xx: initialize .owner field with THIS_MODULE
Date: Wed, 31 Jul 2013 19:49:19 +0530
Message-ID: <08ebac0313328bb7f9701417920e6668861d98be.1375279948.git.viresh.kumar@linaro.org>
References: <cover.1375279948.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:63673 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760399Ab3GaOUz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2013 10:20:55 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl13so909698pab.20
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2013 07:20:54 -0700 (PDT)
In-Reply-To: <cover.1375279948.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1375279948.git.viresh.kumar@linaro.org>
References: <cover.1375279948.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arnd.bergmann@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>

CPUFreq core does following at multiple places:
module_{get|put}(cpufreq_driver->owner)).

This is done to make sure module doesn't get unloaded if it is currently in use.
This will work only if the .owner field of cpufreq driver is initialized with a
valid pointer.

This field wasn't initialized for this driver, lets initialize it with
THIS_MODULE.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/s3c24xx-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
index 87781eb..c5a46cc 100644
--- a/drivers/cpufreq/s3c24xx-cpufreq.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq.c
@@ -479,6 +479,7 @@ static struct cpufreq_driver s3c24xx_driver = {
 	.init		= s3c_cpufreq_init,
 	.suspend	= s3c_cpufreq_suspend,
 	.resume		= s3c_cpufreq_resume,
+	.owner		= THIS_MODULE,
 	.name		= "s3c24xx",
 };
 
-- 
1.7.12.rc2.18.g61b472e

