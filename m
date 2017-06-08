From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH 1/6] drivers base/arch_topology: prepare cpufreq policy notifier for frequency-invariant load-tracking support
Date: Thu,  8 Jun 2017 08:55:08 +0100
Message-ID: <20170608075513.12475-2-dietmar.eggemann@arm.com>
References: <20170608075513.12475-1-dietmar.eggemann@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170608075513.12475-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaor.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

This patch prepares the actual implementation of the frequency-invariant
load-tracking support provided in the next patch ("drivers
base/arch_topology: frequency-invariant load-tracking support").

The maximum supported frequency of a cpu (policy->cpuinfo.max_freq) has
to be retrieved for frequency-invariant load-tracking.

This can be achieved by coding this functionality into the existing
cpufreq policy notifier (init_cpu_capacity_notifier) which is currently
only used for setting up dt-based cpu capacities (cpu node property
capacity-dmips-mhz).

But frequency-invariant load-tracking has to work whether cpu capacity
dt-parsing succeeded or not.

Change init_cpu_capacity_notifier in such a way that even if the parsing
of the cpu capacity information failed the notifier is called for each
cpufreq policy to be able to set the maximum supported frequency.

The exit condition in register_cpufreq_notifier() now only tests for
!acpi_disabled because for frequency invariance the cpufreq policy
notifier has to be enabled even if u32 *raw_capacity is NULL which
occurs when there is no capacity-dmips-mhz property in the dt file or
when the allocation for raw_capacity[cpu] has failed.

The continue statement in init_cpu_capacity_callback() makes sure that
we don't go on calculating capacity_scale in case the capacity parsing
failed. It should be a break rather a continue here but the next patch
introduces code to set the per-cpu variable max_freq in this
for_each_cpu loop before the check if cap_parsing_failed so it has to
be a continue.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Juri Lelli <juri.lelli@arm.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 drivers/base/arch_topology.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index d1c33a85059e..272831c89feb 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -173,7 +173,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 	struct cpufreq_policy *policy = data;
 	int cpu;
 
-	if (cap_parsing_failed || cap_parsing_done)
+	if (cap_parsing_done)
 		return 0;
 
 	switch (val) {
@@ -185,13 +185,17 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 			       cpus_to_visit,
 			       policy->related_cpus);
 		for_each_cpu(cpu, policy->related_cpus) {
+			if (cap_parsing_failed)
+				continue;
 			raw_capacity[cpu] = topology_get_cpu_scale(NULL, cpu) *
 					    policy->cpuinfo.max_freq / 1000UL;
 			capacity_scale = max(raw_capacity[cpu], capacity_scale);
 		}
 		if (cpumask_empty(cpus_to_visit)) {
-			topology_normalize_cpu_scale();
-			kfree(raw_capacity);
+			if (!cap_parsing_failed) {
+				topology_normalize_cpu_scale();
+				kfree(raw_capacity);
+			}
 			pr_debug("cpu_capacity: parsing done\n");
 			cap_parsing_done = true;
 			schedule_work(&parsing_done_work);
@@ -211,7 +215,7 @@ static int __init register_cpufreq_notifier(void)
 	 * until we have the necessary code to parse the cpu capacity, so
 	 * skip registering cpufreq notifier.
 	 */
-	if (!acpi_disabled || !raw_capacity)
+	if (!acpi_disabled)
 		return -EINVAL;
 
 	if (!alloc_cpumask_var(&cpus_to_visit, GFP_KERNEL)) {
-- 
2.11.0
