From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/6] thermal: sti: Supply Device Tree documentation
Date: Thu,  5 Jun 2014 16:06:54 +0100
Message-ID: <1401980819-19962-2-git-send-email-lee.jones@linaro.org>
References: <1401980819-19962-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1401980819-19962-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, kernel@stlinux.com, ajitpal.singh@st.com, edubezval@gmail.com, rui.zhang@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Ajit Pal Singh <ajitpal.singh@st.com>
Acked-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/thermal/st-thermal.txt     | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/st-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/st-thermal.txt b/Documentation/devicetree/bindings/thermal/st-thermal.txt
new file mode 100644
index 0000000..3b9251b
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/st-thermal.txt
@@ -0,0 +1,42 @@
+Binding for Thermal Sensor driver for STMicroelectronics STi series of SoCs.
+
+Required parameters:
+-------------------
+
+compatible : 	st,<SoC>-<module>-thermal; should be one of:
+		  "st,stih415-sas-thermal",
+		  "st,stih415-mpe-thermal",
+		  "st,stih416-sas-thermal"
+		  "st,stih416-mpe-thermal"
+		  "st,stid127-thermal" or
+		  "st,stih407-thermal"
+		according to the SoC type (stih415, stih416, stid127, stih407)
+		and module type (sas or mpe). On stid127 & stih407 there is only
+		one die/module, so there is no module type in the compatible
+		string.
+clock-names : 	Should be "thermal".
+		  See: Documentation/devicetree/bindings/resource-names.txt
+clocks : 	Phandle of the clock used by the thermal sensor.
+		  See: Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Optional parameters:
+-------------------
+
+reg : 		For non-sysconf based sensors, this should be the physical base
+		address and length of the sensor's registers.
+interrupts :	Standard way to define interrupt number.
+		Interrupt is mandatory to be defined when compatible is
+		"stih416-mpe-thermal".
+		  NB: For thermal sensor's for which no interrupt has been
+		  defined, a polling delay of 1000ms will be used to read the
+		  temperature from device.
+
+Example:
+
+	temp1@fdfe8000 {
+		compatible	= "st,stih416-mpe-thermal";
+		reg		= <0xfdfe8000 0x10>;
+		clock-names	= "thermal";
+		clocks		= <&clk_m_mpethsens>;
+		interrupts	= <GIC_SPI 23 IRQ_TYPE_NONE>;
+	};
-- 
1.8.3.2
