From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [RFC PATCH 2/3] ARM: ux500: Add DT node for ux500 power domains
Date: Wed, 16 Apr 2014 15:05:10 +0200
Message-ID: <1397653511-19226-3-git-send-email-ulf.hansson@linaro.org>
References: <1397653511-19226-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:36443 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756298AbaDPNFY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Apr 2014 09:05:24 -0400
Received: by mail-we0-f173.google.com with SMTP id w61so10717653wes.18
        for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2014 06:05:23 -0700 (PDT)
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

