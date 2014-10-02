From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/4] ARM: exynos: Ensure PM domains are powered at initialization
Date: Thu, 2 Oct 2014 11:55:25 +0200
Message-ID: <CAPDyKFqeU7nUXa=DD6X2mTHj6z+ZWfEo6rtQYdp11vm_ndyewA@mail.gmail.com>
References: <1412174494-15346-1-git-send-email-ulf.hansson@linaro.org>
	<1412174494-15346-3-git-send-email-ulf.hansson@linaro.org>
	<542C2972.9070002@samsung.com>
	<6158232.Yd6ncToJoF@vostro.rjw.lan>
	<CAPDyKFrRw-cATC0r7y6jyr2jiu2z8tKjETs0nmeOhEeuW8=hRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:60160 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbaJBJz0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Oct 2014 05:55:26 -0400
Received: by mail-qg0-f42.google.com with SMTP id z60so1677848qgd.29
        for <linux-pm@vger.kernel.org>; Thu, 02 Oct 2014 02:55:25 -0700 (PDT)
In-Reply-To: <CAPDyKFrRw-cATC0r7y6jyr2jiu2z8tKjETs0nmeOhEeuW8=hRg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Beat

On 2 October 2014 11:42, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 1 October 2014 21:50, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Wednesday, October 01, 2014 06:18:58 PM Sylwester Nawrocki wrote:
>>> On 01/10/14 16:41, Ulf Hansson wrote:
>>> > At ->probe() it's common practice for drivers/subsystems to bring their
>>> > devices to full power and without depending on CONFIG_PM_RUNTIME.
>>> >
>>> > We could also expect that drivers/subsystems requires their device's
>>> > corresponding PM domains to be powered, to successfully complete a
>>> > ->probe() sequence.
>>> >
>>> > Align to the behavior above, by ensuring all PM domains are powered
>>> > prior initialization of a generic PM domain.
>>> >
>>> > Do note, since the generic PM domain will try to power off unused PM
>>> > domains at late_init, there should be no increased power consumption
>>> > over time, but potentially during boot.
>>>
>>> Wouldn't it be a better idea to power on the power domains which are
>>> turned off only when CONFIG_PM_RUNTIME is not enabled ? I had a plan
>>> to submit a patch doing that but unfortunately this has fallen through
>>> the cracks. At the moment mach-exynos/pm_domains.c is not even built in
>>> when CONFIG_PM_RUNTIME is disabled.
>
> Yes, that's the approach I also intend to take in the next step.
>
> But, it's not that simple. Since this requires a mechanism for drivers
> to bring their device's PM domains into power state prior doing probe.
> We don't have such today. I do have some ideas about this, but I think
> we need to keep that as a separate discussion.
>
>>>
>>> I don't like the behaviour introduced in this patch to be the default,
>>> i.e. turning all possible power domains during boot sequence, even if
>>> some are not used and not needed. While we're trying to decrease the
>>> power consumption in any possible way this doesn't help at all.
>
> This will hit only during boot, until late_init. Unless you have a
> platform that keeps rebooting all the time, is this really a big
> worry?
>
> Still, I certainly agree that we should strive for a solution where
> it's possible to leave PM domains powered off at init. It's should be

/s/ It's should/ It shouldn't

> too hard to support this from genpd point of view, but
> drivers/subsystems will need some adaptations.
>
>>
>> Agreed (as stated before).
>>
>> And I'm wondering why that comment of mine was ignored?
>
> Sorry, if missed to comment of that. I guess I have at this point.
>
> Kind regards
> Uffe
