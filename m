From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC] fbdev: sh_mobile_hdmi: Re-init regs before irq
 re-enable on resume
Date: Wed, 24 Sep 2014 15:42:36 +0200
Message-ID: <CAMuHMdXtY8_qY1k63t6ubKa6DbS0kNDTNe=w3am=Jf_gYt4f5A@mail.gmail.com>
References: <1411474918-2955-1-git-send-email-geert+renesas@glider.be>
	<CAPDyKFrGiEJqHe2+SSNpUhBKfhGraqfomskUbemFmucszv8ukw@mail.gmail.com>
	<CAMuHMdXoD6b-SNKKQpS6gzM_sDm4guepn1O1p_KK_7SyTC5CDQ@mail.gmail.com>
	<CAPDyKFoGuKsDVnHfALRRtXu8kxXvUG-a-7308VRo=KQP7wAaRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:62422 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645AbaIXNmi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Sep 2014 09:42:38 -0400
In-Reply-To: <CAPDyKFoGuKsDVnHfALRRtXu8kxXvUG-a-7308VRo=KQP7wAaRQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Ulf,

On Wed, Sep 24, 2014 at 3:07 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 24 September 2014 10:32, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Tue, Sep 23, 2014 at 7:26 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> On 23 September 2014 14:21, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>>>> When the PM domain containing the HDMI hardware block is powered down,
>>>> the HDMI register values (incl. interrupt polarity settings) are lost.
>>>> During resume, after powering up the PM domain, interrupts are
>>>> re-enabled, and an interrupt storm happens due to incorrect interrupt
>>>> polarity settings:
>>>>
>>>>     irq 163: nobody cared (try booting with the "irqpoll" option)
>>>>     ...
>>>>     Disabling IRQ #163
>>>>
>>>> To fix this, re-initialize the interrupt polarity settings, and the
>>>> htop1 register block (if present), during resume.
>>>>
>>>> As the .suspend_noirq() and .resume_noirq() callbacks are not called
>>>> when using the generic PM domain, the normal .resume() callback is used,
>>>> and the device interrupt needs to be disabled/enabled manually.
>>>>
>>>> This fixes resume from s2ram with power down of the A4MP PM domain on
>>>> r8a7740/Armadillo.
>>>>
>>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>>> ---
>>>> Is there a specific reason why the .suspend_noirq() and .resume_noirq()
>>>> callbacks are not called when using genpd, unlike .suspend(),
>>>> .suspend_late(), .resume_early(), and .resume()?
>>>
>>> Hi Geert,
>>>
>>> Interesting issue you are trying to fix here.
>>>
>>> In principle I consider the *noirq() callbacks in genpd as workarounds
>>> to handle the corner cases we had when using runtime PM and system PM
>>> together. This is at least how the OMAP PM domain uses them.
>>>
>>> Today, there are a better option which is to use
>>> pm_runtime_force_suspend|resume() and to declare the runtime PM
>>> callbacks within CONFIG_PM instead of CONFIG_PM_RUNTIME. I am actually
>>> working on a patchset that tries this approach, do you think that
>>> could solve your issue?
>>
>> I don't follow 100% what you're telling me, but I don't think this would help:
>> the HDMI interrupt is used for HDMI hotplug detection, so it should stay
>> enabled even when the HDMI device is runtime suspended.
>> Only when the system is suspended, and the PM domain will be powered
>> down, the interrupt can be disabled.
>>
>> After powering up the PM domain, but before the interrupt is enabled,
>> the registers must be restored.
>
> I checked the details about the runtime PM support in the driver. To
> me, it seems there are some additional pieces missing.
>
> For a short while, let's just ignore the behaviour of the generic PM
> domain. Then I would suggest to add the following below to the driver.
> Please tell me if you think I am wrong, I don't no much about ALSA and HDMI. :-)
>
> 1) Add a runtime PM suspend callback to:
> - Save register context.
> - Enable wakeup IRQ if "wakeup IRQ capabilities" is set.
>
> 2) Add a runtime PM resume callback to:
> - Restore register context.
> - Disable wakeup IRQ.
>
> 3) Add a system PM suspend callback to:
> - Disable "wakeup IRQ capabilities".
> - Put the device into low power state.
> Could likely be done by:
>     pm_runtime_get_sync();
>     "disable wakeup irq cap";
>     pm_runtime_put();
>     pm_runtime_force_suspend();
>
> 4) Add a system PM resume callback to:
> - Enable "wakeup IRQ capabilities".
> - Restore power to the device.
> Could likely be done by:
>     "enable wakeup irq_cap";
>     pm_runtime_force_resume();

Thanks, those changes all look OK to me.

Unfortunately I do not have documentation for the HDMI hardware block,
and I am not in the position to do proper regression testing (the driver
doesn't really work on the hardware I do have), so I don't plan to implement
these changes.

> 5) Currently the ->probe() method invokes pm_runtime_get_sync(),
> causing the runtime PM resume callbacks to be invoked in this path.
> Unless I am missing a point, this will cause the device stay runtime
> PM resumed all the time. Is that really what you want?

That's correct. Right now the device is never runtime-suspended.
Given my above reasoning, I think that's fine for now. I just wanted to fix
the most severe issue (a system lock-up).

> In this context, and what I am trying to understand, is what changes
> are needed to the generic PM domain, such it can be used under these
> circumstances.

It seems no changes are needed to the generic PM domain.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
