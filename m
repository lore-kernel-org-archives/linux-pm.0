Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792853262;
	b=v8rF4Acc9klxk/FT3EvVMCH4Zn79M8jOlPFn0GVcFMol1dgWOI6cNjbxE0ewtRCTFWhK
	 v3eAiP/wSqGo5SIDNkEpGvRzo29c0j6hWTqlbA1kr0RtIMpkRdPmHbewSe3cvNPkCaOaR
	 Ymx4YCOJi9gYUJhH8cPjrG8g+rtJ90X9d7wxu0S880rAzL8z+KwS4+JX9sHNqWJalYohv
	 FB5l6mKYfVMi/Sp+O1VpwWc9wecamnE9w1NAKePz9wPcXf26sLgUTWz4iING7L5Lu1vYi
	 9328bfPsDnQMJJ6+xrqd3IP9W8ryFpw5IVZ4BUmR3hH/+PHeEBF4Xlz5OTeDwWy8DFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792853262;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=Hpn8vhaALP5mXUzJnn7dmewFxHKudOANi4WIthOjoCA=;
	b=XsgpQtnvY2xbHxOai73EhR+YnVM/c/0RA5yNAHXk36swuAOYmpqWIbSgJoMVAYgqtNtR
	 Xq2+f9u4iNET3MknywjE4D/XZx7yf8m2/vTzMzYxF7zQOmKshC5X2rCgMPG0/NJd/ymOa
	 KLuPfzAAxbgRn/qzSb590wnni91O4rC7wxpo7HQruA3idoNsTCLxn2+D7ZeVOZbemQDpr
	 YlqzWDOXMze2ZSQfo4gSv2O06jOScydXwgD4zs15wQ18iJ+XF0CI6XHOLmkNFXQaTT6tm
	 enc1QQjbZ27X/bGevQ/P5HFmSFT+jV7KeFmqSAzmtvm1cvOVq9LLWQ4qxRe6N60z5MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=phytium.com.cn;
	spf=pass smtp.mailfrom=phytium.com.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B750606A324;
	Sat, 24 Oct 2026 14:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B750606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwDHHd0Lxdxqt2ZrAQ--.7367S2;
	Sat, 24 Oct 2026 22:47:39 +0800 (CST)
Received: from WIN-B62RPRBL2BM.localdomain (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAf8DwanUExdxqpOjwAA--.14665S4;
	Sat, 24 Oct 2026 22:47:38 +0800 (CST)
From: Zhu Ling <zhuling2709@phytium.com.cn>
To: maz@kernel.org
Cc: Zhu Ling <zhuling2709@phytium.com.cn>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] irqchip/gic-v3: Preserve SPI configuration across hibernation
Date: Sat, 24 Oct 2026 22:47:13 +0800
Message-ID: <20261024144720.113165-2-zhuling2709@phytium.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024144720.113165-1-zhuling2709@phytium.com.cn>
References: <20261024144720.113165-1-zhuling2709@phytium.com.cn>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DwanUExdxqpOjwAA--.14665S4
X-CM-SenderInfo: x2kxzxlqjsliuz6sx5pwlxzhxfrphubq/1tbiAQAPAWrXwUoEpgAqsx
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=zhuling270
	9@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3Jry8uF4kuFWfKr1xWr1UAwb_yoW3Zw1kpF
	WDKFyFyF47JF1xGrZFqF1jvF95W3s7u3yUJr95Gasxu342kryvqa1vvF9YqFyUArZ7ua47
	XF45XFy7Cr48Jr7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

A module-installed chained SPI can remain disabled after restoring a
hibernation image. The boot kernel initializes the distributor but
need not load that module. The restored IRQ descriptor still records
the interrupt as started, enabled and unmasked. Chained interrupts
are skipped by suspend_device_irqs(), so resume_device_irqs() does
not re-enable them.

On the Phytium E2000Q platform, an independent module reproduces this
on SPI 189 with GPIOLIB disabled and no vendor GPIO driver. Ordinary
IRQ mode delivers both pending-state injections, before and after
real S4. Chained mode delivers only the first and leaves the second
pending with the hardware enable bit clear. Unmasking alone delivers
that queued interrupt without rebinding the handler.

