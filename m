From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v3 2/4] ARM: dts: pxa: add pxa25x cpu operating points
Date: Mon, 31 Oct 2016 20:54:54 +0100
Message-ID: <1477943696-23477-3-git-send-email-robert.jarzmik@free.fr>
References: <1477943696-23477-1-git-send-email-robert.jarzmik@free.fr>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:45109 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S946145AbcJaTzT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Oct 2016 15:55:19 -0400
In-Reply-To: <1477943696-23477-1-git-send-email-robert.jarzmik@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rafael J Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Add the relevant data taken from the PXA 25x Electrical, Mechanical, and
Thermal Specfication. This will be input data for cpufreq-dt driver.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v2: opp definition amended as per Viresh's comment
---
 arch/arm/boot/dts/pxa25x.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/pxa25x.dtsi b/arch/arm/boot/dts/pxa25x.dtsi
index 0d1e012178c4..f9f4726396a0 100644
--- a/arch/arm/boot/dts/pxa25x.dtsi
+++ b/arch/arm/boot/dts/pxa25x.dtsi
@@ -89,4 +89,29 @@
 		clocks = <&clktimer>;
 		status = "okay";
 	};
+
+	pxa250_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+
+		opp@99532800 {
+			opp-hz = /bits/ 64 <99532800>;
+			opp-microvolt = <1000000 950000 1650000>;
+			clock-latency-ns = <20>;
+		};
+		opp@199065600 {
+			opp-hz = /bits/ 64 <199065600>;
+			opp-microvolt = <1000000 950000 1650000>;
+			clock-latency-ns = <20>;
+		};
+		opp@298598400 {
+			opp-hz = /bits/ 64 <298598400>;
+			opp-microvolt = <1100000 1045000 1650000>;
+			clock-latency-ns = <20>;
+		};
+		opp@398131200 {
+			opp-hz = /bits/ 64 <398131200>;
+			opp-microvolt = <1300000 1235000 1650000>;
+			clock-latency-ns = <20>;
+		};
+	};
 };
-- 
2.1.4

