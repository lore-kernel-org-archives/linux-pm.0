From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V7 1/3] OPP: Add new bindings to address shortcomings
 of existing bindings
Date: Tue, 16 Jun 2015 08:34:02 -0500
Message-ID: <558025CA.8050008@ti.com>
References: <cover.1433434659.git.viresh.kumar@linaro.org> <d83c0b6b1768c7229384216329b607d13886aa02.1433434659.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43470 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756409AbbFPNey (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 16 Jun 2015 09:34:54 -0400
In-Reply-To: <d83c0b6b1768c7229384216329b607d13886aa02.1433434659.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, broonie@kernel.org, mike.turquette@linaro.org, sboyd@codeaurora.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 06/04/2015 11:20 AM, Viresh Kumar wrote:
> Current OPP (Operating performance point) device tree bindings have been
> insufficient due to the inflexible nature of the original bindings. Over
> time, we have realized that Operating Performance Point definitions and
> usage is varied depending on the SoC and a "single size (just frequency,
> voltage) fits all" model which the original bindings attempted and
> failed.
> 
> The proposed next generation of the bindings addresses by providing a
> expandable binding for OPPs and introduces the following common
> shortcomings seen with the original bindings:
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
> We now have multiple versions of OPP binding and only one of them should
> be used per device.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

I thought I had acked the patch 1 of the series as well in the list,
but looks like I have'nt.. So, for the record..

Acked-by: Nishanth Menon <nm@ti.com>


Thanks for doing this.

-- 
Regards,
Nishanth Menon
