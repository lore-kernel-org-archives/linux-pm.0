From: michael.kao <michael.kao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 2/8] arm64: dts: mt8183: add/update dynamic power
 coefficients
Date: Fri, 10 May 2019 21:27:00 +0800
Message-ID: <1557494826-6044-3-git-send-email-michael.kao@mediatek.com>
References: <1557494826-6044-1-git-send-email-michael.kao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1557494826-6044-1-git-send-email-michael.kao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, hsinyi-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "michael.kao" <michael.kao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Add dynamic power coefficients for all cores and update those of
CPU0 and CPU4.

Signed-off-by: Michael.Kao <michael.kao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 52ad47e..8f9fd9a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -58,6 +58,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x000>;
 			enable-method = "psci";
+			dynamic-power-coefficient = <84>;
 		};
 
 		cpu1: cpu@1 {
@@ -65,6 +66,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x001>;
 			enable-method = "psci";
+			dynamic-power-coefficient = <84>;
 		};
 
 		cpu2: cpu@2 {
@@ -72,6 +74,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x002>;
 			enable-method = "psci";
+			dynamic-power-coefficient = <84>;
 		};
 
 		cpu3: cpu@3 {
@@ -79,6 +82,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x003>;
 			enable-method = "psci";
+			dynamic-power-coefficient = <84>;
 		};
 
 		cpu4: cpu@100 {
@@ -86,6 +90,7 @@
 			compatible = "arm,cortex-a73";
 			reg = <0x100>;
 			enable-method = "psci";
+			dynamic-power-coefficient = <211>;
 		};
 
 		cpu5: cpu@101 {
@@ -93,6 +98,7 @@
 			compatible = "arm,cortex-a73";
 			reg = <0x101>;
 			enable-method = "psci";
+			dynamic-power-coefficient = <211>;
 		};
 
 		cpu6: cpu@102 {
@@ -100,6 +106,7 @@
 			compatible = "arm,cortex-a73";
 			reg = <0x102>;
 			enable-method = "psci";
+			dynamic-power-coefficient = <211>;
 		};
 
 		cpu7: cpu@103 {
@@ -107,6 +114,7 @@
 			compatible = "arm,cortex-a73";
 			reg = <0x103>;
 			enable-method = "psci";
+			dynamic-power-coefficient = <211>;
 		};
 	};
 
-- 
2.6.4
