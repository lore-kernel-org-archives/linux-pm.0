From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V5 11/14] soc: tegra: pmc: Add generic PM domain support
Date: Thu, 11 Feb 2016 11:37:53 +0100
Message-ID: <CAPDyKFrhVqrJEx2W8E8At=tTiOVc_EN33T+Ozf6Y9o__pkrxuw@mail.gmail.com>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
	<1453998832-27383-12-git-send-email-jonathanh@nvidia.com>
	<CAPDyKFpnUJA2pLSUOw8rkjyXLY6b__TM=38jsvYAZVhe+DS=zg@mail.gmail.com>
	<56BB7AF4.8040708@nvidia.com>
	<CAPDyKFrZ6tWBsQC0tyWWeChiZja3h_zcbaiX25ak-Zyp4MzqVw@mail.gmail.com>
	<56BC50C2.7050609@nvidia.com>
	<CAPDyKFrdmufsMqNL0U7q5gPEUqsg3SrkrNChcziQjEOjvd30Ng@mail.gmail.com>
	<56BC5EE0.2040804@nvidia.com>
	<56BC61ED.6000201@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:33134 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbcBKKhy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Feb 2016 05:37:54 -0500
Received: by mail-yk0-f180.google.com with SMTP id z13so18971742ykd.0
        for <linux-pm@vger.kernel.org>; Thu, 11 Feb 2016 02:37:53 -0800 (PST)
In-Reply-To: <56BC61ED.6000201@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Alexandre Courbot <gnurou@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Pawel Moll <pawel.moll@arm.com>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Kumar Gala <galak@codeaurora.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

[...]

>>>
>>> Why not make pm_genpd_remove() to behave as you describe for
>>> pm_genpd_remove_tail()?
>>> That's probably the only sane way to remove genpds anyhow!?
>>
>> Simply to offer flexibility. I could see that for some devices that have
>> no dependencies between pm-domains and have a static list of pm-domains,
>> they can simply call pm_genpd_remove() for a given pm-domain. However,
>> that said, I can envision a case where a single pm-domain would be
>> removed by itself and so may be there is no benefit?
>
> By the way, do you think that instead of passing the struct device * to
> pm_genpd_remove(), we should just have a void *dev_id in the same way
> the request_irq()/free_irq() work? In other words, it would allow people
> to use the struct device or struct device_node, etc?

Hmm. Do you think that would make a difference for the power controller drivers?

I am thinking that genpd might perhaps benefit from being able to use
the device pointer for other purposes as well!?
Giving a void *, will prevent that, won't it?

Kind regards
Uffe
