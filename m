From: Dawei Chien <dawei.chien@mediatek.com>
Subject: [PATCH v5 3/3] arm64: dts: mt8173: Add dynamic power node.
Date: Wed, 16 Dec 2015 11:59:16 +0800
Message-ID: <1450238356-36319-4-git-send-email-dawei.chien@mediatek.com>
References: <1450238356-36319-1-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450238356-36319-1-git-send-email-dawei.chien@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Matthias Brugger <matthias.bgg@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Sascha Hauer <s.hauer@pengutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Dawei Chien <dawei.chien@mediatek.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, Punit Agrawal <punit.agrawal@arm.com>
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
index 4114cee..33fabe4 100644
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
