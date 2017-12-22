From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V8 2/3] OPP: Introduce "required-opp" property
Date: Fri, 22 Dec 2017 10:58:27 +0530
Message-ID: <20171222052827.GD8312@vireshk-i7>
References: <cover.1513591822.git.viresh.kumar@linaro.org>
 <6615035f294a64a4c17e5b44ac6690d1c2ac127c.1513591822.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6615035f294a64a4c17e5b44ac6690d1c2ac127c.1513591822.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, robh+dt@kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, rnayak@codeaurora.org, sudeep.holla@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 18-12-17, 15:51, Viresh Kumar wrote:
> Devices have inter-dependencies some times. For example a device that
> needs to run at 800 MHz, needs another device (e.g. Its power domain) to
> be configured at a particular operating performance point.
> 
> This patch introduces a new property "required-opp" which can be present
> directly in a device's node (if it doesn't need to change its OPPs), or
> in device's OPP nodes. More details on the property can be seen in the
> binding itself.

This is slightly updated based on Rob and Ulf's comments. Will apply it to the
OPP tree with below diff.

-- 
viresh

-------------------------8<-------------------------
Subject: [PATCH] OPP: Introduce "required-opp" property

Devices have inter-dependencies some times. For example a device that
needs to run at 800 MHz, needs another device (e.g. Its power domain) to
be configured at a particular operating performance point.

This patch introduces a new property "required-opp" which can be present
directly in a device's node (if it doesn't need to change its OPPs), or
in device's OPP nodes. More details on the property can be seen in the
binding itself.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Changes:
- s/opp_table/opp-table for node names.
- s/parent/power for domain alias.

 Documentation/devicetree/bindings/opp/opp.txt      |  8 +++
 .../devicetree/bindings/power/power_domain.txt     | 59 ++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index a3953a1bb1a1..4e4f30288c8b 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -159,6 +159,14 @@ properties.
 
 - status: Marks the node enabled/disabled.
 
+- required-opp: This contains phandle to an OPP node in another device's OPP
+  table. It may contain an array of phandles, where each phandle points to an
+  OPP of a different device. It should not contain multiple phandles to the OPP
+  nodes in the same OPP table. This specifies the minimum required OPP of the
+  device(s), whose OPP's phandle is present in this property, for the
+  functioning of the current device at the current OPP (where this property is
+  present).
+
 Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
 
 / {
diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 61549840ab3b..f3355313c020 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -126,4 +126,63 @@ The node above defines a typical PM domain consumer device, which is located
 inside a PM domain with index 0 of a power controller represented by a node
 with the label "power".
 
+Optional properties:
+- required-opp: This contains phandle to an OPP node in another device's OPP
+  table. It may contain an array of phandles, where each phandle points to an
+  OPP of a different device. It should not contain multiple phandles to the OPP
+  nodes in the same OPP table. This specifies the minimum required OPP of the
+  device(s), whose OPP's phandle is present in this property, for the
+  functioning of the current device at the current OPP (where this property is
+  present).
+
+Example:
+- OPP table for domain provider that provides two domains.
+
+	domain0_opp_table: opp-table0 {
+		compatible = "operating-points-v2";
+
+		domain0_opp_0: opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <975000 970000 985000>;
+		};
+		domain0_opp_1: opp-1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <1000000 980000 1010000>;
+		};
+	};
+
+	domain1_opp_table: opp-table1 {
+		compatible = "operating-points-v2";
+
+		domain1_opp_0: opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <975000 970000 985000>;
+		};
+		domain1_opp_1: opp-1300000000 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <1000000 980000 1010000>;
+		};
+	};
+
+	power: power-controller@12340000 {
+		compatible = "foo,power-controller";
+		reg = <0x12340000 0x1000>;
+		#power-domain-cells = <1>;
+		operating-points-v2 = <&domain0_opp_table>, <&domain1_opp_table>;
+	};
+
+	leaky-device0@12350000 {
+		compatible = "foo,i-leak-current";
+		reg = <0x12350000 0x1000>;
+		power-domains = <&power 0>;
+		required-opp = <&domain0_opp_0>;
+	};
+
+	leaky-device1@12350000 {
+		compatible = "foo,i-leak-current";
+		reg = <0x12350000 0x1000>;
+		power-domains = <&power 1>;
+		required-opp = <&domain1_opp_1>;
+	};
+
 [1]. Documentation/devicetree/bindings/power/domain-idle-state.txt
