From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 08/11] cpufreq: imx: Use 'index' only to index into policy->freq_table
Date: Thu,  2 Jun 2016 19:49:08 +0530
Message-ID: <cbdf2d4b7dc59280f53191d892163a629fe8dba8.1464876460.git.viresh.kumar@linaro.org>
References: <cover.1464876460.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1464876460.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1464876460.git.viresh.kumar@linaro.org>
References: <cover.1464876460.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@freescale.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kevin Hilman <khilman@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Steven Miao <realmz6@gmail.com>
List-Id: linux-pm@vger.kernel.org

Later patches would make changes in cpufreq core, after which
policy->freq_table may be reordered by cpufreq core and it wouldn't be
safe anymore to use 'index' for any other local arrays.

To prepare for that, use policy->freq_table[index].driver_data for other
driver specific usage of 'index'. The 'driver_data' fields are already
set properly by the driver.

Cc: Shawn Guo <shawn.guo@freescale.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/imx6q-cpufreq.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 3858dc7e617b..e7da85890e8c 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -42,14 +42,21 @@ static unsigned int transition_latency;
 static u32 *imx6_soc_volt;
 static u32 soc_opp_count;
 
-static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
+static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int pindex)
 {
 	struct dev_pm_opp *opp;
 	unsigned long freq_hz, volt, volt_old;
-	unsigned int old_freq, new_freq;
+	unsigned int old_freq, new_freq, index;
 	int ret;
 
-	new_freq = policy->freq_table[index].frequency;
+	new_freq = policy->freq_table[pindex].frequency;
+
+	/*
+	 * policy->freq_table may be sorted differently, get the index value we
+	 * are concerned about.
+	 */
+	index = policy->freq_table[pindex].driver_data;
+
 	freq_hz = new_freq * 1000;
 	old_freq = clk_get_rate(arm_clk) / 1000;
 
-- 
2.7.1.410.g6faf27b
