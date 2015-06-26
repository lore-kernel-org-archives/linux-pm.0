From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v2 2/4] mfd: da9150: Update DT bindings for Fuel-Gauge support
Date: Fri, 26 Jun 2015 09:47:49 +0100
Message-ID: <afbda3c9439f08cbf57c184ff6b96bdf7f5ca8b4.1435308209.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1435308209.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.bemta14.messagelabs.com ([193.109.254.108]:32267 "EHLO
	mail1.bemta14.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751579AbbFZIyL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2015 04:54:11 -0400
In-Reply-To: <cover.1435308209.git.Adam.Thomson.Opensource@diasemi.com>
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

