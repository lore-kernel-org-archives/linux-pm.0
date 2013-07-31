From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 05/15] cpufreq: exynos: initialize .owner field with THIS_MODULE
Date: Wed, 31 Jul 2013 19:49:14 +0530
Message-ID: <b4dab0727f68614d56892719b82ae10450c4e7ae.1375279948.git.viresh.kumar@linaro.org>
References: <cover.1375279948.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1375279948.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1375279948.git.viresh.kumar@linaro.org>
References: <cover.1375279948.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arnd.bergmann@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-pm@vger.kernel.org

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
 drivers/cpufreq/exynos-cpufreq.c     | 1 +
 drivers/cpufreq/exynos5440-cpufreq.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index 0d32f02..fe0bbce 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -278,6 +278,7 @@ static struct cpufreq_driver exynos_driver = {
 	.init		= exynos_cpufreq_cpu_init,
 	.exit		= exynos_cpufreq_cpu_exit,
 	.name		= "exynos_cpufreq",
+	.owner		= THIS_MODULE,
 	.attr		= exynos_cpufreq_attr,
 #ifdef CONFIG_PM
 	.suspend	= exynos_cpufreq_suspend,
diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
index 0c74018..d0d353c 100644
--- a/drivers/cpufreq/exynos5440-cpufreq.c
+++ b/drivers/cpufreq/exynos5440-cpufreq.c
@@ -344,6 +344,7 @@ static struct cpufreq_driver exynos_driver = {
 	.target		= exynos_target,
 	.get		= exynos_getspeed,
 	.init		= exynos_cpufreq_cpu_init,
+	.owner		= THIS_MODULE,
 	.name		= CPUFREQ_NAME,
 };
 
-- 
1.7.12.rc2.18.g61b472e
