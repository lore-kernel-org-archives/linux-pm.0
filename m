From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH v2 08/10] arm64: wire frequency-invariant accounting support up to the task scheduler
Date: Thu,  6 Jul 2017 10:49:46 +0100
Message-ID: <20170706094948.8779-9-dietmar.eggemann@arm.com>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170706094948.8779-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

Commit dfbca41f3479 ("sched: Optimize freq invariant accounting")
changed the wiring which now has to be done by associating
arch_scale_freq_capacity with the actual implementation provided
by the architecture.

Define arch_scale_freq_capacity to use the arch_topology "driver"
function topology_get_freq_scale() for the task scheduler's
frequency-invariant accounting instead of the default
arch_scale_freq_capacity() in kernel/sched/sched.h.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Juri Lelli <juri.lelli@arm.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: Juri Lelli <juri.lelli@arm.com>
Reviewed-by: Juri Lelli <juri.lelli@arm.com>
---
 arch/arm64/include/asm/topology.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index d9cbb289e295..4fd598b432e6 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -37,6 +37,9 @@ int pcibus_to_node(struct pci_bus *bus);
 /* Subscribe for input data for frequency-invariant load-tracking */
 #define arch_set_freq_scale topology_set_freq_scale
 
+/* Replace task scheduler's default frequency-invariant accounting */
+#define arch_scale_freq_capacity topology_get_freq_scale
+
 #include <asm-generic/topology.h>
 
 #endif /* _ASM_ARM_TOPOLOGY_H */
-- 
2.11.0
