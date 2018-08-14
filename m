From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH v12 01/14] ARM: Add Krait L2 register accessor functions
Date: Tue, 14 Aug 2018 17:42:20 +0530
Message-ID: <1534248753-2440-2-git-send-email-sricharan@codeaurora.org>
References: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mark.rutland@arm.com, robh@kernel.org, sudeep.holla@arm.com, linux@arm.linux.org.uk, ctatlor97@gmail.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, linux-pm@vger.kernel.org, sboyd@codeaurora.org, linux@armlinux.org.uk, thierry.escande@linaro.org, linux-kernel@vger.kernel.org, david.brown@linaro.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, andy.gross@linaro.org, linux-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, niklas.cassel@linaro.org
Cc: sricharan@codeaurora.org
List-Id: linux-pm@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

Krait CPUs have a handful of L2 cache controller registers that
live behind a cp15 based indirection register. First you program
the indirection register (l2cpselr) to point the L2 'window'
register (l2cpdr) at what you want to read/write.  Then you
read/write the 'window' register to do what you want. The
l2cpselr register is not banked per-cpu so we must lock around
accesses to it to prevent other CPUs from re-pointing l2cpdr
underneath us.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm/common/Kconfig                   |  3 ++
 arch/arm/common/Makefile                  |  1 +
 arch/arm/common/krait-l2-accessors.c      | 48 +++++++++++++++++++++++++++++++
 arch/arm/include/asm/krait-l2-accessors.h |  9 ++++++
 4 files changed, 61 insertions(+)
 create mode 100644 arch/arm/common/krait-l2-accessors.c
 create mode 100644 arch/arm/include/asm/krait-l2-accessors.h

diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
index e5ad070..c8e1986 100644
--- a/arch/arm/common/Kconfig
+++ b/arch/arm/common/Kconfig
@@ -7,6 +7,9 @@ config DMABOUNCE
 	bool
 	select ZONE_DMA
 
+config KRAIT_L2_ACCESSORS
+	bool
+
 config SHARP_LOCOMO
 	bool
 
diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index 3157be4..219a260 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -7,6 +7,7 @@ obj-y				+= firmware.o
 
 obj-$(CONFIG_SA1111)		+= sa1111.o
 obj-$(CONFIG_DMABOUNCE)		+= dmabounce.o
+obj-$(CONFIG_KRAIT_L2_ACCESSORS) += krait-l2-accessors.o
 obj-$(CONFIG_SHARP_LOCOMO)	+= locomo.o
 obj-$(CONFIG_SHARP_PARAM)	+= sharpsl_param.o
 obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
diff --git a/arch/arm/common/krait-l2-accessors.c b/arch/arm/common/krait-l2-accessors.c
new file mode 100644
index 0000000..9a97dda
--- /dev/null
+++ b/arch/arm/common/krait-l2-accessors.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, The Linux Foundation. All rights reserved.
+
+#include <linux/spinlock.h>
+#include <linux/export.h>
+
+#include <asm/barrier.h>
+#include <asm/krait-l2-accessors.h>
+
+static DEFINE_RAW_SPINLOCK(krait_l2_lock);
+
+void krait_set_l2_indirect_reg(u32 addr, u32 val)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&krait_l2_lock, flags);
+	/*
+	 * Select the L2 window by poking l2cpselr, then write to the window
+	 * via l2cpdr.
+	 */
+	asm volatile ("mcr p15, 3, %0, c15, c0, 6 @ l2cpselr" : : "r" (addr));
+	isb();
+	asm volatile ("mcr p15, 3, %0, c15, c0, 7 @ l2cpdr" : : "r" (val));
+	isb();
+
+	raw_spin_unlock_irqrestore(&krait_l2_lock, flags);
+}
+EXPORT_SYMBOL(krait_set_l2_indirect_reg);
+
+u32 krait_get_l2_indirect_reg(u32 addr)
+{
+	u32 val;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&krait_l2_lock, flags);
+	/*
+	 * Select the L2 window by poking l2cpselr, then read from the window
+	 * via l2cpdr.
+	 */
+	asm volatile ("mcr p15, 3, %0, c15, c0, 6 @ l2cpselr" : : "r" (addr));
+	isb();
+	asm volatile ("mrc p15, 3, %0, c15, c0, 7 @ l2cpdr" : "=r" (val));
+
+	raw_spin_unlock_irqrestore(&krait_l2_lock, flags);
+
+	return val;
+}
+EXPORT_SYMBOL(krait_get_l2_indirect_reg);
diff --git a/arch/arm/include/asm/krait-l2-accessors.h b/arch/arm/include/asm/krait-l2-accessors.h
new file mode 100644
index 0000000..a5f2cdd
--- /dev/null
+++ b/arch/arm/include/asm/krait-l2-accessors.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASMARM_KRAIT_L2_ACCESSORS_H
+#define __ASMARM_KRAIT_L2_ACCESSORS_H
+
+extern void krait_set_l2_indirect_reg(u32 addr, u32 val);
+extern u32 krait_get_l2_indirect_reg(u32 addr);
+
+#endif
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
