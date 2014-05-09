From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/3] ARM: ux500: Add sdi[n] devices to VAPE power domain
Date: Fri,  9 May 2014 15:05:04 +0200
Message-ID: <1399640704-12289-4-git-send-email-ulf.hansson@linaro.org>
References: <1399640704-12289-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:35822 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755542AbaEINFQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 May 2014 09:05:16 -0400
Received: by mail-lb0-f175.google.com with SMTP id l4so5322790lbv.6
        for <linux-pm@vger.kernel.org>; Fri, 09 May 2014 06:05:14 -0700 (PDT)
In-Reply-To: <1399640704-12289-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Alessandro Rubini <rubini@unipv.it>, Russell King <linux@arm.linux.org.uk>
Cc: linux-pm@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 29a7013..630690b 100644
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
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			status = "disabled";
 		};
@@ -855,6 +857,7 @@
 
 			clocks = <&prcc_kclk 2 4>, <&prcc_pclk 2 6>;
 			clock-names = "sdi", "apb_pclk";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			status = "disabled";
 		};
@@ -870,6 +873,7 @@
 
 			clocks = <&prcc_kclk 3 4>, <&prcc_pclk 3 4>;
 			clock-names = "sdi", "apb_pclk";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			status = "disabled";
 		};
@@ -881,6 +885,7 @@
 
 			clocks = <&prcc_kclk 2 5>, <&prcc_pclk 2 7>;
 			clock-names = "sdi", "apb_pclk";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			status = "disabled";
 		};
@@ -896,6 +901,7 @@
 
 			clocks = <&prcc_kclk 2 2>, <&prcc_pclk 2 4>;
 			clock-names = "sdi", "apb_pclk";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			status = "disabled";
 		};
@@ -907,6 +913,7 @@
 
 			clocks = <&prcc_kclk 3 7>, <&prcc_pclk 3 7>;
 			clock-names = "sdi", "apb_pclk";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			status = "disabled";
 		};
-- 
1.7.9.5

