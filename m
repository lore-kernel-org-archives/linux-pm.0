From: "Fenghua Yu" <fenghua.yu@intel.com>
Subject: [PATCH v10 12/14] x86, hotplug: Handle retrigger irq by the first available CPU
Date: Tue, 13 Nov 2012 11:32:49 -0800
Message-ID: <1352835171-3958-13-git-send-email-fenghua.yu@intel.com>
References: <1352835171-3958-1-git-send-email-fenghua.yu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352835171-3958-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, H Peter Anvin <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Asit K Mallick <asit.k.mallick@intel.com>, Tony Luck <tony.luck@intel.com>, Arjan Dan De Ven <arjan@linux.intel.com>, Suresh B Siddha <suresh.b.siddha@intel.com>, Len Brown <len.brown@intel.com>, "Srivatssa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Randy Dunlap <rdunlap@xenotime.net>, "Rafael J. Wysocki" <rjw@sisk.pl>, Chen Gong <gong.chen@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, x86 <x86@kernel.org>
Cc: Fenghua Yu <fenghua.yu@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

The first cpu in irq cfg->domain is likely to be CPU 0 and may not be available
when CPU 0 is offline. Instead of using CPU 0 to handle retriggered irq, we use
first available CPU which is online and in this irq's domain.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/kernel/apic/io_apic.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index b134f0b..c94bac8 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2199,9 +2199,11 @@ static int ioapic_retrigger_irq(struct irq_data *data)
 {
 	struct irq_cfg *cfg = data->chip_data;
 	unsigned long flags;
+	int cpu;
 
 	raw_spin_lock_irqsave(&vector_lock, flags);
-	apic->send_IPI_mask(cpumask_of(cpumask_first(cfg->domain)), cfg->vector);
+	cpu = cpumask_first_and(cfg->domain, cpu_online_mask);
+	apic->send_IPI_mask(cpumask_of(cpu), cfg->vector);
 	raw_spin_unlock_irqrestore(&vector_lock, flags);
 
 	return 1;
-- 
1.7.2
