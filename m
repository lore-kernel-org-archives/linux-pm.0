From: Michael Turquette <mike.turquette@linaro.org>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Tue, 12 May 2015 14:42:24 -0700
Message-ID: <20150512214224.16410.15922@quantum>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:34829 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932689AbbELVmg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2015 17:42:36 -0400
Received: by iebpz10 with SMTP id pz10so14754547ieb.2
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2015 14:42:36 -0700 (PDT)
In-Reply-To: <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, Viresh Kumar <viresh.kumar@linaro.org>

Quoting Viresh Kumar (2015-04-30 05:07:59)
> Current OPP (Operating performance point) DT bindings are proven to be
> insufficient at multiple instances.

Hi Viresh,

Sorry for chiming in so late in the process. Also, sorry for the long
email. Lots of repetition below:

Why should this new binding exist? Is Devicetree really the right place
to put all of this data? If DT is the right place for some users, some
of the time ... is it always the right place for all users, all of the
time?

> 
> The shortcomings we are trying to solve here:
> 
> - Getting clock sharing information between CPUs. Single shared clock vs
>   independent clock per core vs shared clock per cluster.
> 
> - Support for specifying current levels along with voltages.
> 
> - Support for multiple regulators.
> 
> - Support for turbo modes.
> 
> - Other per OPP settings: transition latencies, disabled status, etc.?

I agree that operating-points-v1 does not do this stuff. There is a need
to express this data, but is DT the right place to do so? Why doesn't a
driver contain this data?

> 
> - Expandability of OPPs in future.

This point above gives me heartburn. It appears that this binding is not
meant to be "sub-classed" by vendor-specific compatible strings. Please
let me know if I'm wrong on that.

The problem with this approach is that every little problem that someone
has with the binding will have to be solved by changing the generic opp
binding. I do not see how this can scale given the complexity of data,
programming sequences and other stuff associated with operating points
and dvfs transitions.

> 
> This patch introduces new bindings "operating-points-v2" to get these problems
> solved. Refer to the bindings for more details.

I like the existing operating points binding. It is very simple. The
data can be entirely encoded in DT and then used by the driver for
simple dvfs use cases.

Maybe we should just stop there and keep it simple? If the data needed
to express an operating point or dvfs transition is very complex, why
use DT for that?

We went through the same issue with the clock bindings where some people
(myself included) wanted to use DT as a data-driven interface into the
kernel. Turns out DT isn't great for that. What we have now is more
scalable: clock providers (usually a clock generator IP block) get a
node in DT. Clock consumers reference that provider node plus an index
value which corresponds to a specific clock signal that the downstream
node consumes. That's it. The binding basically only creates connections
across devices using phandles.

All of the data about clock rates, parents, programming sequences,
register definitions and bitfields, supported operations, etc all belong
in drivers.

For very simple clock providers (such as a fixed-rate crystal) we do
have a dedicated binding that allows for all of the data to belong in DT
(just the clock name and rate is required). I think this is analogous to
the existing operating-points-v1 today, which works nicely for the
simple case.

For the complex case, why not just create a link between the device that
provides the operating points (e.g. a pmic, or system controller, or
clock provider, or whatever) and the device that consumes them (e.g.
cpufreq driver, gpu driver, io controller driver, etc)? Leave all of the
data in C.

> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/opp.txt | 366 +++++++++++++++++++++++-
>  1 file changed, 362 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
> index 74499e5033fc..3b67a5c8d965 100644
> --- a/Documentation/devicetree/bindings/power/opp.txt
> +++ b/Documentation/devicetree/bindings/power/opp.txt
> @@ -1,8 +1,366 @@
> -* Generic OPP Interface
> +Generic OPP (Operating Performance Points) Bindings
> +----------------------------------------------------
>  
> -SoCs have a standard set of tuples consisting of frequency and
> -voltage pairs that the device will support per voltage domain. These
> -are called Operating Performance Points or OPPs.
> +Devices work at voltage-current-frequency triplets and some implementations have
> +the liberty of choosing these. These triplets are called Operating Performance
> +Points aka OPPs. This document defines bindings for these OPPs applicable across
> +wide range of devices. For illustration purpose, this document uses CPU as a
> +device.
> +
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
> +- OPP nodes: One or more OPP nodes describing voltage-current-frequency
> +  triplets. Their name isn't significant but their phandle can be used to
> +  reference an OPP.
> +
> +Optional properties:
> +- shared-opp: Indicates that device nodes using this OPP descriptor's phandle
> +  switch their DVFS state together, i.e. they share clock/voltage/current lines.
> +  Missing property means devices have independent clock/voltage/current lines,
> +  but they share OPP tables.

