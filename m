From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 2/4] mfd: da9150: Update DT bindings for Fuel-Gauge support
Date: Thu, 18 Jun 2015 17:06:36 +0100
Message-ID: <c2059088c648e3356a0c6f35db8f3f1116a68ffd.1434643491.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1434643491.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.164]:29354 "EHLO
	mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756400AbbFRQNd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jun 2015 12:13:33 -0400
In-Reply-To: <cover.1434643491.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 Documentation/devicetree/bindings/mfd/da9150.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/da9150.txt b/Documentation/devicetree/bindings/mfd/da9150.txt
index d0588ea..8bf1a20 100644
--- a/Documentation/devicetree/bindings/mfd/da9150.txt
+++ b/Documentation/devicetree/bindings/mfd/da9150.txt
@@ -6,6 +6,7 @@ Device			 Description
 ------			 -----------
 da9150-gpadc		: General Purpose ADC
 da9150-charger		: Battery Charger
+da9150-fg		: Battery Fuel-Gauge
 
 ======
 
@@ -22,6 +23,7 @@ Required properties:
 Sub-devices:
 - da9150-gpadc: See Documentation/devicetree/bindings/iio/adc/da9150-gpadc.txt
 - da9150-charger: See Documentation/devicetree/bindings/power/da9150-charger.txt
+- da9150-fg: See Documentation/devicetree/bindings/power/da9150-fg.txt
 
 
 Example:
@@ -40,4 +42,8 @@ Example:
 		da9150-charger {
 			...
 		};
+
+		da9150-fg {
+			...
+		};
 	};
-- 
1.9.3

