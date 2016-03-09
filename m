From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v3 7/7] soc: renesas: Add r8a7795 SYSC PM Domain Binding Definitions
Date: Wed,  9 Mar 2016 20:18:42 +0100
Message-ID: <1457551122-21838-8-git-send-email-geert+renesas@glider.be>
References: <1457551122-21838-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457551122-21838-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
