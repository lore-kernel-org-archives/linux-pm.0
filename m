From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 15/44] cpufreq: ia64-acpi: use cpufreq_table_validate_and_show()
Date: Mon, 16 Sep 2013 18:56:17 +0530
Message-ID: <def54433f7c57099a2746c1a4e65f5d152eb85f1.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:57353 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250Ab3IPN2R (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Sep 2013 09:28:17 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp2so4107430pbb.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Sep 2013 06:28:17 -0700 (PDT)
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

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

