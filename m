From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V5 11/14] soc: tegra: pmc: Add generic PM domain support
Date: Thu, 11 Feb 2016 10:57:30 +0100
Message-ID: <CAPDyKFrdmufsMqNL0U7q5gPEUqsg3SrkrNChcziQjEOjvd30Ng@mail.gmail.com>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
	<1453998832-27383-12-git-send-email-jonathanh@nvidia.com>
	<CAPDyKFpnUJA2pLSUOw8rkjyXLY6b__TM=38jsvYAZVhe+DS=zg@mail.gmail.com>
	<56BB7AF4.8040708@nvidia.com>
	<CAPDyKFrZ6tWBsQC0tyWWeChiZja3h_zcbaiX25ak-Zyp4MzqVw@mail.gmail.com>
	<56BC50C2.7050609@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:34468 "EHLO
	mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbcBKJ5b (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Feb 2016 04:57:31 -0500
Received: by mail-yw0-f181.google.com with SMTP id h129so35221887ywb.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Feb 2016 01:57:30 -0800 (PST)
In-Reply-To: <56BC50C2.7050609@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 11 February 2016 at 10:13, Jon Hunter <jonathanh@nvidia.com> wrote:
>
> On 10/02/16 18:25, Ulf Hansson wrote:
>
> [snip]
>
>>>> Perhaps there's a way to allow the generic PM domain to control this
>>>> by itself. If we for example used the struct device corresponding to
>>>> the powergate driver, genpd could use it to distinguish between
>>>> various instances of genpd structs..!? Maybe it would simplify the way
>>>> to deal with removing domains?
>>>
>>> Yes, that would be ideal. However, would have require changing
>>> genpd_init()? I am not sure how genpd would be able to access the device
>>> struct for the powergate driver because we don't provide this via any
>>> API I am aware of? And I am guessing that you don't wish to expose the
>>> gpd_list to the world either.
>>>
>>> If there is an easy way, I am open to it, but looking at it today, I am
>>> not sure I see a simple way in which we could add a new API to do this.
>>> However, may be I am missing something!
>>
>> If we add a new __pm_genpd_init() API, that could require a struct
>> device to be provided. That API will thus invoke the existing
>> pm_genpd_init() but also deal with the extra things needed here.
>>
>> I would also allow such an API to return an error code.
>>
>> Correspondingly, pm_genpd_remove() could be required to be provided
>> with a struct device.
>>
>> Existing users of pm_genpd_init() can then convert to
>> __pm_genpd_init() whenever suitable.
>>
>> Of course, another option is just to add new member in the genpd
>> struct for the struct *device. The caller of pm_genpd_init() could
>> check it, but allow it to be NULL. Although, the pm_genpd_remove() API
>> would require that pointer to the struct device to be set...
>>
>> What do you think?
>
> Yes, sounds good. May be it is simpler just to add a new member and let
> the platform genpd driver handle it.
>
> I am wondering if in addition to pm_genpd_remove(), we then just have a
> function called pm_genpd_remove_tail(), which allows you to pass the
> struct device pointer and will remove the last pm-domain from the
> gpd_list and return the genpd pointer if successful. Internally, it will
> call pm_genpd_remove(). It seems to me that if there are nested
> pm-domains, then we probably want to remove them starting from the tail
> as opposed to the head.
>
> How does that sound?

Why not make pm_genpd_remove() to behave as you describe for
pm_genpd_remove_tail()?
That's probably the only sane way to remove genpds anyhow!?

Kind regards
Uffe
