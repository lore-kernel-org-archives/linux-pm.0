From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v4 3/6] thermal: tsens: Rename tsens-8996 to tsens-v2 for
 reuse
Date: Mon, 2 Jul 2018 11:55:30 -0700
Message-ID: <20180702185530.GD2050@tuxbook-pro>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
 <7e9beaa3218b1c46ea6a7399c5978c1538fce261.1530533998.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7e9beaa3218b1c46ea6a7399c5978c1538fce261.1530533998.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, edubezval@gmail.com, smohanad@codeaurora.org, vivek.gautam@codeaurora.org, andy.gross@linaro.org, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon 02 Jul 05:44 PDT 2018, Amit Kucheria wrote:

> The TSENS block inside the 8996 is internally classified as version 2 of
> the IP. Several other SoC families use this block and can share this code.
> 
> We rename get_temp() to reflect that it can be used across the v2 family.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/qcom/Makefile                     |  2 +-
>  drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c} | 26 ++++++++---------------
>  2 files changed, 10 insertions(+), 18 deletions(-)
>  rename drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c} (66%)
> 
> diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
> index 2cc2193..a821929 100644
> --- a/drivers/thermal/qcom/Makefile
> +++ b/drivers/thermal/qcom/Makefile
> @@ -1,2 +1,2 @@
>  obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
> -qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-8996.o
> +qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-v2.o
> diff --git a/drivers/thermal/qcom/tsens-8996.c b/drivers/thermal/qcom/tsens-v2.c
> similarity index 66%
> rename from drivers/thermal/qcom/tsens-8996.c
> rename to drivers/thermal/qcom/tsens-v2.c
> index e1f7781..2eca7ff 100644
> --- a/drivers/thermal/qcom/tsens-8996.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -1,27 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 and
> - * only version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> + * Copyright (c) 2018, Linaro Limited
>   */
>  
> -#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include "tsens.h"
>  
> -#define STATUS_OFFSET	0x10a0
> -#define LAST_TEMP_MASK	0xfff
> +#define STATUS_OFFSET		0xa0

This is not backwards compatible with present day dts files, you need to
keep this effectively 0x10a0 when the memory region isn't split in two.

Perhaps you can just offset the ioremap by 4k when there's only one
region?


Apart from this I like the change!

Regards,
Bjorn

> +#define LAST_TEMP_MASK		0xfff
>  #define STATUS_VALID_BIT	BIT(21)
>  #define CODE_SIGN_BIT		BIT(11)
>  
> -static int get_temp_8996(struct tsens_device *tmdev, int id, int *temp)
> +static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
>  {
>  	struct tsens_sensor *s = &tmdev->sensor[id];
>  	u32 code;
> @@ -73,12 +64,13 @@ static int get_temp_8996(struct tsens_device *tmdev, int id, int *temp)
>  	return 0;
>  }
>  
> -static const struct tsens_ops ops_8996 = {
> +static const struct tsens_ops ops_generic_v2 = {
>  	.init		= init_common,
> -	.get_temp	= get_temp_8996,
> +	.get_temp	= get_temp_tsens_v2,
>  };
>  
>  const struct tsens_data data_8996 = {
>  	.num_sensors	= 13,
> -	.ops		= &ops_8996,
> +	.ops		= &ops_generic_v2,
>  };
> +
> -- 
> 2.7.4
> 
