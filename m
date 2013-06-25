From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH 1/2] ACPI/Processor: Clear unuseful variable count in the acpi_processor_preregister_performance()
Date: Tue, 25 Jun 2013 10:06:45 +0800
Message-ID: <1372126006-4950-1-git-send-email-tianyu.lan@intel.com>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org, viresh.kumar@linaro.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The variable count in the acpi_processor_preregister_performance() is only initalized
as one for one cpu and increased by one when find another cpu that share same dependency
domain. Otherwise, it isn't referenced somewhere else.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/processor_perflib.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index e854582..1e9732d 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -639,7 +639,7 @@ end:
 int acpi_processor_preregister_performance(
 		struct acpi_processor_performance __percpu *performance)
 {
-	int count, count_target;
+	int count_target;
 	int retval = 0;
 	unsigned int i, j;
 	cpumask_var_t covered_cpus;
@@ -711,7 +711,6 @@ int acpi_processor_preregister_performance(
 
 		/* Validate the Domain info */
 		count_target = pdomain->num_processors;
-		count = 1;
 		if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ALL)
 			pr->performance->shared_type = CPUFREQ_SHARED_TYPE_ALL;
 		else if (pdomain->coord_type == DOMAIN_COORD_TYPE_HW_ALL)
@@ -745,7 +744,6 @@ int acpi_processor_preregister_performance(
 
 			cpumask_set_cpu(j, covered_cpus);
 			cpumask_set_cpu(j, pr->performance->shared_cpu_map);
-			count++;
 		}
 
 		for_each_possible_cpu(j) {
-- 
1.7.10.4

