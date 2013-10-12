From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: acpi: Add comment under ACPI_ADR_SPACE_SYSTEM_IO case
Date: Sat, 12 Oct 2013 07:06:03 +0530
Message-ID: <6334c0aed4840857944d1b267871ada4d7014d57.1381541632.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

policy->cur is now set by cpufreq core when cpufreq_driver->get() is defined and
so drivers aren't required to set it. When space_id is ACPI_ADR_SPACE_SYSTEM_IO
for acpi cpufreq driver it doesn't set ->get to a valid function pointer and so
policy->cur is required to be set by driver.

This is already followed in acpi-cpufreq driver. This patch adds a comment
describing why we need to set policy->cur from driver.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
This change was requested by Rafael here:
http://www.spinics.net/lists/linux-acpi/msg46748.html

 drivers/cpufreq/acpi-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index a8dac7b..8ecd74e 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -838,6 +838,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	switch (perf->control_register.space_id) {
 	case ACPI_ADR_SPACE_SYSTEM_IO:
 		/* Current speed is unknown and not detectable by IO port */
+		/* ->cur wouldn't be set by core as ->get() is NULL */
 		policy->cur = acpi_cpufreq_guess_freq(data, policy->cpu);
 		break;
 	case ACPI_ADR_SPACE_FIXED_HARDWARE:
-- 
1.7.12.rc2.18.g61b472e

