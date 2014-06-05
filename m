From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v1 1/6] thermal: sti: Supply Device Tree documentation
Date: Thu, 5 Jun 2014 15:56:18 +0100
Message-ID: <20140605145618.GF24240@lee--X1>
References: <1401442715-6350-1-git-send-email-lee.jones@linaro.org>
 <1401442715-6350-2-git-send-email-lee.jones@linaro.org>
 <20140605120147.GA7446@griffinp-ThinkPad-X1-Carbon-2nd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:51657 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbaFEO4Z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Jun 2014 10:56:25 -0400
Received: by mail-ig0-f176.google.com with SMTP id a13so3316537igq.9
        for <linux-pm@vger.kernel.org>; Thu, 05 Jun 2014 07:56:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140605120147.GA7446@griffinp-ThinkPad-X1-Carbon-2nd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, kernel@stlinux.com, linux-pm@vger.kernel.org, eduardo.valentin@ti.com, rui.zhang@intel.com

thermal: sti: Supply Device Tree documentation

Signed-off-by: Ajit Pal Singh <ajitpal.singh@st.com>
Acked-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>

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
