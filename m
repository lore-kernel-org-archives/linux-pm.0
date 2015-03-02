From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] dmaengine: shdma: Move DMA stop to (runtime) suspend callbacks
Date: Mon, 2 Mar 2015 12:56:47 +0100
Message-ID: <CAPDyKFrNNOYgif0k=EGK0hCNe0sd3RFeZJxytrR9qS8uH+1XBA@mail.gmail.com>
References: <1424946394-6784-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1424946394-6784-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 26 February 2015 at 11:26, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
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

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
> This is v3 of "dmaengine: shdma: Runtime-resume device in .shutdown()"
>
> v3:
>   - Move the call to sh_dmae_ctl_stop() to sh_dmae_suspend() and
>     sh_dmae_runtime_suspend() instead of runtime-resuming the device in
>     .shutdown(),
>
> v2:
>   - Do nothing if we're runtime suspended.
> ---
>  drivers/dma/sh/shdmac.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
> index b2431aa300331270..9f1d4c7dbab83890 100644
> --- a/drivers/dma/sh/shdmac.c
> +++ b/drivers/dma/sh/shdmac.c
> @@ -582,15 +582,12 @@ static void sh_dmae_chan_remove(struct sh_dmae_device *shdev)
>         }
>  }
>
> -static void sh_dmae_shutdown(struct platform_device *pdev)
> -{
> -       struct sh_dmae_device *shdev = platform_get_drvdata(pdev);
> -       sh_dmae_ctl_stop(shdev);
> -}
> -
>  #ifdef CONFIG_PM
>  static int sh_dmae_runtime_suspend(struct device *dev)
>  {
> +       struct sh_dmae_device *shdev = dev_get_drvdata(dev);
> +
> +       sh_dmae_ctl_stop(shdev);
>         return 0;
>  }
>
> @@ -605,6 +602,9 @@ static int sh_dmae_runtime_resume(struct device *dev)
>  #ifdef CONFIG_PM_SLEEP
>  static int sh_dmae_suspend(struct device *dev)
>  {
> +       struct sh_dmae_device *shdev = dev_get_drvdata(dev);
> +
> +       sh_dmae_ctl_stop(shdev);
>         return 0;
>  }
>
> @@ -929,13 +929,12 @@ static int sh_dmae_remove(struct platform_device *pdev)
>  }
>
>  static struct platform_driver sh_dmae_driver = {
> -       .driver         = {
> +       .driver         = {
>                 .pm     = &sh_dmae_pm,
>                 .name   = SH_DMAE_DRV_NAME,
>                 .of_match_table = sh_dmae_of_match,
>         },
>         .remove         = sh_dmae_remove,
> -       .shutdown       = sh_dmae_shutdown,
>  };
>
>  static int __init sh_dmae_init(void)
> --
> 1.9.1
>
