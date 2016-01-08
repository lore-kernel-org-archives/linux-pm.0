From: Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v2 2/2] power: add documentation for ACT8945A's charger DT bindings
Date: Fri, 8 Jan 2016 16:46:13 +0800
Message-ID: <1452242773-18887-3-git-send-email-wenyou.yang@atmel.com>
References: <1452242773-18887-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452242773-18887-1-git-send-email-wenyou.yang@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Wenyou Yang <wenyou.yang@atmel.com>
List-Id: linux-pm@vger.kernel.org

This patch adds documentation for the DT bindings of the charger
subdevice of ACT8945A MFD.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

Changes in v2: None

 .../devicetree/bindings/power/act8945a-charger.txt |   34 ++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/act8945a-charger.txt

diff --git a/Documentation/devicetree/bindings/power/act8945a-charger.txt b/Documentation/devicetree/bindings/power/act8945a-charger.txt
new file mode 100644
index 0000000..868e0164
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/act8945a-charger.txt
@@ -0,0 +1,34 @@
+Device-Tree bindings for charger of Active-semi ACT8945A Multi-Function Device
+
+Required properties:
+ - compatible: "active-semi,act8945a-charger"
+ - active-semi,chglev-gpio = Specifies a gpio that uses to select
+   the charge current level.
+
+Optional properties:
+ - active-semi,battery_temperature: Indicates if it is allowed to check
+   the battery temperature. If it is missing, assume the battery temperature
+   is not allowed to check.
+ - active-semi,input_voltage_threshold: unit: mV;
+   Specifies the charger's input over-voltage threshold value;
+   The value can be: 6600, 7000, 7500, 8000; default: 6600
+ - active-semi,precondition_timeout: unit: minutes;
+   Specifies the charger's PRECONDITION safety timer setting value;
+   The value can be: 40, 60, 80, 0; If 0, it means to disable this timer;
+   default: 40.
+ - active-semi,total_timeout: unit: hours;
+   Specifies the charger's total safety timer setting value;
+   The value can be: 3, 4, 5, 0; If 0, it means to disable this timer;
+   default: 3.
+
+Example:
+
+	charger {
+		compatible = "active-semi,act8945a-charger";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_charger_chglev>;
+		active-semi,chglev-gpio = <&pioA 12 GPIO_ACTIVE_HIGH>;
+		active-semi,input_voltage_threshold = <6600>;
+		active-semi,precondition_timeout = <40>;
+		active-semi,total_timeout = <3>;
+	};
-- 
1.7.9.5
