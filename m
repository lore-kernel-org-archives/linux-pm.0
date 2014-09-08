From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/7 v6] leds: add device tree bindings for register bit LEDs
Date: Mon,  8 Sep 2014 13:38:01 +0200
Message-ID: <1410176286-32533-3-git-send-email-linus.walleij@linaro.org>
References: <1410176286-32533-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:41699 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084AbaIHLiX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Sep 2014 07:38:23 -0400
Received: by mail-wi0-f172.google.com with SMTP id n3so2456306wiv.5
        for <linux-pm@vger.kernel.org>; Mon, 08 Sep 2014 04:38:21 -0700 (PDT)
In-Reply-To: <1410176286-32533-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>

This adds the device tree bindings used by register bit LEDs.

Cc: devicetree@vger.kernel.org
Cc: Bryan Wu <cooloney@gmail.com>
Cc: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rename binding "register-bit-led"
- Define that such nodes appear only as children of syscon
- Group required and optional parameters
- Number nodes as foo@<offset>.<bit>
- Update example
---
 .../devicetree/bindings/leds/register-bit-led.txt  | 99 ++++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/register-bit-led.txt

diff --git a/Documentation/devicetree/bindings/leds/register-bit-led.txt b/Documentation/devicetree/bindings/leds/register-bit-led.txt
new file mode 100644
index 000000000000..379cefdc0bda
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/register-bit-led.txt
@@ -0,0 +1,99 @@
+Device Tree Bindings for Register Bit LEDs
+
+Register bit leds are used with syscon multifunctional devices
+where single bits in a certain register can turn on/off a
+single LED. The register bit LEDs appear as children to the
+syscon device, with the proper compatible string. For the
+syscon bindings see:
+Documentation/devicetree/bindings/mfd/syscon.txt
+
+Each LED is represented as a sub-node of the syscon device. Each
+node's name represents the name of the corresponding LED.
+
+LED sub-node properties:
+
+Required properties:
+- compatible : must be "register-bit-led"
+- offset : register offset to the register controlling this LED
+- mask : bit mask for the bit controlling this LED in the register
+  typically 0x01, 0x02, 0x04 ...
+
+Optional properties:
+- label : (optional)
+  see Documentation/devicetree/bindings/leds/common.txt
+- linux,default-trigger : (optional)
+  see Documentation/devicetree/bindings/leds/common.txt
+- default-state: (optional) The initial state of the LED. Valid
+  values are "on", "off", and "keep". If the LED is already on or off
+  and the default-state property is set the to same value, then no
+  glitch should be produced where the LED momentarily turns off (or
+  on). The "keep" setting will keep the LED at whatever its current
+  state is, without producing a glitch.  The default is off if this
+  property is not present.
+
+Example:
+
+syscon: syscon@10000000 {
+	compatible = "arm,realview-pb1176-syscon", "syscon";
+	reg = <0x10000000 0x1000>;
+
+	led@08.0 {
+		compatible = "register-bit-led";
+		offset = <0x08>;
+		mask = <0x01>;
+		label = "versatile:0";
+		linux,default-trigger = "heartbeat";
+		default-state = "on";
+	};
+	led@08.1 {
+		compatible = "register-bit-led";
+		offset = <0x08>;
+		mask = <0x02>;
+		label = "versatile:1";
+		linux,default-trigger = "mmc0";
+		default-state = "off";
+	};
+	led@08.2 {
+		compatible = "register-bit-led";
+		offset = <0x08>;
+		mask = <0x04>;
+		label = "versatile:2";
+		linux,default-trigger = "cpu0";
+		default-state = "off";
+	};
+	led@08.3 {
+		compatible = "register-bit-led";
+		offset = <0x08>;
+		mask = <0x08>;
+		label = "versatile:3";
+		default-state = "off";
+	};
+	led@08.4 {
+		compatible = "register-bit-led";
+		offset = <0x08>;
+		mask = <0x10>;
+		label = "versatile:4";
+		default-state = "off";
+	};
+	led@08.5 {
+		compatible = "register-bit-led";
+		offset = <0x08>;
+		mask = <0x20>;
+		label = "versatile:5";
+		default-state = "off";
+	};
+	led@08.6 {
+		compatible = "register-bit-led";
+		offset = <0x08>;
+		mask = <0x40>;
+		label = "versatile:6";
+		default-state = "off";
+	};
+	led@08.7 {
+		compatible = "register-bit-led";
+		offset = <0x08>;
+		mask = <0x80>;
+		label = "versatile:7";
+		default-state = "off";
+	};
+};
-- 
1.9.3

