From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv4 PATCH 17/34] sched: Introduce SD_SHARE_CAP_STATES sched_domain flag
Date: Tue, 12 May 2015 20:38:52 +0100
Message-ID: <1431459549-18343-18-git-send-email-morten.rasmussen@arm.com>
References: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, preeti@linux.vnet.ibm.com, mturquette@linaro.org, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, morten.rasmussen@arm.com
List-Id: linux-pm@vger.kernel.org

cpufreq is currently keeping it a secret which cpus are sharing
clock source. The scheduler needs to know about clock domains as well
to become more energy aware. The SD_SHARE_CAP_STATES domain flag
indicates whether cpus belonging to the sched_domain share capacity
states (P-states).

There is no connection with cpufreq (yet). The flag must be set by
the arch specific topology code.

cc: Russell King <linux@arm.linux.org.uk>
cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 arch/arm/kernel/topology.c |  3 ++-
 include/linux/sched.h      |  1 +
 kernel/sched/core.c        | 10 +++++++---
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 5867587..b35d3e5 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -276,7 +276,8 @@ void store_cpu_topology(unsigned int cpuid)
 
 static inline int cpu_corepower_flags(void)
 {
-	return SD_SHARE_PKG_RESOURCES  | SD_SHARE_POWERDOMAIN;
+	return SD_SHARE_PKG_RESOURCES  | SD_SHARE_POWERDOMAIN | \
+	       SD_SHARE_CAP_STATES;
 }
 
 static struct sched_domain_topology_level arm_topology[] = {
diff --git a/include/linux/sched.h b/include/linux/sched.h
index cf79eef..fe77e54 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -981,6 +981,7 @@ extern void wake_up_q(struct wake_q_head *head);
 #define SD_PREFER_SIBLING	0x1000	/* Prefer to place tasks in a sibling domain */
 #define SD_OVERLAP		0x2000	/* sched_domains of this level overlap */
 #define SD_NUMA			0x4000	/* cross-node balancing */
+#define SD_SHARE_CAP_STATES	0x8000  /* Domain members share capacity state */
 
 #ifdef CONFIG_SCHED_SMT
 static inline int cpu_smt_flags(void)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ab42515..5499b2c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5555,7 +5555,8 @@ static int sd_degenerate(struct sched_domain *sd)
 			 SD_BALANCE_EXEC |
 			 SD_SHARE_CPUCAPACITY |
 			 SD_SHARE_PKG_RESOURCES |
-			 SD_SHARE_POWERDOMAIN)) {
+			 SD_SHARE_POWERDOMAIN |
+			 SD_SHARE_CAP_STATES)) {
 		if (sd->groups != sd->groups->next)
 			return 0;
 	}
@@ -5587,7 +5588,8 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 				SD_SHARE_CPUCAPACITY |
 				SD_SHARE_PKG_RESOURCES |
 				SD_PREFER_SIBLING |
-				SD_SHARE_POWERDOMAIN);
+				SD_SHARE_POWERDOMAIN |
+				SD_SHARE_CAP_STATES);
 		if (nr_node_ids == 1)
 			pflags &= ~SD_SERIALIZE;
 	}
@@ -6241,6 +6243,7 @@ static int sched_domains_curr_level;
  * SD_SHARE_PKG_RESOURCES - describes shared caches
  * SD_NUMA                - describes NUMA topologies
  * SD_SHARE_POWERDOMAIN   - describes shared power domain
+ * SD_SHARE_CAP_STATES    - describes shared capacity states
  *
  * Odd one out:
  * SD_ASYM_PACKING        - describes SMT quirks
@@ -6250,7 +6253,8 @@ static int sched_domains_curr_level;
 	 SD_SHARE_PKG_RESOURCES |	\
 	 SD_NUMA |			\
 	 SD_ASYM_PACKING |		\
-	 SD_SHARE_POWERDOMAIN)
+	 SD_SHARE_POWERDOMAIN |		\
+	 SD_SHARE_CAP_STATES)
 
 static struct sched_domain *
 sd_init(struct sched_domain_topology_level *tl, int cpu)
-- 
1.9.1
