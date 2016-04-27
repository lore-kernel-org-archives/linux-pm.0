From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH] cpufreq: st: enable selective initialization based on the platform
Date: Wed, 27 Apr 2016 12:40:27 +0100
Message-ID: <1461757227-22381-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34208 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752249AbcD0Lke (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 27 Apr 2016 07:40:34 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

The sti-cpufreq does unconditional registration of the cpufreq-dt driver
which causes issue on an multi-platform build. For example, on Vexpress
TC2 platform, we get the following error on boot:

cpu cpu0: OPP-v2 not supported
cpu cpu0: Not doing voltage scaling
cpu: dev_pm_opp_of_cpumask_add_table: couldn't find opp table
	for cpu:0, -19
cpu cpu0: dev_pm_opp_get_max_volt_latency: Invalid regulator (-6)
...
arm_big_little: bL_cpufreq_register: Failed registering platform driver:
		vexpress-spc, err: -17

The actual driver fails to initialise as cpufreq-dt is probed
successfully, which is incorrect. This issue can happen to any platform
not using cpufreq-dt in a multi-platform build.

This patch adds a check to do selective initialization of the driver.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Fixes: ab0ea257fc58 ("cpufreq: st: Provide runtime initialised driver for ST's platforms")
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/sti-cpufreq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
index a9c659f58974..5fce58712a97 100644
--- a/drivers/cpufreq/sti-cpufreq.c
+++ b/drivers/cpufreq/sti-cpufreq.c
@@ -259,6 +259,10 @@ static int sti_cpufreq_init(void)
 {
 	int ret;
 
+	if ((!of_machine_is_compatible("st,stih407-b2120")) &&
+		(!of_machine_is_compatible("st,stih407")))
+		return -ENODEV;
+
 	ddata.cpu = get_cpu_device(0);
 	if (!ddata.cpu) {
 		dev_err(ddata.cpu, "Failed to get device for CPU0\n");
-- 
1.9.1

