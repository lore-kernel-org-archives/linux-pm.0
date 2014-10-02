From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/4] PM / Domains: Fix race conditions during boot
Date: Thu, 2 Oct 2014 12:07:43 +0200
Message-ID: <CAPDyKFpyGRtrRA4BuvkSHhvZ+DnMFYh-jS2k8VLKo1VMGSSgDw@mail.gmail.com>
References: <1412081033-8136-1-git-send-email-ulf.hansson@linaro.org>
	<6902885.zdj1puMRg5@vostro.rjw.lan>
	<CAPDyKFoUUyN2Tqt+RmiyVfB4ymqTiQ-TT1Z6ZvWS87ZGKi-Cog@mail.gmail.com>
	<2138676.3O5bPrOhTg@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:65465 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbaJBKHo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Oct 2014 06:07:44 -0400
Received: by mail-qa0-f51.google.com with SMTP id k15so1502462qaq.10
        for <linux-pm@vger.kernel.org>; Thu, 02 Oct 2014 03:07:43 -0700 (PDT)
In-Reply-To: <2138676.3O5bPrOhTg@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>

[...]

>> 1) Even if CONFIG_PM_RUNTIME is enabled, we have no mechanism to use
>> for drivers/subsystems to bring device's PM domains into powered state
>> before doing ->probe(). Well, of course, they could use
>> pm_runtime_get_sync() in that path, but that's just not the common
>> practice and there are good reasons to why.
>>
>> So, even if we figured out a solution for drivers/subsystems to
>> support the above, it's not reasonable to think we can adopt each of
>> them shortly. We need a fix in genpd.
>
> My concern is that if we change the default behavior today, people will see
> power regressions on some platforms.  Surely, power regressions are not as
> bad as functional regressions, but we can't say we don't care.
>
> Did you consider adding some handling of that to driver_probe_device()?
> We do a barrier in there, but conceivably we could do more if a PM domain
> is attached.

Forgot to comment on this.

I think the problem with such approach would be that the PM domain
hasn't yet been attached to the device, since that happens at
bus->probe().

Maybe we could find a solution which only affect the buses though and
not the drivers. But I need to think a bit more on this, before I can
post a proposal.

Kind regards
Uffe
