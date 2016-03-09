From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 07/11] soc: renesas: rcar-sysc: Add support for R-Car H2 power areas
Date: Wed,  9 Mar 2016 20:18:43 +0100
Message-ID: <1457551127-21934-8-git-send-email-geert+renesas@glider.be>
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
 drivers/soc/renesas/Makefile       |  2 +-
 drivers/soc/renesas/r8a7790-sysc.c | 45 ++++++++++++++++++++++++++++++++++++++
 drivers/soc/renesas/rcar-sysc.c    |  3 +++
 drivers/soc/renesas/rcar-sysc.h    |  1 +
 4 files changed, 50 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/renesas/r8a7790-sysc.c

diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index b8aa9db4fdd95eb8..6588be3c6776fadf 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_ARCH_R8A7779)	+= rcar-sysc.o r8a7779-sysc.o
-obj-$(CONFIG_ARCH_R8A7790)	+= rcar-sysc.o
+obj-$(CONFIG_ARCH_R8A7790)	+= rcar-sysc.o r8a7790-sysc.o
 obj-$(CONFIG_ARCH_R8A7791)	+= rcar-sysc.o
 obj-$(CONFIG_ARCH_R8A7793)	+= rcar-sysc.o
 obj-$(CONFIG_ARCH_R8A7794)	+= rcar-sysc.o
diff --git a/drivers/soc/renesas/r8a7790-sysc.c b/drivers/soc/renesas/r8a7790-sysc.c
new file mode 100644
index 0000000000000000..833b4a02483bcac7
--- /dev/null
+++ b/drivers/soc/renesas/r8a7790-sysc.c
@@ -0,0 +1,45 @@
+/*
+ * Renesas R-Car H2 System Controller
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
+#include <dt-bindings/power/r8a7790-sysc.h>
+
+#include "rcar-sysc.h"
+
+static const struct rcar_sysc_area r8a7790_areas[] __initconst = {
+	{ "ca15-scu",  0x180, 0, R8A7790_PD_CA15_SCU,  -1, PD_SCU, },
+	{ "ca15-cpu0",  0x40, 0, R8A7790_PD_CA15_CPU0, R8A7790_PD_CA15_SCU,
+	  PD_CPU_NOCR, },
+	{ "ca15-cpu1",  0x40, 1, R8A7790_PD_CA15_CPU1, R8A7790_PD_CA15_SCU,
+	  PD_CPU_NOCR, },
+	{ "ca15-cpu2",  0x40, 2, R8A7790_PD_CA15_CPU2, R8A7790_PD_CA15_SCU,
+	  PD_CPU_NOCR, },
+	{ "ca15-cpu3",  0x40, 3, R8A7790_PD_CA15_CPU3, R8A7790_PD_CA15_SCU,
+	  PD_CPU_NOCR, },
+	{ "ca7-scu",   0x100, 0, R8A7790_PD_CA7_SCU,   -1, PD_SCU, },
+	{ "ca7-cpu0",  0x1c0, 0, R8A7790_PD_CA7_CPU0,  R8A7790_PD_CA7_SCU,
+	  PD_CPU_NOCR, },
+	{ "ca7-cpu1",  0x1c0, 1, R8A7790_PD_CA7_CPU1,  R8A7790_PD_CA7_SCU,
+	  PD_CPU_NOCR, },
+	{ "ca7-cpu2",  0x1c0, 2, R8A7790_PD_CA7_CPU2,  R8A7790_PD_CA7_SCU,
+	  PD_CPU_NOCR, },
+	{ "ca7-cpu3",  0x1c0, 3, R8A7790_PD_CA7_CPU3,  R8A7790_PD_CA7_SCU,
+	  PD_CPU_NOCR, },
+	{ "sh",         0x80, 0, R8A7790_PD_SH,        -1, },
+	{ "rgx",        0xc0, 0, R8A7790_PD_RGX,       -1, },
+	{ "imp",       0x140, 0, R8A7790_PD_IMP,       -1, },
+};
+
+const struct rcar_sysc_info r8a7790_sysc_info __initconst = {
+	.areas = r8a7790_areas,
+	.num_areas = ARRAY_SIZE(r8a7790_areas),
+};
diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 3d039009a2222820..44b8ef764cbc33d1 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -284,6 +284,9 @@ static const struct of_device_id rcar_sysc_matches[] = {
 #ifdef CONFIG_ARCH_R8A7779
 	{ .compatible = "renesas,r8a7779-sysc", .data = &r8a7779_sysc_info },
 #endif
+#ifdef CONFIG_ARCH_R8A7790
+	{ .compatible = "renesas,r8a7790-sysc", .data = &r8a7790_sysc_info },
+#endif
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/soc/renesas/rcar-sysc.h b/drivers/soc/renesas/rcar-sysc.h
index 7cf58b9cd544f4b9..33c8f2d00a01eac6 100644
--- a/drivers/soc/renesas/rcar-sysc.h
+++ b/drivers/soc/renesas/rcar-sysc.h
@@ -51,4 +51,5 @@ struct rcar_sysc_info {
 };
 
 extern const struct rcar_sysc_info r8a7779_sysc_info;
+extern const struct rcar_sysc_info r8a7790_sysc_info;
 #endif /* __SOC_RENESAS_RCAR_SYSC_H__ */
-- 
1.9.1
