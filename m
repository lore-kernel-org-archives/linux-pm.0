From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [RFC 3/3] ARM: ux500: Add sdi[n] devices to VAPE power domain
Date: Wed, 16 Apr 2014 15:05:11 +0200
Message-ID: <1397653511-19226-4-git-send-email-ulf.hansson@linaro.org>
References: <1397653511-19226-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:57888 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756297AbaDPNFZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Apr 2014 09:05:25 -0400
Received: by mail-we0-f174.google.com with SMTP id t60so10966098wes.33
        for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2014 06:05:24 -0700 (PDT)
In-Reply-To: <1397653511-19226-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 29a7013..8a0ac7d 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -11,6 +11,7 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/mfd/dbx500-prcmu.h>
+#include <dt-bindings/arm/ux500_pm_domains.h>
 #include "skeleton.dtsi"
 
 / {
@@ -840,6 +841,7 @@
 
 			clocks = <&prcc_kclk 1 5>, <&prcc_pclk 1 5>;
 			clock-names = "sdi", "apb_pclk";
+			power-domain = <&pm_domains DOMAIN_VAPE>;
 
 			status = "disabled";
 		};
@@ -855,6 +857,7 @@
 
 			clocks = <&prcc_kclk 2 4>, <&prcc_pclk 2 6>;
 			clock-names = "sdi", "apb_pclk";
+			power-domain = <&pm_domains DOMAIN_VAPE>;
 
 			status = "disabled";
 		};
@@ -870,6 +873,7 @@
 
 			clocks = <&prcc_kclk 3 4>, <&prcc_pclk 3 4>;
 			clock-names = "sdi", "apb_pclk";
+			power-domain = <&pm_domains DOMAIN_VAPE>;
 
 			status = "disabled";
 		};
@@ -881,6 +885,7 @@
 
 			clocks = <&prcc_kclk 2 5>, <&prcc_pclk 2 7>;
 			clock-names = "sdi", "apb_pclk";
+			power-domain = <&pm_domains DOMAIN_VAPE>;
 
 			status = "disabled";
 		};
@@ -896,6 +901,7 @@
 
 			clocks = <&prcc_kclk 2 2>, <&prcc_pclk 2 4>;
 			clock-names = "sdi", "apb_pclk";
+			power-domain = <&pm_domains DOMAIN_VAPE>;
 
 			status = "disabled";
 		};
@@ -907,6 +913,7 @@
 
 			clocks = <&prcc_kclk 3 7>, <&prcc_pclk 3 7>;
 			clock-names = "sdi", "apb_pclk";
+			power-domain = <&pm_domains DOMAIN_VAPE>;
 
 			status = "disabled";
 		};
-- 
1.7.9.5

