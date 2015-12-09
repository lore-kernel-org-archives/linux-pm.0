From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 16/19] ARM: dts: Add PPMU node for exynos4412-odroidu3
Date: Wed, 09 Dec 2015 13:08:08 +0900
Message-ID: <1449634091-1842-17-git-send-email-cw00.choi@samsung.com>
References: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch add dt node for PPMU_{DMC0|DMC1|LEFTBUS|RIGHTBUS} for
exynos4412-odroidu3 board. Each PPMU dt node includes one event of
'PPMU Count3'.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 40 +++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index edf0fc8db6ff..90800a6da14b 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -504,3 +504,43 @@
 &watchdog {
 	status = "okay";
 };
+
+&ppmu_dmc0 {
+	status = "okay";
+
+	events {
+		ppmu_dmc0_3: ppmu-event3-dmc0 {
+			event-name = "ppmu-event3-dmc0";
+		};
+	};
+};
+
+&ppmu_dmc1 {
+	status = "okay";
+
+	events {
+		ppmu_dmc1_3: ppmu-event3-dmc1 {
+			event-name = "ppmu-event3-dmc1";
+		};
+	};
+};
+
+&ppmu_leftbus {
+	status = "okay";
+
+	events {
+		ppmu_leftbus_3: ppmu-event3-leftbus {
+			event-name = "ppmu-event3-leftbus";
+		};
+	};
+};
+
+&ppmu_rightbus {
+	status = "okay";
+
+	events {
+		ppmu_rightbus_3: ppmu-event3-rightbus {
+			event-name = "ppmu-event3-rightbus";
+		};
+	};
+};
-- 
1.9.1
