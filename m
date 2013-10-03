From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 37/92] cpufreq: acpi: don't initialize part of policy that is set by core too
Date: Thu,  3 Oct 2013 20:28:31 +0530
Message-ID: <8fa3d4a49724fc9a298c0b2f0b266b37d4a13310.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:40248 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164Ab3JCPDg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 11:03:36 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so2586126pbb.34
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2013 08:03:36 -0700 (PDT)
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/acpi-cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 94a5a1d..a8dac7b 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -842,7 +842,6 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		break;
 	case ACPI_ADR_SPACE_FIXED_HARDWARE:
 		acpi_cpufreq_driver.get = get_cur_freq_on_cpu;
-		policy->cur = get_cur_freq_on_cpu(cpu);
 		break;
 	default:
 		break;
-- 
1.7.12.rc2.18.g61b472e

