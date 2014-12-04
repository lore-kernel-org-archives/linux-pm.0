From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC] OPP: Redefine bindings to overcome shortcomings
Date: Thu, 4 Dec 2014 19:37:11 +0530
Message-ID: <CAKohponP3PXd5b=YY7bpBK6FTNc5_Y7RU=X7q7dP1bYELcW6Dw@mail.gmail.com>
References: <52c403454c3b8fc201abe7ac74cf657638479311.1417691389.git.viresh.kumar@linaro.org>
	<1417692868.9037.4.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:45286 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937AbaLDOHM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Dec 2014 09:07:12 -0500
Received: by mail-ob0-f174.google.com with SMTP id nt9so6492136obb.33
        for <linux-pm@vger.kernel.org>; Thu, 04 Dec 2014 06:07:12 -0800 (PST)
In-Reply-To: <1417692868.9037.4.camel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Arnd Bergmann <arnd.bergmann@linaro.org>, Rob Herring <rob.herring@linaro.org>, Grant Likely <grant.likely@linaro.org>, "olof@lixom.net" <olof@lixom.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Stephen Boyd <sboyd@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, santosh shilimkar <santosh.shilimkar@oracle.com>, Mike Turquette <mike.turquette@linaro.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Thomas Abraham <ta.omasab@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Hi Lucas,

On 4 December 2014 at 17:04, Lucas Stach <l.stach@pengutronix.de> wrote:

>> +- opp-list@*:
>> +  List of nodes defining performance points. Following belong to the nodes
>> +  within the opp-lists.
>> +
>> +  Required properties:
>> +  - frequency-kHz: Frequency in kHz
>> +  - voltage-uV: voltage in micro Volts
>> +
>> +  Optional properties:
>> +  - turbo-mode: Marks the volt-freq pair as turbo pair.
>> +  - status: Marks the node enabled/disabled.
>
> What about devices with multiple different turbo states? We have seen

You mean that a state may or maynot be turbo at some point of time ?

> CPUs that boost to different states in the x86 world, surely we will
> encounter something like this in the ARM world too. Do we just mark them
> all as turbo OPPs and let the driver decide what to do? If we want to

Maybe yes. But the good thing about binding this time is, it is expandable.
So, if there is a future need that we can't think of today, then we can surely
do incremental changes here.

> keep using cpufreq-dt for as much devices as possible is it really

Its not about cpufreq-dt alone. We maybe using other drivers as well..

> sufficient to know that this is a turbo state, without knowing the
> conditions required for activating the state?

Can you elaborate more on this? If something is required and we
know what exactly it is, then we can put up the right binding right
now as well..

>> +- opp@*:
>> +  Operating performance point node per device. Multiple devices sharing it can
>> +  use its phandle in their 'opp' property.
>> +
>> +  Required properties:
>> +  - opp-list: phandle to opp-list defined above.
>> +
>> +  Optional properties:
>> +  - clocks: Tuple of clock providers
>> +  - clock-names: Clock names
>> +  - opp-supply: phandle to the parent supply/regulator node
>> +  - voltage-tolerance: Specify the CPU voltage tolerance in percentage.
>
> This is extremely ill defined. It doesn't say in which direction the
> tolerance is to be applied. Can you go below or above the OPP specified
> voltage? For now everyone just assumes that it has to work both ways.

Yes, the binding is as per today's requirements (or rather implementations).
So it is both ways. But if everybody agrees on it, we can improve it..

> Also with this binding the tolerance is applied for all OPPs, where is
> very much depends on the individual OPP.

Hmm, Not only this but the same is true for clock latency as well. We
*may* need that per opp node sometime..

> If you are going to redefine OPPs anyway I would really like to see this
> property die and rather have a min/max voltage per OPP. That way you can

Maybe yes.

> properly express the OPP constraints. Most OPPs will likely allow a much
> higher voltage than their minimal specified one, except when you go over
> thermal limits with a high clock/voltage combination.

Yes.

>> +  - clock-latency: Specify the possible maximum transition latency for clock,
>> +    in unit of nanoseconds.
>
> Why do we need this? This is property of the clock. We should be able to
> handle this completely internally in the kernel. I don't know if the
> clock API has something like this right now, but it should be a trivial
> addition.

This is not only clock's latency, but is somehow named this way. This should
give the time it takes to change from frequency A to frequency B, which include
change in supplies as well.. So, this probably is dvfs-latency ..

This is required by cpufreq right now, but would be useful for the energy aware
scheduler as well. So, yes this is important. Also, it might also be required to
be per OPP...

Probably we can use voltage-tolerance and clock-latency at both
levels. list-level
and OPP level. list level being at higher priority ?

Thanks for your quick comments :)
