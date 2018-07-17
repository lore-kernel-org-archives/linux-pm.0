From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 3/5] thermal: exynos: increase the number of trips for exynos542x
Date: Tue, 17 Jul 2018 14:25:07 +0200
Message-ID: <CAJKOXPe_omjhLMfMScTeXG2k908WT4MesMK5obpA0ejBs=vrfg@mail.gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com> <1531822342-4293-3-git-send-email-linux.amoon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531822342-4293-3-git-send-email-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anand Moon <linux.amoon@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 17 July 2018 at 12:12, Anand Moon <linux.amoon@gmail.com> wrote:
> increase the number of trips to support more polling modes,
> changes help supress following warning.
>
> [    4.231731] thermal thermal_zone0: failed to read out thermal zone (-22)
> [    4.237190] exynos-tmu 10060000.tmu: More trip points than supported by this TMU.
> [    4.244661] exynos-tmu 10060000.tmu: 2 trip points should be configured in polling mode.
> [    4.254821] thermal thermal_zone1: failed to read out thermal zone (-22)
> [    4.260370] exynos-tmu 10064000.tmu: More trip points than supported by this TMU.
> [    4.267631] exynos-tmu 10064000.tmu: 2 trip points should be configured in polling mode.
> [    4.277551] thermal thermal_zone2: failed to read out thermal zone (-22)
> [    4.283090] exynos-tmu 10068000.tmu: More trip points than supported by this TMU.
> [    4.290438] exynos-tmu 10068000.tmu: 2 trip points should be configured in polling mode.
> [    4.300280] thermal thermal_zone3: failed to read out thermal zone (-22)
> [    4.305711] exynos-tmu 1006c000.tmu: More trip points than supported by this TMU.
> [    4.313171] exynos-tmu 1006c000.tmu: 2 trip points should be configured in polling mode.
> [    4.323002] thermal thermal_zone4: failed to read out thermal zone (-22)
>
> CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

NAK

Exynos5420/5422/5800 has 4 trip points (understood as in current driver design).

Best regards,
Krzysztof

> ---
>  drivers/thermal/samsung/exynos_tmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 2dbde97..4a2733c 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -935,7 +935,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
>                 data->tmu_read = exynos4412_tmu_read;
>                 data->tmu_set_emulation = exynos4412_tmu_set_emulation;
>                 data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
> -               data->ntrip = 4;
> +               data->ntrip = 8;
>                 data->gain = 8;
>                 data->reference_voltage = 16;
>                 data->efuse_value = 55;
> --
> 2.7.4
>
