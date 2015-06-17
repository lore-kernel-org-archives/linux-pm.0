From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 3/7] staging: board: Add support for translating hwirq to
 virq numbers
Date: Wed, 17 Jun 2015 10:38:52 +0200
Message-ID: <1434530336-15073-4-git-send-email-geert+renesas@glider.be>
References: <1434530336-15073-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1434530336-15073-1-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <damm+renesas@opensource.se>
Cc: devel@driverdev.osuosl.org, devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

As of commit 9a1091ef0017c40a ("irqchip: gic: Support hierarchy irq
domain."), GIC IRQ numbers are virtual, breaking hardcoded hardware IRQ
numbers in platform device resources.

Add support for translating hardware IRQ numbers to virtual IRQ numbers,
and fixing up platform device resources with hardcoded IRQ numbers.

Add a copyright header, including the original author.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Change the function names to include "gic", as the 3-parameter
    interrupt specifiers are GIC-specific,
  - Warn if board_staging_gic_setup_xlate() is called twice,
  - Add support for low/high edge/level interrupts (the default is still
    high level),
  - Drop RFC status.
---
 drivers/staging/board/board.c | 80 +++++++++++++++++++++++++++++++++++++++++++
 drivers/staging/board/board.h |  5 +++
 2 files changed, 85 insertions(+)

diff --git a/drivers/staging/board/board.c b/drivers/staging/board/board.c
index d5a6abc845191c93..8712f566b31196e0 100644
--- a/drivers/staging/board/board.c
+++ b/drivers/staging/board/board.c
@@ -1,10 +1,27 @@
+/*
+ * Copyright (C) 2014 Magnus Damm
+ * Copyright (C) 2015 Glider bvba
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#define pr_fmt(fmt)	"board_staging: "  fmt
+
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_irq.h>
+
 #include "board.h"
 
+static struct device_node *irqc_node __initdata;
+static unsigned int irqc_base __initdata;
+
 static bool find_by_address(u64 base_address)
 {
 	struct device_node *dn = of_find_all_nodes(NULL);
@@ -38,3 +55,66 @@ bool __init board_staging_dt_node_available(const struct resource *resource,
 
 	return false; /* Nothing found */
 }
+
+int __init board_staging_gic_setup_xlate(const char *gic_match,
+					 unsigned int base)
+{
+	WARN_ON(irqc_node);
+
+	irqc_node = of_find_compatible_node(NULL, NULL, gic_match);
+
+	WARN_ON(!irqc_node);
+	if (!irqc_node)
+		return -ENOENT;
+
+	irqc_base = base;
+	return 0;
+}
+
+static void __init gic_fixup_resource(struct resource *res)
+{
+	struct of_phandle_args irq_data;
+	unsigned int hwirq = res->start;
+	unsigned int virq;
+
+	if (resource_type(res) != IORESOURCE_IRQ || !irqc_node)
+		return;
+
+	irq_data.np = irqc_node;
+	irq_data.args_count = 3;
+	irq_data.args[0] = 0;
+	irq_data.args[1] = hwirq - irqc_base;
+	switch (res->flags &
+		(IORESOURCE_IRQ_LOWEDGE | IORESOURCE_IRQ_HIGHEDGE |
+		 IORESOURCE_IRQ_LOWLEVEL | IORESOURCE_IRQ_HIGHLEVEL)) {
+	case IORESOURCE_IRQ_LOWEDGE:
+		irq_data.args[2] = IRQ_TYPE_EDGE_FALLING;
+		break;
+	case IORESOURCE_IRQ_HIGHEDGE:
+		irq_data.args[2] = IRQ_TYPE_EDGE_RISING;
+		break;
+	case IORESOURCE_IRQ_LOWLEVEL:
+		irq_data.args[2] = IRQ_TYPE_LEVEL_LOW;
+		break;
+	case IORESOURCE_IRQ_HIGHLEVEL:
+	default:
+		irq_data.args[2] = IRQ_TYPE_LEVEL_HIGH;
+		break;
+	}
+
+	virq = irq_create_of_mapping(&irq_data);
+	if (WARN_ON(!virq))
+		return;
+
+	pr_debug("hwirq %u -> virq %u\n", hwirq, virq);
+	res->start = virq;
+}
+
+void __init board_staging_gic_fixup_resources(struct resource *res,
+					      unsigned int nres)
+{
+	unsigned int i;
+
+	for (i = 0; i < nres; i++)
+		gic_fixup_resource(&res[i]);
+}
diff --git a/drivers/staging/board/board.h b/drivers/staging/board/board.h
index e9c914985d4acb36..3af6dbe22f91ebdc 100644
--- a/drivers/staging/board/board.h
+++ b/drivers/staging/board/board.h
@@ -1,10 +1,15 @@
 #ifndef __BOARD_H__
 #define __BOARD_H__
+
 #include <linux/init.h>
 #include <linux/of.h>
 
+struct resource;
+
 bool board_staging_dt_node_available(const struct resource *resource,
 				     unsigned int num_resources);
+int board_staging_gic_setup_xlate(const char *gic_match, unsigned int base);
+void board_staging_gic_fixup_resources(struct resource *res, unsigned int nres);
 
 #define board_staging(str, fn)			\
 static int __init runtime_board_check(void)	\
-- 
1.9.1
