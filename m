From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] thermal: hwmon: EXPORT_SYMBOL for thermal hwmon sysfs
Date: Mon, 4 Jul 2016 08:49:12 +0200
Message-ID: <CAMuHMdUad0bA7-ueEZsT5CrHDkDrO2rHuULojQTmt7NKRtpK8w@mail.gmail.com>
References: <87lh1ykqs4.wl%kuninori.morimoto.gx@renesas.com>
 <201607031043.pubKFAon%fengguang.wu@intel.com> <87zipyz1w9.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87zipyz1w9.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>, "cm-hiep@jinso.co.jp" <cm-hiep@jinso.co.jp>, PhucBui <bd-phuc@jinso.co.jp>
List-Id: linux-pm@vger.kernel.org

Hi Morimoto-san,

On Mon, Jul 4, 2016 at 2:31 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> thermal_add_hwmon_sysfs()/thermal_remove_hwmon_sysfs() need
> EXPORT_SYMBOL(). Otherwise we will have ERROR
>
>>> ERROR: "thermal_remove_hwmon_sysfs" [drivers/thermal/rcar_thermal.ko] undefined!
>>> ERROR: "thermal_add_hwmon_sysfs" [drivers/thermal/rcar_thermal.ko] undefined!
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/thermal/thermal_hwmon.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
> index 06fd2ed9..8eecba8 100644
> --- a/drivers/thermal/thermal_hwmon.c
> +++ b/drivers/thermal/thermal_hwmon.c
> @@ -232,6 +232,7 @@ int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
>
>         return result;
>  }
> +EXPORT_SYMBOL(thermal_add_hwmon_sysfs);

EXPORT_SYMBOL_GPL?
That seems to be prevalent in the thermal subsystem, except for a few cases
in cpu_cooling.c and thermal_helpers.c.

>  void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
>  {
> @@ -270,3 +271,4 @@ void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
>         hwmon_device_unregister(hwmon->device);
>         kfree(hwmon);
>  }
> +EXPORT_SYMBOL(thermal_remove_hwmon_sysfs);

EXPORT_SYMBOL_GPL?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
