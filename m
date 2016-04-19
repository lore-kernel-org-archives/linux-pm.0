From: Mason <slash.tmp@free.fr>
Subject: [PATCH v8 2/2] ARM: dts: tango4: Initial thermal support
Date: Tue, 19 Apr 2016 16:32:47 +0200
Message-ID: <5716418F.80601@free.fr>
References: <20160308214846.GA10950@localhost.localdomain>
 <56F84427.1000507@free.fr> <56F91A47.9060901@free.fr>
 <20160329020050.GA15721@localhost.localdomain> <56FACE0B.9060606@free.fr>
 <20160330000503.GA2625@localhost.localdomain> <56FBEE4F.3060106@free.fr>
 <56FD8582.80002@free.fr> <20160401015240.GB19409@localhost.localdomain>
 <570254D8.3090406@free.fr> <20160406155155.GB326@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:5865 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932127AbcDSOeI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 19 Apr 2016 10:34:08 -0400
In-Reply-To: <20160406155155.GB326@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sebastian Frias <sf84@laposte.net>, arm-soc <arm@kernel.org>

From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

Define the CPU temperature sensor, and critical trip point.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 arch/arm/boot/dts/tango4-smp8758.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/tango4-smp8758.dtsi b/arch/arm/boot/dts/tango4-smp8758.dtsi
index 7ed88ee629fb..01d5f8f1c71d 100644
--- a/arch/arm/boot/dts/tango4-smp8758.dtsi
+++ b/arch/arm/boot/dts/tango4-smp8758.dtsi
@@ -28,4 +28,27 @@
 			<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
 			<GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	soc {
+		cpu_temp: thermal@920100 {
+			#thermal-sensor-cells = <0>;
+			compatible = "sigma,smp8758-thermal";
+			reg = <0x920100 12>;
+		};
+	};
+
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay = <997>;		/* milliseconds */
+			polling-delay-passive = <499>;	/* milliseconds */
+			thermal-sensors = <&cpu_temp>;
+			trips {
+				cpu_critical {
+					temperature = <120000>;
+					hysteresis = <2500>;
+					type = "critical";
+				};
+			};
+		};
+	};
 };
-- 
2.8.1
