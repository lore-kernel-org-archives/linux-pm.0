From: skannan@codeaurora.org
Subject: Re: [PATCH v3 2/2] PM / devfreq: Add devfreq driver for interconnect
 bandwidth voting
Date: Thu, 02 Aug 2018 12:07:07 -0700
Message-ID: <e7bd0cbc4131f597a1fb68af1cfd1a67@codeaurora.org>
References: <1533171465-25508-2-git-send-email-skannan@codeaurora.org>
 <CGME20180802005759epcas4p4a68d50e61c8425124a993de1917021a2@epcms1p5>
 <20180802101341epcms1p53ee79776dbcbeaf6f1e7910b20095220@epcms1p5>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180802101341epcms1p53ee79776dbcbeaf6f1e7910b20095220@epcms1p5>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, georgi.djakov@linaro.org, vincent.guittot@linaro.org, daidavid1@codeaurora.org, bjorn.andersson@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2018-08-02 03:13, MyungJoo Ham wrote:
>> This driver registers itself as a devfreq device that allows devfreq
>> governors to make bandwidth votes for an interconnect path. This 
>> allows
>> applying various policies for different interconnect paths using 
>> devfreq
>> governors.
>> 
> 
> First of all, the name, "devfreq_icbw", is not appropriate for a
> devfreq device driver. It confuses; it looks like a part of the
> framework itself.
> 
>> diff --git a/drivers/devfreq/devfreq_icbw.c 
>> b/drivers/devfreq/devfreq_icbw.c
>> new file mode 100644
>> index 0000000..231fb21
>> --- /dev/null
>> +++ b/drivers/devfreq/devfreq_icbw.c
>> @@ -0,0 +1,116 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2013-2014, 2018, The Linux Foundation. All rights 
>> reserved.
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

Sorry, meant to mention this in the email specific portion of the commit 
text. This is on top of the interconnect framework series that Georgi 
has been working on. linux-pm should have those patches.


>> +
>> +struct dev_data {
>> +	struct icc_path *path;
>> +	u32 cur_ab;
>> +	u32 cur_pb;
>> +	unsigned long gov_ab;
>> +	struct devfreq *df;
>> +	struct devfreq_dev_profile dp;
>> +};
>> +
>> +static int icbw_target(struct device *dev, unsigned long *freq, u32 
>> flags)
>> +{
>> +	struct dev_data *d = dev_get_drvdata(dev);
>> +	int ret;
>> +	u32 new_pb = *freq, new_ab = d->gov_ab;
>> +
>> +	if (d->cur_pb == new_pb && d->cur_ab == new_ab)
>> +		return 0;
>> +
>> +	dev_dbg(dev, "BW KBps: AB: %u PB: %u\n", new_ab, new_pb);
>> +
>> +	ret = icc_set(d->path, new_ab, new_pb);
> 
> I'm not sure if icc_set is available.

Yeah, it's available on that patch series.

-Saravana
