From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH V3] PM / Runtime: Defer resuming of the device in pm_runtime_force_resume()
Date: Fri, 18 Nov 2016 09:07:04 +0100
Message-ID: <CAMuHMdUUUMZP_eSsO1+GJE7C4k40XFM6UPmO6EcUc1WJgBAXtQ@mail.gmail.com>
References: <1476370734-23168-1-git-send-email-ulf.hansson@linaro.org> <CAPDyKFp5Ay1dN2UQauD7vHxPQP+kghviAAduhpHO7QAmH-1UiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:35513 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751617AbcKRIHG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Nov 2016 03:07:06 -0500
Received: by mail-it0-f68.google.com with SMTP id b123so2741456itb.2
        for <linux-pm@vger.kernel.org>; Fri, 18 Nov 2016 00:07:06 -0800 (PST)
In-Reply-To: <CAPDyKFp5Ay1dN2UQauD7vHxPQP+kghviAAduhpHO7QAmH-1UiA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Walleij <linus.walleij@linaro.org>

Hi Ulf,

On Thu, Nov 17, 2016 at 9:21 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 13 October 2016 at 16:58, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> When the pm_runtime_force_suspend|resume() helpers were invented, we still
>> had CONFIG_PM_RUNTIME and CONFIG_PM_SLEEP as separate Kconfig options.
>>
>> To make sure these helpers worked for all combinations and without
>> introducing too much of complexity, the device was always resumed in
>> pm_runtime_force_resume().
>>
>> More precisely, when CONFIG_PM_SLEEP was set and CONFIG_PM_RUNTIME was
>> unset, we needed to resume the device as the subsystem/driver couldn't
>> rely on using runtime PM to do it.
>>
>> As the CONFIG_PM_RUNTIME option was merged into CONFIG_PM a while ago, it
>> removed this combination, of using CONFIG_PM_SLEEP without the earlier
>> CONFIG_PM_RUNTIME.
>>
>> For this reason we can now rely on the subsystem/driver to use runtime PM
>> to resume the device, instead of forcing that to be done in all cases. In
>> other words, let's defer the runtime resume to a later point when it's
>> actually needed.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Rafael, this one is ready to be queued. Unless there are other objections.
>
> The problems that was reported by Geert for this change, has been
> taken care of. Those are fixed by the patch for the smsc911x ethernet
> driver [1], which you queued a while ago.
> I realized that wasn't obvious unless one digested the conversations in detail.

> [1]
> https://www.spinics.net/lists/netdev/msg401339.html

That's correct, thanks again for that fix!

> Geert, perhaps you can confirm by providing a tested-by tag?

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
