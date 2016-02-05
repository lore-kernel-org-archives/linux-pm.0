From: Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 2/5] ARM: dts: rockchip: make rk3288-grf a simple-mfd
Date: Fri,  5 Feb 2016 22:20:15 +0100
Message-ID: <1454707218-23676-3-git-send-email-heiko@sntech.de>
References: <1454707218-23676-1-git-send-email-heiko@sntech.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:60366 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754903AbcBEVUa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 5 Feb 2016 16:20:30 -0500
In-Reply-To: <1454707218-23676-1-git-send-email-heiko@sntech.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, khilman@kernel.org
Cc: linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, sjoerd.simons@collabora.co.uk, dianders@chromium.org, david.wu@rock-chips.com, Heiko Stuebner <heiko@sntech.de>

Similar to the pmu, the general register files contain a lot of different
setting bits grouped into general registers, but also some somewhat special
entities like the controls for some phy-blocks or the io-voltage control.
To be able to move these blocks under the grf node where they actually
belong, make it a simple-mfd.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 3d46327..8e49c17 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -748,7 +748,7 @@
 	};
 
 	grf: syscon@ff770000 {
-		compatible = "rockchip,rk3288-grf", "syscon";
+		compatible = "rockchip,rk3288-grf", "syscon", "simple-mfd";
 		reg = <0xff770000 0x1000>;
 	};
 
-- 
2.6.4

