From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 1/2] PM / Domains: Introduce domain-performance-states binding
Date: Mon, 12 Dec 2016 16:26:18 +0530
Message-ID: <dd95df02a1c3efd00bd4890f8aceeb717ad38788.1481539827.git.viresh.kumar@linaro.org>
References: <cover.1481539827.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36096 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754203AbcLLK4g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Dec 2016 05:56:36 -0500
Received: by mail-pg0-f46.google.com with SMTP id f188so34268053pgc.3
        for <linux-pm@vger.kernel.org>; Mon, 12 Dec 2016 02:56:35 -0800 (PST)
In-Reply-To: <cover.1481539827.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1481539827.git.viresh.kumar@linaro.org>
References: <cover.1481539827.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, devicetree@vger.kernel.org, Nayak Rajendra <rnayak@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>

Some platforms have the capability to configure the performance state of
their Power Domains. The performance levels are represented by positive
integer values, a lower value represents lower performance state.

The power-domains until now were only concentrating on the idle state
management of the device and this needs to change in order to reuse the
infrastructure of power domains for active state management.

This patch adds binding to describe the performance states of a power
domain.

If the consumers don't need the capability of switching to different
domain performance states at runtime, then they can simply define their
required domain performance state in their node directly. Otherwise the
consumers can define their requirements with help of other
infrastructure, for example the OPP table.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../devicetree/bindings/power/power_domain.txt     | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 723e1ad937da..a456e0dc04e0 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -38,6 +38,40 @@ phandle arguments (so called PM domain specifiers) of length specified by the
   domain's idle states. In the absence of this property, the domain would be
   considered as capable of being powered-on or powered-off.
 
+- domain-performance-states : A phandle of the performance states node, which
+		defines all the performance states associated with a power
+		domain.
+  The domain-performance-states property reflects the performance states of this
+  PM domain and not the performance states of the devices or sub-domains in the
+  PM domain. Devices and sub-domains have their own performance states, which
+  are dependent on the performance state of the PM domain.
+
+* PM domain performance states node
+
+This describes the performance states of a PM domain.
+
+Required properties:
+- compatible: Allow performance states to express their compatibility. It should
+  be: "domain-performance-state".
+
+- Performance state nodes: This node shall have one or more "Performance State"
+  nodes.
+
+* Performance state node
+
+Required properties:
+- performance-level: A positive integer value representing the performance level
+  associated with a performance state. The integer value '1' represents the
+  lowest performance level and the highest value represents the highest
+  performance level.
+
+Optional properties:
+- domain-microvolt: voltage in micro Volts.
+
+  A single regulator's voltage is specified with an array of size one or three.
+  Single entry is for target voltage and three entries are for <target min max>
+  voltages.
+
 Example:
 
 	power: power-controller@12340000 {
@@ -118,4 +152,39 @@ The node above defines a typical PM domain consumer device, which is located
 inside a PM domain with index 0 of a power controller represented by a node
 with the label "power".
 
+Optional properties:
+- domain-performance-state: A phandle of a Performance state node.
+
+Example:
+
+	parent: power-controller@12340000 {
+		compatible = "foo,power-controller";
+		reg = <0x12340000 0x1000>;
+		#power-domain-cells = <0>;
+		domain-performance-states = <&domain_perf_states>;
+	};
+
+	domain_perf_states: performance_states {
+		compatible = "domain-performance-state";
+		domain_perf_state1: pstate@1 {
+			performance-level = <1>;
+			domain-microvolt = <970000 975000 985000>;
+		};
+		domain_perf_state2: pstate@2 {
+			performance-level = <2>;
+			domain-microvolt = <1000000 1075000 1085000>;
+		};
+		domain_perf_state3: pstate@3 {
+			performance-level = <3>;
+			domain-microvolt = <1100000 1175000 1185000>;
+		};
+	}
+
+	leaky-device@12350000 {
+		compatible = "foo,i-leak-current";
+		reg = <0x12350000 0x1000>;
+		power-domains = <&power 0>;
+		domain-performance-state = <&domain_perf_state2>;
+	};
+
 [1]. Documentation/devicetree/bindings/power/domain-idle-state.txt
-- 
2.7.1.410.g6faf27b

