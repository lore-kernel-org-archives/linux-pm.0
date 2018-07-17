From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v7 4/7] thermal: tsens: Rename tsens-8996 to tsens-v2 for
 reuse
Date: Tue, 17 Jul 2018 16:54:23 -0700
Message-ID: <20180717235423.GE129942@google.com>
References: <cover.1531384019.git.amit.kucheria@linaro.org>
 <3bd2c05db1bfe6fd3891abd87b0c767152346a1d.1531384019.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3bd2c05db1bfe6fd3891abd87b0c767152346a1d.1531384019.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, smohanad@codeaurora.org, vivek.gautam@codeaurora.org, andy.gross@linaro.org, dianders@chromium.org, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 12, 2018 at 02:09:05PM +0530, Amit Kucheria wrote:
> The TSENS block inside the 8996 is internally classified as version 2 of
> the IP. Several other SoC families use this block and can share this code.
> 
> We rename get_temp() to reflect that it can be used across the v2 family.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/thermal/qcom/Makefile                     |  2 +-
>  drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c} | 25 ++++++++---------------
>  2 files changed, 9 insertions(+), 18 deletions(-)
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
> index 3e60cec..44d3736 100644
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
> -#define STATUS_OFFSET	0xa0
> -#define LAST_TEMP_MASK	0xfff
> +#define STATUS_OFFSET		0xa0
> +#define LAST_TEMP_MASK		0xfff
>  #define STATUS_VALID_BIT	BIT(21)
>  #define CODE_SIGN_BIT		BIT(11)
>  
> -static int get_temp_8996(struct tsens_device *tmdev, int id, int *temp)
> +static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
>  {
>  	struct tsens_sensor *s = &tmdev->sensor[id];
>  	u32 code;
> @@ -73,12 +64,12 @@ static int get_temp_8996(struct tsens_device *tmdev, int id, int *temp)
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

nit: the unrelated cleanup (SPDX identifier, removal of header,
indendation fixes) could have been done in a separate patch. This
patch is small enough though that it doesn't add too much
distraction and one could argue that this patch creates a new
file ;-)

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
