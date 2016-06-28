From: Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v2 7/7] doc: bindings: act8945a-charger: Update properties
Date: Tue, 28 Jun 2016 09:22:50 +0800
Message-ID: <1467076970-12206-8-git-send-email-wenyou.yang@atmel.com>
References: <1467076970-12206-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:50576 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbcF1BiJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jun 2016 21:38:09 -0400
In-Reply-To: <1467076970-12206-1-git-send-email-wenyou.yang@atmel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-pm@vger.kernel.org, Wenyou Yang <wenyou.yang@atmel.com>

Due the driver improvements, update the properties,
 - Remove "active-semi,check-battery-temperature" property.
 - Add the properties, "active-semi,irq_gpio"
   and "active-semi,lbo-gpios".

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

Changes in v2: None

 Documentation/devicetree/bindings/power/act8945a-charger.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/act8945a-charger.txt b/Documentation/devicetree/bindings/power/act8945a-charger.txt
index bea254c..d7cf05b 100644
--- a/Documentation/devicetree/bindings/power/act8945a-charger.txt
+++ b/Documentation/devicetree/bindings/power/act8945a-charger.txt
@@ -4,10 +4,12 @@ Required properties:
  - compatible: "active-semi,act8945a", please refer to ../mfd/act8945a.txt.
  - active-semi,chglev-gpios: charge current level phandle with args
    as described in ../gpio/gpio.txt.
+ - active-semi,irq_gpios: specify the charger interrupt input phanle
+   with args as as described in ../gpio/gpio.txt.
+ - active-semi,lbo-gpios: specify the low battery voltage detect phandle
+   with args as as described in ../gpio/gpio.txt.
 
 Optional properties:
- - active-semi,check-battery-temperature: boolean to check the battery
-   temperature or not.
  - active-semi,input-voltage-threshold-microvolt: unit: mV;
    Specifies the charger's input over-voltage threshold value;
    The value can be: 6600, 7000, 7500, 8000; default: 6600
-- 
2.7.4

