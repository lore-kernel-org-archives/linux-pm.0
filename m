From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH/RFC] fbdev: sh_mobile_hdmi: Re-init regs before irq
 re-enable on resume
Date: Tue, 30 Sep 2014 12:43:36 +0200
Message-ID: <CAPDyKFoPUEuMEbedFARhQzJy5sFgw8w++KZk=H7CE946tiO77g@mail.gmail.com>
References: <1411474918-2955-1-git-send-email-geert+renesas@glider.be>
	<542A84F7.5020005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:46849 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbaI3Knh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Sep 2014 06:43:37 -0400
Received: by mail-qa0-f51.google.com with SMTP id k15so2146633qaq.24
        for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2014 03:43:36 -0700 (PDT)
In-Reply-To: <542A84F7.5020005@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On 30 September 2014 12:24, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> Hi Geert, Ulf,
>
> On 23/09/14 15:21, Geert Uytterhoeven wrote:
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
>> ---
>>  drivers/video/fbdev/sh_mobile_hdmi.c | 44 ++++++++++++++++++++++++++++++++++--
>>  1 file changed, 42 insertions(+), 2 deletions(-)
>
> Should I queue this version for 3.18, or is there some modifications you
> think needs to be done first?

I have no objections for this patch. Please go ahead.

The reason for my comments was to try to figure out if there were any
impact to the generic PM domain.

Kind regards
Uffe
