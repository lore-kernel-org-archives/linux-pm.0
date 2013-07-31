From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 04/15] cpufreq: dbx500: initialize .owner field with THIS_MODULE
Date: Wed, 31 Jul 2013 19:49:13 +0530
Message-ID: <538b0cb147d3bd4a5e21b49c507f725f7fb7feb9.1375279948.git.viresh.kumar@linaro.org>
References: <cover.1375279948.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1375279948.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1375279948.git.viresh.kumar@linaro.org>
References: <cover.1375279948.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arnd.bergmann@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pm@vger.kernel.org

CPUFreq core does following at multiple places:
module_{get|put}(cpufreq_driver->owner)).

This is done to make sure module doesn't get unloaded if it is currently in use.
This will work only if the .owner field of cpufreq driver is initialized with a
valid pointer.

This field wasn't initialized for this driver, lets initialize it with
THIS_MODULE.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/dbx500-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/dbx500-cpufreq.c b/drivers/cpufreq/dbx500-cpufreq.c
index 26321cd..2527f1d 100644
--- a/drivers/cpufreq/dbx500-cpufreq.c
+++ b/drivers/cpufreq/dbx500-cpufreq.c
@@ -120,6 +120,7 @@ static struct cpufreq_driver dbx500_cpufreq_driver = {
 	.get    = dbx500_cpufreq_getspeed,
 	.init   = dbx500_cpufreq_init,
 	.name   = "DBX500",
+	.owner  = THIS_MODULE,
 	.attr   = dbx500_cpufreq_attr,
 };
 
-- 
1.7.12.rc2.18.g61b472e
