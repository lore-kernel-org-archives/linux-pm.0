From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/3] cpufreq: Remove unnecessary use of policy->shared_type
Date: Fri,  1 Feb 2013 12:10:02 +0530
Message-ID: <902bed453159832925df76e24806f3b919fdfc74.1359700706.git.viresh.kumar@linaro.org>
References: <1bf82454ab1f16b13212548d7c9605067c8b7a0d.1359700705.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1bf82454ab1f16b13212548d7c9605067c8b7a0d.1359700705.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <1bf82454ab1f16b13212548d7c9605067c8b7a0d.1359700705.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <1bf82454ab1f16b13212548d7c9605067c8b7a0d.1359700705.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: rjw-KKrjLPT3xs0@public.gmane.org
Cc: Steve.Bannister-5wv7dgnIgG8@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

policy->shared_type field was added only for SoCs with ACPI support:

commit 3b2d99429e3386b6e2ac949fc72486509c8bbe36
Author: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Wed Dec 14 15:05:00 2005 -0500

    P-state software coordination for ACPI core

    http://bugzilla.kernel.org/show_bug.cgi?id=5737

Many non-ACPI systems are filling this field by mistake, which makes its usage
confusing. Lets clean it.

Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-tegra/cpu-tegra.c  | 1 -
 drivers/cpufreq/cpufreq-cpu0.c   | 1 -
 drivers/cpufreq/db8500-cpufreq.c | 2 --
 drivers/cpufreq/omap-cpufreq.c   | 4 +---
 include/linux/cpufreq.h          | 3 ++-
 5 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-tegra/cpu-tegra.c b/arch/arm/mach-tegra/cpu-tegra.c
index e7ddcb2..a36a03d 100644
--- a/arch/arm/mach-tegra/cpu-tegra.c
+++ b/arch/arm/mach-tegra/cpu-tegra.c
@@ -243,7 +243,6 @@ static int tegra_cpu_init(struct cpufreq_policy *policy)
 	/* FIXME: what's the actual transition time? */
 	policy->cpuinfo.transition_latency = 300 * 1000;
 
-	policy->shared_type = CPUFREQ_SHARED_TYPE_ALL;
 	cpumask_copy(policy->cpus, cpu_possible_mask);
 
 	if (policy->cpu == 0)
diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index 38ae178..6a538de 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -146,7 +146,6 @@ static int cpu0_cpufreq_init(struct cpufreq_policy *policy)
 	 * share the clock and voltage and clock.  Use cpufreq affected_cpus
 	 * interface to have all CPUs scaled together.
 	 */
-	policy->shared_type = CPUFREQ_SHARED_TYPE_ANY;
 	cpumask_setall(policy->cpus);
 
 	cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
diff --git a/drivers/cpufreq/db8500-cpufreq.c b/drivers/cpufreq/db8500-cpufreq.c
index e12dff6..79a8486 100644
--- a/drivers/cpufreq/db8500-cpufreq.c
+++ b/drivers/cpufreq/db8500-cpufreq.c
@@ -130,8 +130,6 @@ static int __cpuinit db8500_cpufreq_init(struct cpufreq_policy *policy)
 	/* policy sharing between dual CPUs */
 	cpumask_setall(policy->cpus);
 
-	policy->shared_type = CPUFREQ_SHARED_TYPE_ALL;
-
 	return 0;
 }
 
diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 97102b0..9128c07 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -214,10 +214,8 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 	 * interface to handle this scenario. Additional is_smp() check
 	 * is to keep SMP_ON_UP build working.
 	 */
-	if (is_smp()) {
-		policy->shared_type = CPUFREQ_SHARED_TYPE_ANY;
+	if (is_smp())
 		cpumask_setall(policy->cpus);
-	}
 
 	/* FIXME: what's the actual transition time? */
 	policy->cpuinfo.transition_latency = 300 * 1000;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 6bf3f2d..a22944c 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -93,7 +93,7 @@ struct cpufreq_policy {
 	cpumask_var_t		cpus;	/* Online CPUs only */
 	cpumask_var_t		related_cpus; /* Online + Offline CPUs */
 
-	unsigned int		shared_type; /* ANY or ALL affected CPUs
+	unsigned int		shared_type; /* ACPI: ANY or ALL affected CPUs
 						should set cpufreq */
 	unsigned int		cpu;    /* cpu nr of CPU managing this policy */
 	unsigned int		last_cpu; /* cpu nr of previous CPU that managed
@@ -122,6 +122,7 @@ struct cpufreq_policy {
 #define CPUFREQ_START			(3)
 #define CPUFREQ_UPDATE_POLICY_CPU	(4)
 
+/* Only for ACPI */
 #define CPUFREQ_SHARED_TYPE_NONE (0) /* None */
 #define CPUFREQ_SHARED_TYPE_HW	 (1) /* HW does needed coordination */
 #define CPUFREQ_SHARED_TYPE_ALL	 (2) /* All dependent CPUs should set freq */
-- 
1.7.12.rc2.18.g61b472e
