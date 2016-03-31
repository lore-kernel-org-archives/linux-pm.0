From: Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 5/5] arm64: dts: rockchip: add rk3368-r88 iodomains
Date: Thu, 31 Mar 2016 15:48:46 +0200
Message-ID: <1459432126-6395-6-git-send-email-heiko@sntech.de>
References: <1459432126-6395-1-git-send-email-heiko@sntech.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:51247 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756222AbcCaNtN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 31 Mar 2016 09:49:13 -0400
In-Reply-To: <1459432126-6395-1-git-send-email-heiko@sntech.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, khilman@kernel.org
Cc: linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>

Add the supply-links according to the R88 schematics.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
index 1f2b642..d4dd289 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
@@ -211,6 +211,18 @@
 	status = "ok";
 };
 
+&grf {
+	io-domains {
+		compatible = "rockchip,rk3368-io-voltage-domain";
+
+		audio-supply = <&vcc_io>;
+		gpio30-supply = <&vcc_io>;
+		gpio1830-supply = <&vcc_io>;
+		sdcard-supply = <&vccio_sd>;
+		wifi-supply = <&vccio_wl>;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -331,6 +343,16 @@
 	};
 };
 
+&pmugrf {
+	io-domains {
+		compatible = "rockchip,rk3368-pmu-io-voltage-domain";
+		rockchip,grf = <&pmugrf>;
+
+		pmu-supply = <&vcc_io>;
+		vop-supply = <&vcc_io>;
+	};
+};
+
 &saradc {
 	vref-supply = <&vcc_18>;
 	status = "okay";
-- 
2.6.4

