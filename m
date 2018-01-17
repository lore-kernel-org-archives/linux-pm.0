From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/2] PM / core: genpd fix and pm_runtime_force_suspend|resume()
 rework
Date: Wed, 17 Jan 2018 10:14:23 +0100
Message-ID: <CAMuHMdWR+V8d3geQutKr+f+e7+H2D9k-2_-5kJp-4n0rzMXoWA@mail.gmail.com>
References: <4928977.5hd79RbQlp@aspire.rjw.lan> <CAMuHMdX6dJzOcxkWyDR6anpcwZU5fy03sTeChEp35KY0d40iFg@mail.gmail.com>
 <12351114.Ym7QOfxZhK@aspire.rjw.lan> <CAMuHMdVaiuscrvat=BqtmXxQnA35=wocb85FHEFvQWjQaY615g@mail.gmail.com>
 <CAJZ5v0i5FhKCtvcvS_PfpFQKo-zjExT4YypYaaTC7JD5kX-kew@mail.gmail.com>
 <CAMuHMdVEwHhjfCppYXKYX6viFrunCmH00wH6zUFNo4p5CdJCww@mail.gmail.com>
 <CAMuHMdWLkji-GwtFW=RTW12bg_k01DgFocALt6fFF3bGAy6HAg@mail.gmail.com>
 <CAPDyKFq6a=sj_E5Nz9bSB=6rqWq+ar2MuwcrxJAcu36N+C+m2Q@mail.gmail.com> <CAJZ5v0hEVdARvFQo7ma3F756aE0+3vbqu+-L7Ffw0rgpWYt2rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:40908 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750816AbeAQJOZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jan 2018 04:14:25 -0500
In-Reply-To: <CAJZ5v0hEVdARvFQo7ma3F756aE0+3vbqu+-L7Ffw0rgpWYt2rA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Rafael,

On Mon, Jan 15, 2018 at 5:17 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Mon, Jan 15, 2018 at 3:26 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 15 January 2018 at 14:22, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> [cut]
>
>>>
>>> I did miss a small difference in topology: in pm/linux-next, H3 has DMA
>>> enabled for SCIF2, while M3 hasn't (yet).
>>> With DMA enabled on M3, it fails in the same way.
>>>
>>> As genpd_resume_noirq() no longer calls pm_runtime_force_resume(),
>>> rcar_dmac_runtime_resume() is no longer called, and the DMAC's registers
>>> are no longer reinitialized after system resume, breaking the serial port.
>>
>> In drivers/dma/sh/rcar-dmac.c, I would try to replace the below line:
>> SET_SYSTEM_SLEEP_PM_OPS(rcar_dmac_sleep_suspend, rcar_dmac_sleep_resume)
>>
>> with:
>> SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
>
> Yes, that probably is the least intrusive thing that can be done to
> address the issue.
>
>> in case that may be too early to suspend the dma device (which is
>> rather common for dma devices) then try;
>>
>> SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
>
> Good suggestion, and I would go straight for it anyway.
>
> Geert, can you try if this works, please?

Works. Both using SET_SYSTEM_SLEEP_PM_OPS() and
SET_LATE_SYSTEM_SLEEP_PM_OPS(). But given this is a DMA engine
driver, I'd settle for the latter.

And I did verify doing so doesn't break the system without the patch
in $subject.

Thanks!

Will send a patch...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
