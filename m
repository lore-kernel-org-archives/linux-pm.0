From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 6/7] soc: renesas: Add r8a7794 SYSC PM Domain Binding Definitions
Date: Wed,  9 Mar 2016 20:18:41 +0100
Message-ID: <1457551122-21838-7-git-send-email-geert+renesas@glider.be>
References: <1457551122-21838-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1457551122-21838-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - New.
---
 include/dt-bindings/power/r8a7794-sysc.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 include/dt-bindings/power/r8a7794-sysc.h

diff --git a/include/dt-bindings/power/r8a7794-sysc.h b/include/dt-bindings/power/r8a7794-sysc.h
new file mode 100644
index 0000000000000000..bbe54e977e05bdd1
--- /dev/null
+++ b/include/dt-bindings/power/r8a7794-sysc.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) 2016 Glider bvba
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ */
+#ifndef __DT_BINDINGS_POWER_R8A7794_SYSC_H__
+#define __DT_BINDINGS_POWER_R8A7794_SYSC_H__
+
+/*
+ * These power domain indices match the numbers of the interrupt bits
+ * representing the power areas in the various Interrupt Registers
+ * (e.g. SYSCISR, Interrupt Status Register)
+ */
+
+#define R8A7794_PD_CA7_CPU0		 5
+#define R8A7794_PD_CA7_CPU1		 6
+#define R8A7794_PD_SH			16
+#define R8A7794_PD_SGX			20
+#define R8A7794_PD_CA7_SCU		21
+
+#endif /* __DT_BINDINGS_POWER_R8A7794_SYSC_H__ */
-- 
1.9.1
