From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] dmaengine: usb-dmac: Make DMAC system sleep callbacks explicit
Date: Thu, 17 Jan 2019 10:03:15 +0100
Message-ID: <CAMuHMdU_dbRp2Yqjjd4Vi-1bV4vSQe=UOEcrvCumfoYifzQzxw@mail.gmail.com>
References: <1547692896-2362-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1547692896-2362-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: stable-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, stable <stable@vger.kernel.org>, Phuong Nguyen <phuong.nguyen.xw@renesas.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Shimoda-san,

CC linux-pm people

On Thu, Jan 17, 2019 at 9:48 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> From: Phuong Nguyen <phuong.nguyen.xw@renesas.com>
>
> This commit fixes the issue that USB-DMAC hangs silently after system
> resumes on R-Car Gen3 hence renesas_usbhs will not work correctly
> when using USB-DMAC for bulk transfer e.g. ethernet or serial
> gadgets.
>
> The issue can be reproduced by these steps:
>  1. modprobe g_serial
>  2. Suspend and resume system.
>  3. connect a usb cable to host side
>  4. Transfer data from Host to Target
>  5. cat /dev/ttyGS0 (Target side)
>  6. echo "test" > /dev/ttyACM0 (Host side)
>
> The 'cat' will not result anything. However, system still can work
> normally.
>
> Currently, USB-DMAC driver does not have system sleep callbacks hence
> this driver relies on the PM core to force runtime suspend/resume to
> suspend and reinitialize USB-DMAC during system resume. After
> the commit 17218e0092f8 ("PM / genpd: Stop/start devices without
> pm_runtime_force_suspend/resume()"), PM core will not force
> runtime suspend/resume anymore so this issue happens.
>
> To solve this, make system suspend resume explicit by using
> pm_runtime_force_{suspend,resume}() as the system sleep callbacks.
> SET_NOIRQ_SYSTEM_SLEEP_PM_OPS()is used to make sure USB-DMAC suspended
> after and initialized before renesas_usbhs."
>
> Signed-off-by: Phuong Nguyen <phuong.nguyen.xw@renesas.com>
> Signed-off-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
> Cc: <stable@vger.kernel.org> # v4.16+
> [shimoda: revise the commit log and add Cc tag]
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Thanks for your patch!

This is similar in spirit to commits 1131b0a4af911de5 ("dmaengine:
rcar-dmac: Make DMAC reinit during system resume explicit") and
73dcc666d6bd0db5 ("dmaengine: rcar-dmac: Fix too early/late system
suspend/resume callbacks") for rcar-dmac.

I'm only wondering if the "late" variant would be sufficient here.
Does g_serial support wake-up?
Anyway, using the "noirq" variant, like you did, is probably the safest.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
>  drivers/dma/sh/usb-dmac.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
> index 7f7184c..59403f6 100644
> --- a/drivers/dma/sh/usb-dmac.c
> +++ b/drivers/dma/sh/usb-dmac.c
> @@ -694,6 +694,8 @@ static int usb_dmac_runtime_resume(struct device *dev)
>  #endif /* CONFIG_PM */
>
>  static const struct dev_pm_ops usb_dmac_pm = {
> +       SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +                                     pm_runtime_force_resume)
>         SET_RUNTIME_PM_OPS(usb_dmac_runtime_suspend, usb_dmac_runtime_resume,
>                            NULL)
>  };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