What is the behavior of not setting 'shared-opp'? The same table is
re-used by multiple consumers/devices?

I think a provider/consumer model works better here. E.g. if we have 4
cpus that scale independently then there would be 4 opp providers, each
provider corresponding to the unique frequency and voltage domains per
cpu. If multiple cpu nodes consume the same opp phandle then the sharing
becomes implicit: those cpus are in the same frequency and power
domains.

This is how it works for other resources, such as specifying a clock or
regulator in DT. If two device nodes reference that same resource then
it clear that they are using the same physical hardware. Having just a
table of data in a node that does not clearly map onto hardware (or a
software abstraction that provides access to that hardware) is not as
nice IMO.

> +
> +
> +* OPP Node
> +
> +This defines voltage-current-frequency triplets along with other related
> +properties.
> +
> +Required properties:
> +- opp-khz: Frequency in kHz
> +
> +Optional properties:
> +- opp-microvolt: voltage in micro Volts. It can contain entries for multiple
> +  regulators.
> +
> +  A single regulator's voltage is specified with an array of size one or three.
> +  Single entry is for target voltage and three entries are for <target min max>
> +  voltages.
> +
> +  Entries for multiple regulators must be present in the same order as
> +  regulators are specified in device's DT node.
> +
> +- opp-microamp: current in micro Amperes. It can contain entries for multiple
> +  regulators.
> +
> +  A single regulator's current is specified with an array of size one or three.
> +  Single entry is for target current and three entries are for <target min max>
> +  currents.
> +
> +  Entries for multiple regulators must be present in the same order as
> +  regulators are specified in device's DT node. If few regulators don't provide
> +  capability to configure current, then values for then should be marked as
> +  zero.
> +
> +- clock-latency-ns: Specifies the maximum possible transition latency (in
> +  nanoseconds) for switching to this OPP from any other OPP.
> +- turbo-mode: Marks the OPP to be used only for turbo modes.
> +- status: Marks the node enabled/disabled.

s/clock/transition/

Scaling the regulator can take longer than the clock. Better to reflect
that this value is capturing the total transition time.

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
> +               shared-opp;
> +
> +               entry00 {
> +                       opp-khz = <1000000>;
> +                       opp-microvolt = <970000 975000 985000>;
> +                       opp-microamp = <70000 75000 85000>;
> +                       clock-latency-ns = <300000>;
> +               };
> +               entry01 {
> +                       opp-khz = <1100000>;
> +                       opp-microvolt = <980000 1000000 1010000>;
> +                       opp-microamp = <80000 81000 82000>;
> +                       clock-latency-ns = <310000>;
> +               };
> +               entry02 {
> +                       opp-khz = <1200000>;
> +                       opp-microvolt = <1025000>;
> +                       clock-latency-ns = <290000>;
> +                       turbo-mode;
> +               };
> +       };
> +};

It seems wrong to me that the clock and supply data is owned by the cpu
node, and not the opp descriptor. Everything about the opp transition
should belong to a provider node. Then the cpu simply needs to consume
that via a phandle.

<snip>

> +Deprecated Bindings
> +-------------------
>  
>  Properties:
>  - operating-points: An array of 2-tuples items, and each item consists

I think we should keep these. They work for the simple case.

I know that DT bindings are notorious for bike shedding. But in this
case I'm not debating the color of the bike shed but instead questioning
whether we need the shed at all :-)

Regards,
Mike

> -- 
> 2.3.0.rc0.44.ga94655d
> 
