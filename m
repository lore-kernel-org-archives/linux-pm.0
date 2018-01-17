From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] dmaengine: rcar-dmac: Make DMAC reinit during system
 resume explicit
Date: Wed, 17 Jan 2018 11:00:03 +0100
Message-ID: <CAPDyKFonBsqL0rLXHU=gshc3-8UUQgeDbE6BeMBWXB+S+XawCA@mail.gmail.com>
References: <1516181908-16930-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1516181908-16930-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, dmaengine@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 17 January 2018 at 10:38, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> The current (empty) system sleep callbacks rely on the PM core to force
> a runtime resume to reinitialize the DMAC registers during system
> resume.  Without a reinitialization, e.g. SCIF DMA will hang silently
> after a system resume on R-Car Gen3.
>
> Make this explicit by using pm_runtime_force_{suspend,resume}() as the
> system sleep callbacks instead.  Use SET_LATE_SYSTEM_SLEEP_PM_OPS() as
> DMA engines must be initialized before all DMA slave devices.
>
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
> This is a dependency for "[PATCH 1/2] PM / genpd: Stop/start devices
> without pm_runtime_force_suspend/resume()"
> (https://www.spinics.net/lists/kernel/msg2696802.html), so perhaps it
> makes most sense if Rafael takes it through the PM tree?
>
> Thanks!
> ---
>  drivers/dma/sh/rcar-dmac.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> index fb06b193ad252086..06e4e604eebb79f6 100644
> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -1657,22 +1657,6 @@ static struct dma_chan *rcar_dmac_of_xlate(struct of_phandle_args *dma_spec,
>   * Power management
>   */
>
> -#ifdef CONFIG_PM_SLEEP
> -static int rcar_dmac_sleep_suspend(struct device *dev)
> -{
> -       /*
> -        * TODO: Wait for the current transfer to complete and stop the device.
> -        */
> -       return 0;
> -}
> -
> -static int rcar_dmac_sleep_resume(struct device *dev)
> -{
> -       /* TODO: Resume transfers, if any. */
> -       return 0;
> -}
> -#endif
> -
>  #ifdef CONFIG_PM
>  static int rcar_dmac_runtime_suspend(struct device *dev)
>  {
> @@ -1688,7 +1672,13 @@ static int rcar_dmac_runtime_resume(struct device *dev)
>  #endif
>
>  static const struct dev_pm_ops rcar_dmac_pm = {
> -       SET_SYSTEM_SLEEP_PM_OPS(rcar_dmac_sleep_suspend, rcar_dmac_sleep_resume)
> +       /*
> +        * TODO for system sleep/resume:
> +        *   - Wait for the current transfer to complete and stop the device,
> +        *   - Resume transfers, if any.
> +        */
> +       SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +                                    pm_runtime_force_resume)
>         SET_RUNTIME_PM_OPS(rcar_dmac_runtime_suspend, rcar_dmac_runtime_resume,
>                            NULL)
>  };
> --
> 2.7.4
>