Preserve SPI/ESPI enables, trigger configuration, priorities and routing
in the GICv3 driver. Allocate the context on PM_HIBERNATION_PREPARE and
capture it in syscore suspend, after device IRQ suspension. Restore
configuration with the SPIs disabled, then restore the saved enables.
This preserves the snapshot mask state without changing generic IRQ
PM policy or reinstalling handlers.

Paired thaw and rollback also restore the saved context. No context is
allocated for S3 or PM_RESTORE_PREPARE in the boot kernel; free it on
PM_POST_HIBERNATION. Leave pending/active state, SGIs/PPIs and ITS/LPI
tables untouched. This addresses distributor SPI configuration, not
complete GICv3 hibernation support.

With this change, both modes deliver the second injection after real
S4 without manual recovery. Each was tested for one cycle on a fresh
boot, using a level-high SPI, CPU0, disk=shutdown and pm_test=none.
Signed-off-by: Zhu Ling <zhuling2709@phytium.com.cn>

---
Changes since v1:
 - Replace the genirq force-resume proposal with GICv3 SPI context
   save/restore; leave generic IRQ PM policy and interfaces unchanged.
 - Add physical-board reproduction and patched-kernel S4 results for
   both ordinary and chained registration modes.

Previous review:
https://lists.openwall.net/linux-kernel/2026/09/08/2938

 drivers/irqchip/irq-gic-v3.c | 161 +++++++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 94873646d46fb..b968b428d0bfd 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -11,15 +11,19 @@
 #include <linux/cpu_pm.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/kstrtox.h>
+#include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/percpu.h>
 #include <linux/refcount.h>
 #include <linux/slab.h>
+#include <linux/suspend.h>
+#include <linux/syscore_ops.h>
 #include <linux/iopoll.h>
 
 #include <linux/irqchip.h>
@@ -1506,6 +1510,162 @@ static void gic_cpu_pm_init(void)
 static inline void gic_cpu_pm_init(void) { }
 #endif /* CONFIG_CPU_PM */
 
