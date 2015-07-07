From: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v3 4/6] power: da9150: Add DT bindings documentation for
 Fuel-Gauge
Date: Tue, 7 Jul 2015 17:34:21 +0100
Message-ID: <3f9095a583c26cdb4a6dd7b749d7f6b33c87b8f7.1436284659.git.Adam.Thomson.Opensource@diasemi.com>
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
---

Changes in v3:
 - N/A

Changes in v2:
 - N/A

 .../devicetree/bindings/power/da9150-fg.txt        | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/da9150-fg.txt

diff --git a/Documentation/devicetree/bindings/power/da9150-fg.txt b/Documentation/devicetree/bindings/power/da9150-fg.txt
new file mode 100644
index 0000000..c3c76eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/da9150-fg.txt
@@ -0,0 +1,23 @@
+Dialog Semiconductor DA9150 Fuel-Gauge Power Supply bindings
+
+Required properties:
+- compatible: "dlg,da9150-fg" for DA9150 Fuel-Gauge Power Supply
+
+Optional properties:
+- dlg,update-interval: Interval time (milliseconds) between battery level checks.
+- dlg,warn-soc-level: Battery discharge level (%) where warning event raised.
+      [1 - 100]
+- dlg,crit-soc-level: Battery discharge level (%) where critical event raised.
+  This value should be lower than the warning level.
+      [1 - 100]
+
+
+Example:
+
+	da9150-fg {
+		compatible = "dlg,da9150-fg";
+
+		dlg,update-interval = <10000>;
+		dlg,warn-soc-level = /bits/ 8 <15>;
+		dlg,crit-soc-level = /bits/ 8 <5>;
+	};
--
1.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
