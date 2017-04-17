From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] thermal: bcm2835: move to the broadcom subdirectory
Date: Mon, 17 Apr 2017 23:04:16 +0200
Message-ID: <20170417210416.16426-1-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34992 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755453AbdDQVEk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Apr 2017 17:04:40 -0400
Received: by mail-lf0-f66.google.com with SMTP id i3so17473756lfh.2
        for <linux-pm@vger.kernel.org>; Mon, 17 Apr 2017 14:04:40 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Jon Mason <jonmason@broadcom.com>, linux-pm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>

From: Rafał Miłecki <rafal@milecki.pl>

We already have 2 Broadcom drivers and at least 1 more is coming. This
made us create broadcom subdirectory where bcm2835 should be moves now.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
I'm resending this patch including linux-pm mailing list. Sorry for
missing it previously.
---
 drivers/thermal/Kconfig                          | 8 --------
 drivers/thermal/Makefile                         | 1 -
 drivers/thermal/broadcom/Kconfig                 | 8 ++++++++
 drivers/thermal/broadcom/Makefile                | 1 +
 drivers/thermal/{ => broadcom}/bcm2835_thermal.c | 0
 5 files changed, 9 insertions(+), 9 deletions(-)
 rename drivers/thermal/{ => broadcom}/bcm2835_thermal.c (100%)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 6699843918fa..f786ae433032 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -468,12 +468,4 @@ config ZX2967_THERMAL
 	  the primitive temperature sensor embedded in zx2967 SoCs.
 	  This sensor generates the real time die temperature.
 
-config BCM2835_THERMAL
-	tristate "Thermal sensors on bcm2835 SoC"
-	depends on ARCH_BCM2835 || COMPILE_TEST
-	depends on HAS_IOMEM
-	depends on THERMAL_OF
-	help
-	  Support for thermal sensors on Broadcom bcm2835 SoCs.
-
 endif
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index a1e9b8b4e897..e6834061da28 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -60,4 +60,3 @@ obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
 obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
 obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
 obj-$(CONFIG_ZX2967_THERMAL)	+= zx2967_thermal.o
-obj-$(CONFIG_BCM2835_THERMAL)	+= bcm2835_thermal.o
diff --git a/drivers/thermal/broadcom/Kconfig b/drivers/thermal/broadcom/Kconfig
index f0dea8a8e002..ab08af4654ef 100644
--- a/drivers/thermal/broadcom/Kconfig
+++ b/drivers/thermal/broadcom/Kconfig
@@ -1,3 +1,11 @@
+config BCM2835_THERMAL
+	tristate "Thermal sensors on bcm2835 SoC"
+	depends on ARCH_BCM2835 || COMPILE_TEST
+	depends on HAS_IOMEM
+	depends on THERMAL_OF
+	help
+	  Support for thermal sensors on Broadcom bcm2835 SoCs.
+
 config BCM_NS_THERMAL
 	tristate "Northstar thermal driver"
 	depends on ARCH_BCM_IPROC || COMPILE_TEST
diff --git a/drivers/thermal/broadcom/Makefile b/drivers/thermal/broadcom/Makefile
index 059df9a0ed69..c6f62e4fd0ee 100644
--- a/drivers/thermal/broadcom/Makefile
+++ b/drivers/thermal/broadcom/Makefile
@@ -1 +1,2 @@
+obj-$(CONFIG_BCM2835_THERMAL)		+= bcm2835_thermal.o
 obj-$(CONFIG_BCM_NS_THERMAL)		+= ns-thermal.o
diff --git a/drivers/thermal/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
similarity index 100%
rename from drivers/thermal/bcm2835_thermal.c
rename to drivers/thermal/broadcom/bcm2835_thermal.c
-- 
2.11.0
