From: Anand Moon <linux.amoon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: exynos: Use thermal fuse value for thermal zone
 0 on Exynos5420
Date: Mon, 13 Feb 2017 17:08:36 +0530
Message-ID: <CANAwSgSJRv6XGKvysbw+cXYyVUEcNyGv=6tYSWsvOn42dX5f1w@mail.gmail.com>
References: <20170211201456.27974-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170211201456.27974-1-krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Willy WOLFF <willy.mh.wolff-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,



On 12 February 2017 at 01:44, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> In Odroid XU3 Lite board, the temperature levels reported for thermal
> zone 0 were weird. In warm room:
>         /sys/class/thermal/thermal_zone0/temp:32000
>         /sys/class/thermal/thermal_zone1/temp:51000
>         /sys/class/thermal/thermal_zone2/temp:55000
>         /sys/class/thermal/thermal_zone3/temp:54000
>         /sys/class/thermal/thermal_zone4/temp:51000
>
> Sometimes after booting the value was even equal to ambient temperature
> which is highly unlikely to be a real temperature of sensor in SoC.
>
> The thermal sensor's calibration (trimming) is based on fused values.
> In case of the board above, the fused values are: 35, 52, 43, 58 and 43
> (corresponding to each TMU device).  However driver defined a minimum value
> for fused data as 40 and for smaller values it was using a hard-coded 55
> instead.  This lead to mapping data from sensor to wrong temperatures
> for thermal zone 0.
>
> Various vendor 3.10 trees (Hardkernel's based on Samsung LSI, Artik 10)
> do not impose any limits on fused values.  Since we do not have any
> knowledge about these limits, use 0 as a minimum accepted fused value.
> This should essentially allow accepting any reasonable fused value thus
> behaving like vendor driver.
>

On HK following values are define in drivers/thermal/exynos_thermal.c

#define EFUSE_MIN_VALUE                         40
#define EFUSE_MAX_VALUE                         100

> The exynos5420-tmu-sensor-conf.dtsi is copied directly from existing
> exynso4412 with one change - the samsung,tmu_min_efuse_value.
>
> Signed-off-by: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>
> ---

Best Regards
-Anand
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
