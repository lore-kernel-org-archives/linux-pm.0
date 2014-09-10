From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 3/4] ARM: mvebu: use the cpufreq-dt platform_data for independent clocks
Date: Wed, 10 Sep 2014 11:41:51 +0200
Message-ID: <1410342112-13264-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <CAKohpo=GiQHJ5eg=TkYAkzvsn=hTNTjSwmH20vitG2Z42zsoDA@mail.gmail.com>
 <1410342112-13264-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1410342112-13264-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
List-Id: linux-pm@vger.kernel.org

This commit adjusts the registration of the cpufreq-dt driver in the
mvebu platform to indicate to the cpufreq driver that the platform has
independent clocks for each CPU.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index bbd8664..c81dd5f 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -20,6 +20,7 @@
 
 #include <linux/clk.h>
 #include <linux/cpu_pm.h>
+#include <linux/cpufreq-dt.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -572,6 +573,10 @@ int mvebu_pmsu_dfs_request(int cpu)
 	return 0;
 }
 
+struct cpufreq_dt_platform_data cpufreq_dt_pd = {
+	.independent_clocks = true,
+};
+
 static int __init armada_xp_pmsu_cpufreq_init(void)
 {
 	struct device_node *np;
@@ -644,7 +649,8 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
 		}
 	}
 
-	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
+	platform_device_register_data(NULL, "cpufreq-dt", -1,
+				      &cpufreq_dt_pd, sizeof(cpufreq_dt_pd));
 	return 0;
 }
 
-- 
2.0.0
