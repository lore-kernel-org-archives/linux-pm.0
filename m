From: Juri Lelli <juri.lelli@arm.com>
Subject: [RFC PATCH v2 3/4] arm: Enable dynamic CPU capacity initialization
Date: Fri,  8 Jan 2016 14:09:31 +0000
Message-ID: <1452262172-31861-4-git-send-email-juri.lelli@arm.com>
References: <1452262172-31861-1-git-send-email-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452262172-31861-1-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org

Define arch_wants_init_cpu_capacity() to return true; so that
cpufreq_init_cpu_capacity() can go ahead and profile CPU capacities
at boot time.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 arch/arm/kernel/topology.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index c9c87a5..7d7fc2c 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -52,6 +52,11 @@ void set_capacity_scale(unsigned int cpu, unsigned long capacity)
 	per_cpu(cpu_scale, cpu) = capacity;
 }
 
+bool arch_wants_init_cpu_capacity(void)
+{
+	return true;
+}
+
 #ifdef CONFIG_OF
 struct cpu_efficiency {
 	const char *compatible;
-- 
2.2.2
