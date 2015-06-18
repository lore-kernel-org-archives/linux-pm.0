From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V7 2/3] OPP: Allow multiple OPP tables to be passed via DT
Date: Thu, 18 Jun 2015 08:20:34 +0530
Message-ID: <20150618025034.GB28820@linux>
References: <cover.1433434659.git.viresh.kumar@linaro.org>
 <263c128844f5a3c9280c8be71f6c9eb1869a5188.1433434659.git.viresh.kumar@linaro.org>
 <CAL_Jsq+EOOeQw42wZi+H82ovLn8LcQUuK9HGT+FvewdhTf7Q1w@mail.gmail.com>
 <20150617133314.GB15153@linux>
 <CAL_Jsq+SdgAf7=Yq7Jk_1d9jTpAOLCEuEDCZvD=-h=2MWsNfFw@mail.gmail.com>
 <55821F30.2090802@codeaurora.org>
 <20150618022543.GA28820@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34586 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbbFRCui (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jun 2015 22:50:38 -0400
Received: by pabvl15 with SMTP id vl15so4249261pab.1
        for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2015 19:50:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150618022543.GA28820@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rob Herring <robherring2@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Nishanth Menon <nm@ti.com>, Mark Brown <broonie@kernel.org>, Mike Turquette <mike.turquette@linaro.org>, Grant Likely <grant.likely@linaro.org>, Olof Johansson <olof@lixom.net>, Sudeep Holla <Sudeep.Holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Viswanath Puttagunta <viswanath.puttagunta@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Abraham <ta.omasab@gmail.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kevin Hilman <khilman@linaro.org>, Santosh

On 18-06-15, 07:55, Viresh Kumar wrote:
> Why do you think so? For me the operating-points-v2-names property
> will be present in CPU node (as there is no OPP node which can have
> it) and so every CPU is free to choose what it wants to.

So, I had something like this in mind:

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 30 Apr 2015 17:38:00 +0530
Subject: [PATCH] OPP: Allow multiple OPP tables to be passed via DT

On some platforms (Like Qualcomm's SoCs), it is not decided until
runtime on what OPPs to use. The OPP tables can be fixed at compile
time, but which table to use is found out only after reading some efuses
(sort of an prom) and knowing characteristics of the SoC.

To support such platform we need to pass multiple OPP tables per device
and hardware should be able to choose one and only one table out of
those.

Update operating-points-v2 bindings to support that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/power/opp.txt | 63 +++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
index 259bf00edf7d..72ccacaac9c9 100644
--- a/Documentation/devicetree/bindings/power/opp.txt
+++ b/Documentation/devicetree/bindings/power/opp.txt
@@ -45,10 +45,21 @@ Devices supporting OPPs must set their "operating-points-v2" property with
 phandle to a OPP table in their DT node. The OPP core will use this phandle to
 find the operating points for the device.
 
+Devices may want to choose OPP tables at runtime and so can provide a list of
+phandles here. But only *one* of them should be chosen at runtime. This must be
+accompanied by a corresponding "operating-points-v2-names" property, to uniquely
+identify the OPP tables.
+
 If required, this can be extended for SoC vendor specfic bindings. Such bindings
 should be documented as Documentation/devicetree/bindings/power/<vendor>-opp.txt
 and should have a compatible description like: "operating-points-v2-<vendor>".
 
+Optional properties:
+- operating-points-v2-names: Names of OPP tables (required if multiple OPP
+  tables are present), to uniquely identify them. The same list must be present
+  for all the CPUs which are sharing clock/voltage rails and hence the OPP
+  tables.
+
 * OPP Table Node
 
 This describes the OPPs belonging to a device. This node can have following
@@ -63,11 +74,16 @@ This describes the OPPs belonging to a device. This node can have following
   reference an OPP.
 
 Optional properties:
+- opp-name: Name of the OPP table, to uniquely identify it if more than one OPP
+  table is supplied in "operating-points-v2" property of device.
+
 - opp-shared: Indicates that device nodes using this OPP Table Node's phandle
   switch their DVFS state together, i.e. they share clock/voltage/current lines.
   Missing property means devices have independent clock/voltage/current lines,
   but they share OPP tables.
 
+- status: Marks the OPP table enabled/disabled.
+
 
 * OPP Node
 
@@ -396,3 +412,50 @@ Example 4: Handling multiple regulators
 		};
 	};
 };
+
+Example 5: Multiple OPP tables
+
+/ {
+	cpus {
+		cpu@0 {
+			compatible = "arm,cortex-a7";
+			...
+
+			cpu-supply = <&cpu_supply>
+			operating-points-v2 = <&cpu0_opp_table_slow>, <&cpu0_opp_table_fast>;
+			operating-points-v2-names = "slow", "fast";
+		};
+	};
+
+	cpu0_opp_table_slow: opp_table_slow {
+		compatible = "operating-points-v2";
+		status = "okay";
+		opp-shared;
+
+		opp00 {
+			opp-hz = <600000000>;
+			...
+		};
+
+		opp01 {
+			opp-hz = <800000000>;
+			...
+		};
+	};
+
+	cpu0_opp_table_fast: opp_table_fast {
+		compatible = "operating-points-v2";
+		status = "okay";
+		opp-shared;
+
+		opp10 {
+			opp-hz = <1000000000>;
+			...
+		};
+
+		opp11 {
+			opp-hz = <1100000000>;
+			...
+		};
+	};
+};

