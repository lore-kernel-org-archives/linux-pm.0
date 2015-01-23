From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC V2] OPP: Redefine bindings to overcome shortcomings
Date: Fri, 23 Jan 2015 18:23:03 +0530
Message-ID: <CAKohpokdKby1_aUDTUDkNkYj3C9F83Hn--w7TS=Y-UE1ZdnW6w@mail.gmail.com>
References: <cbe949d7a69c3b16a3e9d6e5429eb81d3ae9d8b9.1422009157.git.viresh.kumar@linaro.org>
	<1422013154.29475.11.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:42786 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbbAWMxE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jan 2015 07:53:04 -0500
Received: by mail-ob0-f179.google.com with SMTP id vb8so6914567obc.10
        for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2015 04:53:03 -0800 (PST)
In-Reply-To: <1422013154.29475.11.camel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Arnd Bergmann <arnd.bergmann@linaro.org>, Rob Herring <rob.herring@linaro.org>, Grant Likely <grant.likely@linaro.org>, "olof@lixom.net" <olof@lixom.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Stephen Boyd <sboyd@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, santosh shilimkar <santosh.shilimkar@oracle.com>, Mike Turquette <mike.turquette@linaro.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Thomas Abraham <ta.omasab@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Mark Brown <broonie@kernel.org>

On 23 January 2015 at 17:09, Lucas Stach <l.stach@pengutronix.de> wrote:
> Am Freitag, den 23.01.2015, 16:14 +0530 schrieb Viresh Kumar:
>> I haven't incorporated the comments given by Mark Brown as I had some doubts.
>> @broonie: Is this what you wanted to mention earlier ? : http://pastebin.com/1RZTccmm
>>
>
> I think we should work this out for the new bindings, as
> voltage-tolerance is a completely bogus value.

Yeah, that's what I was saying. I just wanted to confirm that I understood
it clearly. And so didn't made the changes here.

>> +  - opp-microvolt: voltage in micro Volts
>
> Each OPP voltage should be defined by the triplet of minimum,
> nominal/typical, maximum. This lets you specify exact tolerances in each
> direction and should cover most use-cases.
>
> IMHO it would make sense to just define opp-microvolt as an array of
> those 3 values, so the DT doesn't get bloated with a lot more
> properties.
>
> A typical value for a CPU could then look like this:
> opp-microvolt = <800000 850000 1100000>
>
> For devices without any tolerance you can just specify the same value
> three times and be done with it:
> opp-microvolt = <900000 900000 900000>

Ok.

>> +  Optional properties:
>> +  - turbo-mode: Marks the volt-freq pair as turbo pair.
>> +  - status: Marks the node enabled/disabled.
>> +  - voltage-tolerance: Specify the CPU voltage tolerance in percentage.
>
> Please let's drop this.

Yes, I did dropped it in the pastebin link I gave above.

Thanks again for your feedback.
