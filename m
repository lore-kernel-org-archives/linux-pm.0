From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] dmaengine: shdma: Runtime-resume device in .shutdown()
Date: Fri, 5 Dec 2014 23:17:54 +0530
Message-ID: <20141205174754.GV3411@intel.com>
References: <1416410146-29652-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1416410146-29652-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 19, 2014 at 04:15:46PM +0100, Geert Uytterhoeven wrote:
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
> off, and its registers cannot be accessed. Runtime-resume the device in
> the driver's .shutdown() callback to fix this.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/dma/sh/shdmac.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
> index b65317c6ea4e722c..a13c6ba7468f12a6 100644
> --- a/drivers/dma/sh/shdmac.c
> +++ b/drivers/dma/sh/shdmac.c
> @@ -585,7 +585,10 @@ static void sh_dmae_chan_remove(struct sh_dmae_device *shdev)
>  static void sh_dmae_shutdown(struct platform_device *pdev)
>  {
>  	struct sh_dmae_device *shdev = platform_get_drvdata(pdev);
> +
> +	pm_runtime_get_sync(&pdev->dev);
>  	sh_dmae_ctl_stop(shdev);
> +	pm_runtime_put(&pdev->dev);
but if you are runtime_suspended, then why should you even proceed to stop
the clock. Why not just cleanup and return when runtime suspended

-- 
~Vinod

