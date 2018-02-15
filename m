From: Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH 4/4] drivers: qcom: rpmh: add RPMH helper functions
Date: Thu, 15 Feb 2018 15:52:12 +0000
Message-ID: <20180215155212.GA23714@codeaurora.org>
References: <20180119000157.7380-1-ilina@codeaurora.org>
 <20180119000157.7380-5-ilina@codeaurora.org>
 <217e3652-c7e9-a81a-fcd8-9d97ab7736cd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60840 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425197AbeBOPwP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Feb 2018 10:52:15 -0500
Content-Disposition: inline
In-Reply-To: <217e3652-c7e9-a81a-fcd8-9d97ab7736cd@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

On Thu, Feb 15 2018 at 08:49 +0000, Rajendra Nayak wrote:
>[]..
>
>> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
>> new file mode 100644
>> index 000000000000..ad1def2c362c
>> --- /dev/null
>> +++ b/drivers/soc/qcom/rpmh.c
>> @@ -0,0 +1,264 @@
>> +/* Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +
>> +#include <linux/atomic.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mailbox_client.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/types.h>
>> +#include <linux/wait.h>
>> +
>> +#include <soc/qcom/rpmh.h>
>> +
>> +#include "rpmh-internal.h"
>> +
>> +#define RPMH_MAX_MBOXES			2
>> +#define RPMH_TIMEOUT			msecs_to_jiffies(10000)
>> +
>> +#define DEFINE_RPMH_MSG_ONSTACK(rc, s, q, c, name)
>> +	struct rpmh_msg name = {			\
>> +		.msg = {				\
>> +			.state = s,			\
>> +			.payload = name.cmd,		\
>> +			.num_payload = 0,		\
>> +			.is_complete = true,		\
>> +			.invalidate = false,		\
>
>There seems to be no field called 'invalidate' as part of the struct
>
Yup. Sorry, I will remove it in the next revision. I should be posting
one in a day or so.

Thanks,
Lina
