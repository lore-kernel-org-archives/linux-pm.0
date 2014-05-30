From: Yuyang Du <yuyang.du@intel.com>
Subject: [RFC PATCH 07/16 v3] Init Workload Consolidation flags in sched_domain
Date: Fri, 30 May 2014 14:36:03 +0800
Message-ID: <1401431772-14320-8-git-send-email-yuyang.du@intel.com>
References: <1401431772-14320-1-git-send-email-yuyang.du@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1401431772-14320-1-git-send-email-yuyang.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com, peterz@infradead.org, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: arjan.van.de.ven@intel.com, len.brown@intel.com, alan.cox@intel.com, mark.gross@intel.com, pjt@google.com, bsegall@google.com, morten.rasmussen@arm.com, vincent.guittot@linaro.org, rajeev.d.muralidhar@intel.com, vishwesh.m.rudramuni@intel.com, nicole.chalhoub@intel.com, ajaya.durg@intel.com, harinarayanan.seshadri@intel.com, jacob.jun.pan@linux.intel.com, fengguang.wu@intel.com, yuyang.du@intel.com
List-Id: linux-pm@vger.kernel.org

Workload Consolidation can be enabled/disabled on the fly. This patchset
enables MC and CPU domain WC by default.

To enable CPU WC (SD_WORKLOAD_CONSOLIDATION=0x8000):

sysctl -w kernel.sched_domain.cpuX.domainY.flags += 0x8000

To disable CPU WC:

sysctl -w kernel.sched_domain.cpuX.domainY.flags -= 0x8000

Signed-off-by: Yuyang Du <yuyang.du@intel.com>
---
 include/linux/topology.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/topology.h b/include/linux/topology.h
index 7062330..ebc339c3 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -102,12 +102,14 @@ int arch_update_cpu_topology(void);
 				| 0*SD_SERIALIZE			\
 				| 0*SD_PREFER_SIBLING			\
 				| arch_sd_sibling_asym_packing()	\
+				| 0*SD_WORKLOAD_CONSOLIDATION	\
 				,					\
 	.last_balance		= jiffies,				\
 	.balance_interval	= 1,					\
 	.smt_gain		= 1178,	/* 15% */			\
 	.max_newidle_lb_cost	= 0,					\
 	.next_decay_max_lb_cost	= jiffies,				\
+	.consolidating_coeff = 0,					\
 }
 #endif
 #endif /* CONFIG_SCHED_SMT */
@@ -134,11 +136,13 @@ int arch_update_cpu_topology(void);
 				| 0*SD_SHARE_CPUPOWER			\
 				| 1*SD_SHARE_PKG_RESOURCES		\
 				| 0*SD_SERIALIZE			\
+				| 1*SD_WORKLOAD_CONSOLIDATION	\
 				,					\
 	.last_balance		= jiffies,				\
 	.balance_interval	= 1,					\
 	.max_newidle_lb_cost	= 0,					\
 	.next_decay_max_lb_cost	= jiffies,				\
+	.consolidating_coeff = 180,					\
 }
 #endif
 #endif /* CONFIG_SCHED_MC */
@@ -167,11 +171,13 @@ int arch_update_cpu_topology(void);
 				| 0*SD_SHARE_PKG_RESOURCES		\
 				| 0*SD_SERIALIZE			\
 				| 1*SD_PREFER_SIBLING			\
+				| 1*SD_WORKLOAD_CONSOLIDATION	\
 				,					\
 	.last_balance		= jiffies,				\
 	.balance_interval	= 1,					\
 	.max_newidle_lb_cost	= 0,					\
 	.next_decay_max_lb_cost	= jiffies,				\
+	.consolidating_coeff = 180,					\
 }
 #endif
 
-- 
1.7.9.5
