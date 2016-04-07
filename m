From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 08/11] soc: renesas: rcar-sysc: Add support for R-Car M2-W power areas
Date: Thu,  7 Apr 2016 14:20:25 +0200
Message-ID: <1460031628-13336-9-git-send-email-geert+renesas@glider.be>
References: <1460031628-13336-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from baptiste.telenet-ops.be ([195.130.132.51]:58620 "EHLO
	baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756134AbcDGMUZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Apr 2016 08:20:25 -0400
In-Reply-To: <1460031628-13336-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - Rename R8A7791_PD_SH to R8A7791_PD_SH_4A, "sh" to "sh-4a",
  - Reformat table,

v3:
  - New (converted from DT to C).
---
 drivers/soc/renesas/Makefile       |  2 +-
 drivers/soc/renesas/r8a7791-sysc.c | 31 +++++++++++++++++++++++++++++++
 drivers/soc/renesas/rcar-sysc.c    |  3 +++
 drivers/soc/renesas/rcar-sysc.h    |  1 +
 4 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/renesas/r8a7791-sysc.c

diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index 6588be3c6776fadf..96463c05ee594335 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_ARCH_R8A7779)	+= rcar-sysc.o r8a7779-sysc.o
 obj-$(CONFIG_ARCH_R8A7790)	+= rcar-sysc.o r8a7790-sysc.o
-obj-$(CONFIG_ARCH_R8A7791)	+= rcar-sysc.o
+obj-$(CONFIG_ARCH_R8A7791)	+= rcar-sysc.o r8a7791-sysc.o
 obj-$(CONFIG_ARCH_R8A7793)	+= rcar-sysc.o
 obj-$(CONFIG_ARCH_R8A7794)	+= rcar-sysc.o
diff --git a/drivers/soc/renesas/r8a7791-sysc.c b/drivers/soc/renesas/r8a7791-sysc.c
new file mode 100644
index 0000000000000000..b8afa100baab2fb1
--- /dev/null
+++ b/drivers/soc/renesas/r8a7791-sysc.c
@@ -0,0 +1,31 @@
+/*
+ * Renesas R-Car M2-W/N System Controller
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
+#include <dt-bindings/power/r8a7791-sysc.h>
+
+#include "rcar-sysc.h"
+
+static const struct rcar_sysc_area r8a7791_areas[] __initconst = {
+	{ "ca15-scu",	0x180, 0, R8A7791_PD_CA15_SCU,	-1, PD_SCU },
+	{ "ca15-cpu0",	 0x40, 0, R8A7791_PD_CA15_CPU0,	R8A7791_PD_CA15_SCU,
+	  PD_CPU_NOCR },
+	{ "ca15-cpu1",	 0x40, 1, R8A7791_PD_CA15_CPU1,	R8A7791_PD_CA15_SCU,
+	  PD_CPU_NOCR },
+	{ "sh-4a",	 0x80, 0, R8A7791_PD_SH_4A,	-1 },
+	{ "sgx",	 0xc0, 0, R8A7791_PD_SGX,	-1 },
+};
+
+const struct rcar_sysc_info r8a7791_sysc_info __initconst = {
+	.areas = r8a7791_areas,
+	.num_areas = ARRAY_SIZE(r8a7791_areas),
+};
diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index d25eff00baf6a828..eb382769ffcdbf6f 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -314,6 +314,9 @@ static const struct of_device_id rcar_sysc_matches[] = {
 #ifdef CONFIG_ARCH_R8A7790
 	{ .compatible = "renesas,r8a7790-sysc", .data = &r8a7790_sysc_info },
 #endif
+#ifdef CONFIG_ARCH_R8A7791
+	{ .compatible = "renesas,r8a7791-sysc", .data = &r8a7791_sysc_info },
+#endif
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/soc/renesas/rcar-sysc.h b/drivers/soc/renesas/rcar-sysc.h
index a202a765345ac50a..e4c22e0516d1bf44 100644
--- a/drivers/soc/renesas/rcar-sysc.h
+++ b/drivers/soc/renesas/rcar-sysc.h
@@ -51,4 +51,5 @@ struct rcar_sysc_info {
 
 extern const struct rcar_sysc_info r8a7779_sysc_info;
 extern const struct rcar_sysc_info r8a7790_sysc_info;
+extern const struct rcar_sysc_info r8a7791_sysc_info;
 #endif /* __SOC_RENESAS_RCAR_SYSC_H__ */
-- 
1.9.1

