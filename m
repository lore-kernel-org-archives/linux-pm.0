From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 7/7] soc: renesas: Add r8a7795 SYSC PM Domain Binding Definitions
Date: Thu,  7 Apr 2016 14:20:20 +0200
Message-ID: <1460031620-13240-8-git-send-email-geert+renesas@glider.be>
References: <1460031620-13240-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1460031620-13240-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v4:
  - Add Reviewed-by,

v3:
  - New.
---
 include/dt-bindings/power/r8a7795-sysc.h | 42 ++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 include/dt-bindings/power/r8a7795-sysc.h

diff --git a/include/dt-bindings/power/r8a7795-sysc.h b/include/dt-bindings/power/r8a7795-sysc.h
new file mode 100644
index 0000000000000000..ee2e26ba605ef9a3
--- /dev/null
+++ b/include/dt-bindings/power/r8a7795-sysc.h
@@ -0,0 +1,42 @@
+/*
+ * Copyright (C) 2016 Glider bvba
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ */
+#ifndef __DT_BINDINGS_POWER_R8A7795_SYSC_H__
+#define __DT_BINDINGS_POWER_R8A7795_SYSC_H__
+
+/*
+ * These power domain indices match the numbers of the interrupt bits
+ * representing the power areas in the various Interrupt Registers
+ * (e.g. SYSCISR, Interrupt Status Register)
+ */
+
+#define R8A7795_PD_CA57_CPU0		 0
+#define R8A7795_PD_CA57_CPU1		 1
+#define R8A7795_PD_CA57_CPU2		 2
+#define R8A7795_PD_CA57_CPU3		 3
+#define R8A7795_PD_CA53_CPU0		 5
+#define R8A7795_PD_CA53_CPU1		 6
+#define R8A7795_PD_CA53_CPU2		 7
+#define R8A7795_PD_CA53_CPU3		 8
+#define R8A7795_PD_A3VP			 9
+#define R8A7795_PD_CA57_SCU		12
+#define R8A7795_PD_CR7			13
+#define R8A7795_PD_A3VC			14
+#define R8A7795_PD_3DG_A		17
+#define R8A7795_PD_3DG_B		18
+#define R8A7795_PD_3DG_C		19
+#define R8A7795_PD_3DG_D		20
+#define R8A7795_PD_CA53_SCU		21
+#define R8A7795_PD_3DG_E		22
+#define R8A7795_PD_A3IR			24
+#define R8A7795_PD_A2VC0		25
+#define R8A7795_PD_A2VC1		26
+
+/* Always-on power area */
+#define R8A7795_PD_ALWAYS_ON		32
+
+#endif /* __DT_BINDINGS_POWER_R8A7795_SYSC_H__ */
-- 
1.9.1
