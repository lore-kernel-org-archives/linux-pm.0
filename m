From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Wed, 9 Sep 2015 11:57:22 +0530
Message-ID: <20150909062722.GA5266@linux>
References: <20150811100941.GG5509@linux>
 <20150811115425.GE18282@x1>
 <20150811120124.GH5509@linux>
 <20150811132756.GG18282@x1>
 <20150811142812.GJ5509@linux>
 <20150811151736.GO18282@x1>
 <20150812110841.GC20238@linux>
 <20150826120628.GZ19409@x1>
 <20150902080639.GA26744@linux>
 <CAL_JsqKMGp+3Z+oO6E0YYzjTCb=-R_QM=YF=B33NWayWmV057A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36693 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbbIIG1c (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2015 02:27:32 -0400
Received: by padhk3 with SMTP id hk3so289958pad.3
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2015 23:27:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAL_JsqKMGp+3Z+oO6E0YYzjTCb=-R_QM=YF=B33NWayWmV057A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Ajit Pal Singh <ajitpal.singh@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 02-09-15, 13:58, Rob Herring wrote:
> What do you expect here? It is your job to close it. Ultimately, this
> will be your problem to deal with. If you have 10 different vendors
> doing selection of OPPs in 10 different ways you will not be able to
> change that easily later. Maybe if you can't come up with something
> common, then this should just not go into DT. You can always look at
> how to do this in a common way and move from the kernel to DT later.

After getting ranted a bit, here is an real attempt to solve the
problem in a generic way. I hope this can take care of the complexity
of both Qualcomm and ST Microelectronics SoCs.

@Lee and Stephen: Lemme know if this still wouldn't work :(

-------------------------8<-------------------------
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 9 Sep 2015 11:47:37 +0530
Subject: [PATCH] PM / OPP: Add "opp-cuts" and "opp-supply-version" bindings

For many platforms it is unknown until runtime, about which OPPs should
be used or if used what should be voltage range for the supplies for a
particular frequency. And this mostly depends on the version of the
device or hardware, for which the OPPs are getting used.

This patch adds two new OPP bindings to get this solved.

1. "opp-cuts": The purpose of this binding is to allow the platform to
   identify the valid OPPs based on the different levels of versions
   with which the hardware is identified.

2. "opp-supply-name": The purpose of this binding is to allow the
   platform to select the voltage range of the power supplies, for a
   valid OPP.

Both of these can be used together, as well as independently.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/opp/opp.txt | 90 +++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index c56a6b1a44ef..def75f7a3614 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -98,6 +98,13 @@ This describes the OPPs belonging to a device. This node can have following
   information. But for multiple power-supplies, this must be set to pass
   triplet style values.
 
+- opp-supply-version: One or more strings describing version of the supplies on
+  the platform. This is useful for the cases, where the platform wants to select
+  the voltage range for supplies at runtime, based on the specific version of
+  the hardware. There should be one entry in opp-microvolt array, for each
+  string present here. OPPs for the device must be configured, only for a single
+  version of the supplies.
+
 - status: Marks the OPP table enabled/disabled.
 
 
@@ -144,6 +151,16 @@ properties.
 - opp-suspend: Marks the OPP to be used during device suspend. Only one OPP in
   the table should have this.
 
+- opp-cuts: Variable length field that contains versions/cuts/substrate of the
+  hardware for which the OPP is supported. Should contain entry per level of
+  version type. For example: a platform with three levels of versions (cuts
+  substrate pcode), this field should be like <X Y Z>, where X corresponds to
+  different cuts, Y corresponds to different substrates and Z corresponds to
+  different pcodes the OPP supports. Each bit of the value corresponds to a
+  particular version of the level, and so we can have maximum 32 different
+  values of any level. A value of 0xFFFFFFFF means that all the versions of the
+  level are supported.
+
 - status: Marks the node enabled/disabled.
 
 Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
@@ -491,3 +508,76 @@ Example 5: Multiple OPP tables
 		};
 	};
 };
+
+Example 6: OPP selection based on hardware version
+(example: three levels of versions: cuts, substrate and pcode)
+
+/ {
+	cpus {
+		cpu@0 {
+			compatible = "arm,cortex-a7";
+			...
+
+			cpu-supply = <&cpu_supply>
+			operating-points-v2 = <&cpu0_opp_table_slow>;
+		};
+	};
+
+	opp_table {
+		compatible = "operating-points-v2";
+		status = "okay";
+		opp-shared;
+
+		opp00 {
+			/*
+			 * Supports all substrate and pcode versions for 0xf
+			 * cuts, i.e. only first four cuts.
+			 */
+			opp-cuts = <0xf 0xffffffff 0xffffffff>
+			opp-hz = /bits/ 64 <600000000>;
+			...
+		};
+
+		opp01 {
+			/*
+			 * Supports all substrate and pcode versions for 0x20
+			 * cuts, i.e. only the 6th cut.
+			 */
+			opp-cuts = <0x20 0xffffffff 0xffffffff>
+			opp-hz = /bits/ 64 <800000000>;
+			...
+		};
+	};
+};
+
+Example 7: Multiple voltage-ranges (opp-supply-version) per supply
+(example: device with 2 supplies: vcc0 and vcc1, with two possible ranges of
+voltages: slow and fast)
+
+/ {
+	cpus {
+		cpu@0 {
+			compatible = "arm,cortex-a7";
+			...
+
+			vcc0-supply = <&cpu_supply0>;
+			vcc1-supply = <&cpu_supply1>;
+			operating-points-v2 = <&cpu0_opp_table>;
+		};
+	};
+
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		supply-names = "vcc0", "vcc1";
+		opp-supply-version = "slow", "fast";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <900000 915000 925000>, /* Supply vcc0: slow */
+					<910000 925000 935000>, /* Supply vcc1: slow */
+					<970000 975000 985000>, /* Supply vcc0: fast */
+					<960000 965000 975000>; /* Supply vcc1: fast */
+		};
+	};
+};
