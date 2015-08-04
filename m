From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v4 2/6] mfd: da9150: Update DT bindings for Fuel-Gauge support
Date: Tue, 4 Aug 2015 17:16:30 +0100
Message-ID: <0e26ffa33ae356bd1bf157a665ee7b24b7310f2f.1438692348.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1438692348.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.153]:37405 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753203AbbHDQQx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2015 12:16:53 -0400
In-Reply-To: <cover.1438692348.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---

Changes in v4:
 - Update compatible string of fuel-gauge to "da9150-fuel-gauge".
 - Node name tidy up, relating to maintainer comments on fuel-gauge DT
   binding doc.
 - Removed Ack to patch from Lee Jones, as this has now been modified slightly
   and didn't want to make assumptions of approval.

Changes in v3:
 - Removal of unwanted new-line.
 - Flesh out example bindings usage.

Changes in v2:
 - N/A

 Documentation/devicetree/bindings/mfd/da9150.txt | 27 ++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/da9150.txt b/Documentation/devicetree/bindings/mfd/da9150.txt
index d0588ea..970801d 100644
--- a/Documentation/devicetree/bindings/mfd/da9150.txt
+++ b/Documentation/devicetree/bindings/mfd/da9150.txt
@@ -6,6 +6,7 @@ Device			 Description
 ------			 -----------
 da9150-gpadc		: General Purpose ADC
 da9150-charger		: Battery Charger
+da9150-fg		: Battery Fuel-Gauge

 ======

@@ -22,7 +23,7 @@ Required properties:
 Sub-devices:
 - da9150-gpadc: See Documentation/devicetree/bindings/iio/adc/da9150-gpadc.txt
 - da9150-charger: See Documentation/devicetree/bindings/power/da9150-charger.txt
-
+- da9150-fg: See Documentation/devicetree/bindings/power/da9150-fg.txt

 Example:

@@ -34,10 +35,28 @@ Example:
 		interrupt-controller;

 		gpadc: da9150-gpadc {
-			...
+			compatible = "dlg,da9150-gpadc";
+			#io-channel-cells = <1>;
+		};
+
+		charger {
+			compatible = "dlg,da9150-charger";
+
+			io-channels = <&gpadc 0>,
+				      <&gpadc 2>,
+				      <&gpadc 8>,
+				      <&gpadc 5>;
+			io-channel-names = "CHAN_IBUS",
+					   "CHAN_VBUS",
+					   "CHAN_TJUNC",
+					   "CHAN_VBAT";
 		};

-		da9150-charger {
-			...
+		fuel-gauge {
+			compatible = "dlg,da9150-fuel-gauge";
+
+			dlg,update-interval = <10000>;
+			dlg,warn-soc-level = /bits/ 8 <15>;
+			dlg,crit-soc-level = /bits/ 8 <5>
 		};
 	};
--
1.9.3

