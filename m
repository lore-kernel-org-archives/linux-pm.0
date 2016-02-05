From: Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4/5] arm64: dts: rockchip: make rk3368 grf syscons simple-mfds as well
Date: Fri,  5 Feb 2016 22:20:17 +0100
Message-ID: <1454707218-23676-5-git-send-email-heiko@sntech.de>
References: <1454707218-23676-1-git-send-email-heiko@sntech.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:60364 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755028AbcBEVUa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 5 Feb 2016 16:20:30 -0500
In-Reply-To: <1454707218-23676-1-git-send-email-heiko@sntech.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, khilman@kernel.org
Cc: linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, sjoerd.simons@collabora.co.uk, dianders@chromium.org, david.wu@rock-chips.com, Heiko Stuebner <heiko@sntech.de>

The general register files do contain a lot of separate functions and
while some really are only registers with a lot of different 1-bit
settings, there are also a lot of them containing some bigger function
blocks. To be able to define these as sub-devices, make them simple-mfds.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 49d1191..6029310 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -556,7 +556,7 @@
 	};
 
 	pmugrf: syscon@ff738000 {
-		compatible = "rockchip,rk3368-pmugrf", "syscon";
+		compatible = "rockchip,rk3368-pmugrf", "syscon", "simple-mfd";
 		reg = <0x0 0xff738000 0x0 0x1000>;
 	};
 
@@ -569,7 +569,7 @@
 	};
 
 	grf: syscon@ff770000 {
-		compatible = "rockchip,rk3368-grf", "syscon";
+		compatible = "rockchip,rk3368-grf", "syscon", "simple-mfd";
 		reg = <0x0 0xff770000 0x0 0x1000>;
 	};
 
-- 
2.6.4

