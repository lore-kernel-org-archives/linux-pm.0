From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 06/11] soc: renesas: rcar-sysc: Add support for R-Car H1 power areas
Date: Thu,  7 Apr 2016 14:20:23 +0200
Message-ID: <1460031628-13336-7-git-send-email-geert+renesas@glider.be>
References: <1460031628-13336-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from xavier.telenet-ops.be ([195.130.132.52]:37034 "EHLO
	xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755971AbcDGMUY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Apr 2016 08:20:24 -0400
In-Reply-To: <1460031628-13336-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - Drop R8A7779_PD_SH, as it's not documented in the datasheet,
  - Reformat table,

v3:
  - New (converted from DT to C).
---
 drivers/soc/renesas/Makefile       |  2 +-
 drivers/soc/renesas/r8a7779-sysc.c | 30 ++++++++++++++++++++++++++++++
 drivers/soc/renesas/rcar-sysc.c    |  3 +++
 drivers/soc/renesas/rcar-sysc.h    |  1 +
 4 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/renesas/r8a7779-sysc.c

diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index 2b64f6c9468136f9..b8aa9db4fdd95eb8 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -1,4 +1,4 @@
-obj-$(CONFIG_ARCH_R8A7779)	+= rcar-sysc.o
+obj-$(CONFIG_ARCH_R8A7779)	+= rcar-sysc.o r8a7779-sysc.o
 obj-$(CONFIG_ARCH_R8A7790)	+= rcar-sysc.o
 obj-$(CONFIG_ARCH_R8A7791)	+= rcar-sysc.o
 obj-$(CONFIG_ARCH_R8A7793)	+= rcar-sysc.o
diff --git a/drivers/soc/renesas/r8a7779-sysc.c b/drivers/soc/renesas/r8a7779-sysc.c
new file mode 100644
index 0000000000000000..389d6c7120be4c54
--- /dev/null
+++ b/drivers/soc/renesas/r8a7779-sysc.c
@@ -0,0 +1,30 @@
+/*
+ * Renesas R-Car H1 System Controller
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
+#include <dt-bindings/power/r8a7779-sysc.h>
+
+#include "rcar-sysc.h"
+
+static const struct rcar_sysc_area r8a7779_areas[] __initconst = {
+	{ "arm1",	 0x40, 1, R8A7779_PD_ARM1,	-1, PD_CPU_CR },
+	{ "arm2",	 0x40, 2, R8A7779_PD_ARM2,	-1, PD_CPU_CR },
+	{ "arm3",	 0x40, 3, R8A7779_PD_ARM3,	-1, PD_CPU_CR },
+	{ "sgx",	 0xc0, 0, R8A7779_PD_SGX,	-1 },
+	{ "vdp",	0x100, 0, R8A7779_PD_VDP,	-1 },
+	{ "imp",	0x140, 0, R8A7779_PD_IMP,	-1 },
+};
+
+const struct rcar_sysc_info r8a7779_sysc_info __initconst = {
+	.areas = r8a7779_areas,
+	.num_areas = ARRAY_SIZE(r8a7779_areas),
+};
diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 6fad1311133a3ac7..89505e3dae9be4bd 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -308,6 +308,9 @@ static void __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
 }
 
 static const struct of_device_id rcar_sysc_matches[] = {
+#ifdef CONFIG_ARCH_R8A7779
+	{ .compatible = "renesas,r8a7779-sysc", .data = &r8a7779_sysc_info },
+#endif
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/soc/renesas/rcar-sysc.h b/drivers/soc/renesas/rcar-sysc.h
index 4aeb3541227a5456..d1ec6fad38b35681 100644
--- a/drivers/soc/renesas/rcar-sysc.h
+++ b/drivers/soc/renesas/rcar-sysc.h
@@ -49,4 +49,5 @@ struct rcar_sysc_info {
 	unsigned int num_areas;
 };
 
+extern const struct rcar_sysc_info r8a7779_sysc_info;
 #endif /* __SOC_RENESAS_RCAR_SYSC_H__ */
-- 
1.9.1

