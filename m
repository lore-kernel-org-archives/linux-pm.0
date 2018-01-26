From: Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v2 2/5] irqchip/gic-v3-its: add ability to save/restore ITS state
Date: Thu, 25 Jan 2018 23:38:32 -0800
Message-ID: <20180126073835.16575-3-dbasehore@chromium.org>
References: <20180126073835.16575-1-dbasehore@chromium.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180126073835.16575-1-dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Soby.Mathew-5wv7dgnIgG8@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Some platforms power off GIC logic in suspend, so we need to
save/restore state. The distributor and redistributor registers need
to be handled in platform code due to access permissions on those
registers, but the ITS registers can be restored in the kernel.

Signed-off-by: Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 86 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 06f025fd5726..4727b447610f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -33,6 +33,7 @@
 #include <linux/of_platform.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
+#include <linux/syscore_ops.h>
 
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic-v3.h>
@@ -46,6 +47,7 @@
 #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
+#define ITS_FLAGS_SAVE_SUSPEND_STATE		(1ULL << 3)
 
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
 
@@ -83,6 +85,15 @@ struct its_baser {
 	u32		psz;
 };
 
+/*
+ * Saved ITS state - this is where saved state for the ITS is stored
+ * when it's disabled during system suspend.
+ */
+struct its_ctx {
+	u64			cbaser;
+	u32			ctlr;
+};
+
 struct its_device;
 
 /*
@@ -101,6 +112,7 @@ struct its_node {
 	struct its_collection	*collections;
 	struct fwnode_handle	*fwnode_handle;
 	u64			(*get_msi_base)(struct its_device *its_dev);
+	struct its_ctx		its_ctx;
 	struct list_head	its_device_list;
 	u64			flags;
 	unsigned long		list_nr;
@@ -3042,6 +3054,75 @@ static void its_enable_quirks(struct its_node *its)
 	gic_enable_quirks(iidr, its_quirks, its);
 }
 
+int its_save_disable(void)
+{
+	struct its_node *its;
+	int err = 0;
+
+	spin_lock(&its_lock);
+	list_for_each_entry(its, &its_nodes, entry) {
+		if (its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE) {
+			struct its_ctx *ctx = &its->its_ctx;
+			void __iomem *base = its->base;
+
+			ctx->ctlr = readl_relaxed(base + GITS_CTLR);
+			err = its_force_quiescent(base);
+			if (err) {
+				writel_relaxed(ctx->ctlr, base + GITS_CTLR);
+				goto err;
+			}
+
+			ctx->cbaser = gits_read_cbaser(base + GITS_CBASER);
+		}
+	}
+
+err:
+	if (err) {
+		list_for_each_entry_continue_reverse(its, &its_nodes, entry) {
+			if (its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE) {
+				struct its_ctx *ctx = &its->its_ctx;
+				void __iomem *base = its->base;
+
+				writel_relaxed(ctx->ctlr, base + GITS_CTLR);
+			}
+		}
+	}
+
+	spin_unlock(&its_lock);
+
+	return err;
+}
+
+void its_restore_enable(void)
+{
+	struct its_node *its;
+
+	spin_lock(&its_lock);
+	list_for_each_entry(its, &its_nodes, entry) {
+		struct its_ctx *ctx = &its->its_ctx;
+		struct its_baser *baser;
+		void __iomem *base;
+		int i;
+
+		if (its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE) {
+			base = its->base;
+			gits_write_cbaser(ctx->cbaser, base + GITS_CBASER);
+			/* Restore GITS_BASER from the value cache. */
+			for (i = 0; i < GITS_BASER_NR_REGS; i++) {
+				baser = &its->tables[i];
+				its_write_baser(its, baser, baser->val);
+			}
+			writel_relaxed(ctx->ctlr, base + GITS_CTLR);
+		}
+	}
+	spin_unlock(&its_lock);
+}
+
+static struct syscore_ops its_syscore_ops = {
+	.suspend = its_save_disable,
+	.resume = its_restore_enable,
+};
+
 static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
 {
 	struct irq_domain *inner_domain;
@@ -3261,6 +3342,9 @@ static int __init its_probe_one(struct resource *res,
 		ctlr |= GITS_CTLR_ImDe;
 	writel_relaxed(ctlr, its->base + GITS_CTLR);
 
+	if (fwnode_property_present(handle, "reset-on-suspend"))
+		its->flags |= ITS_FLAGS_SAVE_SUSPEND_STATE;
+
 	err = its_init_domain(handle, its);
 	if (err)
 		goto out_free_tables;
@@ -3515,5 +3599,7 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 		}
 	}
 
+	register_syscore_ops(&its_syscore_ops);
+
 	return 0;
 }
-- 
2.16.0.rc1.238.g530d649a79-goog

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
