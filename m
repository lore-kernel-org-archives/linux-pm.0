From: Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH 8/8] irqchip/gic-v3: add power down/up sequence
Date: Fri, 12 Jan 2018 13:24:22 -0800
Message-ID: <20180112212422.148625-9-dbasehore@chromium.org>
References: <20180112212422.148625-1-dbasehore@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180112212422.148625-1-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, tglx@linutronix.de, briannorris@chromium.org, marc.zyngier@arm.com, Derek Basehore <dbasehore@chromium.org>
List-Id: linux-pm@vger.kernel.org

This adds the implementation specific power down/up sequence for the
GIC-500 and the GIC-600 (which are implementations of the GIC-v3
specification). This allows the LPI pending information to be properly
flushed on suspend if the GIC is disabled.

Change-Id: Iad2135b5f5a57f7dc0c15d05e4b9a06e1b4c24d1
Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/irqchip/irq-gic-v3.c       | 58 ++++++++++++++++++++++++++++++++++++++
 include/linux/irqchip/arm-gic-v3.h |  9 ++++++
 2 files changed, 67 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 95d37fb6f458..5286757dd413 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -816,6 +816,35 @@ static void gic_redist_save(int cpu)
 	ctx->nsacr = readl_relaxed(base + GICR_NSACR);
 }
 
+static void gic_power_down(void)
+{
+	void __iomem *base = gic_data.dist_base;
+	u32 product_id = readl_relaxed(base + GICD_IIDR) >>
+			 GICD_IIDR_PRODUCTID_SHIFT;
+
+	/*
+	 * This power down sequence is implementation defined. It's the same for
+	 * the GIC-500 and GIC-600.
+	 */
+	if ((product_id & GIC500_IIDR_PRODUCTID) ||
+	    (product_id & GIC600_IIDR_PRODUCTID)) {
+		u32 val;
+
+		/*
+		 * There's only one instance of the GICR_WAKER register which
+		 * each redistributor maps to. So this just needs to be set for
+		 * the current CPU.
+		 */
+		base = gic_data_rdist_rd_base();
+		val = readl_relaxed(base + GICR_WAKER);
+		writel_relaxed(val | GICR_WAKER_Sleep, base + GICR_WAKER);
+		while (!(readl_relaxed(base + GICR_WAKER) &
+			 GICR_WAKER_Quiescent))
+			;
+
+	}
+}
+
 static void gic_dist_save(void)
 {
 	struct gic_dist_ctx *ctx = gic_data.gicd_ctx;
@@ -871,6 +900,7 @@ static int gic_suspend(void)
 	for_each_possible_cpu(cpu)
 		gic_redist_save(cpu);
 
+	gic_power_down();
 	its_save_disable();
 	gic_dist_save();
 
@@ -901,6 +931,33 @@ static void gic_rdist_restore(int cpu)
 	gic_do_wait_for_rwp(base);
 }
 
+static void gic_power_up(void)
+{
+	void __iomem *base = gic_data.dist_base;
+	u32 product_id = readl_relaxed(base + GICD_IIDR) >>
+			 GICD_IIDR_PRODUCTID_SHIFT;
+
+	/*
+	 * Same as the power down sequence, this part of the power up sequence
+	 * is implementation defined.
+	 */
+	if ((product_id & GIC500_IIDR_PRODUCTID) ||
+	    (product_id & GIC600_IIDR_PRODUCTID)) {
+		u32 val;
+
+		/*
+		 * Need to turn the GIC back on in-case suspend is cancelled.
+		 * The GIC hardware reset state or the platform layer should
+		 * handle this otherwise.
+		 */
+		base = gic_data_rdist_rd_base();
+		val = readl_relaxed(base + GICR_WAKER);
+		writel_relaxed(val & ~GICR_WAKER_Sleep, base + GICR_WAKER);
+		while (readl_relaxed(base + GICR_WAKER) & GICR_WAKER_Quiescent)
+			;
+	}
+}
+
 static void gic_dist_restore(void)
 {
 	struct gic_dist_ctx *ctx = gic_data.gicd_ctx;
@@ -937,6 +994,7 @@ static void gic_resume(void)
 
 	gic_dist_restore();
 	its_restore_enable();
+	gic_power_up();
 	for_each_possible_cpu(cpu)
 		gic_rdist_restore(cpu);
 
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index f086987e3cb4..22ced72be1c5 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -59,6 +59,10 @@
 #define GICD_NSACR_SHIFT		4
 #define GICD_IROUTER_SHIFT		0
 
+#define GICD_IIDR_PRODUCTID_SHIFT	24
+#define GIC500_IIDR_PRODUCTID		0x00
+#define GIC600_IIDR_PRODUCTID		0x02
+
 /*
  * Those registers are actually from GICv2, but the spec demands that they
  * are implemented as RES0 if ARE is 1 (which we do in KVM's emulated GICv3).
@@ -122,8 +126,13 @@
 
 #define GICR_TYPER_CPU_NUMBER(r)	(((r) >> 8) & 0xffff)
 
+/*
+ * Sleep and Quiescent are implementation specific for the GIC-500 and GIC-600.
+ */
+#define GICR_WAKER_Sleep		(1U << 0)
 #define GICR_WAKER_ProcessorSleep	(1U << 1)
 #define GICR_WAKER_ChildrenAsleep	(1U << 2)
+#define GICR_WAKER_Quiescent		(1U << 31)
 
 #define GIC_BASER_CACHE_nCnB		0ULL
 #define GIC_BASER_CACHE_SameAsInner	0ULL
-- 
2.16.0.rc1.238.g530d649a79-goog
