From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V6 08/10] soc: tegra: pmc: Move powergate definitions to dt-bindings
Date: Fri, 26 Feb 2016 15:48:42 +0000
Message-ID: <1456501724-28477-9-git-send-email-jonathanh@nvidia.com>
References: <1456501724-28477-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456501724-28477-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Move the Tegra Powergate definitions into include/dt-bindings so that
these can be used by the powergate bindings in device-tree source files.

Remove the TEGRA_POWERGATE_3D0 definition as this is an alias and is
not used anywhere.

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/soc/tegra/pmc.c                     |  2 +
 include/dt-bindings/power/tegra-powergate.h | 88 +++++++++++++++++++++++++++++
 include/soc/tegra/pmc.h                     | 39 +------------
 3 files changed, 93 insertions(+), 36 deletions(-)
 create mode 100644 include/dt-bindings/power/tegra-powergate.h

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 9d2d204342c5..6c5833bc3fab 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -19,6 +19,8 @@
 
 #define pr_fmt(fmt) "tegra-pmc: " fmt
 
+#include <dt-bindings/power/tegra-powergate.h>
+
 #include <linux/kernel.h>
 #include <linux/clk.h>
 #include <linux/clk/tegra.h>
diff --git a/include/dt-bindings/power/tegra-powergate.h b/include/dt-bindings/power/tegra-powergate.h
new file mode 100644
index 000000000000..f45d64207bc0
--- /dev/null
+++ b/include/dt-bindings/power/tegra-powergate.h
@@ -0,0 +1,88 @@
+/*
+ * Copyright (c) 2016 NVIDIA Corporation
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _DT_BINDINGS_POWER_TEGRA_POWERGATE_H
+#define _DT_BINDINGS_POWER_TEGRA_POWERGATE_H
+
+/*
+ * The below definitions define the bit that is used to control the
+ * various powergates on the Tegra SoC devices. Note that not every
+ * powergate is available on a particular device. The following
+ * table provides a description of the powergates and shows which
+ * powergates are applicable to which devices.
+ *
+ * Name                   Description               Devices Applicable
+ * TEGRA_POWERGATE_CPU    CPU Cluster 0             All
+ * TEGRA_POWERGATE_3D     3D                        All
+ * TEGRA_POWERGATE_VENC   Video Encode              All
+ * TEGRA_POWERGATE_PCIE   PCIE                      Tegra20/30/124/210
+ * TEGRA_POWERGATE_VDEC   Video Decode              Tegra20/30/114/124
+ * TEGRA_POWERGATE_L2     L2 Cache                  Tegra20/30/114/210
+ * TEGRA_POWERGATE_MPE    MPEG Encode               All
+ * TEGRA_POWERGATE_HEG    2D                        Tegra30/114/124/210
+ * TEGRA_POWERGATE_SATA   SATA                      Tegra30/124/210
+ * TEGRA_POWERGATE_CPU1   CPU1                      Tegra30/114/124/210
+ * TEGRA_POWERGATE_CPU2   CPU2                      Tegra30/114/124/210
+ * TEGRA_POWERGATE_CPU3   CPU3                      Tegra30/114/124/210
+ * TEGRA_POWERGATE_CELP   Low-power CPU (cluster 1) Tegra30/114/124
+ * TEGRA_POWERGATE_3D1    3D1                       Tegra30
+ * TEGRA_POWERGATE_CPU0   CPU0                      Tegra114/124/210
+ * TEGRA_POWERGATE_C0NC   Cluster 0 non-CPU         Tegra114/124/210
+ * TEGRA_POWERGATE_C1NC   Cluster 1 non-CPU         Tegra114/124
+ * TEGRA_POWERGATE_SOR    Display interfaces        Tegra124/210
+ * TEGRA_POWERGATE_DIS    Display A                 Tegra114/124/210
+ * TEGRA_POWERGATE_DISB   Display B                 Tegra114/124/210
+ * TEGRA_POWERGATE_XUSBA  XUSB A                    Tegra114/124/210
+ * TEGRA_POWERGATE_XUSBB  XUSB B                    Tegra114/124/210
+ * TEGRA_POWERGATE_XUSBC  XUSB C                    Tegra114/124/210
+ * TEGRA_POWERGATE_VIC    Video Imaging Compositor  Tegra124/210
+ * TEGRA_POWERGATE_IRAM   Internal RAM              Tegra124/210
+ * TEGRA_POWERGATE_NVDEC  NV Video Decode           Tegra210
+ * TEGRA_POWERGATE_NVJPG  NV JPEG                   Tegra210
+ * TEGRA_POWERGATE_AUD    Audio                     Tegra210
+ * TEGRA_POWERGATE_DFD    Debug                     Tegra210
+ * TEGRA_POWERGATE_VE2    Video Encode 2            Tegra210
+ */
+#define TEGRA_POWERGATE_CPU	0
+#define TEGRA_POWERGATE_3D	1
+#define TEGRA_POWERGATE_VENC	2
+#define TEGRA_POWERGATE_PCIE	3
+#define TEGRA_POWERGATE_VDEC	4
+#define TEGRA_POWERGATE_L2	5
+#define TEGRA_POWERGATE_MPE	6
+#define TEGRA_POWERGATE_HEG	7
+#define TEGRA_POWERGATE_SATA	8
+#define TEGRA_POWERGATE_CPU1	9
+#define TEGRA_POWERGATE_CPU2	10
+#define TEGRA_POWERGATE_CPU3	11
+#define TEGRA_POWERGATE_CELP	12
+#define TEGRA_POWERGATE_3D1	13
+#define TEGRA_POWERGATE_CPU0	14
+#define TEGRA_POWERGATE_C0NC	15
+#define TEGRA_POWERGATE_C1NC	16
+#define TEGRA_POWERGATE_SOR	17
+#define TEGRA_POWERGATE_DIS	18
+#define TEGRA_POWERGATE_DISB	19
+#define TEGRA_POWERGATE_XUSBA	20
+#define TEGRA_POWERGATE_XUSBB	21
+#define TEGRA_POWERGATE_XUSBC	22
+#define TEGRA_POWERGATE_VIC	23
+#define TEGRA_POWERGATE_IRAM	24
+#define TEGRA_POWERGATE_NVDEC	25
+#define TEGRA_POWERGATE_NVJPG	26
+#define TEGRA_POWERGATE_AUD	27
+#define TEGRA_POWERGATE_DFD	28
+#define TEGRA_POWERGATE_VE2	29
+#define TEGRA_POWERGATE_MAX	TEGRA_POWERGATE_VE2
+
+#endif
diff --git a/include/soc/tegra/pmc.h b/include/soc/tegra/pmc.h
index e9e53473a63e..c028557365ad 100644
--- a/include/soc/tegra/pmc.h
+++ b/include/soc/tegra/pmc.h
@@ -19,6 +19,8 @@
 #ifndef __SOC_TEGRA_PMC_H__
 #define __SOC_TEGRA_PMC_H__
 
