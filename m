From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v1 03/10] thermal: tsens: Add SPDX license identifiers
Date: Thu, 9 Aug 2018 12:19:52 -0700
Message-ID: <20180809191952.GK160295@google.com>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
 <e9f81dd5358244d44b0d74e3fb11189b514dd976.1533815718.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e9f81dd5358244d44b0d74e3fb11189b514dd976.1533815718.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, smohanad@codeaurora.org, andy.gross@linaro.org, dianders@chromium.org, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 09, 2018 at 06:02:35PM +0530, Amit Kucheria wrote:
> The TSENS drivers use a GPL-2.0 license. Replace with equivalent SPDX
> tags and delete the full license text.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/qcom/tsens-8916.c   | 11 +----------
>  drivers/thermal/qcom/tsens-8960.c   | 11 +----------
>  drivers/thermal/qcom/tsens-8974.c   | 11 +----------
>  drivers/thermal/qcom/tsens-common.c | 11 +----------
>  drivers/thermal/qcom/tsens.c        | 11 +----------
>  drivers/thermal/qcom/tsens.h        | 11 ++---------
>  6 files changed, 7 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-8916.c b/drivers/thermal/qcom/tsens-8916.c
> index fdf561b8b81d..c4955c85e922 100644
> --- a/drivers/thermal/qcom/tsens-8916.c
> +++ b/drivers/thermal/qcom/tsens-8916.c
> @@ -1,15 +1,6 @@
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
>   */
>  
>  #include <linux/platform_device.h>
> diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
> index 0451277d3a8f..4af76de7dc2e 100644
> --- a/drivers/thermal/qcom/tsens-8960.c
> +++ b/drivers/thermal/qcom/tsens-8960.c
> @@ -1,15 +1,6 @@
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
>   */
>  
>  #include <linux/platform_device.h>
> diff --git a/drivers/thermal/qcom/tsens-8974.c b/drivers/thermal/qcom/tsens-8974.c
> index 9baf77e8cbe3..7e149edbfeb6 100644
> --- a/drivers/thermal/qcom/tsens-8974.c
> +++ b/drivers/thermal/qcom/tsens-8974.c
> @@ -1,15 +1,6 @@
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
>   */
>  
>  #include <linux/platform_device.h>
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 478739543bbc..303e3fdaca98 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -1,15 +1,6 @@
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
>   */
>  
>  #include <linux/err.h>
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index a2c9bfae3d86..90bb431cf740 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -1,15 +1,6 @@
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
>   */
>  
>  #include <linux/err.h>
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index 14331eb45a86..8207610f326a 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -1,15 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
> +
>  #ifndef __QCOM_TSENS_H__
>  #define __QCOM_TSENS_H__
>  

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
