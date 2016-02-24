From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH V5 11/14] soc: tegra: pmc: Add generic PM domain support
Date: Tue, 23 Feb 2016 16:03:32 -0800
Message-ID: <7h60xft1nv.fsf@baylibre.com>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
	<1453998832-27383-12-git-send-email-jonathanh@nvidia.com>
	<CAPDyKFpnUJA2pLSUOw8rkjyXLY6b__TM=38jsvYAZVhe+DS=zg@mail.gmail.com>
	<7hh9hdzflv.fsf@baylibre.com> <56C1B62B.5060708@nvidia.com>
	<CAPDyKFoPrFoMOFxC37zXX4L3VdLKknaw_LUTw7ycr9mfa_=7_A@mail.gmail.com>
	<56C5F1DA.2060705@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:32967 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbcBXADe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Feb 2016 19:03:34 -0500
Received: by mail-pa0-f50.google.com with SMTP id fl4so1447429pad.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Feb 2016 16:03:34 -0800 (PST)
In-Reply-To: <56C5F1DA.2060705@nvidia.com> (Jon Hunter's message of "Thu, 18
	Feb 2016 16:31:22 +0000")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Jon Hunter <jonathanh@nvidia.com> writes:

> On 18/02/16 16:00, Ulf Hansson wrote:
>> [...]
>> 
>>>>
>>>> What about the pm_clk_* API which was built for tracking clocks
>>>> associated with devices for runtime PM.
>>>>
>>>> IOW, you could pm_clk_add(pg->pmc->dev, pg->clks[i]) and then your
>>>> _enable_clocks() would become pm_clk_suspend() an dyour
>>>> _disable_clocks() would become pm_clk_resume().
>>>
>>> Very interesting, I was not aware of this.
>>>
>>>> I might not be following the mapping between PMC and PGs though so not
>>>> sure pg->pmc->dev is the right struct device, but you get the idea.
>>>
>>> Yes, so this will not work here as-is, because the pmc->dev is common to
>>> all pm-domains (it is the device that creates all the pm-domains). So to
>>> make this work, I would need to create a device for each pm-domain and
>>> add the clocks to that.
>>>
>>> I see that this works very well for normal drivers, but it does not feel
>>> so natural for pm-domains where we don't have a device struct today. By
>>> the way, the rockchip pm-domains implementation is very much in the same
>>> boat as tegra, where there are multiple clocks per pm-domain and it is
>>> handled by a simple list. So I am not sure if you think that we should
>>> be turning all pm-domains registered by pm_genpd_init() into a device
>>> and then we can make use of these pm_clk_XXXX() APIs?
>>>
>>> I have implemented the generic clk APIs that Ulf and I discussed for
>>> handling multiple clocks, but if we think that this is a better way,
>>> then I will hold off for now.
>> 
>> I think Kevin has a point that we already have PM clocks to build upon.
>> Could we perhaps try to extend that API instead to suite this needs as well?
>
> We certainly could and I am not against it, however, it means that we
> need to create a device structure for each pm-domain. If you and Kevin
> are ok with me adding this to pm_genpd_init(), then I can give it a try.

At this point, I'm thinking that the added complexity of a per-pm-domain
struct device isn't justified.  Managing simple lists of clocks in the
SoC specific PM domains is quite easy to review and maintain, IMO.

So I recommend just keeping it that way for now.  If it starts to get
unwieldy for tegra, rockchip and any others, we can revisit a common way
of doing it then.

Kevin

