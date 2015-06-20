From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V7 2/3] OPP: Allow multiple OPP tables to be passed via DT
Date: Sat, 20 Jun 2015 07:54:18 +0530
Message-ID: <20150620022418.GB1955@linux>
References: <cover.1433434659.git.viresh.kumar@linaro.org>
 <263c128844f5a3c9280c8be71f6c9eb1869a5188.1433434659.git.viresh.kumar@linaro.org>
 <CAL_Jsq+EOOeQw42wZi+H82ovLn8LcQUuK9HGT+FvewdhTf7Q1w@mail.gmail.com>
 <20150617133314.GB15153@linux>
 <CAL_Jsq+SdgAf7=Yq7Jk_1d9jTpAOLCEuEDCZvD=-h=2MWsNfFw@mail.gmail.com>
 <55821F30.2090802@codeaurora.org>
 <20150618022543.GA28820@linux>
 <20150618025034.GB28820@linux>
 <20150619184747.GD22132@codeaurora.org>
 <CAL_JsqJfWDO4r_FP6xHSxRkMM-pSnbEUB=d9Gj6mhvPY+ouLxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqJfWDO4r_FP6xHSxRkMM-pSnbEUB=d9Gj6mhvPY+ouLxA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mike Turquette <mike.turquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Sudeep Holla <Sudeep.Holla-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Viswanath Puttagunta <viswanath.puttagunta-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Thomas Abraham <ta.omasab-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Abhilash Kesavan <kesavan.abhilash-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Santosh
List-Id: linux-pm@vger.kernel.org

On 19-06-15, 13:52, Rob Herring wrote:
> On Fri, Jun 19, 2015 at 1:47 PM, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> > But isn't this being removed? If it is removed, feel free to add

Sigh..

> > Reviewed-by: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Thanks. And here is the final Acked version..

------------------------8<-----------------------

From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
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

Reviewed-by: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/power/opp.txt | 60 +++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
index 259bf00edf7d..3d5d32ca0f97 100644
--- a/Documentation/devicetree/bindings/power/opp.txt
+++ b/Documentation/devicetree/bindings/power/opp.txt
@@ -45,10 +45,21 @@ Devices supporting OPPs must set their "operating-points-v2" property with
 phandle to a OPP table in their DT node. The OPP core will use this phandle to
 find the operating points for the device.
 
+Devices may want to choose OPP tables at runtime and so can provide a list of
+phandles here. But only *one* of them should be chosen at runtime. This must be
+accompanied by a corresponding "operating-points-names" property, to uniquely
+identify the OPP tables.
+
 If required, this can be extended for SoC vendor specfic bindings. Such bindings
 should be documented as Documentation/devicetree/bindings/power/<vendor>-opp.txt
 and should have a compatible description like: "operating-points-v2-<vendor>".
 
+Optional properties:
+- operating-points-names: Names of OPP tables (required if multiple OPP
+  tables are present), to uniquely identify them. The same list must be present
+  for all the CPUs which are sharing clock/voltage rails and hence the OPP
+  tables.
+
 * OPP Table Node
 
 This describes the OPPs belonging to a device. This node can have following
@@ -68,6 +79,8 @@ This describes the OPPs belonging to a device. This node can have following
   Missing property means devices have independent clock/voltage/current lines,
   but they share OPP tables.
 
+- status: Marks the OPP table enabled/disabled.
+
 
 * OPP Node
 
@@ -396,3 +409,50 @@ Example 4: Handling multiple regulators
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
+			operating-points-names = "slow", "fast";
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
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
