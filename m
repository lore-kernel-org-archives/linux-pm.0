From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv5 PATCH 05/46] arm: Update arch_scale_cpu_capacity() to reflect change to define
Date: Tue,  7 Jul 2015 19:23:48 +0100
Message-ID: <1436293469-25707-6-git-send-email-morten.rasmussen@arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37357 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932684AbbGGSWN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 7 Jul 2015 14:22:13 -0400
In-Reply-To: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Russell King <linux@arm.linux.org.uk>

arch_scale_cpu_capacity() is no longer a weak function but a #define
instead. Include the #define in topology.h.

cc: Russell King <linux@arm.linux.org.uk>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 arch/arm/include/asm/topology.h | 4 ++++
 arch/arm/kernel/topology.c      | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
index c31096f..1b8902c 100644
--- a/arch/arm/include/asm/topology.h
+++ b/arch/arm/include/asm/topology.h
@@ -31,6 +31,10 @@ unsigned long arm_arch_scale_freq_capacity(struct sched_domain *sd, int cpu);
 
 DECLARE_PER_CPU(atomic_long_t, cpu_freq_capacity);
 
+#define arch_scale_cpu_capacity arm_arch_scale_cpu_capacity
+extern
+unsigned long arm_arch_scale_cpu_capacity(struct sched_domain *sd, int cpu);
+
 #else
 
 static inline void init_cpu_topology(void) { }
diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 9c09e6e..bad267c 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -42,7 +42,7 @@
  */
 static DEFINE_PER_CPU(unsigned long, cpu_scale);
 
-unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
+unsigned long arm_arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
 {
 	return per_cpu(cpu_scale, cpu);
 }
-- 
1.9.1

