From: Dawei Chien <dawei.chien@mediatek.com>
Subject: [RESEND][PATCH 3/3] arm64: dts: mt8173: Add dynamic power node.
Date: Tue, 15 Mar 2016 16:10:37 +0800
Message-ID: <1458029437-12846-4-git-send-email-dawei.chien@mediatek.com>
References: <1458029437-12846-1-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458029437-12846-1-git-send-email-dawei.chien@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Daniel Kurtz <djkurtz@chromium.org>, Sascha Hauer <s.hauer@pengutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Dawei Chien <dawei.chien@mediatek.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, Punit Agrawal <punit.agrawal@arm.com>
List-Id: linux-pm@vger.kernel.org

This device node is for calculating dynamic power in mW.
Since mt8173 has two clusters, there are two dynamic power
coefficient as well.

Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
---
This patch is base on patchset:
https://lkml.org/lkml/2015/11/17/251
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index f9c44cc..5cb6b4e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -71,6 +71,7 @@
 			#cooling-cells = <2>;
 			#cooling-min-level = <0>;
 			#cooling-max-level = <7>;
+			dynamic-power-coefficient = <263>;
 		};
 
 		cpu1: cpu@1 {
@@ -95,6 +96,7 @@
 			#cooling-cells = <2>;
 			#cooling-min-level = <0>;
 			#cooling-max-level = <7>;
+			dynamic-power-coefficient = <263>;
 		};
 
 		cpu2: cpu@100 {
@@ -119,6 +121,7 @@
 			#cooling-cells = <2>;
 			#cooling-min-level = <0>;
 			#cooling-max-level = <7>;
+			dynamic-power-coefficient = <530>;
 		};
 
 		cpu3: cpu@101 {
@@ -143,6 +146,7 @@
 			#cooling-cells = <2>;
 			#cooling-min-level = <0>;
 			#cooling-max-level = <7>;
+			dynamic-power-coefficient = <530>;
 		};
 
 		idle-states {
-- 
1.7.9.5
