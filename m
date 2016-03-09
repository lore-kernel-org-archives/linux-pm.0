From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 11/11] soc: renesas: rcar-sysc: Add support for R-Car H3 power areas
Date: Wed,  9 Mar 2016 20:18:47 +0100
Message-ID: <1457551127-21934-12-git-send-email-geert+renesas@glider.be>
References: <1457551127-21934-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1457551127-21934-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - New (converted from DT to C).
---
 drivers/soc/renesas/Makefile       |  1 +
 drivers/soc/renesas/r8a7795-sysc.c | 56 ++++++++++++++++++++++++++++++++++++++
 drivers/soc/renesas/rcar-sysc.c    |  3 ++
 drivers/soc/renesas/rcar-sysc.h    |  1 +
 4 files changed, 61 insertions(+)
 create mode 100644 drivers/soc/renesas/r8a7795-sysc.c

diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index b328205fef36441a..151fcd3f025b01f3 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_ARCH_R8A7791)	+= rcar-sysc.o r8a7791-sysc.o
 # R-Car M2-N is identical to R-Car M2-W w.r.t. power domains.
 obj-$(CONFIG_ARCH_R8A7793)	+= rcar-sysc.o r8a7791-sysc.o
 obj-$(CONFIG_ARCH_R8A7794)	+= rcar-sysc.o r8a7794-sysc.o
+obj-$(CONFIG_ARCH_R8A7795)	+= rcar-sysc.o r8a7795-sysc.o
diff --git a/drivers/soc/renesas/r8a7795-sysc.c b/drivers/soc/renesas/r8a7795-sysc.c
new file mode 100644
index 0000000000000000..7a01913e6dbbf869
--- /dev/null
+++ b/drivers/soc/renesas/r8a7795-sysc.c
@@ -0,0 +1,56 @@
+/*
+ * Renesas R-Car H3 System Controller
+ *
+ * Copyright (C) 2016 Glider bvba
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/bug.h>
+#include <linux/kernel.h>
+
+#include <dt-bindings/power/r8a7795-sysc.h>
+
+#include "rcar-sysc.h"
+
+static const struct rcar_sysc_area r8a7795_areas[] __initconst = {
+	{ "always-on",     0, 0, R8A7795_PD_ALWAYS_ON, -1, PD_ALWAYS_ON },
+	{ "ca57-scu",  0x1c0, 0, R8A7795_PD_CA57_SCU,  R8A7795_PD_ALWAYS_ON,
+	  PD_SCU },
+	{ "ca57-cpu0",  0x80, 0, R8A7795_PD_CA57_CPU0, R8A7795_PD_CA57_SCU,
+	  PD_CPU_NOCR, },
+	{ "ca57-cpu1",  0x80, 1, R8A7795_PD_CA57_CPU1, R8A7795_PD_CA57_SCU,
+	  PD_CPU_NOCR, },
+	{ "ca57-cpu2",  0x80, 2, R8A7795_PD_CA57_CPU2, R8A7795_PD_CA57_SCU,
+	  PD_CPU_NOCR, },
+	{ "ca57-cpu3",  0x80, 3, R8A7795_PD_CA57_CPU3, R8A7795_PD_CA57_SCU,
+	  PD_CPU_NOCR, },
+	{ "ca53-scu",  0x140, 0, R8A7795_PD_CA53_SCU,  R8A7795_PD_ALWAYS_ON,
+	  PD_SCU },
+	{ "ca53-cpu0", 0x200, 0, R8A7795_PD_CA53_CPU0, R8A7795_PD_CA53_SCU,
+	  PD_CPU_NOCR, },
+	{ "ca53-cpu1", 0x200, 1, R8A7795_PD_CA53_CPU1, R8A7795_PD_CA53_SCU,
+	  PD_CPU_NOCR, },
+	{ "ca53-cpu2", 0x200, 2, R8A7795_PD_CA53_CPU2, R8A7795_PD_CA53_SCU,
+	  PD_CPU_NOCR, },
+	{ "ca53-cpu3", 0x200, 3, R8A7795_PD_CA53_CPU3, R8A7795_PD_CA53_SCU,
+	  PD_CPU_NOCR, },
+	{ "a3vp",      0x340, 0, R8A7795_PD_A3VP,      R8A7795_PD_ALWAYS_ON, },
+	{ "cr7",       0x240, 0, R8A7795_PD_CR7,       R8A7795_PD_ALWAYS_ON, },
+	{ "a3vc",      0x380, 0, R8A7795_PD_A3VC,      R8A7795_PD_ALWAYS_ON, },
+	{ "a2vc0",     0x3c0, 0, R8A7795_PD_A2VC0,     R8A7795_PD_A3VC, },
+	{ "a2vc1",     0x3c0, 1, R8A7795_PD_A2VC1,     R8A7795_PD_A3VC, },
+	{ "3dg-a",     0x100, 0, R8A7795_PD_3DG_A,     R8A7795_PD_ALWAYS_ON, },
+	{ "3dg-b",     0x100, 1, R8A7795_PD_3DG_B,     R8A7795_PD_3DG_A, },
+	{ "3dg-c",     0x100, 2, R8A7795_PD_3DG_C,     R8A7795_PD_3DG_B, },
+	{ "3dg-d",     0x100, 3, R8A7795_PD_3DG_D,     R8A7795_PD_3DG_C, },
+	{ "3dg-e",     0x100, 4, R8A7795_PD_3DG_E,     R8A7795_PD_3DG_D, },
+	{ "a3ir",      0x180, 0, R8A7795_PD_A3IR,      R8A7795_PD_ALWAYS_ON, },
+};
+
+const struct rcar_sysc_info r8a7795_sysc_info __initconst = {
+	.areas = r8a7795_areas,
+	.num_areas = ARRAY_SIZE(r8a7795_areas),
+};
diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 21fd70aea4a4e7b5..7d2a139d7a660ed3 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -296,6 +296,9 @@ static const struct of_device_id rcar_sysc_matches[] = {
 #ifdef CONFIG_ARCH_R8A7794
 	{ .compatible = "renesas,r8a7794-sysc", .data = &r8a7794_sysc_info },
 #endif
+#ifdef CONFIG_ARCH_R8A7795
+	{ .compatible = "renesas,r8a7795-sysc", .data = &r8a7795_sysc_info },
+#endif
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/soc/renesas/rcar-sysc.h b/drivers/soc/renesas/rcar-sysc.h
index 953c85dd04943980..f5aeac18f1c92813 100644
--- a/drivers/soc/renesas/rcar-sysc.h
+++ b/drivers/soc/renesas/rcar-sysc.h
@@ -56,4 +56,5 @@ extern const struct rcar_sysc_info r8a7791_sysc_info;
 /* R-Car M2-N is identical to R-Car M2-W w.r.t. power domains. */
 #define r8a7793_sysc_info r8a7791_sysc_info
 extern const struct rcar_sysc_info r8a7794_sysc_info;
+extern const struct rcar_sysc_info r8a7795_sysc_info;
 #endif /* __SOC_RENESAS_RCAR_SYSC_H__ */
-- 
1.9.1
