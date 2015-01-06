From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] thermal: rcar: fix ENR register value
Date: Tue, 6 Jan 2015 11:53:02 +0100
Message-ID: <CAMuHMdVRz5ys3u72M1+FnZsJ5qiEokO3KMzjhkWArme0zAR7mA@mail.gmail.com>
References: <1420538528-5236-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1420538528-5236-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1420538528-5236-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Shimoda-san,

On Tue, Jan 6, 2015 at 11:02 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Since the write value should always be 0 for bit 31-4 of ENR register
> on R-Car H2, this patch fixes the value.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/thermal/rcar_thermal.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index 8803e69..bbdf64e 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -409,7 +409,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>                         return PTR_ERR(common->base);
>
>                 /* enable temperature comparation */
> -               rcar_thermal_common_write(common, ENR, 0x00030303);
> +               rcar_thermal_common_write(common, ENR, 0x00000003);

While your patch is correct for R-Car gen2, this driver is also used on
R-Mobile APE6 (r8a73a4), which does have 3 thermal zones.
So I think you should count the other I/O resource sets to calculate
the correct mask.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
