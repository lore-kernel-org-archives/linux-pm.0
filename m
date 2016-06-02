From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 07/11] cpufreq: ia64: Use 'index' only to index into policy->freq_table
Date: Thu,  2 Jun 2016 19:49:07 +0530
Message-ID: <aa62b1838f80890432009522ac53a7b4459afec2.1464876460.git.viresh.kumar@linaro.org>
References: <cover.1464876460.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36702 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161198AbcFBOTs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jun 2016 10:19:48 -0400
Received: by mail-pa0-f52.google.com with SMTP id te7so2839672pab.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Jun 2016 07:19:48 -0700 (PDT)
In-Reply-To: <cover.1464876460.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1464876460.git.viresh.kumar@linaro.org>
References: <cover.1464876460.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kevin Hilman <khilman@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Shawn Guo <shawn.guo@freescale.com>, Steven Miao <realmz6@gmail.com>

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

