From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/4] ARM: shmobile: R-Mobile: Add SYSC restart handler
Date: Wed,  3 Dec 2014 15:17:04 +0100
Message-ID: <1417616227-6715-2-git-send-email-geert+renesas@glider.be>
References: <1417616227-6715-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1417616227-6715-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Extend the PM domain platform driver for the R-Mobile System
Controller (SYSC) to register a restart handler, to be used on various
Renesas ARM SoCs (e.g. R-Mobile A1 (r8a7740) and APE6 (r8a73a4), and
SH-Mobile AP4 (sh7372) and AG5 (sh73a0)).

Note that this supports DT-based platforms only.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/pm-rmobile.c | 48 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index f540096c05f6eabd..b82da04c7210a98d 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -23,14 +23,22 @@
 #include <linux/slab.h>
 
 #include <asm/io.h>
+#include <asm/system_misc.h>
 
 #include "pm-rmobile.h"
 
-/* SYSC */
+/* SYSC Register Bank 1 */
 #define SPDCR		0x08	/* SYS Power Down Control Register */
 #define SWUCR		0x14	/* SYS Wakeup Control Register */
 #define PSTR		0x80	/* Power Status Register */
 
+/* SYSC Register Bank 2 */
+#define RESCNT2		0x20	/* Reset Control Register 2 */
+
+/* Reset Control Register 2 */
+#define RESCNT2_PRES	0x80000000	/* Soft power-on reset */
+
+
 #define PSTR_RETRIES	100
 #define PSTR_DELAY_US	10
 
@@ -400,3 +408,41 @@ static int __init rmobile_init_pm_domains(void)
 core_initcall(rmobile_init_pm_domains);
 
 #endif /* !CONFIG_ARCH_SHMOBILE_LEGACY */
+
+
+static void __iomem *sysc_base2;
+
+static void rmobile_sysc_restart(enum reboot_mode reboot_mode, const char *cmd)
+{
+	pr_debug("%s %u/%s\n", __func__, reboot_mode, cmd);
+
+	writel(RESCNT2_PRES, sysc_base2 + RESCNT2);
+}
+
+static int rmobile_sysc_probe(struct platform_device *pdev)
+{
+	dev_dbg(&pdev->dev, "%s\n", __func__);
+
+	sysc_base2 = of_iomap(pdev->dev.of_node, 1);
+	if (!sysc_base2)
+		return -ENODEV;
+
+	arm_pm_restart = rmobile_sysc_restart;
+
+	return 0;
+}
+
+static const struct of_device_id rmobile_sysc_of_match[] = {
+	{ .compatible = "renesas,sysc-rmobile", },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver rmobile_sysc_driver = {
+	.probe = rmobile_sysc_probe,
+	.driver = {
+		.name = "rmobile_sysc",
+		.of_match_table = rmobile_sysc_of_match,
+	},
+};
+
+module_platform_driver(rmobile_sysc_driver);
-- 
1.9.1

