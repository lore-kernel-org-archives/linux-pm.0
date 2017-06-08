From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH 6/6] arm64: wire cpu-invariant accounting support up to the task scheduler
Date: Thu,  8 Jun 2017 08:55:13 +0100
Message-ID: <20170608075513.12475-7-dietmar.eggemann@arm.com>
References: <20170608075513.12475-1-dietmar.eggemann@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170608075513.12475-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaor.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

Commit 8cd5601c5060 ("sched/fair: Convert arch_scale_cpu_capacity() from
weak function to #define") changed the wiring which now has to be done
by associating arch_scale_cpu_capacity with the actual implementation
provided by the architecture.

Define arch_scale_cpu_capacity to use the arch_topology "driver"
function topology_get_cpu_scale() for the task scheduler's cpu-invariant
accounting instead of the default arch_scale_cpu_capacity() in
kernel/sched/sched.h.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Juri Lelli <juri.lelli@arm.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 arch/arm64/include/asm/topology.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index 44598a86ec4a..e313eeb10756 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -37,6 +37,9 @@ int pcibus_to_node(struct pci_bus *bus);
 /* Replace task scheduler's default frequency-invariant accounting */
 #define arch_scale_freq_capacity topology_get_freq_scale
 
+/* Replace task scheduler's default cpu-invariant accounting */
+#define arch_scale_cpu_capacity topology_get_cpu_scale
+
 #include <asm-generic/topology.h>
 
 #endif /* _ASM_ARM_TOPOLOGY_H */
-- 
2.11.0
