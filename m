From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH v3] Documentation: DT: twl-charger: document new iio properties
Date: Fri, 25 Sep 2015 22:20:46 +0200
Message-ID: <1443212447-5841-2-git-send-email-marek@goldelico.com>
References: <1443212447-5841-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443212447-5841-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: neilb@suse.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, hns@goldelico.com, Marek Belisko <marek@goldelico.com>
List-Id: linux-pm@vger.kernel.org

Document added iio properties to avoid using direct function call from twl4030-madc
driver.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 Documentation/devicetree/bindings/power/twl-charger.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/twl-charger.txt b/Documentation/devicetree/bindings/power/twl-charger.txt
index 3b4ea1b..e198650 100644
--- a/Documentation/devicetree/bindings/power/twl-charger.txt
+++ b/Documentation/devicetree/bindings/power/twl-charger.txt
@@ -19,12 +19,18 @@ Required properties:
 Optional properties:
 - ti,bb-uvolt: microvolts for charging the backup battery.
 - ti,bb-uamp: microamps for charging the backup battery.
+- io-channels: Should contain following: <&twl4030_madc 11>
+- io-channel-names: Should contains following value:
+	* "vac" - ADC channel for measuring the voltage of the external AC charger
+If io properties aren't provided then functionality of accesory charger doesn't work.
 
 Examples:
 
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
