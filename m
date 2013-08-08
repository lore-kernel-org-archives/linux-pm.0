From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 15/35] cpufreq: ia64-acpi: use cpufreq_table_validate_and_show()
Date: Thu,  8 Aug 2013 19:18:17 +0530
Message-ID: <2787686052efa74fdb05d3fd429187684af642fa.1375964117.git.viresh.kumar@linaro.org>
References: <cover.1375964117.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:50730 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965372Ab3HHNun (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2013 09:50:43 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx1so3485531pab.13
        for <linux-pm@vger.kernel.org>; Thu, 08 Aug 2013 06:50:43 -0700 (PDT)
In-Reply-To: <cover.1375964117.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1375964117.git.viresh.kumar@linaro.org>
References: <cover.1375964117.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, Tony Luck <tony.luck@intel.com>

Lets use cpufreq_table_validate_and_show() instead of calling
cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/ia64-acpi-cpufreq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/ia64-acpi-cpufreq.c b/drivers/cpufreq/ia64-acpi-cpufreq.c
index 3e14f03..6cfad51 100644
--- a/drivers/cpufreq/ia64-acpi-cpufreq.c
+++ b/drivers/cpufreq/ia64-acpi-cpufreq.c
@@ -335,7 +335,7 @@ acpi_cpufreq_cpu_init (
 		}
 	}
 
-	result = cpufreq_frequency_table_cpuinfo(policy, data->freq_table);
+	result = cpufreq_table_validate_and_show(policy, data->freq_table);
 	if (result) {
 		goto err_freqfree;
 	}
@@ -356,8 +356,6 @@ acpi_cpufreq_cpu_init (
 			(u32) data->acpi_data.states[i].status,
 			(u32) data->acpi_data.states[i].control);
 
-	cpufreq_frequency_table_get_attr(data->freq_table, policy->cpu);
-
 	/* the first call to ->target() should result in us actually
 	 * writing something to the appropriate registers. */
 	data->resume = 1;
-- 
1.7.12.rc2.18.g61b472e

