From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 15/15] cpufreq: Unicore: initialize .owner field with THIS_MODULE
Date: Wed, 31 Jul 2013 19:49:24 +0530
Message-ID: <0b4bbc3d04710cccd9b575ae54255ecf1168a5ec.1375279948.git.viresh.kumar@linaro.org>
References: <cover.1375279948.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1375279948.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1375279948.git.viresh.kumar@linaro.org>
References: <cover.1375279948.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arnd.bergmann@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>
List-Id: linux-pm@vger.kernel.org

CPUFreq core does following at multiple places:
module_{get|put}(cpufreq_driver->owner)).

This is done to make sure module doesn't get unloaded if it is currently in use.
This will work only if the .owner field of cpufreq driver is initialized with a
valid pointer.

This field wasn't initialized for this driver, lets initialize it with
THIS_MODULE.

Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/unicore2-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/unicore2-cpufreq.c b/drivers/cpufreq/unicore2-cpufreq.c
index 12fc904..93519f7 100644
--- a/drivers/cpufreq/unicore2-cpufreq.c
+++ b/drivers/cpufreq/unicore2-cpufreq.c
@@ -81,6 +81,7 @@ static struct cpufreq_driver ucv2_driver = {
 	.target		= ucv2_target,
 	.get		= ucv2_getspeed,
 	.init		= ucv2_cpu_init,
+	.owner		= THIS_MODULE,
 	.name		= "UniCore-II",
 };
 
-- 
1.7.12.rc2.18.g61b472e
