From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v4 14/16] dt/bindings: Add PSCI OS-Initiated PM Domains bindings
Date: Thu, 25 Aug 2016 14:03:23 -0600
Message-ID: <1472155405-41841-15-git-send-email-lina.iyer@linaro.org>
References: <1472155405-41841-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36536 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757641AbcHYUEY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Aug 2016 16:04:24 -0400
Received: by mail-pa0-f52.google.com with SMTP id di2so19725482pad.3
        for <linux-pm@vger.kernel.org>; Thu, 25 Aug 2016 13:04:17 -0700 (PDT)
In-Reply-To: <1472155405-41841-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com, Lina Iyer <lina.iyer@linaro.org>, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>

Add bindings for defining a OS-Initiated based CPU PM domain.

Cc: <devicetree@vger.kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 Documentation/devicetree/bindings/arm/psci.txt | 79 ++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation/devicetree/bindings/arm/psci.txt
index a2c4f1d..63a229b 100644
--- a/Documentation/devicetree/bindings/arm/psci.txt
+++ b/Documentation/devicetree/bindings/arm/psci.txt
@@ -105,7 +105,86 @@ Case 3: PSCI v0.2 and PSCI v0.1.
 		...
 	};
 
+PSCI v1.0 onwards, supports OS-Initiated mode for powering off CPU domains
+from the firmware. Such PM domains for which the PSCI firmware driver acts as
+pseudo-controller, may also be specified in the DT under the psci node. The
+domain definitions must follow the domain idle state specifications per [3].
+The domain states themselves must be compatible with 'arm,idle-state' defined
+in [1] and need to specify the arm,psci-suspend-param property for each idle
+state.
+
+More information on defining CPU PM domains is available in [4].
+
+Example: OS-Iniated PSCI based PM domains with 1 CPU in each domain
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		CPU0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_PWRDN>;
+			power-domains = <&CPU_PD0>;
+		};
+
+		CPU1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x100>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_PWRDN>;
+			power-domains = <&CPU_PD1>;
+		};
+
+		idle-states {
+			CPU_PWRDN: cpu_power_down{
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x000001>;
+				entry-latency-us = <10>;
+				exit-latency-us = <10>;
+				min-residency-us = <100>;
+			};
+
+			CLUSTER_RET: domain_ret {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x1000010>;
+				entry-latency-us = <500>;
+				exit-latency-us = <500>;
+				min-residency-us = <2000>;
+			};
+
+			CLUSTER_PWR_DWN: domain_gdhs {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x1000030>;
+				entry-latency-us = <2000>;
+				exit-latency-us = <2000>;
+				min-residency-us = <6000>;
+			};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+
+		CPU_PD0: cpu-pd@0 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_RET>, <&CLUSTER_PWR_DWN>;
+		};
+
+		CPU_PD1: cpu-pd@1 {
+			#power-domain-cells = <0>;
+			domain-idle-states =  <&CLUSTER_PWR_DWN>;
+		};
+	};
+
 [1] Kernel documentation - ARM idle states bindings
     Documentation/devicetree/bindings/arm/idle-states.txt
 [2] Power State Coordination Interface (PSCI) specification
     http://infocenter.arm.com/help/topic/com.arm.doc.den0022c/DEN0022C_Power_State_Coordination_Interface.pdf
+[3]. PM Domains description
+    Documentation/devicetree/bindings/power/power_domain.txt
+[4]. CPU PM Domains description
+    Documentation/power/cpu_domains.txt
-- 
2.7.4

