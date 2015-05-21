From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V5 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Thu, 21 May 2015 00:27:36 -0500
Message-ID: <555D6CC8.9050201@ti.com>
References: <cover.1432091956.git.viresh.kumar@linaro.org> <51a2603050f7993643fea9e5dcd2dba7a5a3fe23.1432091956.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35462 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751481AbbEUF2k (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 21 May 2015 01:28:40 -0400
In-Reply-To: <51a2603050f7993643fea9e5dcd2dba7a5a3fe23.1432091956.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, arnd.bergmann@linaro.org, broonie@kernel.org, mike.turquette@linaro.org, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

$subject: (Rafael usually hand fixes it.. but might be nice of us not to
save him that effort) PM / OPP: Additional binding definition to address ...

we are not really redefining the old definitions..

On 05/19/2015 10:41 PM, Viresh Kumar wrote:
> Current OPP (Operating performance point) DT bindings are proven to be
Nit Pick: s/DT/device tree ; s/are/have been

> insufficient at multiple instances.

insufficient due to the inflexible nature of the original bindings. Over
time, we have realized that Operating Performance Point definitions and
usage is varied depending on the SoC and a "single size (just frequency,
voltage) fits all" model which the original bindings attempted and failed.

> 
> The shortcomings we are trying to solve here:

The proposed next generation of the bindings addresses by providing a
expandable binding for OPPs and introduces the following common
shortcomings seen with the original bindings:

[...]

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

Will be nice to repeat this message in the commit message as well..
folks just doing git log should probably not freak out that the current
dtbs will stop working once the implementation is merged in - it might
help deal with some of the concerns of folks not aware of the mailing
thread discussions.

> +
> +Binding 1: operating-points
> +============================
> +
> +This binding only supports voltage-frequency pairs.
>  
>  Properties:
>  - operating-points: An array of 2-tuples items, and each item consists
> @@ -23,3 +34,363 @@ cpu@0 {
>  		198000  850000
>  	>;
>  };
> +
> +

Extra EOLs? maybe just stop at 2 EOLs to separate the sections.?

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

I would suggest adding a link to how future vendor specific extension
docs might look like - maybe this is probably not the time to discuss
this.. but anyways.. we could make some statement to the effect of "SoC
vendor specfic extensions are documented as
Documentation/devicetree/bindings/power/<vendor>,opp.txt and should
clearly indicate that the extensions are permitted only under the
operating-points-v2 compatible description."


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

What if this was generated data (say using an overlay)? does it have to
be "required" or just "optional" :)

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

I am just being nit picky -> should we keep Heinrich Hertz respected[2]
and name it opp-Hz ? No strong opinions either way.

different angle: How about just target-freq-Hz? just drop the "opp"
prefix for properties of an OPP node? No strong feelings here. (some
folks did have variations of a few Hz based on clock tree - example with
a crystal frequency of 19.2MHz you'd probably get 1001MHz exact, with a
26MHz crystal, you'd get 1000MHz -> ofcourse round-rate is supposed to
help with that... but anyways.. why not say we are trying to indicate
target frequency? I do recollect during initial days of OPP
(pre-dt-adoption days) folks did complain about this - we kinda worked
around this with round-rated handling - but we might as well anticipate it.

[...]

> +Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.

Thanks for adding the examples - My customer support team especially
will appreciate having such examples ;).

> +
> +/ {
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {
> +			compatible = "arm,cortex-a9";
> +			reg = <0>;
> +			next-level-cache = <&L2>;
> +			clocks = <&clk_controller 0>;
> +			clock-names = "cpu";
> +			opp-supply = <&cpu_supply0>;
> +			operating-points-v2 = <&cpu0_opp>;
> +		};
> +
> +		cpu@1 {
> +			compatible = "arm,cortex-a9";
> +			reg = <1>;
> +			next-level-cache = <&L2>;
> +			clocks = <&clk_controller 0>;

I agree with Mike[1] here -> why not move clocks and supply to cpu0_opp?
"
It seems wrong to me that the clock and supply data is owned by the cpu
node, and not the opp descriptor. Everything about the opp transition
should belong to a provider node. Then the cpu simply needs to consume
that via a phandle.
"

I am not sure if we discussed that point further OR if we kinda got
hooked on to the "should it be in kernel" point of debate in V4.

> +			clock-names = "cpu";
> +			opp-supply = <&cpu_supply0>;
> +			operating-points-v2 = <&cpu0_opp>;
> +		};
> +	};
> +

[...]

[1] http://marc.info/?l=linux-pm&m=143146696029140&w=2
[2] http://marc.info/?l=linux-kernel&m=143135047525313&w=2
-- 
Regards,
Nishanth Menon