+#ifdef CONFIG_HIBERNATION
+/* The SPI and ESPI register banks each cover at most 1024 INTIDs. */
+struct gic_dist_context {
+	u32 enabled[1024 / 32];
+	u32 config[1024 / 16];
+	u32 priority[1024 / 4];
+	u64 router[1024];
+};
+
+static struct gic_dist_context *gic_saved_dist;
+static bool gic_dist_saved;
+
+static void gic_save_spis(struct gic_dist_context *ctx, u32 first, u32 nr)
+{
+	struct irq_data d = { };
+	void __iomem *base;
+	u32 i, index, offset;
+
+	for (i = 0; i < nr; i++) {
+		d.hwirq = first + i;
+		base = gic_dist_base_alias(&d);
+
+		offset = convert_offset_index(&d, GICD_IROUTER, &index);
+		ctx->router[index] = readq_relaxed(base + offset + index * 8);
+
+		if (IS_ALIGNED(index, 32)) {
+			offset = convert_offset_index(&d, GICD_ISENABLER, &index);
+			ctx->enabled[index / 32] =
+				readl_relaxed(base + offset + index / 32 * 4);
+		}
+		if (IS_ALIGNED(index, 16)) {
+			offset = convert_offset_index(&d, GICD_ICFGR, &index);
+			ctx->config[index / 16] =
+				readl_relaxed(base + offset + index / 16 * 4);
+		}
+		if (IS_ALIGNED(index, 4)) {
+			offset = convert_offset_index(&d, GICD_IPRIORITYR, &index);
+			ctx->priority[index / 4] =
+				readl_relaxed(base + offset + index / 4 * 4);
+		}
+	}
+}
+
+static void gic_restore_spis(struct gic_dist_context *ctx, u32 first, u32 nr)
+{
+	void __iomem *base = gic_data.dist_base;
+	struct irq_data d = { };
+	u32 i, index, offset;
+
+	/* Configuration and routing must be restored with the SPIs disabled. */
+	for (i = 0; i < nr; i += 32) {
+		d.hwirq = first + i;
+		offset = convert_offset_index(&d, GICD_ICENABLER, &index);
+		writel_relaxed(~0U, base + offset + index / 32 * 4);
+	}
+	gic_dist_wait_for_rwp();
+
+	for (i = 0; i < nr; i++) {
+		d.hwirq = first + i;
+		offset = convert_offset_index(&d, GICD_IROUTER, &index);
+		gic_write_irouter(ctx->router[index], base + offset + index * 8);
+
+		if (IS_ALIGNED(index, 16)) {
+			offset = convert_offset_index(&d, GICD_ICFGR, &index);
+			writel_relaxed(ctx->config[index / 16],
+				       base + offset + index / 16 * 4);
+		}
+		if (IS_ALIGNED(index, 4)) {
+			offset = convert_offset_index(&d, GICD_IPRIORITYR, &index);
+			writel_relaxed(ctx->priority[index / 4],
+				       base + offset + index / 4 * 4);
+		}
+	}
+
+	/* Order configuration writes before restoring interrupt enables. */
+	wmb();
+	for (i = 0; i < nr; i += 32) {
+		d.hwirq = first + i;
+		offset = convert_offset_index(&d, GICD_ISENABLER, &index);
+		writel_relaxed(ctx->enabled[index / 32],
+			       base + offset + index / 32 * 4);
+	}
+}
+
+/*
+ * Capture the distributor after device IRQs have been suspended. The image
+ * retains this context and gic_dist_saved, even though the initial thaw clears
+ * the latter. PM_RESTORE_PREPARE in the boot kernel does not allocate a context.
+ * Paired thaw and rollback also restore the saved configuration; S3 is untouched.
+ */
+static int gic_hibernate_suspend(void *data)
+{
+	if (!gic_saved_dist)
+		return 0;
+
+	gic_save_spis(gic_saved_dist, 32, GIC_LINE_NR - 32);
+	if (GIC_ESPI_NR)
+		gic_save_spis(gic_saved_dist + 1, ESPI_BASE_INTID, GIC_ESPI_NR);
+	gic_dist_saved = true;
+	return 0;
+}
+
+static void gic_hibernate_resume(void *data)
+{
+	if (!gic_dist_saved)
+		return;
+
+	gic_restore_spis(gic_saved_dist, 32, GIC_LINE_NR - 32);
+	if (GIC_ESPI_NR)
+		gic_restore_spis(gic_saved_dist + 1, ESPI_BASE_INTID, GIC_ESPI_NR);
+	gic_dist_saved = false;
+}
+
+static const struct syscore_ops gic_hibernate_syscore_ops = {
+	.suspend = gic_hibernate_suspend,
+	.resume = gic_hibernate_resume,
+};
+
+static struct syscore gic_hibernate_syscore = {
+	.ops = &gic_hibernate_syscore_ops,
+};
+
+static int gic_hibernate_notify(struct notifier_block *nb,
+				unsigned long event, void *unused)
+{
+	switch (event) {
+	case PM_HIBERNATION_PREPARE:
+		gic_saved_dist = kmalloc_objs(*gic_saved_dist, 1 + !!GIC_ESPI_NR);
+		if (!gic_saved_dist)
+			return notifier_from_errno(-ENOMEM);
+		break;
+	case PM_POST_HIBERNATION:
+		kfree(gic_saved_dist);
+		gic_saved_dist = NULL;
+		gic_dist_saved = false;
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block gic_hibernate_notifier = {
+	.notifier_call = gic_hibernate_notify,
+};
+
+static void __init gic_hibernate_init(void)
+{
+	if (register_pm_notifier(&gic_hibernate_notifier)) {
+		pr_warn("Failed to register hibernation notifier\n");
+		return;
+	}
+	register_syscore(&gic_hibernate_syscore);
+}
+#else
+static inline void gic_hibernate_init(void) { }
+#endif /* CONFIG_HIBERNATION */
+
 static struct irq_chip gic_chip = {
 	.name			= "GICv3",
 	.irq_mask		= gic_mask_irq,
@@ -2053,6 +2213,7 @@ static int __init gic_init_bases(phys_addr_t dist_phys_base,
 	gic_enable_nmi_support();
 	gic_smp_init();
 	gic_cpu_pm_init();
+	gic_hibernate_init();
 
 	if (gic_dist_supports_lpis()) {
 		its_init(handle, &gic_data.rdists, gic_data.domain, dist_prio_irq);

