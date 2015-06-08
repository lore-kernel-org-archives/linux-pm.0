From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 2/2] ARM: dts: Set max17047 over heat and over voltage
 thresholds
Date: Mon, 08 Jun 2015 10:11:39 +0900
Message-ID: <1433725899-13849-2-git-send-email-k.kozlowski@samsung.com>
References: <1433725899-13849-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:27846 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820AbbFHBLy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2015 21:11:54 -0400
In-reply-to: <1433725899-13849-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Add some safe values for over head and over voltage. The Trats2 uses 3.8
V battery and during testing it operated properly under 4.48 V.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4412-trats2.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 0b228ee14c64..8a87d39a28a0 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -595,6 +595,9 @@
 			interrupt-parent = <&gpx2>;
 			interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
 			reg = <0x36>;
+
+			maxim,over-heat-temp = <700>;
+			maxim,over-volt = <4500>;
 		};
 	};
 
-- 
1.9.1

