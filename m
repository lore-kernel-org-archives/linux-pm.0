From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 5/9] cpufreq: ia64: Use 'index' only to index into policy->freq_table
Date: Fri,  3 Jun 2016 19:05:11 +0530
Message-ID: <f800f84d5b4111d34ff88567a4ca4338e6a20091.1464960877.git.viresh.kumar@linaro.org>
References: <cover.1464960877.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1464960877.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1464960877.git.viresh.kumar@linaro.org>
References: <cover.1464960877.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, steve.muckle@linaro.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Shawn Guo <shawn.guo@freescale.com>, Steven Miao <realmz6@gmail.com>
List-Id: linux-pm@vger.kernel.org

Later patches would make changes in cpufreq core, after which
policy->freq_table may be reordered by cpufreq core and it wouldn't be
safe anymore to use 'index' for any other local arrays.

To prepare for that, use policy->freq_table[index].driver_data for other
driver specific usage of 'index'. The 'driver_data' fields are set
properly by the driver now.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/ia64-acpi-cpufreq.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/ia64-acpi-cpufreq.c b/drivers/cpufreq/ia64-acpi-cpufreq.c
index 759612da4fdc..cc8bb1e5ac50 100644
--- a/drivers/cpufreq/ia64-acpi-cpufreq.c
+++ b/drivers/cpufreq/ia64-acpi-cpufreq.c
@@ -210,7 +210,12 @@ acpi_cpufreq_target (
 	struct cpufreq_policy   *policy,
 	unsigned int index)
 {
-	return processor_set_freq(acpi_io_data[policy->cpu], policy, index);
+	/*
+	 * policy->freq_table may be sorted differently, get the index value we
+	 * are concerned about.
+	 */
+	return processor_set_freq(acpi_io_data[policy->cpu], policy,
+				  policy->freq_table[index].driver_data);
 }
 
 static int
@@ -282,6 +287,8 @@ acpi_cpufreq_cpu_init (
 		} else {
 			freq_table[i].frequency = CPUFREQ_TABLE_END;
 		}
+
+		freq_table[i].driver_data = i;
 	}
 
 	result = cpufreq_table_validate_and_show(policy, freq_table);
-- 
2.7.1.410.g6faf27b
