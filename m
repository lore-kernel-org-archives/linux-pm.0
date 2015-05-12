From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V4 2/3] OPP: Allow multiple OPP tables to be passed via
 DT
Date: Tue, 12 May 2015 11:09:04 -0500
Message-ID: <555225A0.8050707@ti.com>
References: <cover.1430394884.git.viresh.kumar@linaro.org> <d734a94af2263285fe8cef9f177212f15f218944.1430394884.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59260 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753036AbbELQJx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 12 May 2015 12:09:53 -0400
In-Reply-To: <d734a94af2263285fe8cef9f177212f15f218944.1430394884.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, arnd.bergmann@linaro.org, broonie@kernel.org, mike.turquette@linaro.org, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 04/30/2015 07:08 AM, Viresh Kumar wrote:
> On some platforms (Like Qualcomm's SoCs), it is not decided until
> runtime on what OPPs to use. The OPP tables can be fixed at compile
> time, but which table to use is found out only after reading some efuses
> (sort of an eeprom) and knowing characteristics of the SoC.

they are more like prom than eeprom in many instances.

> 
> To support such platform we need to pass multiple OPP tables per device
> and hardware should be able to choose one and only one table out of
> those.
> 
> Update OPP-v2 bindings to support that.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/opp.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
> index 3b67a5c8d965..07959903ec32 100644
> --- a/Documentation/devicetree/bindings/power/opp.txt
> +++ b/Documentation/devicetree/bindings/power/opp.txt
> @@ -14,6 +14,9 @@ Devices supporting OPPs must set their "operating-points-v2" property with
>  phandle to a OPP descriptor in their DT node. The OPP core will use this phandle
>  to find the operating points for the device.
>  
> +Devices may want to choose OPP tables at runtime and so can provide a list of
> +phandles here. But only *one* of them should be chosen at runtime.
> +
>  
>  * OPP Descriptor Node
>  
> @@ -28,6 +31,8 @@ This describes the OPPs belonging to a device. This node can have following
>    reference an OPP.
>  
>  Optional properties:
> +- opp-name: Name of the OPP table, to uniquely identify it if more than one OPP
> +  table is supplied in "operating-points-v2" property of device.
>  - shared-opp: Indicates that device nodes using this OPP descriptor's phandle
>    switch their DVFS state together, i.e. they share clock/voltage/current lines.
>    Missing property means devices have independent clock/voltage/current lines,
> 

With some SoCs like AM335x - thanks to some brain dead incompatible
hardware design choices, this might end up as a big list or various
OPP tables. but overall, I must prefer this approach as well.

Thanks for proposing this. will be great to see examples documented in
bindings doc as well.

With no further issues,
Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
