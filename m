From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH/RFC] Runtime PM: ARM: subarch-specific extensions
	of pdev_archdata
Date: Tue, 22 Sep 2009 18:50:48 -0700
Message-ID: <1253670648-28610-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On ARM platforms, power management can be very platform specific.
This patch allows ARM subarches to extend the platform_device
pdev_archdata for each subarch by creating a new struct pdev_machdata
and allowing each subarch to customize it as needed.

As a starting point, each subarch's <mach/device.h> creates an empty
struct pdev_machdata.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
Applies against Linus' current master branch and is a follow up
to : 

commit d7aacaddcac3971e33cf52d7e610c06696cb347f
Author: Magnus Damm <damm@igel.co.jp>
Date:   Wed Jul 8 13:21:31 2009 +0200

    Driver Core: Add platform device arch data V3
    
    Allow architecture specific data in struct platform_device V3.
    [...]

 arch/arm/include/asm/device.h                  |    3 +++
 arch/arm/mach-aaec2000/include/mach/device.h   |   12 ++++++++++++
 arch/arm/mach-at91/include/mach/device.h       |   12 ++++++++++++
 arch/arm/mach-bcmring/include/mach/device.h    |   12 ++++++++++++
 arch/arm/mach-clps711x/include/mach/device.h   |   12 ++++++++++++
 arch/arm/mach-davinci/include/mach/device.h    |   12 ++++++++++++
 arch/arm/mach-ebsa110/include/mach/device.h    |   12 ++++++++++++
 arch/arm/mach-ep93xx/include/mach/device.h     |   12 ++++++++++++
 arch/arm/mach-footbridge/include/mach/device.h |   12 ++++++++++++
 arch/arm/mach-gemini/include/mach/device.h     |   12 ++++++++++++
 arch/arm/mach-h720x/include/mach/device.h      |   12 ++++++++++++
 arch/arm/mach-integrator/include/mach/device.h |   12 ++++++++++++
 arch/arm/mach-iop13xx/include/mach/device.h    |   12 ++++++++++++
 arch/arm/mach-iop32x/include/mach/device.h     |   12 ++++++++++++
 arch/arm/mach-iop33x/include/mach/device.h     |   12 ++++++++++++
 arch/arm/mach-ixp2000/include/mach/device.h    |   12 ++++++++++++
 arch/arm/mach-ixp23xx/include/mach/device.h    |   12 ++++++++++++
 arch/arm/mach-ixp4xx/include/mach/device.h     |   12 ++++++++++++
 arch/arm/mach-kirkwood/include/mach/device.h   |   12 ++++++++++++
 arch/arm/mach-ks8695/include/mach/device.h     |   12 ++++++++++++
 arch/arm/mach-l7200/include/mach/device.h      |   12 ++++++++++++
 arch/arm/mach-lh7a40x/include/mach/device.h    |   12 ++++++++++++
 arch/arm/mach-loki/include/mach/device.h       |   12 ++++++++++++
 arch/arm/mach-mmp/include/mach/device.h        |   12 ++++++++++++
 arch/arm/mach-msm/include/mach/device.h        |   12 ++++++++++++
 arch/arm/mach-mv78xx0/include/mach/device.h    |   12 ++++++++++++
 arch/arm/mach-netx/include/mach/device.h       |   12 ++++++++++++
 arch/arm/mach-nomadik/include/mach/device.h    |   12 ++++++++++++
 arch/arm/mach-ns9xxx/include/mach/device.h     |   12 ++++++++++++
 arch/arm/mach-orion5x/include/mach/device.h    |   12 ++++++++++++
 arch/arm/mach-pnx4008/include/mach/device.h    |   12 ++++++++++++
 arch/arm/mach-pxa/include/mach/device.h        |   12 ++++++++++++
 arch/arm/mach-realview/include/mach/device.h   |   12 ++++++++++++
 arch/arm/mach-rpc/include/mach/device.h        |   12 ++++++++++++
 arch/arm/mach-s3c2400/include/mach/device.h    |   12 ++++++++++++
 arch/arm/mach-s3c2410/include/mach/device.h    |   12 ++++++++++++
 arch/arm/mach-s3c2442/include/mach/device.h    |   12 ++++++++++++
 arch/arm/mach-s3c24a0/include/mach/device.h    |   12 ++++++++++++
 arch/arm/mach-s3c6400/include/mach/device.h    |   12 ++++++++++++
 arch/arm/mach-s5pc100/include/mach/device.h    |   12 ++++++++++++
 arch/arm/mach-sa1100/include/mach/device.h     |   12 ++++++++++++
 arch/arm/mach-shark/include/mach/device.h      |   12 ++++++++++++
 arch/arm/mach-stmp378x/include/mach/device.h   |   12 ++++++++++++
 arch/arm/mach-stmp37xx/include/mach/device.h   |   12 ++++++++++++
 arch/arm/mach-u300/include/mach/device.h       |   12 ++++++++++++
 arch/arm/mach-versatile/include/mach/device.h  |   12 ++++++++++++
 arch/arm/mach-w90x900/include/mach/device.h    |   12 ++++++++++++
 arch/arm/plat-mxc/include/mach/device.h        |   12 ++++++++++++
 arch/arm/plat-omap/include/mach/device.h       |   12 ++++++++++++
 arch/arm/plat-s3c/include/mach/device.h        |   12 ++++++++++++
 arch/arm/plat-s3c24xx/include/mach/device.h    |   12 ++++++++++++
 arch/arm/plat-stmp3xxx/include/mach/device.h   |   12 ++++++++++++
 52 files changed, 615 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-aaec2000/include/mach/device.h
 create mode 100644 arch/arm/mach-at91/include/mach/device.h
 create mode 100644 arch/arm/mach-bcmring/include/mach/device.h
 create mode 100644 arch/arm/mach-clps711x/include/mach/device.h
 create mode 100644 arch/arm/mach-davinci/include/mach/device.h
 create mode 100644 arch/arm/mach-ebsa110/include/mach/device.h
 create mode 100644 arch/arm/mach-ep93xx/include/mach/device.h
 create mode 100644 arch/arm/mach-footbridge/include/mach/device.h
 create mode 100644 arch/arm/mach-gemini/include/mach/device.h
 create mode 100644 arch/arm/mach-h720x/include/mach/device.h
 create mode 100644 arch/arm/mach-integrator/include/mach/device.h
 create mode 100644 arch/arm/mach-iop13xx/include/mach/device.h
 create mode 100644 arch/arm/mach-iop32x/include/mach/device.h
 create mode 100644 arch/arm/mach-iop33x/include/mach/device.h
 create mode 100644 arch/arm/mach-ixp2000/include/mach/device.h
 create mode 100644 arch/arm/mach-ixp23xx/include/mach/device.h
 create mode 100644 arch/arm/mach-ixp4xx/include/mach/device.h
 create mode 100644 arch/arm/mach-kirkwood/include/mach/device.h
 create mode 100644 arch/arm/mach-ks8695/include/mach/device.h
 create mode 100644 arch/arm/mach-l7200/include/mach/device.h
 create mode 100644 arch/arm/mach-lh7a40x/include/mach/device.h
 create mode 100644 arch/arm/mach-loki/include/mach/device.h
 create mode 100644 arch/arm/mach-mmp/include/mach/device.h
 create mode 100644 arch/arm/mach-msm/include/mach/device.h
 create mode 100644 arch/arm/mach-mv78xx0/include/mach/device.h
 create mode 100644 arch/arm/mach-netx/include/mach/device.h
 create mode 100644 arch/arm/mach-nomadik/include/mach/device.h
 create mode 100644 arch/arm/mach-ns9xxx/include/mach/device.h
 create mode 100644 arch/arm/mach-orion5x/include/mach/device.h
 create mode 100644 arch/arm/mach-pnx4008/include/mach/device.h
 create mode 100644 arch/arm/mach-pxa/include/mach/device.h
 create mode 100644 arch/arm/mach-realview/include/mach/device.h
 create mode 100644 arch/arm/mach-rpc/include/mach/device.h
 create mode 100644 arch/arm/mach-s3c2400/include/mach/device.h
 create mode 100644 arch/arm/mach-s3c2410/include/mach/device.h
 create mode 100644 arch/arm/mach-s3c2442/include/mach/device.h
 create mode 100644 arch/arm/mach-s3c24a0/include/mach/device.h
 create mode 100644 arch/arm/mach-s3c6400/include/mach/device.h
 create mode 100644 arch/arm/mach-s5pc100/include/mach/device.h
 create mode 100644 arch/arm/mach-sa1100/include/mach/device.h
 create mode 100644 arch/arm/mach-shark/include/mach/device.h
 create mode 100644 arch/arm/mach-stmp378x/include/mach/device.h
 create mode 100644 arch/arm/mach-stmp37xx/include/mach/device.h
 create mode 100644 arch/arm/mach-u300/include/mach/device.h
 create mode 100644 arch/arm/mach-versatile/include/mach/device.h
 create mode 100644 arch/arm/mach-w90x900/include/mach/device.h
 create mode 100644 arch/arm/plat-mxc/include/mach/device.h
 create mode 100644 arch/arm/plat-omap/include/mach/device.h
 create mode 100644 arch/arm/plat-s3c/include/mach/device.h
 create mode 100644 arch/arm/plat-s3c24xx/include/mach/device.h
 create mode 100644 arch/arm/plat-stmp3xxx/include/mach/device.h

diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
index 9f390ce..8bf0dd8 100644
--- a/arch/arm/include/asm/device.h
+++ b/arch/arm/include/asm/device.h
@@ -6,6 +6,8 @@
 #ifndef ASMARM_DEVICE_H
 #define ASMARM_DEVICE_H
 
+#include <mach/device.h>
+
 struct dev_archdata {
 #ifdef CONFIG_DMABOUNCE
 	struct dmabounce_device_info *dmabounce;
@@ -13,6 +15,7 @@ struct dev_archdata {
 };
 
 struct pdev_archdata {
+	struct pdev_machdata machdata;
 };
 
 #endif
diff --git a/arch/arm/mach-aaec2000/include/mach/device.h b/arch/arm/mach-aaec2000/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-aaec2000/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-at91/include/mach/device.h b/arch/arm/mach-at91/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-at91/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-bcmring/include/mach/device.h b/arch/arm/mach-bcmring/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-bcmring/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-clps711x/include/mach/device.h b/arch/arm/mach-clps711x/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-clps711x/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-davinci/include/mach/device.h b/arch/arm/mach-davinci/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-davinci/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-ebsa110/include/mach/device.h b/arch/arm/mach-ebsa110/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-ebsa110/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-ep93xx/include/mach/device.h b/arch/arm/mach-ep93xx/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-ep93xx/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-footbridge/include/mach/device.h b/arch/arm/mach-footbridge/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-footbridge/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-gemini/include/mach/device.h b/arch/arm/mach-gemini/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-gemini/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-h720x/include/mach/device.h b/arch/arm/mach-h720x/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-h720x/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-integrator/include/mach/device.h b/arch/arm/mach-integrator/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-integrator/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-iop13xx/include/mach/device.h b/arch/arm/mach-iop13xx/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-iop13xx/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-iop32x/include/mach/device.h b/arch/arm/mach-iop32x/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-iop32x/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-iop33x/include/mach/device.h b/arch/arm/mach-iop33x/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-iop33x/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-ixp2000/include/mach/device.h b/arch/arm/mach-ixp2000/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-ixp2000/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-ixp23xx/include/mach/device.h b/arch/arm/mach-ixp23xx/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-ixp23xx/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-ixp4xx/include/mach/device.h b/arch/arm/mach-ixp4xx/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-ixp4xx/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-kirkwood/include/mach/device.h b/arch/arm/mach-kirkwood/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-kirkwood/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-ks8695/include/mach/device.h b/arch/arm/mach-ks8695/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-ks8695/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-l7200/include/mach/device.h b/arch/arm/mach-l7200/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-l7200/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-lh7a40x/include/mach/device.h b/arch/arm/mach-lh7a40x/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-lh7a40x/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-loki/include/mach/device.h b/arch/arm/mach-loki/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-loki/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-mmp/include/mach/device.h b/arch/arm/mach-mmp/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-mmp/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-msm/include/mach/device.h b/arch/arm/mach-msm/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-msm/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-mv78xx0/include/mach/device.h b/arch/arm/mach-mv78xx0/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-mv78xx0/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-netx/include/mach/device.h b/arch/arm/mach-netx/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-netx/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-nomadik/include/mach/device.h b/arch/arm/mach-nomadik/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-nomadik/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-ns9xxx/include/mach/device.h b/arch/arm/mach-ns9xxx/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-ns9xxx/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-orion5x/include/mach/device.h b/arch/arm/mach-orion5x/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-orion5x/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-pnx4008/include/mach/device.h b/arch/arm/mach-pnx4008/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-pnx4008/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-pxa/include/mach/device.h b/arch/arm/mach-pxa/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-pxa/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-realview/include/mach/device.h b/arch/arm/mach-realview/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-realview/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-rpc/include/mach/device.h b/arch/arm/mach-rpc/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-rpc/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-s3c2400/include/mach/device.h b/arch/arm/mach-s3c2400/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-s3c2400/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-s3c2410/include/mach/device.h b/arch/arm/mach-s3c2410/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-s3c2410/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-s3c2442/include/mach/device.h b/arch/arm/mach-s3c2442/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-s3c2442/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-s3c24a0/include/mach/device.h b/arch/arm/mach-s3c24a0/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-s3c24a0/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-s3c6400/include/mach/device.h b/arch/arm/mach-s3c6400/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-s3c6400/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-s5pc100/include/mach/device.h b/arch/arm/mach-s5pc100/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-s5pc100/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-sa1100/include/mach/device.h b/arch/arm/mach-sa1100/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-sa1100/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-shark/include/mach/device.h b/arch/arm/mach-shark/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-shark/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-stmp378x/include/mach/device.h b/arch/arm/mach-stmp378x/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-stmp378x/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-stmp37xx/include/mach/device.h b/arch/arm/mach-stmp37xx/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-stmp37xx/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-u300/include/mach/device.h b/arch/arm/mach-u300/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-u300/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-versatile/include/mach/device.h b/arch/arm/mach-versatile/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-versatile/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/mach-w90x900/include/mach/device.h b/arch/arm/mach-w90x900/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/mach-w90x900/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/plat-mxc/include/mach/device.h b/arch/arm/plat-mxc/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/plat-omap/include/mach/device.h b/arch/arm/plat-omap/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/plat-omap/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/plat-s3c/include/mach/device.h b/arch/arm/plat-s3c/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/plat-s3c/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/plat-s3c24xx/include/mach/device.h b/arch/arm/plat-s3c24xx/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/plat-s3c24xx/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
diff --git a/arch/arm/plat-stmp3xxx/include/mach/device.h b/arch/arm/plat-stmp3xxx/include/mach/device.h
new file mode 100644
index 0000000..0bd31e6
--- /dev/null
+++ b/arch/arm/plat-stmp3xxx/include/mach/device.h
@@ -0,0 +1,12 @@
+/*
+ * ARM mach-specific extensions to platform_device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef MACH_DEVICE_H
+#define MACH_DEVICE_H
+
+struct pdev_machdata {
+};
+
+#endif
-- 
1.6.4.3
