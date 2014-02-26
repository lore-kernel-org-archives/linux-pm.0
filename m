From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: [PATCH v3 2/3] ARM: avoid tracers in soft_restart
Date: Tue, 25 Feb 2014 16:01:59 -0800
Message-ID: <1393372920-3896-3-git-send-email-sebastian.capella@linaro.org>
References: <1393372920-3896-1-git-send-email-sebastian.capella@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393372920-3896-1-git-send-email-sebastian.capella@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc: Sebastian Capella <sebastian.capella@linaro.org>, Russell King <linux@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Robin Holt <robin.m.holt@gmail.com>
List-Id: linux-pm@vger.kernel.org

Use of tracers in local_irq_disable is causes abort loops when called
with irqs disabled using a temporary stack.  Replace local_irq_disable
with raw_local_irq_disable instead to avoid tracers.

Signed-off-by: Sebastian Capella <sebastian.capella@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Robin Holt <robin.m.holt@gmail.com>
---
 arch/arm/kernel/process.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 92f7b15..f58b723 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -100,7 +100,7 @@ void soft_restart(unsigned long addr)
 	u64 *stack = soft_restart_stack + ARRAY_SIZE(soft_restart_stack);
 
 	/* Disable interrupts first */
-	local_irq_disable();
+	raw_local_irq_disable();
 	local_fiq_disable();
 
 	/* Disable the L2 if we're the last man standing. */
-- 
1.7.9.5
