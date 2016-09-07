From: Vinay Simha BN <simhavcs@gmail.com>
Subject: [PATCH 2/4] dt-bindings: Add summit SMB347 charger bindings
Date: Wed,  7 Sep 2016 15:50:11 +0530
Message-ID: <1473243615-29746-2-git-send-email-simhavcs@gmail.com>
References: <1473243615-29746-1-git-send-email-simhavcs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473243615-29746-1-git-send-email-simhavcs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Vinay Simha BN <simhavcs@gmail.com>, John Stultz <john.stultz@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:POWER SUPPLY CLASS/SUBSYSTEM and
        DRIVERS" <linux-pm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Add documentation for summit SMB347 charger

Cc: John Stultz <john.stultz@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Myungjoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Vinay Simha BN <simhavcs@gmail.com>
---
 .../bindings/power/supply/smb347_charger.txt       | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/smb347_charger.txt

diff --git a/Documentation/devicetree/bindings/power/supply/smb347_charger.txt b/Documentation/devicetree/bindings/power/supply/smb347_charger.txt
new file mode 100644
index 0000000..91570a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/smb347_charger.txt
@@ -0,0 +1,57 @@
+smb347_charger bindings
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+[Required porperties]
+- compatible : "summit,smb347"
+- reg : Slave address for i2c interface
+# At least one of followings should be set
+  - enable-usb-charging
+  - enable-otg-charging
+  - enable-mains-charging
+
+[Optional properties]
+- interrupt-parent : The phandle for the interrupt controller
+- interrupts : Interrupt line index for mapping
+- enable-chg-ctrl : Enable charging control
+		<0> : SW (i2c interface)
+		<1> : Pin control (Active Low)
+		<2> : Pin control (Active High)
+# Charging constraints
+- max-chg-curr : Maximum current for charging (in uA)
+- max-chg-volt : Maximum voltage for charging (in uV)
+- pre-chg-curr : Pre-charging current (in uA)
+- term-curr : Charging cycle termination current (in uA)
+- fast-volt-thershold : Voltage threshold to transit to fast charge mode (in uV)
+- mains-curr-limit : Maximum input current from AC/DC input (in uA)
+- usb-curr-limit : Maximum input current from USB input (in uA)
+
+# Related thermometer monitoring (in degree C)
+- chip-temp-threshold : Chip temperature for thermal regulaton.   <100, 130>
+- soft-cold-temp-limit : Cold battery temperature for soft alarm. <0, 15>*
+- soft-hot-temp-limit : Hot battery temperature for soft alarm.   <40, 55>
+- hard-cold-temp-limit : Cold battery temperature for hard alarm. <0, 15>*
+- hard-hot-temp-limit : Hot battery temperature for hard alarm.   <55, 65>
+(* The written temperature has +5'C offset. 0'C -> -5'C, 15'C -> 10'C)
+- soft-comp-method : Soft temperature limit compensation method
+	(Not defined) : Use default setting
+		<0> : Compensation none
+		<1> : Charge current compensation
+		<2> : Voltage compensation
+
+Example:
+	smb347@7f {
+		compatible = "summit,smb347";
+		reg = <0x7f>;
+		status = "okay";
+
+		max-chg-curr = <1800000>;
+		mains-curr-limit = <2000000>;
+		usb-curr-limit = <450000>;
+
+		chip-temp-thershold = <110>;
+
+		enable-usb-charging;
+		enable-mains-charging;
+
+		enable-chg-ctrl = <2>;	/* Pin control (Active High) */
+	};
-- 
2.1.2
