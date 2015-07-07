From: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v3 2/6] mfd: da9150: Update DT bindings for Fuel-Gauge support
Date: Tue, 7 Jul 2015 17:34:17 +0100
Message-ID: <8ed4719d9142c3ca780a4c1474036635d40b595e.1436284659.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1436284659.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1436284659.git.Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---

Changes in v3:
 - Removal of unwanted new-line.
 - Flesh out example bindings usage.

Changes in v2:
 - N/A

 Documentation/devicetree/bindings/mfd/da9150.txt | 25 +++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/da9150.txt b/Documentation/devicetree/bindings/mfd/da9150.txt
index d0588ea..d629ed5 100644
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
 		};

 		da9150-charger {
-			...
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
+		};
+
+		da9150-fg {
+			compatible = "dlg,da9150-fg";
+
+			dlg,update-interval = <10000>;
+			dlg,warn-soc-level = /bits/ 8 <15>;
+			dlg,crit-soc-level = /bits/ 8 <5>
 		};
 	};
--
1.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
