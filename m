From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH v2 2/3] Documentation: DT: twl-charger: document new iio properties
Date: Tue, 22 Sep 2015 22:19:30 +0200
Message-ID: <1442953171-19718-2-git-send-email-marek@goldelico.com>
References: <1442953171-19718-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442953171-19718-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-pm@vger.kernel.org, hns@goldelico.com, linux-kernel@vger.kernel.org, neilb@suse.de, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Marek Belisko <marek@goldelico.com>
List-Id: linux-pm@vger.kernel.org

Document added iio properties to avoid using direct funcion call from twl4030-madc
driver.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 Documentation/devicetree/bindings/power/twl-charger.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/twl-charger.txt b/Documentation/devicetree/bindings/power/twl-charger.txt
index 3b4ea1b..54faee6 100644
--- a/Documentation/devicetree/bindings/power/twl-charger.txt
+++ b/Documentation/devicetree/bindings/power/twl-charger.txt
@@ -15,6 +15,9 @@ Required properties:
   - "ti,twl4030-bci"
 - interrupts: two interrupt lines from the TWL SIH (secondary
   interrupt handler) - interrupts 9 and 2.
+- io-channels: Should contain following: <&twl4030_madc 11>
+- io-channel-names: Shoud contains following value:
+* "vac" - ADC channel for measuring the voltage of the external AC charger
 
 Optional properties:
 - ti,bb-uvolt: microvolts for charging the backup battery.
@@ -25,6 +28,8 @@ Examples:
 bci {
    compatible = "ti,twl4030-bci";
    interrupts = <9>, <2>;
+   io-channels = <&twl4030_madc 11>;
+   io-channel-name = "vac";
    ti,bb-uvolt = <3200000>;
    ti,bb-uamp = <150>;
 };
-- 
1.9.1
