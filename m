From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] dmaengine: shdma: Runtime-resume device in .shutdown()
Date: Sun, 7 Dec 2014 17:23:44 +0530
Message-ID: <20141207115344.GZ3411@intel.com>
References: <1416410146-29652-1-git-send-email-geert+renesas@glider.be>
 <20141205174754.GV3411@intel.com>
 <CAMuHMdW+zQontjNcG+MGxFec4CZFFzcDAwY=zNMNKCZLJh9whQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdW+zQontjNcG+MGxFec4CZFFzcDAwY=zNMNKCZLJh9whQ@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Dec 07, 2014 at 11:35:21AM +0100, Geert Uytterhoeven wrote:
> >>  static void sh_dmae_shutdown(struct platform_device *pdev)
> >>  {
> >>       struct sh_dmae_device *shdev = platform_get_drvdata(pdev);
> >> +
> >> +     pm_runtime_get_sync(&pdev->dev);
> >>       sh_dmae_ctl_stop(shdev);
> >> +     pm_runtime_put(&pdev->dev);
> > but if you are runtime_suspended, then why should you even proceed to stop
> > the clock. Why not just cleanup and return when runtime suspended
> 
> sh_dmae_ctl_stop() stops the DMA engine, not the clock.
> Accessing the DMA engine cannot be done while the module clock is stopped.
> 
> If pm_runtime_suspended() returns true, I can indeed just return (no new
> request can come in while .shutdown() is called).
> However, if pm_runtime_suspended() returns false, the device may still
> become runtime suspended in between the check for pm_runtime_suspended()
> and accessing the DMA engine registers in sh_dmae_ctl_stop(), as runtime
> suspend is an asynchronous operation, right?
> 
> So I think adding a check for pm_runtime_suspended() can only serve as
> an optimization, the pm_runtime_{get_sync,put}() has to stay to prevent a
> race condition.
You are quite right in your observations, but this solution though correct
seems bit heavy for case like shutdown. can't we can use driver lock to
prevent race.

-- 
~Vinod

