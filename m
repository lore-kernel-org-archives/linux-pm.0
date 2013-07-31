From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 09/15] cpufreq: pxa: initialize .owner field with THIS_MODULE
Date: Wed, 31 Jul 2013 19:49:18 +0530
Message-ID: <4389a861605420ef261dc7fb39955812320b8153.1375279948.git.viresh.kumar@linaro.org>
References: <cover.1375279948.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1375279948.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1375279948.git.viresh.kumar@linaro.org>
References: <cover.1375279948.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arnd.bergmann@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Eric Miao <eric.y.miao@gmail.com>
List-Id: linux-pm@vger.kernel.org

CPUFreq core does following at multiple places:
module_{get|put}(cpufreq_driver->owner)).

This is done to make sure module doesn't get unloaded if it is currently in use.
This will work only if the .owner field of cpufreq driver is initialized with a
valid pointer.

This field wasn't initialized for this driver, lets initialize it with
THIS_MODULE.

Cc: Eric Miao <eric.y.miao@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/pxa2xx-cpufreq.c | 1 +
 drivers/cpufreq/pxa3xx-cpufreq.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/cpufreq/pxa2xx-cpufreq.c b/drivers/cpufreq/pxa2xx-cpufreq.c
index fb3981a..d62781b 100644
--- a/drivers/cpufreq/pxa2xx-cpufreq.c
+++ b/drivers/cpufreq/pxa2xx-cpufreq.c
@@ -468,6 +468,7 @@ static struct cpufreq_driver pxa_cpufreq_driver = {
 	.target	= pxa_set_target,
 	.init	= pxa_cpufreq_init,
 	.get	= pxa_cpufreq_get,
+	.owner	= THIS_MODULE,
 	.name	= "PXA2xx",
 };
 
diff --git a/drivers/cpufreq/pxa3xx-cpufreq.c b/drivers/cpufreq/pxa3xx-cpufreq.c
index 9c92ef0..81727ec 100644
--- a/drivers/cpufreq/pxa3xx-cpufreq.c
+++ b/drivers/cpufreq/pxa3xx-cpufreq.c
@@ -232,6 +232,7 @@ static struct cpufreq_driver pxa3xx_cpufreq_driver = {
 	.target		= pxa3xx_cpufreq_set,
 	.init		= pxa3xx_cpufreq_init,
 	.get		= pxa3xx_cpufreq_get,
+	.owner		= THIS_MODULE,
 	.name		= "pxa3xx-cpufreq",
 };
 
-- 
1.7.12.rc2.18.g61b472e
