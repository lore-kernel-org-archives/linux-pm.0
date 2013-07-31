From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 02/15] cpufreq: cpufreq-cpu0: initialize .owner field with THIS_MODULE
Date: Wed, 31 Jul 2013 19:49:11 +0530
Message-ID: <8f37155d1524de4298f7b1de08b3474fe2d97241.1375279948.git.viresh.kumar@linaro.org>
References: <cover.1375279948.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1375279948.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1375279948.git.viresh.kumar@linaro.org>
References: <cover.1375279948.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arnd.bergmann@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-pm@vger.kernel.org

CPUFreq core does following at multiple places:
module_{get|put}(cpufreq_driver->owner)).

This is done to make sure module doesn't get unloaded if it is currently in use.
This will work only if the .owner field of cpufreq driver is initialized with a
valid pointer.

This field wasn't initialized for this driver, lets initialize it with
THIS_MODULE.

Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-cpu0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index ad1fde2..a087bf1 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -169,6 +169,7 @@ static struct cpufreq_driver cpu0_cpufreq_driver = {
 	.init = cpu0_cpufreq_init,
 	.exit = cpu0_cpufreq_exit,
 	.name = "generic_cpu0",
+	.owner = THIS_MODULE,
 	.attr = cpu0_cpufreq_attr,
 };
 
-- 
1.7.12.rc2.18.g61b472e
