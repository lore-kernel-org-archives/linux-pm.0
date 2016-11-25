From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH 07/10] ARM: dts: sun8i-a33-olinuxino: use AXP223 DTSI
Date: Fri, 25 Nov 2016 10:09:18 +0100
Message-ID: <20161125090921.23138-8-quentin.schulz@free-electrons.com>
References: <20161125090921.23138-1-quentin.schulz@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:58741 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754580AbcKYJLj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Nov 2016 04:11:39 -0500
In-Reply-To: <20161125090921.23138-1-quentin.schulz@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com

Previously, the Olimex A33-OlinuXino used everything declared in AXP221
DTSI while it has an AXP223 PMIC.

This corrects that so the Olimex A33-OlinuXino can get some features the
AXP223 has (at the moment, ability to have 100mA as maximal current on
VBUS power supply).

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
index 9ea637e..3e8f2ec 100644
--- a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
+++ b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
@@ -126,7 +126,7 @@
 	};
 };
 
-#include "axp22x.dtsi"
+#include "axp223.dtsi"
 
 &reg_aldo1 {
 	regulator-always-on;
-- 
2.9.3

