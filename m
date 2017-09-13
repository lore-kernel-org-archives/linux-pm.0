From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [RFC 3/3] arm64: dts: r8a7796: update register size for thermal
Date: Wed, 13 Sep 2017 13:01:37 +0200
Message-ID: <20170913110137.13490-4-niklas.soderlund+renesas@ragnatech.se>
References: <20170913110137.13490-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170913110137.13490-1-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
List-Id: linux-pm@vger.kernel.org

To be able to read fused calibration values from hardware the size of
the register resource of TSC1 needs to be incremented to cover one more
register which holds the information if the calibration values have been
fused or not.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 0b805dc30925e9be..b1428c10e703b37c 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -2098,7 +2098,7 @@
 
 		tsc: thermal@e6198000 {
 			compatible = "renesas,r8a7796-thermal";
-			reg = <0 0xe6198000 0 0x68>,
+			reg = <0 0xe6198000 0 0x6c>,
 			      <0 0xe61a0000 0 0x5c>,
 			      <0 0xe61a8000 0 0x5c>;
 			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.14.1
