From: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Subject: [PATCH v4 2/2] add property of "linux,wakeup" for juno.dts
Date: Wed, 16 Sep 2015 14:47:00 +0800
Message-ID: <1442386021-5113-2-git-send-email-zhaoyang.huang@linaro.org>
References: <1442386021-5113-1-git-send-email-zhaoyang.huang@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34176 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbbIPGrN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2015 02:47:13 -0400
Received: by padhy16 with SMTP id hy16so200307232pad.1
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2015 23:47:12 -0700 (PDT)
In-Reply-To: <1442386021-5113-1-git-send-email-zhaoyang.huang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: amit.kucheria@linaro.org, sudeep.holla@arm.com

add property of "linux,wakeup" to let the driver know
if the device should work as wakeup source

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@linaro.org>
---
 Documentation/devicetree/bindings/serial/pl011.txt |    3 ++-
 arch/arm64/boot/dts/arm/juno-base.dtsi             |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/pl011.txt b/Documentation/devicetree/bindings/serial/pl011.txt
index cbae3d9..609e8e9 100644
--- a/Documentation/devicetree/bindings/serial/pl011.txt
+++ b/Documentation/devicetree/bindings/serial/pl011.txt
@@ -35,7 +35,8 @@ Optional properties:
 - poll-timeout-ms:
 	   Poll timeout when auto-poll is set, default
 	   3000ms.
-
+- linux,wakeup:
+	   set the pl011 work as wakeup source for suspend to ram/idle
 See also bindings/arm/primecell.txt
 
 Example:
diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index a3d5a77..f7bb150 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -152,6 +152,7 @@
 		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&soc_uartclk>, <&soc_refclk100mhz>;
 		clock-names = "uartclk", "apb_pclk";
+		linux,wakeup;
 	};
 
 	i2c@7ffa0000 {
-- 
1.7.9.5

