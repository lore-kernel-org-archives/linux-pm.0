From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH V5 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Wed, 20 May 2015 08:27:59 -0500
Message-ID: <CAL_JsqKR0-TcBjCnoaLBR9M2wGHCOuO2KSyL+4U+dpTvHGzubQ@mail.gmail.com>
References: <cover.1432091956.git.viresh.kumar@linaro.org> <51a2603050f7993643fea9e5dcd2dba7a5a3fe23.1432091956.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yh0-f52.google.com ([209.85.213.52]:33200 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832AbbETN2V (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2015 09:28:21 -0400
In-Reply-To: <51a2603050f7993643fea9e5dcd2dba7a5a3fe23.1432091956.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Arnd Bergmann <arnd.bergmann@linaro.org>, Nishanth Menon <nm@ti.com>, Mark Brown <broonie@kernel.org>, Mike Turquette <mike.turquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Olof Johansson <olof@lixom.net>, Sudeep Holla <Sudeep.Holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Viswanath Puttagunta <viswanath.puttagunta@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Abraham <ta.omasab@gmail.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kevin Hilman <khilman@linaro.org>, Santosh

On Tue, May 19, 2015 at 10:41 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Current OPP (Operating performance point) DT bindings are proven to be
> insufficient at multiple instances.
>
> The shortcomings we are trying to solve here:
>
> - Getting clock/voltage/current rails sharing information between CPUs.
>   Shared by all cores vs independent clock per core vs shared clock per
>   cluster.
>
> - Support for specifying current levels along with voltages.
>
> - Support for multiple regulators.
>
> - Support for turbo modes.
>
> - Other per OPP settings: transition latencies, disabled status, etc.?
>
> - Expandability of OPPs in future.
>
> This patch introduces new bindings "operating-points-v2" to get these problems
> solved. Refer to the bindings for more details.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

This looks good to me:

Reviewed-by: Rob Herring <robh@kernel.org>

As I've mentioned before, I would like to see some users' acks on this as well.

Rob

> ---
>  Documentation/devicetree/bindings/power/opp.txt | 379 +++++++++++++++++++++++-
>  1 file changed, 375 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
> index 74499e5033fc..d132e2927b21 100644
> --- a/Documentation/devicetree/bindings/power/opp.txt
> +++ b/Documentation/devicetree/bindings/power/opp.txt
> @@ -1,8 +1,19 @@
> -* Generic OPP Interface
> +Generic OPP (Operating Performance Points) Bindings
> +----------------------------------------------------
>
> -SoCs have a standard set of tuples consisting of frequency and
> -voltage pairs that the device will support per voltage domain. These
> -are called Operating Performance Points or OPPs.
> +Devices work at voltage-current-frequency combinations and some implementations
> +have the liberty of choosing these. These combinations are called Operating
> +Performance Points aka OPPs. This document defines bindings for these OPPs
> +applicable across wide range of devices. For illustration purpose, this document
> +uses CPU as a device.
> +
> +This document contain multiple versions of OPP binding and only one of them
> +should be used per device.
> +
> +Binding 1: operating-points
> +============================
> +
> +This binding only supports voltage-frequency pairs.
>
>  Properties:
>  - operating-points: An array of 2-tuples items, and each item consists
> @@ -23,3 +34,363 @@ cpu@0 {
>                 198000  850000
>         >;
>  };
> +
> +
> +
> +Binding 2: operating-points-v2
> +============================
> +
> +* Property: operating-points-v2
> +
> +Devices supporting OPPs must set their "operating-points-v2" property with
> +phandle to a OPP descriptor in their DT node. The OPP core will use this phandle
> +to find the operating points for the device.
> +
> +
> +* OPP Descriptor Node
> +
> +This describes the OPPs belonging to a device. This node can have following
> +properties:
> +
> +Required properties:
> +- compatible: Allow OPPs to express their compatibility. It should be:
> +  "operating-points-v2".
> +
> +- OPP nodes: One or more OPP nodes describing voltage-current-frequency
> +  combinations. Their name isn't significant but their phandle can be used to
> +  reference an OPP.
> +
> +Optional properties:
> +- opp-shared: Indicates that device nodes using this OPP descriptor's phandle
> +  switch their DVFS state together, i.e. they share clock/voltage/current lines.
> +  Missing property means devices have independent clock/voltage/current lines,
> +  but they share OPP tables.
> +
> +
> +* OPP Node
> +
> +This defines voltage-current-frequency combinations along with other related
> +properties.
> +
> +Required properties:
> +- opp-hz: Frequency in Hz
> +
> +Optional properties:
> +- opp-microvolt: voltage in micro Volts.
> +
> +  A single regulator's voltage is specified with an array of size one or three.
> +  Single entry is for target voltage and three entries are for <target min max>
> +  voltages.
> +
> +  Entries for multiple regulators must be present in the same order as
> +  regulators are specified in device's DT node.
> +
> +- opp-microamp: The maximum current drawn by the device in microamperes
> +  considering system specific parameters (such as transients, process, aging,
> +  maximum operating temperature range etc.) as necessary. This may be used to
> +  set the most efficient regulator operating mode.
> +
> +  Should only be set if opp-microvolt is set for the OPP.
> +
> +  Entries for multiple regulators must be present in the same order as
> +  regulators are specified in device's DT node. If this property isn't required
> +  for few regulators, then this should be marked as zero for them. If it isn't
> +  required for any regulator, then this property need not be present.
> +
> +- clock-latency-ns: Specifies the maximum possible transition latency (in
> +  nanoseconds) for switching to this OPP from any other OPP.
> +
> +- turbo-mode: Marks the OPP to be used only for turbo modes. Turbo mode is
> +  available on some platforms, where the device can run over its operating
> +  frequency for a short duration of time limited by the device's power, current
> +  and thermal limits.
> +
> +- status: Marks the node enabled/disabled.
> +
> +Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
> +
> +/ {
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu@0 {
> +                       compatible = "arm,cortex-a9";
> +                       reg = <0>;
> +                       next-level-cache = <&L2>;
> +                       clocks = <&clk_controller 0>;
> +                       clock-names = "cpu";
> +                       opp-supply = <&cpu_supply0>;
> +                       operating-points-v2 = <&cpu0_opp>;
> +               };
> +
> +               cpu@1 {
> +                       compatible = "arm,cortex-a9";
> +                       reg = <1>;
> +                       next-level-cache = <&L2>;
> +                       clocks = <&clk_controller 0>;
> +                       clock-names = "cpu";
> +                       opp-supply = <&cpu_supply0>;
> +                       operating-points-v2 = <&cpu0_opp>;
> +               };
> +       };
> +
> +       cpu0_opp: opp0 {
> +               compatible = "operating-points-v2";
> +               opp-shared;
> +
> +               entry00 {
> +                       opp-hz = <1000000000>;
> +                       opp-microvolt = <970000 975000 985000>;
> +                       opp-microamp = <70000>;
> +                       clock-latency-ns = <300000>;
> +               };
> +               entry01 {
> +                       opp-hz = <1100000000>;
> +                       opp-microvolt = <980000 1000000 1010000>;
> +                       opp-microamp = <80000>;
> +                       clock-latency-ns = <310000>;
> +               };
> +               entry02 {
> +                       opp-hz = <1200000000>;
> +                       opp-microvolt = <1025000>;
> +                       clock-latency-ns = <290000>;
> +                       turbo-mode;
> +               };
> +       };
> +};
> +
> +Example 2: Single cluster, Quad-core Qualcom-krait, switches DVFS states
> +independently.
> +
> +/ {
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu@0 {
> +                       compatible = "qcom,krait";
> +                       reg = <0>;
> +                       next-level-cache = <&L2>;
> +                       clocks = <&clk_controller 0>;
> +                       clock-names = "cpu";
> +                       opp-supply = <&cpu_supply0>;
> +                       operating-points-v2 = <&cpu0_opp>;
> +               };
> +
> +               cpu@1 {
> +                       compatible = "qcom,krait";
> +                       reg = <1>;
> +                       next-level-cache = <&L2>;
> +                       clocks = <&clk_controller 1>;
> +                       clock-names = "cpu";
> +                       opp-supply = <&cpu_supply1>;
> +                       operating-points-v2 = <&cpu0_opp>;
> +               };
> +
> +               cpu@2 {
> +                       compatible = "qcom,krait";
> +                       reg = <2>;
> +                       next-level-cache = <&L2>;
> +                       clocks = <&clk_controller 2>;
> +                       clock-names = "cpu";
> +                       opp-supply = <&cpu_supply2>;
> +                       operating-points-v2 = <&cpu0_opp>;
> +               };
> +
> +               cpu@3 {
> +                       compatible = "qcom,krait";
> +                       reg = <3>;
> +                       next-level-cache = <&L2>;
> +                       clocks = <&clk_controller 3>;
> +                       clock-names = "cpu";
> +                       opp-supply = <&cpu_supply3>;
> +                       operating-points-v2 = <&cpu0_opp>;
> +               };
> +       };
> +
> +       cpu0_opp: opp0 {
> +               compatible = "operating-points-v2";
> +
> +               /*
> +                * Missing opp-shared property means CPUs switch DVFS states
> +                * independently.
> +                */
> +
> +               entry00 {
> +                       opp-hz = <1000000000>;
> +                       opp-microvolt = <970000 975000 985000>;
> +                       opp-microamp = <70000>;
> +                       clock-latency-ns = <300000>;
> +               };
> +               entry01 {
> +                       opp-hz = <1100000000>;
> +                       opp-microvolt = <980000 1000000 1010000>;
> +                       opp-microamp = <80000>;
> +                       clock-latency-ns = <310000>;
> +               };
> +               entry02 {
> +                       opp-hz = <1200000000>;
> +                       opp-microvolt = <1025000>;
> +                       opp-microamp = <90000;
> +                       lock-latency-ns = <290000>;
> +                       turbo-mode;
> +               };
> +       };
> +};
> +
> +Example 3: Dual-cluster, Dual-core per cluster. CPUs within a cluster switch
> +DVFS state together.
> +
> +/ {
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu@0 {
> +                       compatible = "arm,cortex-a7";
> +                       reg = <0>;
> +                       next-level-cache = <&L2>;
> +                       clocks = <&clk_controller 0>;
> +                       clock-names = "cpu";
> +                       opp-supply = <&cpu_supply0>;
> +                       operating-points-v2 = <&cluster0_opp>;
> +               };
> +
> +               cpu@1 {
> +                       compatible = "arm,cortex-a7";
> +                       reg = <1>;
> +                       next-level-cache = <&L2>;
> +                       clocks = <&clk_controller 0>;
> +                       clock-names = "cpu";
> +                       opp-supply = <&cpu_supply0>;
> +                       operating-points-v2 = <&cluster0_opp>;
> +               };
> +
> +               cpu@100 {
> +                       compatible = "arm,cortex-a15";
> +                       reg = <100>;
> +                       next-level-cache = <&L2>;
> +                       clocks = <&clk_controller 1>;
> +                       clock-names = "cpu";
> +                       opp-supply = <&cpu_supply1>;
> +                       operating-points-v2 = <&cluster1_opp>;
> +               };
> +
> +               cpu@101 {
> +                       compatible = "arm,cortex-a15";
> +                       reg = <101>;
> +                       next-level-cache = <&L2>;
> +                       clocks = <&clk_controller 1>;
> +                       clock-names = "cpu";
> +                       opp-supply = <&cpu_supply1>;
> +                       operating-points-v2 = <&cluster1_opp>;
> +               };
> +       };
> +
> +       cluster0_opp: opp0 {
> +               compatible = "operating-points-v2";
> +               opp-shared;
> +
> +               entry00 {
> +                       opp-hz = <1000000000>;
> +                       opp-microvolt = <970000 975000 985000>;
> +                       opp-microamp = <70000>;
> +                       clock-latency-ns = <300000>;
> +               };
> +               entry01 {
> +                       opp-hz = <1100000000>;
> +                       opp-microvolt = <980000 1000000 1010000>;
> +                       opp-microamp = <80000>;
> +                       clock-latency-ns = <310000>;
> +               };
> +               entry02 {
> +                       opp-hz = <1200000000>;
> +                       opp-microvolt = <1025000>;
> +                       opp-microamp = <90000>;
> +                       clock-latency-ns = <290000>;
> +                       turbo-mode;
> +               };
> +       };
> +
> +       cluster1_opp: opp1 {
> +               compatible = "operating-points-v2";
> +               opp-shared;
> +
> +               entry10 {
> +                       opp-hz = <1300000000>;
> +                       opp-microvolt = <1045000 1050000 1055000>;
> +                       opp-microamp = <95000>;
> +                       clock-latency-ns = <400000>;
> +               };
> +               entry11 {
> +                       opp-hz = <1400000000>;
> +                       opp-microvolt = <1075000>;
> +                       opp-microamp = <100000>;
> +                       clock-latency-ns = <400000>;
> +               };
> +               entry12 {
> +                       opp-hz = <1500000000>;
> +                       opp-microvolt = <1010000 1100000 1110000>;
> +                       opp-microamp = <95000>;
> +                       clock-latency-ns = <400000>;
> +                       turbo-mode;
> +               };
> +       };
> +};
> +
> +Example 4: Handling multiple regulators
> +
> +/ {
> +       cpus {
> +               cpu@0 {
> +                       compatible = "arm,cortex-a7";
> +                       ...
> +
> +                       opp-supply = <&cpu_supply0>, <&cpu_supply1>, <&cpu_supply2>;
> +                       operating-points-v2 = <&cpu0_opp>;
> +               };
> +       };
> +
> +       cpu0_opp: opp0 {
> +               compatible = "operating-points-v2";
> +               opp-shared;
> +
> +               entry00 {
> +                       opp-hz = <1000000000>;
> +                       opp-microvolt = <970000>, /* Supply 0 */
> +                                       <960000>, /* Supply 1 */
> +                                       <960000>; /* Supply 2 */
> +                       opp-microamp =  <70000>,  /* Supply 0 */
> +                                       <70000>,  /* Supply 1 */
> +                                       <70000>;  /* Supply 2 */
> +                       clock-latency-ns = <300000>;
> +               };
> +
> +               /* OR */
> +
> +               entry00 {
> +                       opp-hz = <1000000000>;
> +                       opp-microvolt = <970000 975000 985000>, /* Supply 0 */
> +                                       <960000 965000 975000>, /* Supply 1 */
> +                                       <960000 965000 975000>; /* Supply 2 */
> +                       opp-microamp =  <70000>,                /* Supply 0 */
> +                                       <70000>,                /* Supply 1 */
> +                                       <70000>;                /* Supply 2 */
> +                       clock-latency-ns = <300000>;
> +               };
> +
> +               /* OR */
> +
> +               entry00 {
> +                       opp-hz = <1000000000>;
> +                       opp-microvolt = <970000 975000 985000>, /* Supply 0 */
> +                                       <960000 965000 975000>, /* Supply 1 */
> +                                       <960000 965000 975000>; /* Supply 2 */
> +                       opp-microamp =  <70000>,                /* Supply 0 */
> +                                       <0>,                    /* Supply 1 doesn't need this */
> +                                       <70000>;                /* Supply 2 */
> +                       clock-latency-ns = <300000>;
> +               };
> +       };
> +};
> --
> 2.4.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
