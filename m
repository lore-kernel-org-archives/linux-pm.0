From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v3 2/2] PM / devfreq: Add devfreq driver for interconnect
 bandwidth voting
Date: Thu, 2 Aug 2018 16:15:09 +0300
Message-ID: <248eb8ef-6936-a23b-4c44-fd9953992ae2@linaro.org>
References: <1533171465-25508-2-git-send-email-skannan@codeaurora.org>
 <CGME20180802005759epcas4p4a68d50e61c8425124a993de1917021a2@epcms1p5>
 <20180802101341epcms1p53ee79776dbcbeaf6f1e7910b20095220@epcms1p5>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180802101341epcms1p53ee79776dbcbeaf6f1e7910b20095220@epcms1p5>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Saravana Kannan <skannan@codeaurora.org>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daidavid1@codeaurora.org" <daidavid1@codeaurora.org>, "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi MyungJoo,

On 08/02/2018 01:13 PM, MyungJoo Ham wrote:
>> This driver registers itself as a devfreq device that allows devfreq
>> governors to make bandwidth votes for an interconnect path. This allows
>> applying various policies for different interconnect paths using devfreq
>> governors.
>>
> 
> First of all, the name, "devfreq_icbw", is not appropriate for a
> devfreq device driver. It confuses; it looks like a part of the
> framework itself.
> 
>> diff --git a/drivers/devfreq/devfreq_icbw.c b/drivers/devfreq/devfreq_icbw.c
>> new file mode 100644
>> index 0000000..231fb21
>> --- /dev/null
>> +++ b/drivers/devfreq/devfreq_icbw.c
>> @@ -0,0 +1,116 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2013-2014, 2018, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#define pr_fmt(fmt) "icbw: " fmt
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/err.h>
>> +#include <linux/errno.h>
>> +#include <linux/mutex.h>
>> +#include <linux/devfreq.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/of.h>
>> +#include <linux/interconnect.h>
> 
> Where can I find this file?

It is part of the On-chip interconnect API, which is currently under
review and is available here: https://lkml.org/lkml/2018/7/31/647

Thanks,
Georgi
