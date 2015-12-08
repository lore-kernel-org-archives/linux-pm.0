From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v5 07/11] ARM: STi: STiH407: Provide CPU with a means to look-up Major number
Date: Tue,  8 Dec 2015 14:32:00 +0000
Message-ID: <1449585124-15596-8-git-send-email-lee.jones@linaro.org>
References: <1449585124-15596-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449585124-15596-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, maxime.coquelin@st.com, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, devicetree@vger.kernel.org, ajitpal.singh@st.com, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pm@vger.kernel.org

This is used for CPU Frequency Scaling.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index d0e639cd..eb2601f 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -36,6 +36,7 @@
 			clock-names = "cpu";
 			clock-latency = <100000>;
 			cpu0-supply = <&pwm_regulator>;
+			st,syscfg = <&syscfg_core 0x8e0>;
 		};
 		cpu@1 {
 			device_type = "cpu";
-- 
1.9.1
