From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2] dmaengine: shdma: Runtime-resume device in .shutdown()
Date: Thu, 5 Feb 2015 12:17:08 -0800
Message-ID: <20150205201708.GC16547@intel.com>
References: <1420454789-11547-1-git-send-email-geert+renesas@glider.be>
 <CAPDyKFoxfJa2Wq=mA0Khx7B3E6MbY99BYyHtCAoff_7V+9rSaw@mail.gmail.com>
 <20150204020835.GI4489@intel.com>
 <CAPDyKFoRnHjjGVn1zsOipnd7+BJU6xRTV8pgDKiC6+Nmh37SUQ@mail.gmail.com>
 <CAMuHMdWYSSajAijZZ=VHAf3NjcgoW6t2X1XH8oMZ=mcDH742BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWYSSajAijZZ=VHAf3NjcgoW6t2X1XH8oMZ=mcDH742BQ@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 04, 2015 at 10:56:00AM +0100, Geert Uytterhoeven wrote:
> >>> I can't find that sh_dmae_ctl_stop() is invoked from the runtime PM
> >>> suspend callback. That means the device will be "removed" differently,
> >>> depending on it's runtime PM status (due to the upper check for
> >>> pm_runtime_suspended() ) . Is that really what you want?
> >> I think the patch description is the key. "During system reboot, the
> >> sh-dma-engine device may be runtime-suspended, causing a crash"
> >>
> >> The runtime-suspended device is already idle and has removed its clock.
> >
> > That's not my point. The device will be shutdown differently,
> > depending if it's runtime PM suspended or not.
> 
> You're right.
> 
> > So, if it's only about gating clocks then why do even bother invoking
> > sh_dmae_ctl_stop() in this path.
> 
> sh_dmae_ctl_stop() stops the DMA controller.  But this is the "master stop".
> At this time, the individual channels should have been stopped by dmae_halt().
> 
> So you prefer my V1 patch instead, which unconditionally runtime-resumed
> the device, so sh_dmae_ctl_stop() can be called?
> http://www.spinics.net/lists/dmaengine/msg02954.html
That forces device to resume when we are doinga  shutdown...
> 
> Alternatively...
> 
> Both sh_dmae_resume() and sh_dmae_runtime_resume() call sh_dmae_rst(),
> which re-initializes the DMAOR register.
> To make it symmetric, we can move the call to sh_dmae_ctl_stop() to
> sh_dmae_suspend() and sh_dmae_runtime_suspend() instead?
I think thats a btter idea..

-- 
~Vinod

