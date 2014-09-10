From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCHv2 3/4] ARM: mvebu: use the cpufreq-dt platform_data for independent clocks
Date: Wed, 10 Sep 2014 14:08:27 +0200
Message-ID: <1410350908-11316-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <CAKohpo=GiQHJ5eg=TkYAkzvsn=hTNTjSwmH20vitG2Z42zsoDA@mail.gmail.com>
 <1410350908-11316-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:36852 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751003AbaIJMIf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Sep 2014 08:08:35 -0400
In-Reply-To: <1410350908-11316-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

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

