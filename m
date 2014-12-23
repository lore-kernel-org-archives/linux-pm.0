From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv5 9/9] ARM: dts: exynos: Add PPMU_CPU/DMC0/DMC1 node for
 Exynos4412-based TRATS2 board
Date: Tue, 23 Dec 2014 12:18:17 +0900
Message-ID: <1419304697-14789-10-git-send-email-cw00.choi@samsung.com>
References: <1419304697-14789-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1419304697-14789-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: kgene.kim@samsung.com, kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, mark.rutland@arm.com, a.kesavan@samsung.com, tomasz.figa@gmail.com, k.kozlowski@samsung.com, cw00.choi@samsung.com, inki.dae@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch add dt node for PPMU_CPU/DMC0/DMC1 for exynos4412-trats2 board.
Each PPMU dt node includes one event of 'PPMU Count 3'

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm/boot/dts/exynos4412-trats2.dts | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index dd9ac66..9b98258 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -811,6 +811,36 @@
 	};
 };
 
+&ppmu_cpu {
+	status = "okay";
+
+	events {
+		ppmu_cpu_3: ppmu-event3-cpu {
+			event-name = "ppmu-event3-cpu";
+		};
+	};
+};
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
 &pinctrl_0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sleep0>;
-- 
1.8.5.5
