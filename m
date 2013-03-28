From: Rickard Andersson <rickard.andersson@stericsson.com>
Subject: [PATCH V2 09/12] drivers: bus: ux500: Add ICN driver
Date: Thu, 28 Mar 2013 17:11:35 +0100
Message-ID: <1364487098-10319-10-git-send-email-rickard.andersson@stericsson.com>
References: <1364487098-10319-1-git-send-email-rickard.andersson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1364487098-10319-1-git-send-email-rickard.andersson@stericsson.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rjw@sisk.pl, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: hongbo.zhang@linaro.org, ulf.hansson@linaro.org, khilman@linaro.org, linus.walleij@stericsson.com, daniel.lezcano@linaro.org, rickard.andersson@stericsson.com
List-Id: linux-pm@vger.kernel.org

Add driver for the U8500 main interconnect bus. The
settings of these hardware registers are lost when
the APE power domain is powered off.
The ICN default settings are done during early boot.

Signed-off-by: Rickard Andersson <rickard.andersson@stericsson.com>
---
 drivers/bus/dbx500-icn.c | 522 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 522 insertions(+)
 create mode 100644 drivers/bus/dbx500-icn.c

diff --git a/drivers/bus/dbx500-icn.c b/drivers/bus/dbx500-icn.c
new file mode 100644
index 0000000..5173650
--- /dev/null
+++ b/drivers/bus/dbx500-icn.c
@@ -0,0 +1,522 @@
+/*
+ * U8500 interconnect driver
+ *
+ * Copyright (C) STMicroelectronics 2009
+ * Copyright (C) ST-Ericsson SA 2010-2013
+ *
+ * License Terms: GNU General Public License v2
+ * Author: Sundar Iyer for ST-Ericsson
+ *	   Rickard Andersson  <rickard.andersson@stericsson.com>
+ *
+ */
+
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <mach/hardware.h>
+
+/* Priority, BW limiter register offsets */
+#define NODE_HIBW1_ESRAM_IN_0_PRIORITY		0x00
+#define NODE_HIBW1_ESRAM_IN_1_PRIORITY		0x04
+#define NODE_HIBW1_ESRAM_IN_2_PRIORITY		0x08
+#define NODE_HIBW1_ESRAM_IN_0_ARB_1_LIMIT	0x24
+#define NODE_HIBW1_ESRAM_IN_0_ARB_2_LIMIT	0x28
+#define NODE_HIBW1_ESRAM_IN_0_ARB_3_LIMIT	0x2C
+#define NODE_HIBW1_ESRAM_IN_1_ARB_1_LIMIT	0x30
+#define NODE_HIBW1_ESRAM_IN_1_ARB_2_LIMIT	0x34
+#define NODE_HIBW1_ESRAM_IN_1_ARB_3_LIMIT	0x38
+#define NODE_HIBW1_ESRAM_IN_2_ARB_1_LIMIT	0x3C
+#define NODE_HIBW1_ESRAM_IN_2_ARB_2_LIMIT	0x40
+#define NODE_HIBW1_ESRAM_IN_2_ARB_3_LIMIT	0x44
+#define NODE_HIBW1_DDR_IN_0_PRIORITY		0x400
+#define NODE_HIBW1_DDR_IN_1_PRIORITY		0x404
+#define NODE_HIBW1_DDR_IN_2_PRIORITY		0x408
+#define NODE_HIBW1_DDR_IN_0_LIMIT		0x424
+#define NODE_HIBW1_DDR_IN_1_LIMIT		0x428
+#define NODE_HIBW1_DDR_IN_2_LIMIT		0x42C
+#define NODE_HIBW1_DDR_OUT_0_PRIORITY		0x430
+#define NODE_HIBW2_ESRAM_IN_0_PRIORITY		0x800
+#define NODE_HIBW2_ESRAM_IN_1_PRIORITY		0x804
+#define NODE_HIBW2_ESRAM_IN_0_ARB_1_LIMIT	0x818
+#define NODE_HIBW2_ESRAM_IN_0_ARB_2_LIMIT	0x81C
+#define NODE_HIBW2_ESRAM_IN_0_ARB_3_LIMIT	0x820
+#define NODE_HIBW2_ESRAM_IN_1_ARB_1_LIMIT	0x824
+#define NODE_HIBW2_ESRAM_IN_1_ARB_2_LIMIT	0x828
+#define NODE_HIBW2_ESRAM_IN_1_ARB_3_LIMIT	0x82C
+#define NODE_HIBW2_DDR_IN_0_PRIORITY		0xC00
+#define NODE_HIBW2_DDR_IN_1_PRIORITY		0xC04
+#define NODE_HIBW2_DDR_IN_2_PRIORITY		0xC08
+
+#define NODE_HIBW2_DDR_IN_0_LIMIT		0xC24
+#define NODE_HIBW2_DDR_IN_1_LIMIT		0xC28
+#define NODE_HIBW2_DDR_IN_2_LIMIT		0xC2C
+#define NODE_HIBW2_DDR_OUT_0_PRIORITY		0xC30
+
+/*
+ * Note the following addresses are presented in
+ * db8500 design spec v3.1 and v3.3, table 10.
+ * But their addresses are not the same as in the
+ * description. The addresses in the description
+ * of each registers are correct.
+ * NODE_HIBW2_DDR_IN_3_LIMIT is only present in v1.
+ *
+ * Faulty registers addresses in table 10:
+ * NODE_HIBW2_DDR_IN_2_LIMIT 0xC38
+ * NODE_HIBW2_DDR_IN_3_LIMIT 0xC3C
+ * NODE_HIBW2_DDR_OUT_0_PRIORITY 0xC40
+ */
+
+#define NODE_ESRAM0_IN_0_PRIORITY		0x1000
+#define NODE_ESRAM0_IN_1_PRIORITY		0x1004
+#define NODE_ESRAM0_IN_2_PRIORITY		0x1008
+#define NODE_ESRAM0_IN_3_PRIORITY		0x100C
+#define NODE_ESRAM0_IN_0_LIMIT			0x1030
+#define NODE_ESRAM0_IN_1_LIMIT			0x1034
+#define NODE_ESRAM0_IN_2_LIMIT			0x1038
+#define NODE_ESRAM0_IN_3_LIMIT			0x103C
+/* Common */
+#define NODE_ESRAM1_2_IN_0_PRIORITY		0x1400
+#define NODE_ESRAM1_2_IN_1_PRIORITY		0x1404
+#define NODE_ESRAM1_2_IN_2_PRIORITY		0x1408
+#define NODE_ESRAM1_2_IN_3_PRIORITY		0x140C
+#define NODE_ESRAM1_2_IN_0_ARB_1_LIMIT		0x1430
+#define NODE_ESRAM1_2_IN_0_ARB_2_LIMIT		0x1434
+#define NODE_ESRAM1_2_IN_1_ARB_1_LIMIT		0x1438
+#define NODE_ESRAM1_2_IN_1_ARB_2_LIMIT		0x143C
+#define NODE_ESRAM1_2_IN_2_ARB_1_LIMIT		0x1440
+#define NODE_ESRAM1_2_IN_2_ARB_2_LIMIT		0x1444
+#define NODE_ESRAM1_2_IN_3_ARB_1_LIMIT		0x1448
+#define NODE_ESRAM1_2_IN_3_ARB_2_LIMIT		0x144C
+
+#define NODE_ESRAM3_4_IN_0_PRIORITY		0x1800
+#define NODE_ESRAM3_4_IN_1_PRIORITY		0x1804
+#define NODE_ESRAM3_4_IN_2_PRIORITY		0x1808
+#define NODE_ESRAM3_4_IN_3_PRIORITY		0x180C
+#define NODE_ESRAM3_4_IN_0_ARB_1_LIMIT		0x1830
+#define NODE_ESRAM3_4_IN_0_ARB_2_LIMIT		0x1834
+#define NODE_ESRAM3_4_IN_1_ARB_1_LIMIT		0x1838
+#define NODE_ESRAM3_4_IN_1_ARB_2_LIMIT		0x183C
+#define NODE_ESRAM3_4_IN_2_ARB_1_LIMIT		0x1840
+#define NODE_ESRAM3_4_IN_2_ARB_2_LIMIT		0x1844
+#define NODE_ESRAM3_4_IN_3_ARB_1_LIMIT		0x1848
+#define NODE_ESRAM3_4_IN_3_ARB_2_LIMIT		0x184C
+
+static struct {
+	void __iomem *base;
+	u32 hibw1_esram_in_pri[3];
+	u32 hibw1_esram_in0_arb[3];
+	u32 hibw1_esram_in1_arb[3];
+	u32 hibw1_esram_in2_arb[3];
+	u32 hibw1_ddr_in_prio[3];
+	u32 hibw1_ddr_in_limit[3];
+	u32 hibw1_ddr_out_prio;
+
+	/* HiBw2 node registers */
+	u32 hibw2_esram_in_pri[2];
+	u32 hibw2_esram_in0_arblimit[3];
+	u32 hibw2_esram_in1_arblimit[3];
+	u32 hibw2_ddr_in_prio[4];
+	u32 hibw2_ddr_in_limit[4];
+	u32 hibw2_ddr_out_prio;
+
+	/* ESRAM node registers */
+	u32 esram_in_prio[4];
+	u32 esram_in_lim[4];
+	u32 esram0_in_prio[4];
+	u32 esram0_in_lim[4];
+	u32 esram12_in_prio[4];
+	u32 esram12_in_arb_lim[8];
+	u32 esram34_in_prio[4];
+	u32 esram34_in_arb_lim[8];
+} context_icn;
+
+/**
+ * icn_save_context() - Save interconnect context
+ */
+static void icn_save_context(void)
+{
+	void __iomem *b = context_icn.base;
+
+	context_icn.hibw1_esram_in_pri[0] =
+		readl_relaxed(b + NODE_HIBW1_ESRAM_IN_0_PRIORITY);
+	context_icn.hibw1_esram_in_pri[1] =
+		readl_relaxed(b + NODE_HIBW1_ESRAM_IN_1_PRIORITY);
+	context_icn.hibw1_esram_in_pri[2] =
+		readl_relaxed(b + NODE_HIBW1_ESRAM_IN_2_PRIORITY);
+
+	context_icn.hibw1_esram_in0_arb[0] =
+		readl_relaxed(b + NODE_HIBW1_ESRAM_IN_0_ARB_1_LIMIT);
+	context_icn.hibw1_esram_in0_arb[1] =
+		readl_relaxed(b + NODE_HIBW1_ESRAM_IN_0_ARB_2_LIMIT);
+	context_icn.hibw1_esram_in0_arb[2] =
+		readl_relaxed(b + NODE_HIBW1_ESRAM_IN_0_ARB_3_LIMIT);
+
+	context_icn.hibw1_esram_in1_arb[0] =
+		readl_relaxed(b + NODE_HIBW1_ESRAM_IN_1_ARB_1_LIMIT);
+	context_icn.hibw1_esram_in1_arb[1] =
+		readl_relaxed(b + NODE_HIBW1_ESRAM_IN_1_ARB_2_LIMIT);
+	context_icn.hibw1_esram_in1_arb[2] =
+		readl_relaxed(b + NODE_HIBW1_ESRAM_IN_1_ARB_3_LIMIT);
+
+	context_icn.hibw1_esram_in2_arb[0] =
+		readl_relaxed(b + NODE_HIBW1_ESRAM_IN_2_ARB_1_LIMIT);
+	context_icn.hibw1_esram_in2_arb[1] =
+		readl_relaxed(b + NODE_HIBW1_ESRAM_IN_2_ARB_2_LIMIT);
+	context_icn.hibw1_esram_in2_arb[2] =
+		readl_relaxed(b + NODE_HIBW1_ESRAM_IN_2_ARB_3_LIMIT);
+
+	context_icn.hibw1_ddr_in_prio[0] =
+		readl_relaxed(b + NODE_HIBW1_DDR_IN_0_PRIORITY);
+	context_icn.hibw1_ddr_in_prio[1] =
+		readl_relaxed(b + NODE_HIBW1_DDR_IN_1_PRIORITY);
+	context_icn.hibw1_ddr_in_prio[2] =
+		readl_relaxed(b + NODE_HIBW1_DDR_IN_2_PRIORITY);
+
+	context_icn.hibw1_ddr_in_limit[0] =
+		readl_relaxed(b + NODE_HIBW1_DDR_IN_0_LIMIT);
+	context_icn.hibw1_ddr_in_limit[1] =
+		readl_relaxed(b + NODE_HIBW1_DDR_IN_1_LIMIT);
+	context_icn.hibw1_ddr_in_limit[2] =
+		readl_relaxed(b + NODE_HIBW1_DDR_IN_2_LIMIT);
+
+	context_icn.hibw1_ddr_out_prio =
+		readl_relaxed(b + NODE_HIBW1_DDR_OUT_0_PRIORITY);
+
+	context_icn.hibw2_esram_in_pri[0] =
+		readl_relaxed(b + NODE_HIBW2_ESRAM_IN_0_PRIORITY);
+	context_icn.hibw2_esram_in_pri[1] =
+		readl_relaxed(b + NODE_HIBW2_ESRAM_IN_1_PRIORITY);
+
+	context_icn.hibw2_esram_in0_arblimit[0] =
+		readl_relaxed(b + NODE_HIBW2_ESRAM_IN_0_ARB_1_LIMIT);
+	context_icn.hibw2_esram_in0_arblimit[1] =
+		 readl_relaxed(b + NODE_HIBW2_ESRAM_IN_0_ARB_2_LIMIT);
+	context_icn.hibw2_esram_in0_arblimit[2] =
+		 readl_relaxed(b + NODE_HIBW2_ESRAM_IN_0_ARB_3_LIMIT);
+
+	context_icn.hibw2_esram_in1_arblimit[0] =
+		readl_relaxed(b + NODE_HIBW2_ESRAM_IN_1_ARB_1_LIMIT);
+	context_icn.hibw2_esram_in1_arblimit[1] =
+		readl_relaxed(b + NODE_HIBW2_ESRAM_IN_1_ARB_2_LIMIT);
+	context_icn.hibw2_esram_in1_arblimit[2] =
+		readl_relaxed(b + NODE_HIBW2_ESRAM_IN_1_ARB_3_LIMIT);
+
+	context_icn.hibw2_ddr_in_prio[0] =
+		readl_relaxed(b + NODE_HIBW2_DDR_IN_0_PRIORITY);
+	context_icn.hibw2_ddr_in_prio[1] =
+		readl_relaxed(b + NODE_HIBW2_DDR_IN_1_PRIORITY);
+	context_icn.hibw2_ddr_in_prio[2] =
+		readl_relaxed(b + NODE_HIBW2_DDR_IN_2_PRIORITY);
+
+	context_icn.hibw2_ddr_in_limit[0] =
+		readl_relaxed(b + NODE_HIBW2_DDR_IN_0_LIMIT);
+	context_icn.hibw2_ddr_in_limit[1] =
+		readl_relaxed(b + NODE_HIBW2_DDR_IN_1_LIMIT);
+
+	context_icn.hibw2_ddr_in_limit[2] =
+		readl_relaxed(b + NODE_HIBW2_DDR_IN_2_LIMIT);
+
+	context_icn.hibw2_ddr_out_prio =
+		readl_relaxed(b + NODE_HIBW2_DDR_OUT_0_PRIORITY);
+
+	context_icn.esram0_in_prio[0] =
+		readl_relaxed(b + NODE_ESRAM0_IN_0_PRIORITY);
+	context_icn.esram0_in_prio[1] =
+		readl_relaxed(b + NODE_ESRAM0_IN_1_PRIORITY);
+	context_icn.esram0_in_prio[2] =
+		readl_relaxed(b + NODE_ESRAM0_IN_2_PRIORITY);
+	context_icn.esram0_in_prio[3] =
+		readl_relaxed(b + NODE_ESRAM0_IN_3_PRIORITY);
+
+	context_icn.esram0_in_lim[0] =
+		readl_relaxed(b + NODE_ESRAM0_IN_0_LIMIT);
+	context_icn.esram0_in_lim[1] =
+		readl_relaxed(b + NODE_ESRAM0_IN_1_LIMIT);
+	context_icn.esram0_in_lim[2] =
+		readl_relaxed(b + NODE_ESRAM0_IN_2_LIMIT);
+	context_icn.esram0_in_lim[3] =
+		readl_relaxed(b + NODE_ESRAM0_IN_3_LIMIT);
+
+	context_icn.esram12_in_prio[0] =
+		readl_relaxed(b + NODE_ESRAM1_2_IN_0_PRIORITY);
+	context_icn.esram12_in_prio[1] =
+		readl_relaxed(b + NODE_ESRAM1_2_IN_1_PRIORITY);
+	context_icn.esram12_in_prio[2] =
+		readl_relaxed(b + NODE_ESRAM1_2_IN_2_PRIORITY);
+	context_icn.esram12_in_prio[3] =
+		readl_relaxed(b + NODE_ESRAM1_2_IN_3_PRIORITY);
+
+	context_icn.esram12_in_arb_lim[0] =
+		readl_relaxed(b + NODE_ESRAM1_2_IN_0_ARB_1_LIMIT);
+	context_icn.esram12_in_arb_lim[1] =
+		readl_relaxed(b + NODE_ESRAM1_2_IN_0_ARB_2_LIMIT);
+	context_icn.esram12_in_arb_lim[2] =
+		readl_relaxed(b + NODE_ESRAM1_2_IN_1_ARB_1_LIMIT);
+	context_icn.esram12_in_arb_lim[3] =
+		readl_relaxed(b + NODE_ESRAM1_2_IN_1_ARB_2_LIMIT);
+	context_icn.esram12_in_arb_lim[4] =
+		readl_relaxed(b + NODE_ESRAM1_2_IN_2_ARB_1_LIMIT);
+	context_icn.esram12_in_arb_lim[5] =
+		readl_relaxed(b + NODE_ESRAM1_2_IN_2_ARB_2_LIMIT);
+	context_icn.esram12_in_arb_lim[6] =
+		readl_relaxed(b + NODE_ESRAM1_2_IN_3_ARB_1_LIMIT);
+	context_icn.esram12_in_arb_lim[7] =
+		readl_relaxed(b + NODE_ESRAM1_2_IN_3_ARB_2_LIMIT);
+
+	context_icn.esram34_in_prio[0] =
+		readl_relaxed(b + NODE_ESRAM3_4_IN_0_PRIORITY);
+	context_icn.esram34_in_prio[1] =
+		readl_relaxed(b + NODE_ESRAM3_4_IN_1_PRIORITY);
+	context_icn.esram34_in_prio[2] =
+		readl_relaxed(b + NODE_ESRAM3_4_IN_2_PRIORITY);
+	context_icn.esram34_in_prio[3] =
+		readl_relaxed(b + NODE_ESRAM3_4_IN_3_PRIORITY);
+
+	context_icn.esram34_in_arb_lim[0] =
+		readl_relaxed(b + NODE_ESRAM3_4_IN_0_ARB_1_LIMIT);
+	context_icn.esram34_in_arb_lim[1] =
+		readl_relaxed(b + NODE_ESRAM3_4_IN_0_ARB_2_LIMIT);
+	context_icn.esram34_in_arb_lim[2] =
+		readl_relaxed(b + NODE_ESRAM3_4_IN_1_ARB_1_LIMIT);
+	context_icn.esram34_in_arb_lim[3] =
+		readl_relaxed(b + NODE_ESRAM3_4_IN_1_ARB_2_LIMIT);
+	context_icn.esram34_in_arb_lim[4] =
+		readl_relaxed(b + NODE_ESRAM3_4_IN_2_ARB_1_LIMIT);
+	context_icn.esram34_in_arb_lim[5] =
+		readl_relaxed(b + NODE_ESRAM3_4_IN_2_ARB_2_LIMIT);
+	context_icn.esram34_in_arb_lim[6] =
+		readl_relaxed(b + NODE_ESRAM3_4_IN_3_ARB_1_LIMIT);
+	context_icn.esram34_in_arb_lim[7] =
+		readl_relaxed(b + NODE_ESRAM3_4_IN_3_ARB_2_LIMIT);
+}
+
+/**
+ * icn_restore_context() - Restore interconnect context
+ */
+static void icn_restore_context(void)
+{
+	void __iomem *b = context_icn.base;
+
+	writel_relaxed(context_icn.hibw1_esram_in_pri[0],
+		       b + NODE_HIBW1_ESRAM_IN_0_PRIORITY);
+	writel_relaxed(context_icn.hibw1_esram_in_pri[1],
+		       b + NODE_HIBW1_ESRAM_IN_1_PRIORITY);
+	writel_relaxed(context_icn.hibw1_esram_in_pri[2],
+		       b + NODE_HIBW1_ESRAM_IN_2_PRIORITY);
+
+	writel_relaxed(context_icn.hibw1_esram_in0_arb[0],
+		       b + NODE_HIBW1_ESRAM_IN_0_ARB_1_LIMIT);
+	writel_relaxed(context_icn.hibw1_esram_in0_arb[1],
+		       b + NODE_HIBW1_ESRAM_IN_0_ARB_2_LIMIT);
+	writel_relaxed(context_icn.hibw1_esram_in0_arb[2],
+		       b + NODE_HIBW1_ESRAM_IN_0_ARB_3_LIMIT);
+
+	writel_relaxed(context_icn.hibw1_esram_in1_arb[0],
+		       b + NODE_HIBW1_ESRAM_IN_1_ARB_1_LIMIT);
+	writel_relaxed(context_icn.hibw1_esram_in1_arb[1],
+		       b + NODE_HIBW1_ESRAM_IN_1_ARB_2_LIMIT);
+	writel_relaxed(context_icn.hibw1_esram_in1_arb[2],
+		       b + NODE_HIBW1_ESRAM_IN_1_ARB_3_LIMIT);
+
+	writel_relaxed(context_icn.hibw1_esram_in2_arb[0],
+		       b + NODE_HIBW1_ESRAM_IN_2_ARB_1_LIMIT);
+	writel_relaxed(context_icn.hibw1_esram_in2_arb[1],
+		       b + NODE_HIBW1_ESRAM_IN_2_ARB_2_LIMIT);
+	writel_relaxed(context_icn.hibw1_esram_in2_arb[2],
+		       b + NODE_HIBW1_ESRAM_IN_2_ARB_3_LIMIT);
+
+	writel_relaxed(context_icn.hibw1_ddr_in_prio[0],
+		       b + NODE_HIBW1_DDR_IN_0_PRIORITY);
+	writel_relaxed(context_icn.hibw1_ddr_in_prio[1],
+		       b + NODE_HIBW1_DDR_IN_1_PRIORITY);
+	writel_relaxed(context_icn.hibw1_ddr_in_prio[2],
+		       b + NODE_HIBW1_DDR_IN_2_PRIORITY);
+
+	writel_relaxed(context_icn.hibw1_ddr_in_limit[0],
+		       b + NODE_HIBW1_DDR_IN_0_LIMIT);
+	writel_relaxed(context_icn.hibw1_ddr_in_limit[1],
+		       b + NODE_HIBW1_DDR_IN_1_LIMIT);
+	writel_relaxed(context_icn.hibw1_ddr_in_limit[2],
+		       b + NODE_HIBW1_DDR_IN_2_LIMIT);
+
+	writel_relaxed(context_icn.hibw1_ddr_out_prio,
+		       b + NODE_HIBW1_DDR_OUT_0_PRIORITY);
+
+	writel_relaxed(context_icn.hibw2_esram_in_pri[0],
+		       b + NODE_HIBW2_ESRAM_IN_0_PRIORITY);
+	writel_relaxed(context_icn.hibw2_esram_in_pri[1],
+		       b + NODE_HIBW2_ESRAM_IN_1_PRIORITY);
+
+	writel_relaxed(context_icn.hibw2_esram_in0_arblimit[0],
+		       b + NODE_HIBW2_ESRAM_IN_0_ARB_1_LIMIT);
+	writel_relaxed(context_icn.hibw2_esram_in0_arblimit[1],
+		       b + NODE_HIBW2_ESRAM_IN_0_ARB_2_LIMIT);
+	writel_relaxed(context_icn.hibw2_esram_in0_arblimit[2],
+		       b + NODE_HIBW2_ESRAM_IN_0_ARB_3_LIMIT);
+
+	writel_relaxed(context_icn.hibw2_esram_in1_arblimit[0],
+		       b + NODE_HIBW2_ESRAM_IN_1_ARB_1_LIMIT);
+	writel_relaxed(context_icn.hibw2_esram_in1_arblimit[1],
+		       b + NODE_HIBW2_ESRAM_IN_1_ARB_2_LIMIT);
+	writel_relaxed(context_icn.hibw2_esram_in1_arblimit[2],
+		       b + NODE_HIBW2_ESRAM_IN_1_ARB_3_LIMIT);
+
+	writel_relaxed(context_icn.hibw2_ddr_in_prio[0],
+		       b + NODE_HIBW2_DDR_IN_0_PRIORITY);
+	writel_relaxed(context_icn.hibw2_ddr_in_prio[1],
+		       b + NODE_HIBW2_DDR_IN_1_PRIORITY);
+	writel_relaxed(context_icn.hibw2_ddr_in_prio[2],
+		       b + NODE_HIBW2_DDR_IN_2_PRIORITY);
+	writel_relaxed(context_icn.hibw2_ddr_in_limit[0],
+		       b + NODE_HIBW2_DDR_IN_0_LIMIT);
+	writel_relaxed(context_icn.hibw2_ddr_in_limit[1],
+		       b + NODE_HIBW2_DDR_IN_1_LIMIT);
+	writel_relaxed(context_icn.hibw2_ddr_in_limit[2],
+		       b + NODE_HIBW2_DDR_IN_2_LIMIT);
+	writel_relaxed(context_icn.hibw2_ddr_out_prio,
+		       b + NODE_HIBW2_DDR_OUT_0_PRIORITY);
+
+	writel_relaxed(context_icn.esram0_in_prio[0],
+		       b + NODE_ESRAM0_IN_0_PRIORITY);
+	writel_relaxed(context_icn.esram0_in_prio[1],
+		       b + NODE_ESRAM0_IN_1_PRIORITY);
+	writel_relaxed(context_icn.esram0_in_prio[2],
+		       b + NODE_ESRAM0_IN_2_PRIORITY);
+	writel_relaxed(context_icn.esram0_in_prio[3],
+		       b + NODE_ESRAM0_IN_3_PRIORITY);
+
+	writel_relaxed(context_icn.esram0_in_lim[0],
+		       b + NODE_ESRAM0_IN_0_LIMIT);
+	writel_relaxed(context_icn.esram0_in_lim[1],
+		       b + NODE_ESRAM0_IN_1_LIMIT);
+	writel_relaxed(context_icn.esram0_in_lim[2],
+		       b + NODE_ESRAM0_IN_2_LIMIT);
+	writel_relaxed(context_icn.esram0_in_lim[3],
+		       b + NODE_ESRAM0_IN_3_LIMIT);
+
+	writel_relaxed(context_icn.esram12_in_prio[0],
+		       b + NODE_ESRAM1_2_IN_0_PRIORITY);
+	writel_relaxed(context_icn.esram12_in_prio[1],
+		       b + NODE_ESRAM1_2_IN_1_PRIORITY);
+	writel_relaxed(context_icn.esram12_in_prio[2],
+		       b + NODE_ESRAM1_2_IN_2_PRIORITY);
+	writel_relaxed(context_icn.esram12_in_prio[3],
+		       b + NODE_ESRAM1_2_IN_3_PRIORITY);
+
+	writel_relaxed(context_icn.esram12_in_arb_lim[0],
+		       b + NODE_ESRAM1_2_IN_0_ARB_1_LIMIT);
+	writel_relaxed(context_icn.esram12_in_arb_lim[1],
+		       b + NODE_ESRAM1_2_IN_0_ARB_2_LIMIT);
+	writel_relaxed(context_icn.esram12_in_arb_lim[2],
+		       b + NODE_ESRAM1_2_IN_1_ARB_1_LIMIT);
+	writel_relaxed(context_icn.esram12_in_arb_lim[3],
+		       b + NODE_ESRAM1_2_IN_1_ARB_2_LIMIT);
+	writel_relaxed(context_icn.esram12_in_arb_lim[4],
+		       b + NODE_ESRAM1_2_IN_2_ARB_1_LIMIT);
+	writel_relaxed(context_icn.esram12_in_arb_lim[5],
+		       b + NODE_ESRAM1_2_IN_2_ARB_2_LIMIT);
+	writel_relaxed(context_icn.esram12_in_arb_lim[6],
+		       b + NODE_ESRAM1_2_IN_3_ARB_1_LIMIT);
+	writel_relaxed(context_icn.esram12_in_arb_lim[7],
+		       b + NODE_ESRAM1_2_IN_3_ARB_2_LIMIT);
+
+	writel_relaxed(context_icn.esram34_in_prio[0],
+		       b + NODE_ESRAM3_4_IN_0_PRIORITY);
+	writel_relaxed(context_icn.esram34_in_prio[1],
+		       b + NODE_ESRAM3_4_IN_1_PRIORITY);
+	writel_relaxed(context_icn.esram34_in_prio[2],
+		       b + NODE_ESRAM3_4_IN_2_PRIORITY);
+	writel_relaxed(context_icn.esram34_in_prio[3],
+		       b + NODE_ESRAM3_4_IN_3_PRIORITY);
+
+	writel_relaxed(context_icn.esram34_in_arb_lim[0],
+		       b + NODE_ESRAM3_4_IN_0_ARB_1_LIMIT);
+	writel_relaxed(context_icn.esram34_in_arb_lim[1],
+		       b + NODE_ESRAM3_4_IN_0_ARB_2_LIMIT);
+	writel_relaxed(context_icn.esram34_in_arb_lim[2],
+		       b + NODE_ESRAM3_4_IN_1_ARB_1_LIMIT);
+	writel_relaxed(context_icn.esram34_in_arb_lim[3],
+		       b + NODE_ESRAM3_4_IN_1_ARB_2_LIMIT);
+	writel_relaxed(context_icn.esram34_in_arb_lim[4],
+		       b + NODE_ESRAM3_4_IN_2_ARB_1_LIMIT);
+	writel_relaxed(context_icn.esram34_in_arb_lim[5],
+		       b + NODE_ESRAM3_4_IN_2_ARB_2_LIMIT);
+	writel_relaxed(context_icn.esram34_in_arb_lim[6],
+		       b + NODE_ESRAM3_4_IN_3_ARB_1_LIMIT);
+	writel_relaxed(context_icn.esram34_in_arb_lim[7],
+		       b + NODE_ESRAM3_4_IN_3_ARB_2_LIMIT);
+}
+
+static int icn_context_call(struct notifier_block *this,
+			    unsigned long event, void *data)
+{
+	bool power_on = (bool)event;
+
+	if (power_on)
+		icn_restore_context();
+	else
+		icn_save_context();
+
+	return 0;
+}
+
+static struct notifier_block icn_context_notifier = {
+	.notifier_call = icn_context_call,
+};
+
+static const struct of_device_id dbx500_icn_match[] = {
+	{ .compatible = "stericsson,db8500-icn", },
+	{},
+};
+
+static struct platform_driver dbx500_icn_plat_driver = {
+	.driver = {
+		.name = "dbx500-icn",
+		.of_match_table = dbx500_icn_match,
+	},
+};
+
+static int __init dbx500_icn_probe(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "missing platform resources\n");
+		return -EINVAL;
+	}
+
+	if (!request_mem_region(res->start, resource_size(res), pdev->name)) {
+		dev_err(&pdev->dev, "failed to request I/O memory\n");
+		return -EBUSY;
+	}
+
+	context_icn.base = ioremap(res->start, resource_size(res));
+	if (!context_icn.base) {
+		ret = -ENOMEM;
+		goto err_free_mem_region;
+	}
+
+	ret = pm_genpd_register_on_off_notifier(&pdev->dev,
+						&icn_context_notifier);
+	if (ret)
+		goto err_iounmap;
+
+	return ret;
+
+ err_iounmap:
+	iounmap(context_icn.base);
+ err_free_mem_region:
+	release_mem_region(res->start, resource_size(res));
+	return ret;
+
+}
+
+static int __init dbx500_icn_init(void)
+{
+	return platform_driver_probe(&dbx500_icn_plat_driver,
+				     dbx500_icn_probe);
+}
+
+arch_initcall(dbx500_icn_init);
-- 
1.8.2
