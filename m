From: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 4/5] arm64: dts: register Hi6220's thermal sensor
Date: Fri, 26 Feb 2016 11:43:46 +0800
Message-ID: <1456458227-12950-5-git-send-email-leo.yan@linaro.org>
References: <1456458227-12950-1-git-send-email-leo.yan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456458227-12950-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, kongxinwei <kong.kongxinwei@hisilicon.com>, Javi Merino <javi.merino@arm.com>, Punit Agrawal <Punit.Agrawal@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Leo Yan <leo.yan@linaro.org>
List-Id: linux-pm@vger.kernel.org

Bind thermal sensor driver for Hi6220.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index f588be9..50ba1b0 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -313,5 +313,14 @@
 			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
 			#mbox-cells = <3>;
 		};
+
+		tsensor: tsensor@0,f7030700 {
+			compatible = "hisilicon,tsensor";
+			reg = <0x0 0xf7030700 0x0 0x1000>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sys_ctrl 22>;
+			clock-names = "thermal_clk";
+			#thermal-sensor-cells = <1>;
+		};
 	};
 };
-- 
1.9.1
