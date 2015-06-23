From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] PM / Domains: Avoid infinite loops in attach/detach code
Date: Tue, 23 Jun 2015 15:45:43 +0200
Message-ID: <CAMuHMdU8sHuAKrRvVF1pV7FOCLYrdi1xfAiqb50tfJWhKK3jDQ@mail.gmail.com>
References: <1434622954-26747-3-git-send-email-geert+renesas@glider.be>
	<1434958282-27376-1-git-send-email-geert+renesas@glider.be>
	<CAPDyKFpRMrJZxZPv8w+jLEGAHu8U+AGSeG3LaJMXGW9zn__o+g@mail.gmail.com>
	<CAMuHMdX4cWmkx_W4P8vh6soZD_LzHJWgL=QpVUrKdubo2LaePg@mail.gmail.com>
	<CAJZ5v0j2RkjsWQkDkjZOf8mx12CvLzOzmLG3yRT-04naa9==HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:33425 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754585AbbFWNpo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2015 09:45:44 -0400
In-Reply-To: <CAJZ5v0j2RkjsWQkDkjZOf8mx12CvLzOzmLG3yRT-04naa9==HQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Magnus Damm <damm@opensource.se>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Rafael,

On Tue, Jun 23, 2015 at 3:38 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>> @@ -2218,10 +2227,13 @@ int genpd_dev_pm_attach(struct device *dev)
>>>>
>>>>         dev_dbg(dev, "adding to PM domain %s\n", pd->name);
>>>>
>>>> -       while (1) {
>>>> +       for (i = 0; i < GENPD_RETRIES; i++) {
>>>>                 ret = pm_genpd_add_device(pd, dev);
>>>>                 if (ret != -EAGAIN)
>>>>                         break;
>>>> +
>>>> +               if (i > GENPD_RETRIES / 2)
>>>> +                       udelay(GENPD_DELAY_US);
>>>
>>> In this execution path, we retry when getting -EAGAIN while believing
>>> the reason to the error are only *temporary* as we are soon waiting
>>> for all devices in the genpd to be system PM resumed. At least that's
>>> my understanding to why we want to deal with -EAGAIN here, but I might
>>> be wrong.
>>>
>>> In this regards, I wonder whether it could be better to re-try only a
>>> few times but with a far longer interval time than a couple us. What
>>> do you think?
>>
>> That's indeed viable. I have no idea for how long this temporary state can
>> extend.
>
> A usual approach to this kind of thing is to use exponential fallback
> where you increase the delay twice with respect to the previous one
> every time.

Right, but when do you give up?

Note that udelay() is a busy loop. Should it fall back to msleep() after
a while?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
