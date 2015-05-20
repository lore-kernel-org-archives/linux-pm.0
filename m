From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Tue, 19 May 2015 17:51:08 -0700
Message-ID: <555BDA7C.7020506@codeaurora.org>
References: <cover.1430394884.git.viresh.kumar@linaro.org> <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:37536 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbbETAvL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 May 2015 20:51:11 -0400
In-Reply-To: <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mike.turquette@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 04/30/15 05:07, Viresh Kumar wrote:
> Current OPP (Operating performance point) DT bindings are proven to be
> insufficient at multiple instances.
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
>
> - Expandability of OPPs in future.
>
> This patch introduces new bindings "operating-points-v2" to get these problems
> solved. Refer to the bindings for more details.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

This looks like it covers my usecases. I'm not sure if I'm going to put
all of this data in DT because of the philosophical question regarding
what should be in DT and the technical decisions that some platforms I'm
working on have made to encode parts of the OPPs in fuses, but at least
the binding looks to support all the scenarios I have today.

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
> +
> +
> +* OPP Node
> +
> +This defines voltage-current-frequency triplets along with other related
> +properties.
> +
> +Required properties:
> +- opp-khz: Frequency in kHz

Can this be in Hz? I thought there were some problems with kHz and Hz
before where we wanted to make this into Hz so that rounding problems
don't arise?

Also I wonder if all properties should be optional? I don't have this
scenario today, but perhaps the frequencies could be encoded in fuses,
but the voltages wouldn't be and so we might want to read out the
frequencies for a fixed set of voltages. Of course, if there's nothing
in the OPP node at all, it's not very useful, so perhaps some statement
that at least one of the frequency/voltage/amperage properties should be
present.

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

s/then/them/

> +  zero.
> +
> +- clock-latency-ns: Specifies the maximum possible transition latency (in
> +  nanoseconds) for switching to this OPP from any other OPP.
> +- turbo-mode: Marks the OPP to be used only for turbo modes.
> +- status: Marks the node enabled/disabled.

Please put some space between properties so they can be found quickly:

clock-latency-ns:

turbo-mode:

status:

...


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

