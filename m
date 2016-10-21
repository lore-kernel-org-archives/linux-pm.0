From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH V3] PM / Runtime: Defer resuming of the device in pm_runtime_force_resume()
Date: Fri, 21 Oct 2016 10:51:08 +0200
Message-ID: <CAMuHMdVUMKPAYrPHuOUTYmyMf21NLgJUErOn7-4=OdNWUaJ99w@mail.gmail.com>
References: <1476370734-23168-1-git-send-email-ulf.hansson@linaro.org>
 <CAMuHMdW8D9WbsYw0H38Lq0WcRya1Hx8LM_XKPVO3pYcZAcojxQ@mail.gmail.com> <CAPDyKFopV=oLQ6nHpkw04cFE_jp5gMR3TpM4Skv242Pxf7JmGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:36247 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752463AbcJUIvJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Oct 2016 04:51:09 -0400
Received: by mail-it0-f65.google.com with SMTP id 66so10067798itl.3
        for <linux-pm@vger.kernel.org>; Fri, 21 Oct 2016 01:51:09 -0700 (PDT)
In-Reply-To: <CAPDyKFopV=oLQ6nHpkw04cFE_jp5gMR3TpM4Skv242Pxf7JmGg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>

Hi Ulf,

On Fri, Oct 21, 2016 at 10:42 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 18 October 2016 at 15:50, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Thu, Oct 13, 2016 at 4:58 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> When the pm_runtime_force_suspend|resume() helpers were invented, we still
>>> had CONFIG_PM_RUNTIME and CONFIG_PM_SLEEP as separate Kconfig options.
>>>
>>> To make sure these helpers worked for all combinations and without
>>> introducing too much of complexity, the device was always resumed in
>>> pm_runtime_force_resume().
>>>
>>> More precisely, when CONFIG_PM_SLEEP was set and CONFIG_PM_RUNTIME was
>>> unset, we needed to resume the device as the subsystem/driver couldn't
>>> rely on using runtime PM to do it.
>>>
>>> As the CONFIG_PM_RUNTIME option was merged into CONFIG_PM a while ago, it
>>> removed this combination, of using CONFIG_PM_SLEEP without the earlier
>>> CONFIG_PM_RUNTIME.
>>>
>>> For this reason we can now rely on the subsystem/driver to use runtime PM
>>> to resume the device, instead of forcing that to be done in all cases. In
>>> other words, let's defer the runtime resume to a later point when it's
>>> actually needed.
>>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> ---
>>>
>>> Changes in v3:
>>>         - Updated to take care of parent-child relations.
>>>         - Improved comment in the code and updated text in a function header
>>>         to better describe the changes.
>>
>> Thanks for the update!
>>
>>> This patch has earlier been sent standalone, but also as a part of series. In
>>> the end it turned out the solution needed some improvement to take care of
>>> parent-child relations, as reported by Geert [1].
>>>
>>> Geert, I would really appreciate if you could help out testing to make sure the
>>> reported issue is fixed.
>>
>> Unfortunately it doesn't help. Still fails on both r8a73a4/ape6evm and
>> sh73a0/kzm9g.
>
> Again, thanks for testing! Seems like we need to debug this a bit more. :-)
>
> I have more or less set up the similar environment as you have, using
> the simple PM bus, and having a child device below it. The child
> device is being operated by my runtime PM test-driver - and both
> devices are in a genpd.
>
> Anyway, I will continue to look into this via my test environment, but
> in the end we probably need to add some debug code in the PM callbacks
> of the real drivers (and HW) at your side. I hope you are willing to
> help a little with that. Allow me to send you a debug patch within a
> couple of days, hopefully that will give us some answers. Unless, you
> have other ideas for how to proceed?

No problem. I can easily test a debug patch.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
