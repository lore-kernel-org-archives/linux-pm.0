From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v4 4/6] power: da9150: Add DT bindings documentation for
 Fuel-Gauge
Date: Tue, 4 Aug 2015 17:16:34 +0100
Message-ID: <452f38e63bfffe1cfd3873cdf5d0c9d263020001.1438692348.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1438692348.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1438692348.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---

Changes in v4:
 - Update compatible string of fuel-gauge to "dlg,da9150-fuel-gauge".
 - Changed example node name to "fuel-gauge".

Changes in v3:
 - N/A

Changes in v2:
 - N/A

 .../devicetree/bindings/power/da9150-fg.txt        | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/da9150-fg.txt

diff --git a/Documentation/devicetree/bindings/power/da9150-fg.txt b/Documentation/devicetree/bindings/power/da9150-fg.txt
new file mode 100644
index 0000000..00236fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/da9150-fg.txt
@@ -0,0 +1,23 @@
+Dialog Semiconductor DA9150 Fuel-Gauge Power Supply bindings
+
+Required properties:
+- compatible: "dlg,da9150-fuel-gauge" for DA9150 Fuel-Gauge Power Supply
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
+	fuel-gauge {
+		compatible = "dlg,da9150-fuel-gauge";
+
+		dlg,update-interval = <10000>;
+		dlg,warn-soc-level = /bits/ 8 <15>;
+		dlg,crit-soc-level = /bits/ 8 <5>;
+	};
--
1.9.3
