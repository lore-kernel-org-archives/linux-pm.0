From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] dmaengine: shdma: Move DMA stop to (runtime) suspend
 callbacks
Date: Mon, 2 Mar 2015 22:11:23 +0530
Message-ID: <20150302164123.GB2613@intel.com>
References: <1424946394-6784-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424946394-6784-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Dan Williams <dan.j.williams@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, dmaengine@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 26, 2015 at 11:26:34AM +0100, Geert Uytterhoeven wrote:
> During system reboot, the sh-dma-engine device may be runtime-suspended,
> causing a crash:
> 
>     Unhandled fault: imprecise external abort (0x1406) at 0x0002c02c
>     Internal error: : 1406 [#1] SMP ARM
>     ...
>     PC is at sh_dmae_ctl_stop+0x28/0x64
>     LR is at sh_dmae_ctl_stop+0x24/0x64
> 
> If the sh-dma-engine is runtime-suspended, its module clock is turned
> off, and its registers cannot be accessed.
> 
> To fix this, move the call to sh_dmae_ctl_stop(), which touches the
> DMAOR register, to the sh_dmae_suspend() and sh_dmae_runtime_suspend()
> callbacks.  This makes PM operations more symmetric, as both
> sh_dmae_resume() and sh_dmae_runtime_resume() already call sh_dmae_rst()
> to re-initialize the DMAOR register.
> 
> Remove sh_dmae_shutdown(), as it became empty.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Applied, thanks

-- 
~Vinod

