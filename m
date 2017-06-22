From: Tao Wang <kevin.wangtao@hisilicon.com>
Subject: [Patch v2 3/3] arm64: dts: register Hi3660's thermal sensor
Date: Thu, 22 Jun 2017 11:42:03 +0800
Message-ID: <1498102923-68481-3-git-send-email-kevin.wangtao@hisilicon.com>
References: <1497930035-60894-3-git-send-email-kevin.wangtao@hisilicon.com>
 <1498102923-68481-1-git-send-email-kevin.wangtao@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498102923-68481-1-git-send-email-kevin.wangtao@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sunzhaosheng@hisilicon.com, leo.yan@linaro.org, Tao Wang <kevin.wangtao@hisilicon.com>
List-Id: linux-pm@vger.kernel.org

Bind thermal sensor driver for Hi3660.

Signed-off-by: Tao Wang <kevin.wangtao@hisilicon.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
Changes in v2:
- rebase changes on linux next

 arch/arm64/boot/dts/hisilicon/hi3660.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index c6a1961..a6a1e01 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -848,5 +848,11 @@
 				     &sdio_cfg_func>;
 			status = "disabled";
 		};
+
+		tsensor: tsensor {
+			compatible = "hisilicon,hi3660-thermal";
+			reg = <0x0 0xfff30000 0x0 0x1000>;
+			#thermal-sensor-cells = <1>;
+		};
 	};
 };
-- 
1.7.9.5
