From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC] fbdev: sh_mobile_hdmi: Re-init regs before irq
 re-enable on resume
Date: Wed, 24 Sep 2014 10:32:01 +0200
Message-ID: <CAMuHMdXoD6b-SNKKQpS6gzM_sDm4guepn1O1p_KK_7SyTC5CDQ@mail.gmail.com>
References: <1411474918-2955-1-git-send-email-geert+renesas@glider.be>
	<CAPDyKFrGiEJqHe2+SSNpUhBKfhGraqfomskUbemFmucszv8ukw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:36858 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984AbaIXIcE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Sep 2014 04:32:04 -0400
In-Reply-To: <CAPDyKFrGiEJqHe2+SSNpUhBKfhGraqfomskUbemFmucszv8ukw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Ulf,

On Tue, Sep 23, 2014 at 7:26 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 23 September 2014 14:21, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>> When the PM domain containing the HDMI hardware block is powered down,
>> the HDMI register values (incl. interrupt polarity settings) are lost.
>> During resume, after powering up the PM domain, interrupts are
>> re-enabled, and an interrupt storm happens due to incorrect interrupt
>> polarity settings:
>>
>>     irq 163: nobody cared (try booting with the "irqpoll" option)
>>     ...
>>     Disabling IRQ #163
>>
>> To fix this, re-initialize the interrupt polarity settings, and the
>> htop1 register block (if present), during resume.
>>
>> As the .suspend_noirq() and .resume_noirq() callbacks are not called
>> when using the generic PM domain, the normal .resume() callback is used,
>> and the device interrupt needs to be disabled/enabled manually.
>>
>> This fixes resume from s2ram with power down of the A4MP PM domain on
>> r8a7740/Armadillo.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> Is there a specific reason why the .suspend_noirq() and .resume_noirq()
>> callbacks are not called when using genpd, unlike .suspend(),
>> .suspend_late(), .resume_early(), and .resume()?
>
> Hi Geert,
>
> Interesting issue you are trying to fix here.
>
> In principle I consider the *noirq() callbacks in genpd as workarounds
> to handle the corner cases we had when using runtime PM and system PM
> together. This is at least how the OMAP PM domain uses them.
>
> Today, there are a better option which is to use
> pm_runtime_force_suspend|resume() and to declare the runtime PM
> callbacks within CONFIG_PM instead of CONFIG_PM_RUNTIME. I am actually
> working on a patchset that tries this approach, do you think that
> could solve your issue?

I don't follow 100% what you're telling me, but I don't think this would help:
the HDMI interrupt is used for HDMI hotplug detection, so it should stay
enabled even when the HDMI device is runtime suspended.
Only when the system is suspended, and the PM domain will be powered
down, the interrupt can be disabled.

After powering up the PM domain, but before the interrupt is enabled,
the registers must be restored.

> That said, I also think it's a bug in genpd to not invoke
> pm_generic_suspend|resume_noirq() from its corresponding callbacks. I
> think we should add them, but let's see if its trivial to do that. :-)

pm_genpd_suspend() and pm_genpd_suspend_late() call the
pm_generic_*() version if no genpd->suspend_power_off callback is
set up.

pm_genpd_suspend_noirq() does some really different things (i.e.
powering down the PM domain), so IMHO this isn't trivial to change.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
