From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 1/9] ARM: STi: STiH407: Provide generic (safe) DVFS configuration
Date: Wed, 24 Jun 2015 14:59:00 +0100
Message-ID: <1435154348-28840-2-git-send-email-lee.jones@linaro.org>
References: <1435154348-28840-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435154348-28840-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pm@vger.kernel.org

You'll notice that the voltage cell is populated with 0's.  Voltage
information is very platform specific, even depends on 'cut' and
'substrate' versions.  Thus it is left blank for a generic (safe)
implementation.  If other nodes/properties are provided by the
bootloader, the ST CPUFreq driver will over-ride these generic
values.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index be201aa..2680ac7 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -22,11 +22,21 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+					 /* kHz     uV   */
+			operating-points = <1500000 0
+					    1200000 0
+					    800000  0
+					    500000  0>;
 		};
 		cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
+					 /* kHz     uV   */
+			operating-points = <1500000 0
+					    1200000 0
+					    800000  0
+					    500000  0>;
 		};
 	};
 
-- 
1.9.1
