From: David HERNANDEZ SANCHEZ <david.hernandezsanchez@st.com>
Subject: [PATCH 3/3] ARM: dts: stm32: add thermal sensor support on STM32MP157c
Date: Fri, 5 Oct 2018 10:08:46 +0000
Message-ID: <1538734081-26585-4-git-send-email-david.hernandezsanchez@st.com>
References: <1538734081-26585-1-git-send-email-david.hernandezsanchez@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1538734081-26585-1-git-send-email-david.hernandezsanchez@st.com>
Content-Language: en-US
Content-ID: <0932A0602563C245875E65CD0851CD2C@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Add configuration on DT for thermal sensor driver

Signed-off-by: David Hernandez Sanchez <david.hernandezsanchez@st.com>

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 661be94..e90b9f6 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -84,6 +84,31 @@
 		};
 	};

+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&dts>;
+
+			trips {
+				cpu_alert1: cpu-alert1 {
+					temperature = <85000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				cpu-crit {
+					temperature = <120000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+			};
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -908,6 +933,16 @@
 			status = "disabled";
 		};

+		dts: thermal@50028000 {
+			compatible = "st,stm32-thermal";
+			reg = <0x50028000 0x100>;
+			interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc TMPSENS>;
+			clock-names = "pclk";
+			#thermal-sensor-cells = <0>;
+			status = "disabled";
+		};
+
 		cryp1: cryp@54001000 {
 			compatible = "st,stm32mp1-cryp";
 			reg = <0x54001000 0x400>;
--
2.7.4
