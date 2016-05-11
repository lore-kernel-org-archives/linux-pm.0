From: Chris Brand <chris.brand@broadcom.com>
Subject: [PATCH v2 5/6] arm: BCM23550 SMP support
Date: Wed, 11 May 2016 14:36:21 -0700
Message-ID: <1463002582-6875-6-git-send-email-chris.brand@broadcom.com>
References: <1463002582-6875-1-git-send-email-chris.brand@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463002582-6875-1-git-send-email-chris.brand@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
Cc: Raymond Ngun <raymond.ngun@broadcom.com>
List-Id: linux-pm@vger.kernel.org

BCM23550 has a Cluster Dormant Control IP block that holds cores
in an idle state. Support a new CPU enable method in which the CDC is
accessed to bring the core online.

Signed-off-by: Raymond Ngun <raymond.ngun@broadcom.com>
Signed-off-by: Chris Brand <chris.brand@broadcom.com>
---
 arch/arm/mach-bcm/platsmp.c | 58 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm/mach-bcm/platsmp.c b/arch/arm/mach-bcm/platsmp.c
index cfae9c71fb74..33c4d8349f95 100644
--- a/arch/arm/mach-bcm/platsmp.c
+++ b/arch/arm/mach-bcm/platsmp.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/jiffies.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
 
@@ -255,6 +256,57 @@ static int kona_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	return -ENXIO;
 }
 
+/* Cluster Dormant Control command to bring CPU into a running state */
+#define CDC_CMD			6
+#define CDC_CMD_OFFSET		0
+#define CDC_CMD_REG(cpu)	(CDC_CMD_OFFSET + 4*(cpu))
+
+/*
+ * BCM23550 has a Cluster Dormant Control block that keeps the core in
+ * idle state. A command needs to be sent to the block to bring the CPU
+ * into running state.
+ */
+static int bcm23550_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	void __iomem *cdc_base;
+	struct device_node *dn;
+	char *name;
+	int ret;
+
+	/* Make sure a CDC node exists before booting the
+	 * secondary core.
+	 */
+	name = "brcm,bcm23550-cdc";
+	dn = of_find_compatible_node(NULL, NULL, name);
+	if (!dn) {
+		pr_err("unable to find cdc node\n");
+		return -ENODEV;
+	}
+
+	cdc_base = of_iomap(dn, 0);
+	of_node_put(dn);
+
+	if (!cdc_base) {
+		pr_err("unable to remap cdc base register\n");
+		return -ENOMEM;
+	}
+
+	/* Boot the secondary core */
+	ret = kona_boot_secondary(cpu, idle);
+	if (ret)
+		goto out;
+
+	/* Bring this CPU to RUN state so that nIRQ nFIQ
+	 * signals are unblocked.
+	 */
+	writel_relaxed(CDC_CMD, cdc_base + CDC_CMD_REG(cpu));
+
+out:
+	iounmap(cdc_base);
+
+	return ret;
+}
+
 static int nsp_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	int ret;
@@ -283,6 +335,12 @@ static const struct smp_operations bcm_smp_ops __initconst = {
 CPU_METHOD_OF_DECLARE(bcm_smp_bcm281xx, "brcm,bcm11351-cpu-method",
 			&bcm_smp_ops);
 
+static const struct smp_operations bcm23550_smp_ops __initconst = {
+	.smp_boot_secondary	= bcm23550_boot_secondary,
+};
+CPU_METHOD_OF_DECLARE(bcm_smp_bcm23550, "brcm,bcm23550",
+			&bcm23550_smp_ops);
+
 static const struct smp_operations nsp_smp_ops __initconst = {
 	.smp_prepare_cpus	= bcm_smp_prepare_cpus,
 	.smp_boot_secondary	= nsp_boot_secondary,
-- 
1.9.1
