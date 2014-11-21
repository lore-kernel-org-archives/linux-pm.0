From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v10 01/10] qom: scm: Move scm-boot files to drivers/soc/qcom/ and include/soc/qcom
Date: Fri, 21 Nov 2014 11:03:48 -0700
Message-ID: <1416593037-27527-2-git-send-email-lina.iyer@linaro.org>
References: <1416593037-27527-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:61503 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbaKUSEG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Nov 2014 13:04:06 -0500
Received: by mail-pa0-f43.google.com with SMTP id kx10so5337287pab.16
        for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2014 10:04:06 -0800 (PST)
In-Reply-To: <1416593037-27527-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>

Follow the scm.c and move scm-boot files to drivers/soc/qcom. The
guidance is to clean files out from mach-qcom and move to drivers/soc
area.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/mach-qcom/Makefile                         | 1 -
 arch/arm/mach-qcom/platsmp.c                        | 2 +-
 drivers/soc/qcom/Makefile                           | 2 +-
 {arch/arm/mach-qcom => drivers/soc/qcom}/scm-boot.c | 4 ++--
 {arch/arm/mach-qcom => include/soc/qcom}/scm-boot.h | 0
 5 files changed, 4 insertions(+), 5 deletions(-)
 rename {arch/arm/mach-qcom => drivers/soc/qcom}/scm-boot.c (97%)
 rename {arch/arm/mach-qcom => include/soc/qcom}/scm-boot.h (100%)

diff --git a/arch/arm/mach-qcom/Makefile b/arch/arm/mach-qcom/Makefile
index db41e8c..e324375 100644
--- a/arch/arm/mach-qcom/Makefile
+++ b/arch/arm/mach-qcom/Makefile
@@ -1,3 +1,2 @@
 obj-y			:= board.o
 obj-$(CONFIG_SMP)	+= platsmp.o
-obj-$(CONFIG_QCOM_SCM)	+= scm-boot.o
diff --git a/arch/arm/mach-qcom/platsmp.c b/arch/arm/mach-qcom/platsmp.c
index d690856..a692bcb 100644
--- a/arch/arm/mach-qcom/platsmp.c
+++ b/arch/arm/mach-qcom/platsmp.c
@@ -20,7 +20,7 @@
 
 #include <asm/smp_plat.h>
 
-#include "scm-boot.h"
+#include <soc/qcom/scm-boot.h>
 
 #define VDD_SC1_ARRAY_CLAMP_GFS_CTL	0x35a0
 #define SCSS_CPU1CORE_RESET		0x2d80
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index a39446d..70d52ed 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
 CFLAGS_scm.o :=$(call as-instr,.arch_extension sec,-DREQUIRES_SEC=1)
-obj-$(CONFIG_QCOM_SCM) += scm.o
+obj-$(CONFIG_QCOM_SCM) += scm.o scm-boot.o
diff --git a/arch/arm/mach-qcom/scm-boot.c b/drivers/soc/qcom/scm-boot.c
similarity index 97%
rename from arch/arm/mach-qcom/scm-boot.c
rename to drivers/soc/qcom/scm-boot.c
index 5add20e..60ff7b4 100644
--- a/arch/arm/mach-qcom/scm-boot.c
+++ b/drivers/soc/qcom/scm-boot.c
@@ -17,9 +17,9 @@
 
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <soc/qcom/scm.h>
 
-#include "scm-boot.h"
+#include <soc/qcom/scm.h>
+#include <soc/qcom/scm-boot.h>
 
 /*
  * Set the cold/warm boot address for one of the CPU cores.
diff --git a/arch/arm/mach-qcom/scm-boot.h b/include/soc/qcom/scm-boot.h
similarity index 100%
rename from arch/arm/mach-qcom/scm-boot.h
rename to include/soc/qcom/scm-boot.h
-- 
2.1.0

