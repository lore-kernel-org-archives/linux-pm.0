From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] dmaengine: shdma: Runtime-resume device in .shutdown()
Date: Wed, 4 Feb 2015 10:56:00 +0100
Message-ID: <CAMuHMdWYSSajAijZZ=VHAf3NjcgoW6t2X1XH8oMZ=mcDH742BQ@mail.gmail.com>
References: <1420454789-11547-1-git-send-email-geert+renesas@glider.be>
	<CAPDyKFoxfJa2Wq=mA0Khx7B3E6MbY99BYyHtCAoff_7V+9rSaw@mail.gmail.com>
	<20150204020835.GI4489@intel.com>
	<CAPDyKFoRnHjjGVn1zsOipnd7+BJU6xRTV8pgDKiC6+Nmh37SUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:42013 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965030AbbBDJ4B (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Feb 2015 04:56:01 -0500
In-Reply-To: <CAPDyKFoRnHjjGVn1zsOipnd7+BJU6xRTV8pgDKiC6+Nmh37SUQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Vinod Koul <vinod.koul@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Hi Ulf,

On Wed, Feb 4, 2015 at 10:35 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 4 February 2015 at 03:08, Vinod Koul <vinod.koul@intel.com> wrote:
>> On Mon, Feb 02, 2015 at 10:35:10AM +0100, Ulf Hansson wrote:
>>> On 5 January 2015 at 11:46, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>>> > During system reboot, the sh-dma-engine device may be runtime-suspended,
>>> > causing a crash:
>>> >
>>> >     Unhandled fault: imprecise external abort (0x1406) at 0x0002c02c
>>> >     Internal error: : 1406 [#1] SMP ARM
>>> >     ...
>>> >     PC is at sh_dmae_ctl_stop+0x28/0x64
>>> >     LR is at sh_dmae_ctl_stop+0x24/0x64
>>> >
>>> > If the sh-dma-engine is runtime-suspended, its module clock is turned
>>> > off, and its registers cannot be accessed.
>>> >
>>> > To fix this, change the driver's .shutdown() callback:
>>> >   - If the device is runtime suspended, do nothing,
>>> >   - Else, explicitly runtime-resume the device, to avoid the device from
>>> >     being suspended while sh_dmae_ctl_stop() is being executed.
>>> >
>>> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> > ---
>>> > v2:
>>> >   - Do nothing if we're runtime suspended.
>>> > ---
>>> >  drivers/dma/sh/shdmac.c | 6 ++++++
>>> >  1 file changed, 6 insertions(+)
>>> >
>>> > diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
>>> > index aec8a84784a469d7..2de30e8e7d9290b9 100644
>>> > --- a/drivers/dma/sh/shdmac.c
>>> > +++ b/drivers/dma/sh/shdmac.c
>>> > @@ -585,7 +585,13 @@ static void sh_dmae_chan_remove(struct sh_dmae_device *shdev)
>>> >  static void sh_dmae_shutdown(struct platform_device *pdev)
>>> >  {
>>> >         struct sh_dmae_device *shdev = platform_get_drvdata(pdev);
>>> > +
>>> > +       if (pm_runtime_suspended(&pdev->dev))
>>> > +               return;
>>> > +
>>> > +       pm_runtime_get_sync(&pdev->dev);
>>> >         sh_dmae_ctl_stop(shdev);
>>>
>>> I can't find that sh_dmae_ctl_stop() is invoked from the runtime PM
>>> suspend callback. That means the device will be "removed" differently,
>>> depending on it's runtime PM status (due to the upper check for
>>> pm_runtime_suspended() ) . Is that really what you want?
>> I think the patch description is the key. "During system reboot, the
>> sh-dma-engine device may be runtime-suspended, causing a crash"
>>
>> The runtime-suspended device is already idle and has removed its clock.
>
> That's not my point. The device will be shutdown differently,
> depending if it's runtime PM suspended or not.

You're right.

> So, if it's only about gating clocks then why do even bother invoking
> sh_dmae_ctl_stop() in this path.

sh_dmae_ctl_stop() stops the DMA controller.  But this is the "master stop".
At this time, the individual channels should have been stopped by dmae_halt().

So you prefer my V1 patch instead, which unconditionally runtime-resumed
the device, so sh_dmae_ctl_stop() can be called?
http://www.spinics.net/lists/dmaengine/msg02954.html

Alternatively...

Both sh_dmae_resume() and sh_dmae_runtime_resume() call sh_dmae_rst(),
which re-initializes the DMAOR register.
To make it symmetric, we can move the call to sh_dmae_ctl_stop() to
sh_dmae_suspend() and sh_dmae_runtime_suspend() instead?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
