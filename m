From: Rob Herring <robherring2@gmail.com>
Subject: Re: [RFC] OPP: Redefine bindings to overcome shortcomings
Date: Mon, 29 Dec 2014 11:05:55 -0600
Message-ID: <CAL_JsqJabcXe7-juTnJDcVdzpnFokYmt-N=bjZt5a+32Fzr_vg@mail.gmail.com>
References: <52c403454c3b8fc201abe7ac74cf657638479311.1417691389.git.viresh.kumar@linaro.org>
 <CAKohpokUXvhqt+z4EPC9k=O8ZnQOqNSGGi8w6w4shYtbvv8mTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:53807 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbaL2RGR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Dec 2014 12:06:17 -0500
In-Reply-To: <CAKohpokUXvhqt+z4EPC9k=O8ZnQOqNSGGi8w6w4shYtbvv8mTw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Arnd Bergmann <arnd.bergmann@linaro.org>, Rob Herring <rob.herring@linaro.org>, Grant Likely <grant.likely@linaro.org>, "olof@lixom.net" <olof@lixom.net>, Nishanth Menon <nm@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, santosh shilimkar <santosh.shilimkar@oracle.com>, Stephen Boyd <sboyd@codeaurora.org>, Mike Turquette <mike.turquette@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Dec 9, 2014 at 9:51 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 4 December 2014 at 16:44, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> The shortcomings we are trying to solve here:
>>
>> - Some kind of compatibility string to probe the right cpufreq driver for
>>   platforms, when multiple drivers are available. For example: how to choose
>>   between cpufreq-dt and arm_big_little drivers.
>>
>> - Getting clock sharing information between CPUs. Single shared clock vs.
>>   independent clock per core vs. shared clock per cluster.
>>
>> - Support for turbo modes
>>
>> - Other per OPP settings: transition latencies, disabled status, etc.?
>
> Some updates on the structure of bindings which I got up to with help of Arnd
> and Rob over IRC, have got better examples to show how things would look
> like:
>
> diff --git a/Documentation/devicetree/bindings/power/opp.txt
> b/Documentation/devicetree/bindings/power/opp.txt
> index 74499e5033fc..8ae574b84650 100644
> --- a/Documentation/devicetree/bindings/power/opp.txt
> +++ b/Documentation/devicetree/bindings/power/opp.txt
> @@ -1,9 +1,292 @@
> -* Generic OPP Interface
> +Generic OPP (Operating Performance Points) Interface
> +----------------------------------------------------
>
>  SoCs have a standard set of tuples consisting of frequency and
>  voltage pairs that the device will support per voltage domain. These
>  are called Operating Performance Points or OPPs.
>
> +This documents defines OPP bindings with its required/optional properties.
> +OPPs can be defined for any device, this file uses CPU device as an example to
> +illustrate how to define OPPs.
> +
> +opp nodes and opp-lists
> +
> +- opp-listN:
> +  List of nodes defining performance points. Following belong to the nodes
> +  within the opp-lists.
> +
> +  Required properties:
> +  - frequency-kHz: Frequency in kHz

s/kHz/khz/

> +  - voltage-uV: voltage in micro Volts

-microvolt is more consistent with regulator binding.

The names are a bit redundant. perhaps opp-khz and opp-microvolt instead.

> +
> +  Optional properties:
> +  - turbo-mode: Marks the volt-freq pair as turbo pair.
> +  - status: Marks the node enabled/disabled.
> +
> +- oppN:
> +  Operating performance point node per device. Devices using it should have its
> +  phandle in their "operating-points-v2" property.
> +
> +  Required properties:
> +  - compatible: allow OPPs to express their compatibility
> +  - opp-list: phandle to opp-list defined above.
> +
> +  Optional properties:
> +  - clocks: Tuple of clock providers
> +  - clock-names: Clock names
> +  - opp-supply: phandle to the parent supply/regulator node
> +  - voltage-tolerance: Specify the CPU voltage tolerance in percentage.
> +  - clock-latency: Specify the possible maximum transition latency for clock,
> +    in unit of nanoseconds.
> +
> +Example 1: Simple case of dual-core cortex A9-single cluster, sharing
> clock line.
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
> +                       operating-points-v2 = <&opp0>;
> +
> +                       opp0: opp0 {

I don't really like having this under cpu0 when it applies to all
cpus. I would move it out of /cpus.

> +                               compatible = "linux,cpu-dvfs";

This should not be linux specific. Probably not cpu specific either.

> +                               clocks = <&clk-controller 0>;
> +                               clock-names = "cpu";

clocks are an input to the cpu, not really an opp. You could have a an
OPP which uses a different parent clock, but that is most likely a
switch within the clock controller rather than 2 clock inputs to the
cpu.

I think the clock binding for cpus should stand on its own independent of OPPs.

> +                               opp-supply = <&cpu-supply0>;

Same comment as clocks applies here.

> +                               voltage-tolerance = <2>; /* percentage */
> +                               clock-latency = <300000>;

These could be per entry. I'm not sure it is worth the savings to not
just always specify them per entry.

We should append units (-us) to clock-latency unless there is a good
reason to maintain compatibility.

> +                               opp-list = <&opplist0>;

With the above changes, having this list is unnecessary.

So, what I envision is like this:

/cpus {
  cpu@0 {
    clocks = <...>;
    cpu-supply = <...>;
    operating-point-v2 = <&cpu0-opp>;
   };
  cpu@1 {
    clocks = <...>;
    cpu-supply = <...>;
    operating-point-v2 = <&cpu1-opp>;
   };
};

cpu0-opp : opp0 {
  compatible = "operating-point-table";
  entry0 {
    opp-khz = <500000>;
    opp-microvolt = <900000>;
  };
  entry1 {
    opp-khz = <1000000>;
    opp-microvolt = <1000000>;
    turbo-mode;
  };
};

cpu1-opp : opp1 {
  compatible = "operating-point-table";
...
};

We need to also consider if this all works for other non-cpu OPPs like
GPUs or DRAM/bus.

Rob
