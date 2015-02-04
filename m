From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2] dmaengine: shdma: Runtime-resume device in .shutdown()
Date: Tue, 3 Feb 2015 18:08:35 -0800
Message-ID: <20150204020835.GI4489@intel.com>
References: <1420454789-11547-1-git-send-email-geert+renesas@glider.be>
 <CAPDyKFoxfJa2Wq=mA0Khx7B3E6MbY99BYyHtCAoff_7V+9rSaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:3186 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965120AbbBDCKf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 3 Feb 2015 21:10:35 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFoxfJa2Wq=mA0Khx7B3E6MbY99BYyHtCAoff_7V+9rSaw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Mon, Feb 02, 2015 at 10:35:10AM +0100, Ulf Hansson wrote:
> On 5 January 2015 at 11:46, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > During system reboot, the sh-dma-engine device may be runtime-suspended,
> > causing a crash:
> >
> >     Unhandled fault: imprecise external abort (0x1406) at 0x0002c02c
> >     Internal error: : 1406 [#1] SMP ARM
> >     ...
> >     PC is at sh_dmae_ctl_stop+0x28/0x64
> >     LR is at sh_dmae_ctl_stop+0x24/0x64
> >
> > If the sh-dma-engine is runtime-suspended, its module clock is turned
> > off, and its registers cannot be accessed.
> >
> > To fix this, change the driver's .shutdown() callback:
> >   - If the device is runtime suspended, do nothing,
> >   - Else, explicitly runtime-resume the device, to avoid the device from
> >     being suspended while sh_dmae_ctl_stop() is being executed.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > v2:
> >   - Do nothing if we're runtime suspended.
> > ---
> >  drivers/dma/sh/shdmac.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
> > index aec8a84784a469d7..2de30e8e7d9290b9 100644
> > --- a/drivers/dma/sh/shdmac.c
> > +++ b/drivers/dma/sh/shdmac.c
> > @@ -585,7 +585,13 @@ static void sh_dmae_chan_remove(struct sh_dmae_device *shdev)
> >  static void sh_dmae_shutdown(struct platform_device *pdev)
> >  {
> >         struct sh_dmae_device *shdev = platform_get_drvdata(pdev);
> > +
> > +       if (pm_runtime_suspended(&pdev->dev))
> > +               return;
> > +
> > +       pm_runtime_get_sync(&pdev->dev);
> >         sh_dmae_ctl_stop(shdev);
> 
> I can't find that sh_dmae_ctl_stop() is invoked from the runtime PM
> suspend callback. That means the device will be "removed" differently,
> depending on it's runtime PM status (due to the upper check for
> pm_runtime_suspended() ) . Is that really what you want?
I think the patch description is the key. "During system reboot, the
sh-dma-engine device may be runtime-suspended, causing a crash"

The runtime-suspended device is already idle and has removed its clock.

-- 
~Vinod