+#include <dt-bindings/power/tegra-powergate.h>
+
 #include <linux/reboot.h>
 
 #include <soc/tegra/pm.h>
@@ -39,43 +41,8 @@ int tegra_pmc_cpu_remove_clamping(unsigned int cpuid);
 #endif /* CONFIG_SMP */
 
 /*
- * powergate and I/O rail APIs
+ * I/O rail APIs
  */
-
-#define TEGRA_POWERGATE_CPU	0
-#define TEGRA_POWERGATE_3D	1
-#define TEGRA_POWERGATE_VENC	2
-#define TEGRA_POWERGATE_PCIE	3
-#define TEGRA_POWERGATE_VDEC	4
-#define TEGRA_POWERGATE_L2	5
-#define TEGRA_POWERGATE_MPE	6
-#define TEGRA_POWERGATE_HEG	7
-#define TEGRA_POWERGATE_SATA	8
-#define TEGRA_POWERGATE_CPU1	9
-#define TEGRA_POWERGATE_CPU2	10
-#define TEGRA_POWERGATE_CPU3	11
-#define TEGRA_POWERGATE_CELP	12
-#define TEGRA_POWERGATE_3D1	13
-#define TEGRA_POWERGATE_CPU0	14
-#define TEGRA_POWERGATE_C0NC	15
-#define TEGRA_POWERGATE_C1NC	16
-#define TEGRA_POWERGATE_SOR	17
-#define TEGRA_POWERGATE_DIS	18
-#define TEGRA_POWERGATE_DISB	19
-#define TEGRA_POWERGATE_XUSBA	20
-#define TEGRA_POWERGATE_XUSBB	21
-#define TEGRA_POWERGATE_XUSBC	22
-#define TEGRA_POWERGATE_VIC	23
-#define TEGRA_POWERGATE_IRAM	24
-#define TEGRA_POWERGATE_NVDEC	25
-#define TEGRA_POWERGATE_NVJPG	26
-#define TEGRA_POWERGATE_AUD	27
-#define TEGRA_POWERGATE_DFD	28
-#define TEGRA_POWERGATE_VE2	29
-#define TEGRA_POWERGATE_MAX	TEGRA_POWERGATE_VE2
-
-#define TEGRA_POWERGATE_3D0	TEGRA_POWERGATE_3D
-
 #define TEGRA_IO_RAIL_CSIA	0
 #define TEGRA_IO_RAIL_CSIB	1
 #define TEGRA_IO_RAIL_DSI	2
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
