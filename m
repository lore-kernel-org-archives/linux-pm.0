From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V8 01/14] thermal: tegra: move tegra thermal files into tegra directory
Date: Wed, 16 Mar 2016 16:55:58 +0800
Message-ID: <1458118571-29717-2-git-send-email-wni@nvidia.com>
References: <1458118571-29717-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458118571-29717-1-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mikko.perttunen-/1wQRMveznE@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Move Tegra soctherm driver to tegra directory, it's easy to maintain
and add more new function support for Tegra platforms.
This will also help to split soctherm driver into common parts and
chip specific data related parts.

Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/thermal/Kconfig                                     | 12 ++----------
 drivers/thermal/Makefile                                    |  2 +-
 drivers/thermal/tegra/Kconfig                               | 13 +++++++++++++
 drivers/thermal/tegra/Makefile                              |  1 +
 .../thermal/{tegra_soctherm.c => tegra/tegra-soctherm.c}    |  0
 5 files changed, 17 insertions(+), 11 deletions(-)
 create mode 100644 drivers/thermal/tegra/Kconfig
 create mode 100644 drivers/thermal/tegra/Makefile
 rename drivers/thermal/{tegra_soctherm.c => tegra/tegra-soctherm.c} (100%)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 8cc4ac64a91c..1802629f5051 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -254,16 +254,6 @@ config ARMADA_THERMAL
 	  Enable this option if you want to have support for thermal management
 	  controller present in Armada 370 and Armada XP SoC.
 
-config TEGRA_SOCTHERM
-	tristate "Tegra SOCTHERM thermal management"
-	depends on ARCH_TEGRA
-	help
-	  Enable this option for integrated thermal management support on NVIDIA
-	  Tegra124 systems-on-chip. The driver supports four thermal zones
-	  (CPU, GPU, MEM, PLLX). Cooling devices can be bound to the thermal
-	  zones to manage temperatures. This option is also required for the
-	  emergency thermal reset (thermtrip) feature to function.
-
 config DB8500_CPUFREQ_COOLING
 	tristate "DB8500 cpufreq cooling"
 	depends on ARCH_U8500
@@ -380,6 +370,8 @@ depends on ARCH_STI && OF
 source "drivers/thermal/st/Kconfig"
 endmenu
 
+source "drivers/thermal/tegra/Kconfig"
+
 config QCOM_SPMI_TEMP_ALARM
 	tristate "Qualcomm SPMI PMIC Temperature Alarm"
 	depends on OF && SPMI && IIO
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index cfae6a654793..119e25cdcc66 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -46,5 +46,5 @@ obj-$(CONFIG_TI_SOC_THERMAL)	+= ti-soc-thermal/
 obj-$(CONFIG_INT340X_THERMAL)  += int340x_thermal/
 obj-$(CONFIG_INTEL_PCH_THERMAL)	+= intel_pch_thermal.o
 obj-$(CONFIG_ST_THERMAL)	+= st/
-obj-$(CONFIG_TEGRA_SOCTHERM)	+= tegra_soctherm.o
+obj-$(CONFIG_TEGRA_SOCTHERM)	+= tegra/
 obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
diff --git a/drivers/thermal/tegra/Kconfig b/drivers/thermal/tegra/Kconfig
new file mode 100644
index 000000000000..bed898858d02
--- /dev/null
+++ b/drivers/thermal/tegra/Kconfig
@@ -0,0 +1,13 @@
+menu "NVIDIA Tegra thermal drivers"
+depends on ARCH_TEGRA
+
+config TEGRA_SOCTHERM
+	tristate "Tegra SOCTHERM thermal management"
+	help
+	  Enable this option for integrated thermal management support on NVIDIA
+	  Tegra124 systems-on-chip. The driver supports four thermal zones
+	  (CPU, GPU, MEM, PLLX). Cooling devices can be bound to the thermal
+	  zones to manage temperatures. This option is also required for the
+	  emergency thermal reset (thermtrip) feature to function.
+
+endmenu
diff --git a/drivers/thermal/tegra/Makefile b/drivers/thermal/tegra/Makefile
new file mode 100644
index 000000000000..d4dc4e7f279e
--- /dev/null
+++ b/drivers/thermal/tegra/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_TEGRA_SOCTHERM)	+= tegra-soctherm.o
diff --git a/drivers/thermal/tegra_soctherm.c b/drivers/thermal/tegra/tegra-soctherm.c
similarity index 100%
rename from drivers/thermal/tegra_soctherm.c
rename to drivers/thermal/tegra/tegra-soctherm.c
-- 
1.9.1
