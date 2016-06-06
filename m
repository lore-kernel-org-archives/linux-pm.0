From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 1/8] ARM: davinci: Sort frequency table
Date: Mon,  6 Jun 2016 09:14:54 +0530
Message-ID: <3a395ec9a3cfec21f227a1ad92df237b1dda9f2d.1465184522.git.viresh.kumar@linaro.org>
References: <f9a03695c321b9c0628c6ae0136adfe004f358ad.1464931080.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f9a03695c321b9c0628c6ae0136adfe004f358ad.1464931080.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This is required for some of the changes in cpufreq core. There was only
one function dependent on the order of the table, that is fixed as well.

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@kernel.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V3->V4:
- Fixed an error reported by buildbot, by removing '&' before
  usage of da850_freq_table.

 arch/arm/mach-davinci/da850.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 239886299968..a706df3367ee 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -1004,13 +1004,14 @@ static const struct da850_opp da850_opp_96 = {
 		.frequency = freq * 1000, \
 	}
 
+/* Table sorted in ascending order of frequencies */
 static struct cpufreq_frequency_table da850_freq_table[] = {
-	OPP(456),
-	OPP(408),
-	OPP(372),
-	OPP(300),
-	OPP(200),
 	OPP(96),
+	OPP(200),
+	OPP(300),
+	OPP(372),
+	OPP(408),
+	OPP(456),
 	{
 		.driver_data		= 0,
 		.frequency	= CPUFREQ_TABLE_END,
@@ -1076,8 +1077,9 @@ int da850_register_cpufreq(char *async_clk)
 		clk_add_alias("async", da850_cpufreq_device.name,
 							async_clk, NULL);
 	for (i = 0; i < ARRAY_SIZE(da850_freq_table); i++) {
-		if (da850_freq_table[i].frequency <= da850_max_speed) {
-			cpufreq_info.freq_table = &da850_freq_table[i];
+		if (da850_freq_table[i].frequency > da850_max_speed) {
+			da850_freq_table[i].driver_data = 0;
+			da850_freq_table[i].frequency = CPUFREQ_TABLE_END;
 			break;
 		}
 	}
-- 
2.7.1.410.g6faf27b
