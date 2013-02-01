From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/3] cpufreq: Set all cpus in policy->cpus for single cluster
	SoCs
Date: Fri,  1 Feb 2013 12:10:01 +0530
Message-ID: <e76624720ca471d11ecd45628464d97e9eb513c9.1359700706.git.viresh.kumar@linaro.org>
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
Cc: Steve.Bannister-5wv7dgnIgG8@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

With following patch, we need to set policy->cpus with mask of all possible cpus
and policy->related_cpus would be filled automatically by the core.

commit 4948b355e90080cd5ec1e91189f65a01e4186ef2
Author: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Date:   Tue Jan 29 14:39:08 2013 +0000

cpufreq: Simplify cpufreq_add_dev()

Lets fix it for all single cluster SoCs.

Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
---
 drivers/cpufreq/db8500-cpufreq.c | 2 +-
 drivers/cpufreq/maple-cpufreq.c  | 2 +-
 drivers/cpufreq/spear-cpufreq.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/db8500-cpufreq.c b/drivers/cpufreq/db8500-cpufreq.c
index 4f154bc..e12dff6 100644
--- a/drivers/cpufreq/db8500-cpufreq.c
+++ b/drivers/cpufreq/db8500-cpufreq.c
@@ -128,7 +128,7 @@ static int __cpuinit db8500_cpufreq_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = 20 * 1000; /* in ns */
 
 	/* policy sharing between dual CPUs */
-	cpumask_copy(policy->cpus, cpu_present_mask);
+	cpumask_setall(policy->cpus);
 
 	policy->shared_type = CPUFREQ_SHARED_TYPE_ALL;
 
diff --git a/drivers/cpufreq/maple-cpufreq.c b/drivers/cpufreq/maple-cpufreq.c
index 89b178a..d4c4989 100644
--- a/drivers/cpufreq/maple-cpufreq.c
+++ b/drivers/cpufreq/maple-cpufreq.c
@@ -181,7 +181,7 @@ static int maple_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	/* secondary CPUs are tied to the primary one by the
 	 * cpufreq core if in the secondary policy we tell it that
 	 * it actually must be one policy together with all others. */
-	cpumask_copy(policy->cpus, cpu_online_mask);
+	cpumask_setall(policy->cpus);
 	cpufreq_frequency_table_get_attr(maple_cpu_freqs, policy->cpu);
 
 	return cpufreq_frequency_table_cpuinfo(policy,
diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index fc714a6..8126084 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -188,7 +188,7 @@ static int spear_cpufreq_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = spear_cpufreq.transition_latency;
 	policy->cur = spear_cpufreq_get(0);
 
-	cpumask_copy(policy->cpus, topology_core_cpumask(policy->cpu));
+	cpumask_setall(policy->cpus);
 
 	return 0;
 }
-- 
1.7.12.rc2.18.g61b472e
