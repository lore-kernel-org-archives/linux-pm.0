From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [RFC] OPP: Redefine bindings to overcome shortcomings
Date: Thu, 04 Dec 2014 12:34:28 +0100
Message-ID: <1417692868.9037.4.camel@pengutronix.de>
References: <52c403454c3b8fc201abe7ac74cf657638479311.1417691389.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49842 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753619AbaLDLee (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Dec 2014 06:34:34 -0500
In-Reply-To: <52c403454c3b8fc201abe7ac74cf657638479311.1417691389.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, arnd.bergmann@linaro.org, rob.herring@linaro.org, grant.likely@linaro.org, olof@lixom.net, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Sudeep.Holla@arm.com, sboyd@codeaurora.org, devicetree@vger.kernel.org, santosh.shilimkar@oracle.com, mike.turquette@linaro.org, kesavan.abhilash@gmail.com, catalin.marinas@arm.com, ta.omasab@gmail.com, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com

Hi Viresh,

not commenting on the overall structure as I have to think a bit more
about this. But small comments below.

Am Donnerstag, den 04.12.2014, 16:44 +0530 schrieb Viresh Kumar:
> Hi Rob, et al..
> 
> Current OPP (Operating performance point) DT bindings are proven to be
> insufficient at multiple instances.
> 
> There had been multiple band-aid approaches to get them fixed (The latest one
> being: http://www.mail-archive.com/devicetree@vger.kernel.org/msg53398.html).
> For obvious reasons Rob rejected them and shown the right path forward. And this
> is the first try to get those with a pen and paper.
> 
> The shortcomings we are trying to solve here:
> 
> - Some kind of compatibility string to probe the right cpufreq driver for
>   platforms, when multiple drivers are available. For example: how to choose
>   between cpufreq-dt and arm_big_little drivers.
> 
> - Getting clock sharing information between CPUs. Single shared clock vs.
>   independent clock per core vs. shared clock per cluster.
> 
> - Support for turbo modes
> 
> - Other per OPP settings: transition latencies, disabled status, etc.?
> 
> The below document should be enough to describe how I am trying to fix these.
> Please let me know what all I need to fix, surely there would be lots of
> obstacles. I am prepared to get beaten up :)
> 
> I accept in advance that naming is extremely bad here, I need some suggestions
> for sure.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/opp.txt | 147 ++++++++++++++++++++++++
>  1 file changed, 147 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
> index 74499e5..5efd8d4 100644
> --- a/Documentation/devicetree/bindings/power/opp.txt
> +++ b/Documentation/devicetree/bindings/power/opp.txt
> @@ -4,6 +4,153 @@ SoCs have a standard set of tuples consisting of frequency and
>  voltage pairs that the device will support per voltage domain. These
>  are called Operating Performance Points or OPPs.
>  
> +This documents defines OPP bindings with its required/optional properties.
> +OPPs can be defined for any device, this file uses CPU device as an example to
> +illustrate how to define OPPs.
> +
> +linux,operating-points, opp-lists and opps:
> +
> +- linux,operating-points:
> +  Container of all OPP nodes.
> +
> +  Required properties:
> +  - opp nodes (explained below)
> +
> +  Optional properties:
> +  - compatible: allow OPPs to express their compatibility with devices
> +
> +
> +- opp-list@*:
> +  List of nodes defining performance points. Following belong to the nodes
> +  within the opp-lists.
> +
> +  Required properties:
> +  - frequency-kHz: Frequency in kHz
> +  - voltage-uV: voltage in micro Volts
> +
> +  Optional properties:
> +  - turbo-mode: Marks the volt-freq pair as turbo pair.
> +  - status: Marks the node enabled/disabled.

What about devices with multiple different turbo states? We have seen
CPUs that boost to different states in the x86 world, surely we will
encounter something like this in the ARM world too. Do we just mark them
all as turbo OPPs and let the driver decide what to do? If we want to
keep using cpufreq-dt for as much devices as possible is it really
sufficient to know that this is a turbo state, without knowing the
conditions required for activating the state?

> +
> +
> +- opp@*:
> +  Operating performance point node per device. Multiple devices sharing it can
> +  use its phandle in their 'opp' property.
> +
> +  Required properties:
> +  - opp-list: phandle to opp-list defined above.
> +
> +  Optional properties:
> +  - clocks: Tuple of clock providers
> +  - clock-names: Clock names
> +  - opp-supply: phandle to the parent supply/regulator node
> +  - voltage-tolerance: Specify the CPU voltage tolerance in percentage.

This is extremely ill defined. It doesn't say in which direction the
tolerance is to be applied. Can you go below or above the OPP specified
voltage? For now everyone just assumes that it has to work both ways.
Also with this binding the tolerance is applied for all OPPs, where is
very much depends on the individual OPP.

If you are going to redefine OPPs anyway I would really like to see this
property die and rather have a min/max voltage per OPP. That way you can
properly express the OPP constraints. Most OPPs will likely allow a much
higher voltage than their minimal specified one, except when you go over
thermal limits with a high clock/voltage combination.

> +  - clock-latency: Specify the possible maximum transition latency for clock,
> +    in unit of nanoseconds.

Why do we need this? This is property of the clock. We should be able to
handle this completely internally in the kernel. I don't know if the
clock API has something like this right now, but it should be a trivial
addition.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

