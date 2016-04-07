From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 10/11] soc: renesas: rcar-sysc: Add support for R-Car E2 power areas
Date: Thu,  7 Apr 2016 14:20:27 +0200
Message-ID: <1460031628-13336-11-git-send-email-geert+renesas@glider.be>
References: <1460031628-13336-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from baptiste.telenet-ops.be ([195.130.132.51]:58601 "EHLO
	baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756104AbcDGMUY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Apr 2016 08:20:24 -0400
In-Reply-To: <1460031628-13336-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - Rename R8A7794_PD_SH to R8A7794_PD_SH_4A, "sh" to "sh-4a",
  - Reformat table,

v3:
  - New (converted from DT to C).
---
 drivers/soc/renesas/Makefile       |  2 +-
 drivers/soc/renesas/r8a7794-sysc.c | 31 +++++++++++++++++++++++++++++++
 drivers/soc/renesas/rcar-sysc.c    |  3 +++
 drivers/soc/renesas/rcar-sysc.h    |  1 +
 4 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/renesas/r8a7794-sysc.c

diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index c6c4ce7ef8a145ea..b328205fef36441a 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -3,4 +3,4 @@ obj-$(CONFIG_ARCH_R8A7790)	+= rcar-sysc.o r8a7790-sysc.o
 obj-$(CONFIG_ARCH_R8A7791)	+= rcar-sysc.o r8a7791-sysc.o
 # R-Car M2-N is identical to R-Car M2-W w.r.t. power domains.
 obj-$(CONFIG_ARCH_R8A7793)	+= rcar-sysc.o r8a7791-sysc.o
-obj-$(CONFIG_ARCH_R8A7794)	+= rcar-sysc.o
+obj-$(CONFIG_ARCH_R8A7794)	+= rcar-sysc.o r8a7794-sysc.o
diff --git a/drivers/soc/renesas/r8a7794-sysc.c b/drivers/soc/renesas/r8a7794-sysc.c
new file mode 100644
index 0000000000000000..a3d4e5fe832432e1
--- /dev/null
+++ b/drivers/soc/renesas/r8a7794-sysc.c
@@ -0,0 +1,31 @@
+/*
+ * Renesas R-Car E2 System Controller
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
+#include <dt-bindings/power/r8a7794-sysc.h>
+
+#include "rcar-sysc.h"
+
+static const struct rcar_sysc_area r8a7794_areas[] __initconst = {
+	{ "ca7-scu",	0x100, 0, R8A7794_PD_CA7_SCU,	-1, PD_SCU },
+	{ "ca7-cpu0",	0x1c0, 0, R8A7794_PD_CA7_CPU0,	R8A7794_PD_CA7_SCU,
+	  PD_CPU_NOCR },
+	{ "ca7-cpu1",	0x1c0, 1, R8A7794_PD_CA7_CPU1,	R8A7794_PD_CA7_SCU,
+	  PD_CPU_NOCR },
+	{ "sh-4a",	 0x80, 0, R8A7794_PD_SH_4A,	-1 },
+	{ "sgx",	 0xc0, 0, R8A7794_PD_SGX,	-1 },
+};
+
+const struct rcar_sysc_info r8a7794_sysc_info __initconst = {
+	.areas = r8a7794_areas,
+	.num_areas = ARRAY_SIZE(r8a7794_areas),
+};
diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 4bedf38dc6fbba90..9bb227b104f1abd2 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -320,6 +320,9 @@ static const struct of_device_id rcar_sysc_matches[] = {
 #ifdef CONFIG_ARCH_R8A7793
 	{ .compatible = "renesas,r8a7793-sysc", .data = &r8a7793_sysc_info },
 #endif
+#ifdef CONFIG_ARCH_R8A7794
+	{ .compatible = "renesas,r8a7794-sysc", .data = &r8a7794_sysc_info },
+#endif
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/soc/renesas/rcar-sysc.h b/drivers/soc/renesas/rcar-sysc.h
index 513a2beef1b0eb12..e6d8a42789837cf8 100644
--- a/drivers/soc/renesas/rcar-sysc.h
+++ b/drivers/soc/renesas/rcar-sysc.h
@@ -54,4 +54,5 @@ extern const struct rcar_sysc_info r8a7790_sysc_info;
 extern const struct rcar_sysc_info r8a7791_sysc_info;
 /* R-Car M2-N is identical to R-Car M2-W w.r.t. power domains. */
 #define r8a7793_sysc_info r8a7791_sysc_info
+extern const struct rcar_sysc_info r8a7794_sysc_info;
 #endif /* __SOC_RENESAS_RCAR_SYSC_H__ */
-- 
1.9.1

