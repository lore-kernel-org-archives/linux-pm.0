From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Tue, 12 May 2015 11:04:50 -0500
Message-ID: <555224A2.7000308@ti.com>
References: <cover.1430394884.git.viresh.kumar@linaro.org> <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org> <554FFFA3.1060801@ti.com> <20150512051633.GB32300@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40868 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933059AbbELQFn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 12 May 2015 12:05:43 -0400
In-Reply-To: <20150512051633.GB32300@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, arnd.bergmann@linaro.org, broonie@kernel.org, mike.turquette@linaro.org, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

Hi Viresh,
On 05/12/2015 12:16 AM, Viresh Kumar wrote:
[..]
> On 10-05-15, 20:02, Nishanth Menon wrote:
>> On 04/30/2015 07:07 AM, Viresh Kumar wrote:

One additional comment - after re-reading the bindings again..
> 
> +- opp-microvolt: voltage in micro Volts. It can contain entries for multiple
> +  regulators.
> +
> +  A single regulator's voltage is specified with an array of size one or three.
> +  Single entry is for target voltage and three entries are for <target min max>
> +  voltages.

Just curious -> is'nt it better to just have min<->max range? binding
as it stands right now is open to interpretation as to what will be
attempted and in what sequence? with a valid min, target or max -
is'nt it more power efficient always to go for a "min" than a target?

Further, min<->max implies anywhere in that range and is more
consistent with "regulator like" description.


>> That said, flexibility of this approach is awesome, thanks for doing
>> this, I believe we did have a discussion about "safe OPP" for thermal
>> behavior -> now that we have phandles for OPPs, we  can give phandle
>> pointer to the thermal framework. in addition, we can also use phandle
>> for marking throttling information in thermal framework instead of
>> indices as well. which allows a lot of flexibility.
>>
>> in some systems, we'd have need to mark certain OPPs for entry into
>> suspend(tegra?) or during shutdown (for example) - do we allow for such
>> description as phandle pointer back to the OPP nodes (from cpu0 device)
>> OR do we describe them as additional properties?
> 
> Haven't thought about it earlier. In case we need them, probably it
> should go in the OPP table.

> 
> NOTE: Mike T. once told me that we shouldn't over-abuse the bindings
> by putting every detail there. And I am not sure at all on how to draw
> that line.

True. one option might be to allow for vendor specific property
extensions - that will let vendors add in additional quirky data
custom to their SoCs as needed.

> 
>>> +- status: Marks the node enabled/disabled.
>>
>> One question we'd probably want the new framework to address is the need
>> for OPPs based on Efuse options - Am I correct in believing that the
>> solution that iMX, and TI SoCs probably need is something similar to
>> modifying the status to disabled? or do we have Vendor specfic modifier
>> properties that would be allowed?
> 
> See PATCH 2/3 for that.

Sorry about that. I had kind of expected all bindings to be a single
patch :)..

>  
>> One additional behavior need I noticed in various old threads is a need
>> to restrict transition OPPs -> certain SoCs might have constraints on
>> next OPP they can transition from certain OPPs in-order to achieve a new
>> OPP. again, such behavior could be phandle lists OR properties that link
>> the chain up together. Number of such needs did sound less, but still
>> just thought to bring it up.
> 
> See 0/3 and 3/3 for that. Its present in my solution but Mike T. is
> strictly against keeping that in OPP table. And so 3/3 may get Nak'd.
> 

missed this as well :(


-- 
Regards,
Nishanth Menon
