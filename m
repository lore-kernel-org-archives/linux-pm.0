From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2 14/15] cpufreq: Add module to register cpufreq on Krait
 CPUs
Date: Mon, 08 Sep 2014 17:37:42 -0700
Message-ID: <540E4BD6.4030200@codeaurora.org>
References: <1409957256-23729-1-git-send-email-sboyd@codeaurora.org>	<1409957256-23729-16-git-send-email-sboyd@codeaurora.org> <CAKohpokLFMMK-h2657=_BCBr3oXCTiQDA+C-rDgorxfrPR-9YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAKohpokLFMMK-h2657=_BCBr3oXCTiQDA+C-rDgorxfrPR-9YQ@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mike Turquette <mturquette@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 09/07/14 21:46, Viresh Kumar wrote:
> On 6 September 2014 04:17, Stephen Boyd <sboyd@codeaurora.org> wrote:
>
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/cpu.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/slab.h>
>> +#include <linux/pm_opp.h>
>> +#include <linux/init.h>
> Would be good if these can be in alphanumeric order. That helps maintaining
> them later on..

Ok.

>
>> +static int __init qcom_cpufreq_populate_opps(void)
>> +{
>> +       int len, num_rows, i, k;
>> +       char table_name[] = "qcom,speedXX-pvsXX-bin-vXX";
>> +       struct device_node *np;
>> +       struct device *dev;
>> +       int cpu = 0;
>> +       int speed, pvs, pvs_ver;
>> +       int cols;
> All the 'int' declarations can be combined in a single line if you would like.

Sure.

>> +
>> +MODULE_DESCRIPTION("Qualcomm CPUfreq driver");
> A module author as well?

How about we use git blame instead?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
