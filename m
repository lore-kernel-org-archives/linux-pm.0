From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 1/4] ARM: dts: s5pv210: Add dmc nodes
Date: Thu, 10 Jan 2019 21:52:12 +0100
Message-ID: <20190110205215.22030-2-pawel.mikolaj.chmiel@gmail.com>
References: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kgene@kernel.org
Cc: krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, viresh.kumar@linaro.org, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
List-Id: linux-pm@vger.kernel.org

This commit adds dmc nodes, which are needed by s5pv210 cpufreq driver
to work.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 arch/arm/boot/dts/s5pv210.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index e9613418228d..2d55a3a6e79e 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -25,6 +25,8 @@
 
 	aliases {
 		csis0 = &csis0;
+		dmc0 = &dmc0;
+		dmc1 = &dmc1;
 		fimc0 = &fimc0;
 		fimc1 = &fimc1;
 		fimc2 = &fimc2;
@@ -521,6 +523,16 @@
 			status = "disabled";
 		};
 
+		dmc0: dmc@f0000000 {
+			compatible = "samsung,s5pv210-dmc";
+			reg = <0xf0000000 0x1000>;
+		};
+
+		dmc1: dmc@f1400000 {
+			compatible = "samsung,s5pv210-dmc";
+			reg = <0xf1400000 0x1000>;
+		};
+
 		g2d: g2d@fa000000 {
 			compatible = "samsung,s5pv210-g2d";
 			reg = <0xfa000000 0x1000>;
-- 
2.17.1
