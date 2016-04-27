From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/4] clk: renesas: mstp: Use always-on governor for Clock Domain
Date: Wed, 27 Apr 2016 16:07:33 +0200
Message-ID: <CAPDyKFrSc8YdPc08eZ1usBOrNOkYxqY4BZnPTSk_1EDFpOWs-A@mail.gmail.com>
References: <1461654582-668-1-git-send-email-geert+renesas@glider.be>
	<1461654582-668-3-git-send-email-geert+renesas@glider.be>
	<CAPDyKFqApbcY9apg7dtGh=y71607c0hPHvEGDOo-skUTwCrUCg@mail.gmail.com>
	<CAMuHMdWyzbd8n-3+AZ16b9HL2prYQM2YXfcm8PKa_TbJ1QDQtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33672 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803AbcD0OHf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2016 10:07:35 -0400
Received: by mail-wm0-f53.google.com with SMTP id g17so8535763wme.0
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2016 07:07:34 -0700 (PDT)
In-Reply-To: <CAMuHMdWyzbd8n-3+AZ16b9HL2prYQM2YXfcm8PKa_TbJ1QDQtg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-clk <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-renesas-soc@vger.kernel.org

On 27 April 2016 at 16:04, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Ulf,
>
> On Wed, Apr 27, 2016 at 3:59 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 26 April 2016 at 09:09, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>>> As a pure Clock Domain does not have the concept of powering the domain
>>> itself, the CPG/MSTP driver does not provide power_off() and power_on()
>>> callbacks.
>>> However, the genpd core may still perform a dummy power down, causing
>>> /sys/kernel/debug/pm_genpd/pm_genpd_summary to report the domain's
>>> status being "off-0".
>>>
>>> Use the always-on governor to make sure the domain is never powered
>>> down, and always shows up as "on" in pm_genpd_summary.
>>
>> Hmm.
>>
>> Hypothetically, what if the clock domain would be a subdomain, where
>> its master is able to power down? Using the always on governor would
>> prevent the master from power off as well.
>
> That's correct. However, on R-Mobile/R-Car SoCs, this is not the case, so it
> doesn't matter here.
>
>> I am wondering whether we should introduce some similar as
>> pm_runtime_no_callbacks() but for the generic PM domain instead.
>>
>> What do you think?
>
> In my case, the domain is not managed by its parent, to there's no such
> analogy.

Ok, fair enough.

This looks good to me!

Kind regards
Uffe

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
