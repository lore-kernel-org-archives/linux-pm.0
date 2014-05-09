From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/3] ARM: ux500: Add DT node for ux500 power domains
Date: Fri,  9 May 2014 15:05:03 +0200
Message-ID: <1399640704-12289-3-git-send-email-ulf.hansson@linaro.org>
References: <1399640704-12289-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:44492 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755467AbaEINFN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 May 2014 09:05:13 -0400
Received: by mail-la0-f50.google.com with SMTP id b8so407052lan.23
        for <linux-pm@vger.kernel.org>; Fri, 09 May 2014 06:05:12 -0700 (PDT)
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
 arch/arm/boot/dts/ste-dbx5x0.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index e41eedc..29a7013 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -43,6 +43,10 @@
 			interrupts = <0 7 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		pm_domains: pm_domains0 {
+			compatible = "stericsson,ux500-pm-domains";
+			#power-domain-cells = <1>;
+		};
 
 		clocks {
 			compatible = "stericsson,u8500-clks";
-- 
1.7.9.5

