From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 1/3] regulator: bd9571mwv: Use "backup_mode" sysfs file
 instead of "wake_up"
Date: Fri, 13 Jul 2018 22:08:28 +0200
Message-ID: <CAMuHMdVdd1o51X-DwntSjxcMBjA30Unnorv4_A=5TXYFh6_n1w@mail.gmail.com>
References: <20180713154720.18316-1-geert+renesas@glider.be> <20180713154720.18316-2-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180713154720.18316-2-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 13, 2018 at 6:31 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Currently the BD9571MWV PMIC driver uses the standard "wake_up" sysfs
> file to control enablement of DDR Backup Mode.
>
> However, configuring DDR Backup Mode is not really equivalent to
> configuring the PMIC as a wake-up source.  To avoid confusion, use a
> custom "backup_mode" attribute file in sysfs instead.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>   - New.
> ---
>  drivers/regulator/bd9571mwv-regulator.c | 52 ++++++++++++++++++++++---
>  1 file changed, 46 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/regulator/bd9571mwv-regulator.c b/drivers/regulator/bd9571mwv-regulator.c
> index be574eb444ebda97..7432b605db4dc879 100644
> --- a/drivers/regulator/bd9571mwv-regulator.c
> +++ b/drivers/regulator/bd9571mwv-regulator.c

> @@ -270,15 +298,26 @@ static int bd9571mwv_regulator_probe(struct platform_device *pdev)
>                 return -EINVAL;
>         }
>
> +#ifdef CONFIG_PM_SLEEP
>         if (bdreg->bkup_mode_cnt_keepon) {
> -               device_set_wakeup_capable(&pdev->dev, true);
>                 /*
> -                * Wakeup is enabled by default in pulse mode, but needs
> +                * Backup mode is enabled by default in pulse mode, but needs
>                  * explicit user setup in level mode.
>                  */
> -               device_set_wakeup_enable(&pdev->dev, bdreg->rstbmode_pulse);
> +               bdreg->bkup_mode_enabled = bdreg->rstbmode_pulse;
> +
> +               ret = device_create_file(&pdev->dev, &dev_attr_backup_mode);
> +               if (ret)
> +                       return ret;
>         }
> +#endif /* CONFIG_PM_SLEEP */
> +
> +       return 0;
> +}
>
> +static int bd9571mwv_regulator_remove(struct platform_device *pdev)
> +{
> +       device_remove_file(&pdev->dev, &dev_attr_backup_mode);

Woops, this line needs to be protected by CONFIG_PM_SLEEP.
Thank you, 0-day!

>         return 0;
>  }
>
> @@ -294,6 +333,7 @@ static struct platform_driver bd9571mwv_regulator_driver = {
>                 .pm = DEV_PM_OPS,
>         },
>         .probe = bd9571mwv_regulator_probe,
> +       .remove = bd9571mwv_regulator_remove,
>         .id_table = bd9571mwv_regulator_id_table,
>  };
>  module_platform_driver(bd9571mwv_regulator_driver);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
