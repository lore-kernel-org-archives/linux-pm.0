From: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v7 6/7] power: da9150: Add DT binding documentation for charger
Date: Wed, 18 Feb 2015 14:08:34 +0000
Message-ID: <f6c1bb16817176c5f253aec7cb5a912219bd814a.1424267009.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1424267009.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1424267009.git.Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
---
 .../devicetree/bindings/power/da9150-charger.txt   | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/da9150-charger.txt

diff --git a/Documentation/devicetree/bindings/power/da9150-charger.txt b/Documentation/devicetree/bindings/power/da9150-charger.txt
new file mode 100644
index 0000000..f390666
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/da9150-charger.txt
@@ -0,0 +1,26 @@
+Dialog Semiconductor DA9150 Charger Power Supply bindings
+
+Required properties:
+- compatible: "dlg,da9150-charger" for DA9150 Charger Power Supply
+
+Optional properties:
+- io-channels: List of phandle and IIO specifier pairs
+- io-channel-names: List of channel names used by charger
+      ["CHAN_IBUS", "CHAN_VBUS", "CHAN_TJUNC", "CHAN_VBAT"]
+  (See Documentation/devicetree/bindings/iio/iio-bindings.txt for further info)
+
+
+Example:
+
+	da9150-charger {
+		compatible = "dlg,da9150-charger";
+
+		io-channels = <&gpadc 0>,
+			      <&gpadc 2>,
+			      <&gpadc 8>,
+			      <&gpadc 5>;
+		io-channel-names = "CHAN_IBUS",
+				   "CHAN_VBUS",
+				   "CHAN_TJUNC",
+				   "CHAN_VBAT";
+	};
--
1.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
