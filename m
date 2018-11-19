From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH v9 09/15] sched: Introduce sched_energy_present static key
Date: Mon, 19 Nov 2018 14:18:51 +0000
Message-ID: <20181119141857.8625-10-quentin.perret@arm.com>
References: <20181119141857.8625-1-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181119141857.8625-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org, quentin.perret@arm.com
List-Id: linux-pm@vger.kernel.org

In order to make sure Energy Aware Scheduling (EAS) will not impact
systems where no Energy Model is available, introduce a static key
guarding the access to EAS code. Since EAS is enabled on a
per-root-domain basis, the static key is enabled when at least one root
domain meets all conditions for EAS.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 kernel/sched/sched.h    |  4 ++++
 kernel/sched/topology.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0278b251c379..5b636a8aa900 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2298,3 +2298,7 @@ unsigned long scale_irq_capacity(unsigned long util, unsigned long irq, unsigned
 #else
 #define perf_domain_span(pd) NULL
 #endif
+
+#ifdef CONFIG_SMP
+extern struct static_key_false sched_energy_present;
+#endif
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 70492d4bfed6..1457ef80ee94 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -201,6 +201,7 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 	return 1;
 }
 
+DEFINE_STATIC_KEY_FALSE(sched_energy_present);
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 DEFINE_MUTEX(sched_energy_mutex);
 bool sched_energy_update;
@@ -273,6 +274,35 @@ static void destroy_perf_domain_rcu(struct rcu_head *rp)
 	free_pd(pd);
 }
 
+static void sched_energy_start(int ndoms_new, cpumask_var_t doms_new[])
+{
+	/*
+	 * The conditions for EAS to start are checked during the creation of
+	 * root domains. If one of them meets all conditions, it will have a
+	 * non-null list of performance domains.
+	 */
+	while (ndoms_new) {
+		if (cpu_rq(cpumask_first(doms_new[ndoms_new - 1]))->rd->pd)
+			goto enable;
+		ndoms_new--;
+	}
+
+	if (static_branch_unlikely(&sched_energy_present)) {
+		if (sched_debug())
+			pr_info("%s: stopping EAS\n", __func__);
+		static_branch_disable_cpuslocked(&sched_energy_present);
+	}
+
+	return;
+
+enable:
+	if (!static_branch_unlikely(&sched_energy_present)) {
+		if (sched_debug())
+			pr_info("%s: starting EAS\n", __func__);
+		static_branch_enable_cpuslocked(&sched_energy_present);
+	}
+}
+
 /*
  * EAS can be used on a root domain if it meets all the following conditions:
  *    1. an Energy Model (EM) is available;
@@ -2187,6 +2217,7 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 match3:
 		;
 	}
+	sched_energy_start(ndoms_new, doms_new);
 #endif
 
 	/* Remember the new sched domains: */
-- 
2.19.1
