From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [RFC 2/3] arm64: dts: r8a7795: update register size for thermal
Date: Wed, 13 Sep 2017 13:01:36 +0200
Message-ID: <20170913110137.13490-3-niklas.soderlund+renesas@ragnatech.se>
References: <20170913110137.13490-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp-3.sys.kth.se ([130.237.48.192]:42154 "EHLO
        smtp-3.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751940AbdIMLCH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Sep 2017 07:02:07 -0400
In-Reply-To: <20170913110137.13490-1-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>

To be able to read fused calibration values from hardware the size of
the register resource of TSC1 needs to be incremented to cover one more
register which holds the information if the calibration values have been
fused or not.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 1818fd20660d0315..be3c7ff6999af57e 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -2805,7 +2805,7 @@
 
 		tsc: thermal@e6198000 {
 			compatible = "renesas,r8a7795-thermal";
-			reg = <0 0xe6198000 0 0x68>,
+			reg = <0 0xe6198000 0 0x6c>,
 			      <0 0xe61a0000 0 0x5c>,
 			      <0 0xe61a8000 0 0x5c>;
 			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.14.1
