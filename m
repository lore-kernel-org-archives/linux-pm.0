From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 5/6] ARM: STi: DT: STiH416: Supply Thermal Controller Device Tree nodes
Date: Thu,  5 Jun 2014 16:06:58 +0100
Message-ID: <1401980819-19962-6-git-send-email-lee.jones@linaro.org>
References: <1401980819-19962-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1401980819-19962-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, kernel@stlinux.com, ajitpal.singh@st.com, edubezval@gmail.com, rui.zhang@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com
List-Id: linux-pm@vger.kernel.org

We supply two of these.  The first is controlled by the System Configuration
registers and the second one provided is a more traditional 'memory mapped'
variant.  Each are handled by they own sub-driver.

Signed-off-by: Ajit Pal Singh <ajitpal.singh@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih416.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index 06473c5..ed80220 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -236,5 +236,23 @@
 			resets	= <&powerdown STIH416_KEYSCAN_POWERDOWN>,
 				  <&softreset STIH416_KEYSCAN_SOFTRESET>;
 		};
+
+		temp0 {
+			compatible = "st,stih416-sas-thermal";
+			clock-names = "thermal";
+			clocks = <&clockgen_c_vcc 14>;
+
+			status = "okay";
+		};
+
+		temp1@fdfe8000 {
+			compatible = "st,stih416-mpe-thermal";
+			reg = <0xfdfe8000 0x10>;
+			clocks = <&clockgen_e 3>;
+			clock-names = "thermal";
+			interrupts = <GIC_SPI 23 IRQ_TYPE_EDGE_RISING>;
+
+			status = "okay";
+		};
 	};
 };
-- 
1.8.3.2
