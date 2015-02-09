From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH RFC 03/12] thermal: cpu_cooling: remove duplicate documentation entries
Date: Mon,  9 Feb 2015 17:34:04 -0400
Message-ID: <1423517653-11359-4-git-send-email-edubezval@gmail.com>
References: <1423517653-11359-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423517653-11359-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>, ezequiel.garcia@free-electrons.com, amit.kachhap@linaro.org, viresh.kumar@linaro.org, amit.daniel@samsung.com, hongbo.zhang@linaro.com, andrew@lunn.ch, durgadoss.r@intel.com, peter@piie.net, shawn.guo@linaro.org, aaron.lu@intel.com, caesar.wang@rock-chips.com, b.zolnierkie@samsung.com, l.majewski@samsung.com, vincenzo.frascino@st.com, mperttunen@nvidia.com, mikko.perttunen@kapsi.fi, srinivas.pandruvada@linux.intel.com, jacob.jun.pan@linux.intel.com, bcousson@baylibre.com
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

This patch removes the kernel docs from cpu_cooling.h.
The entries found in this file are already documented
in cpu_cooling.c. The entries in cpu_cooling.c are more
complete than those in cpu_cooling.h. Thus, removing
from cpu_cooling.h

Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 include/linux/cpu_cooling.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index bd95527..a8d827c 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -29,18 +29,9 @@
 #include <linux/cpumask.h>
 
 #ifdef CONFIG_CPU_THERMAL
-/**
- * cpufreq_cooling_register - function to create cpufreq cooling device.
- * @clip_cpus: cpumask of cpus where the frequency constraints will happen
- */
 struct thermal_cooling_device *
 cpufreq_cooling_register(const struct cpumask *clip_cpus);
 
-/**
- * of_cpufreq_cooling_register - create cpufreq cooling device based on DT.
- * @np: a valid struct device_node to the cooling device device tree node.
- * @clip_cpus: cpumask of cpus where the frequency constraints will happen
- */
 #ifdef CONFIG_THERMAL_OF
 struct thermal_cooling_device *
 of_cpufreq_cooling_register(struct device_node *np,
@@ -54,10 +45,6 @@ of_cpufreq_cooling_register(struct device_node *np,
 }
 #endif
 
-/**
- * cpufreq_cooling_unregister - function to remove cpufreq cooling device.
- * @cdev: thermal cooling device pointer.
- */
 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev);
 
 unsigned long cpufreq_cooling_get_level(unsigned int cpu, unsigned int freq);
-- 
2.1.3
