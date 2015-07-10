From: Pan Xinhui <xinhuix.pan@intel.com>
Subject: [PATCH] acpi-cpufreq: Add a miss ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
Date: Fri, 10 Jul 2015 13:50:11 +0800
Message-ID: <559F5D13.8050104@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:58581 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752236AbbGJFwq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 10 Jul 2015 01:52:46 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>, "mnipxh@163.com" <mnipxh@163.com>


If CONFIG_X86_ACPI_CPUFREQ_CPB has not been defined, the placeholder for
cpb is not needed. Add ifdef around it.

Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index e7fcaa6..314a19e 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -884,7 +884,9 @@ static int acpi_cpufreq_resume(struct cpufreq_policy *policy)
 static struct freq_attr *acpi_cpufreq_attr[] = {
 	&cpufreq_freq_attr_scaling_available_freqs,
 	&freqdomain_cpus,
+#ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
 	NULL,	/* this is a placeholder for cpb, do not remove */
+#endif
 	NULL,
 };
 
-- 
1.9.1
