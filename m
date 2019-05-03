From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v5 1/6] devfreq: rockchip-dfi: Move GRF definitions to a
 common place.
Date: Fri, 3 May 2019 09:36:44 +0900
Message-ID: <1f5cbebb-811d-d181-6d7f-83be6954514f@samsung.com>
References: <20190502175820.25382-1-gael.portay@collabora.com>
        <CGME20190502175826epcas1p43c82151e13a9d7708d46ad78c113ba76@epcas1p4.samsung.com>
        <20190502175820.25382-2-gael.portay@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190502175820.25382-2-gael.portay@collabora.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Ga=c3=abl_PORTAY?= <gael.portay@collabora.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lin Huang <hl@rock-chips.com>, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Klaus Goger <klaus.goger@theobroma-systems.com>, Derek Basehore <dbasehore@chromium.org>, Randy Li <ayaka@soulik.info>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, kernel@collabora.com
List-Id: linux-pm@vger.kernel.org

Hi Gaël,

The patch1 was already applied to devfreq.git
and then it was applied to linux-pm.git through
pull request of devfreq.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=adfe3b76608ffe547af5a74415f15499b798f32a

On 19. 5. 3. 오전 2:58, Gaël PORTAY wrote:
> From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> Some rk3399 GRF (Generic Register Files) definitions can be used for
> different drivers. Move these definitions to a common include so we
> don't need to duplicate these definitions.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> ---
> 
> Changes in v5: None
> 
> Changes in v4:
> - [PATCH v3 1/5] Add Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>.
> 
> Changes in v3:
> - [PATCH v2 1/5] Add Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>.
> 
> Changes in v2:
> - [PATCH 1/8] Really add Acked-by: Chanwoo Choi <cw00.choi@samsung.com>.
> 
> Changes in v1:
> - [RFC 1/10] Add Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> - [RFC 1/10] s/Generic/General/ (Robin Murphy)
> - [RFC 4/10] Removed from the series. I did not found a use case where not holding the mutex causes the issue.
> - [RFC 7/10] Removed from the series. I did not found a use case where this matters.
> 
>  drivers/devfreq/event/rockchip-dfi.c | 23 +++++++----------------
>  include/soc/rockchip/rk3399_grf.h    | 21 +++++++++++++++++++++
>  2 files changed, 28 insertions(+), 16 deletions(-)
>  create mode 100644 include/soc/rockchip/rk3399_grf.h
> 
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
> index 22b113363ffc..2fbbcbeb644f 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -26,6 +26,8 @@
>  #include <linux/list.h>
>  #include <linux/of.h>
>  
> +#include <soc/rockchip/rk3399_grf.h>
> +
>  #define RK3399_DMC_NUM_CH	2
>  
>  /* DDRMON_CTRL */
> @@ -43,18 +45,6 @@
>  #define DDRMON_CH1_COUNT_NUM		0x3c
>  #define DDRMON_CH1_DFI_ACCESS_NUM	0x40
>  
> -/* pmu grf */
> -#define PMUGRF_OS_REG2	0x308
> -#define DDRTYPE_SHIFT	13
> -#define DDRTYPE_MASK	7
> -
> -enum {
> -	DDR3 = 3,
> -	LPDDR3 = 6,
> -	LPDDR4 = 7,
> -	UNUSED = 0xFF
> -};
> -
>  struct dmc_usage {
>  	u32 access;
>  	u32 total;
> @@ -83,16 +73,17 @@ static void rockchip_dfi_start_hardware_counter(struct devfreq_event_dev *edev)
>  	u32 ddr_type;
>  
>  	/* get ddr type */
> -	regmap_read(info->regmap_pmu, PMUGRF_OS_REG2, &val);
> -	ddr_type = (val >> DDRTYPE_SHIFT) & DDRTYPE_MASK;
> +	regmap_read(info->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
> +	ddr_type = (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
> +		    RK3399_PMUGRF_DDRTYPE_MASK;
>  
>  	/* clear DDRMON_CTRL setting */
>  	writel_relaxed(CLR_DDRMON_CTRL, dfi_regs + DDRMON_CTRL);
>  
>  	/* set ddr type to dfi */
> -	if (ddr_type == LPDDR3)
> +	if (ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR3)
>  		writel_relaxed(LPDDR3_EN, dfi_regs + DDRMON_CTRL);
> -	else if (ddr_type == LPDDR4)
> +	else if (ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR4)
>  		writel_relaxed(LPDDR4_EN, dfi_regs + DDRMON_CTRL);
>  
>  	/* enable count, use software mode */
> diff --git a/include/soc/rockchip/rk3399_grf.h b/include/soc/rockchip/rk3399_grf.h
> new file mode 100644
> index 000000000000..3eebabcb2812
> --- /dev/null
> +++ b/include/soc/rockchip/rk3399_grf.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Rockchip General Register Files definitions
> + *
> + * Copyright (c) 2018, Collabora Ltd.
> + * Author: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> + */
> +
> +#ifndef __SOC_RK3399_GRF_H
> +#define __SOC_RK3399_GRF_H
> +
> +/* PMU GRF Registers */
> +#define RK3399_PMUGRF_OS_REG2		0x308
> +#define RK3399_PMUGRF_DDRTYPE_SHIFT	13
> +#define RK3399_PMUGRF_DDRTYPE_MASK	7
> +#define RK3399_PMUGRF_DDRTYPE_DDR3	3
> +#define RK3399_PMUGRF_DDRTYPE_LPDDR2	5
> +#define RK3399_PMUGRF_DDRTYPE_LPDDR3	6
> +#define RK3399_PMUGRF_DDRTYPE_LPDDR4	7
> +
> +#endif
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
