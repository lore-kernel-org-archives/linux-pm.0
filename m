From: Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 4/4] drivers: qcom: rpmh: add RPMH helper functions
Date: Thu, 15 Feb 2018 14:19:48 +0530
Message-ID: <217e3652-c7e9-a81a-fcd8-9d97ab7736cd@codeaurora.org>
References: <20180119000157.7380-1-ilina@codeaurora.org>
 <20180119000157.7380-5-ilina@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180119000157.7380-5-ilina-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lina Iyer <ilina-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

[]..

> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> new file mode 100644
> index 000000000000..ad1def2c362c
> --- /dev/null
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -0,0 +1,264 @@
> +/* Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/atomic.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <linux/wait.h>
> +
> +#include <soc/qcom/rpmh.h>
> +
> +#include "rpmh-internal.h"
> +
> +#define RPMH_MAX_MBOXES			2
> +#define RPMH_TIMEOUT			msecs_to_jiffies(10000)
> +
> +#define DEFINE_RPMH_MSG_ONSTACK(rc, s, q, c, name)
> +	struct rpmh_msg name = {			\
> +		.msg = {				\
> +			.state = s,			\
> +			.payload = name.cmd,		\
> +			.num_payload = 0,		\
> +			.is_complete = true,		\
> +			.invalidate = false,		\

There seems to be no field called 'invalidate' as part of the struct

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
