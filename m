From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 13/15] cpufreq: SPEAr: initialize .owner field with THIS_MODULE
Date: Wed, 31 Jul 2013 19:49:22 +0530
Message-ID: <584c19ee84ad8a183985fd9a9152d147316038e3.1375279948.git.viresh.kumar@linaro.org>
References: <cover.1375279948.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1375279948.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1375279948.git.viresh.kumar@linaro.org>
References: <cover.1375279948.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arnd.bergmann@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

CPUFreq core does following at multiple places:
module_{get|put}(cpufreq_driver->owner)).

This is done to make sure module doesn't get unloaded if it is currently in use.
This will work only if the .owner field of cpufreq driver is initialized with a
valid pointer.

This field wasn't initialized for this driver, lets initialize it with
THIS_MODULE.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/spear-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index c3efa7f..3c00dd5 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -212,6 +212,7 @@ static struct cpufreq_driver spear_cpufreq_driver = {
 	.get		= spear_cpufreq_get,
 	.init		= spear_cpufreq_init,
 	.exit		= spear_cpufreq_exit,
+	.owner		= THIS_MODULE,
 	.attr		= spear_cpufreq_attr,
 };
 
-- 
1.7.12.rc2.18.g61b472e
