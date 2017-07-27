From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH v3 01/10] drivers base/arch_topology: free cpumask cpus_to_visit
Date: Thu, 27 Jul 2017 20:33:03 +0100
Message-ID: <20170727193312.9849-2-dietmar.eggemann@arm.com>
References: <20170727193312.9849-1-dietmar.eggemann@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170727193312.9849-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

Free cpumask cpus_to_visit in case registering
init_cpu_capacity_notifier has failed or the parsing of the cpu
capacity-dmips-mhz property is done. The cpumask cpus_to_visit is
only used inside the notifier call init_cpu_capacity_callback.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Juri Lelli <juri.lelli@arm.com>
Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: Juri Lelli <juri.lelli@arm.com>
Reviewed-by: Juri Lelli <juri.lelli@arm.com>
---
 drivers/base/arch_topology.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index d1c33a85059e..562e0c93ae52 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -206,6 +206,8 @@ static struct notifier_block init_cpu_capacity_notifier = {
 
 static int __init register_cpufreq_notifier(void)
 {
+	int ret;
+
 	/*
 	 * on ACPI-based systems we need to use the default cpu capacity
 	 * until we have the necessary code to parse the cpu capacity, so
@@ -221,8 +223,13 @@ static int __init register_cpufreq_notifier(void)
 
 	cpumask_copy(cpus_to_visit, cpu_possible_mask);
 
-	return cpufreq_register_notifier(&init_cpu_capacity_notifier,
-					 CPUFREQ_POLICY_NOTIFIER);
+	ret = cpufreq_register_notifier(&init_cpu_capacity_notifier,
+					CPUFREQ_POLICY_NOTIFIER);
+
+	if (ret)
+		free_cpumask_var(cpus_to_visit);
+
+	return ret;
 }
 core_initcall(register_cpufreq_notifier);
 
@@ -230,6 +237,7 @@ static void parsing_done_workfn(struct work_struct *work)
 {
 	cpufreq_unregister_notifier(&init_cpu_capacity_notifier,
 					 CPUFREQ_POLICY_NOTIFIER);
+	free_cpumask_var(cpus_to_visit);
 }
 
 #else
-- 
2.11.0
