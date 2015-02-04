From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: RFC on cpufreq implementation
Date: Wed, 4 Feb 2015 09:42:48 +0530
Message-ID: <CAKohpokPseRu9jGEKc7gL+y8O6j8WvV72RCYzm_J-J4wKwf3eQ@mail.gmail.com>
References: <54B7F7CD.7030903@free.fr>
	<54CA6327.5070707@free.fr>
	<CAKohponrzDb4ZGvRtJ5jtGTPAy4RCfRsYGvdjR5fx51K2=evCg@mail.gmail.com>
	<54CC174F.10703@free.fr>
	<CAKohpomzCEjXUrxUJjypaA77=r4j_ZPa+x3gM=cNN0kc3ux0uQ@mail.gmail.com>
	<54D162B6.2050602@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:45020 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656AbbBDEMt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Feb 2015 23:12:49 -0500
Received: by mail-ob0-f175.google.com with SMTP id va2so14293130obc.6
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2015 20:12:49 -0800 (PST)
In-Reply-To: <54D162B6.2050602@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <mpeg.blue@free.fr>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>

On 4 February 2015 at 05:37, Mason <mpeg.blue@free.fr> wrote:
> All of them?
>
> ~/linux-3.19-rc7$ wc drivers/cpufreq/*
>  31542  95730 813482 total
>
> Are there perhaps 1 or 2 "golden standard" drivers that are well-written
> and up-to-date with respect to current conventions?

cpufreq-dt.c

> Like Samsung did with include/dt-bindings/clock/exynos*.h ?

Yeah.

> Are you saying that use of DeviceTree is mandatory for new ARM ports?

Yes.

> In other words, ports using "board files" will not be accepted into
> mainline, nor will drivers not using DT?

It wouldn't be good for you as well, that's all I can say.

> If that is correct, then my proposed cpufreq driver has exactly 0%
> chance of being mainlined as-is, right?

:)

> I took a look at cpufreq-dt.c but I think it doesn't quite fit my use-case.
> In my driver, I define "clock dividers" (typically 1,2,3,5,9) and these are
> used to divide some baseline frequency that the cpufreq code doesn't need to
> know. The baseline frequency is set by the boot loader, and Linux is not
> supposed to change that, only apply the dividers if necessary.
>
> What do you think of this use-case?

You need to write a backend clock driver for this. Most of the other platforms
are doing this. cpufreq-dt driver does clk_get(), clk_get_rate(), clk_set_rate()
and your backend driver should handle these to change the frequencies.
