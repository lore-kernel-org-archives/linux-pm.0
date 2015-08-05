From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH 6/9] ARM: domain: Add platform handlers for CPU PM domains
Date: Wed, 5 Aug 2015 10:38:00 -0600
Message-ID: <20150805163759.GA52339@linaro.org>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438731339-58317-7-git-send-email-lina.iyer@linaro.org>
 <CAL_JsqKWekSGiFbZz6++3ibAzY_8Y6+0nOBQinFVw4cBk6JvEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:35816 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbbHEQhv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2015 12:37:51 -0400
Received: by pdrg1 with SMTP id g1so20813856pdr.2
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2015 09:37:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAL_JsqKWekSGiFbZz6++3ibAzY_8Y6+0nOBQinFVw4cBk6JvEw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Krzysztof =?utf-8?Q?Koz=C5=82owski?= <k.kozlowski@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, msivasub@codeaurora.org, Andy Gross <agross@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

On Wed, Aug 05 2015 at 08:45 -0600, Rob Herring wrote:
>On Tue, Aug 4, 2015 at 6:35 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>> In addition to the common power up/down actions of CPU PM domain core,
>> platforms may have additional configuration before the CPU domain can be
>> powered off or considered active. Allow platform drivers to register
>> handlers for CPU PM domains.
>>
>> Platform drivers may register their callbacks against a compatible
>> string defined by their PM domain provider device node in the DT. At
>> domain init, the platform driver can initialize the platform specific
>> genpd attributes. The init callback would need to return successfully,
>> for the platform power_on/off handlers to be registered with the CPU PM
>> domain.
>>
>> The code uses __init section to reduce memory needed for platform
>> handlers and therefore can be freed after the driver is initialized, a
>> desirable outcome for single kernel image.
>
>[...]
>
>> diff --git a/arch/arm/include/asm/arm-pd.h b/arch/arm/include/asm/arm-pd.h
>> new file mode 100644
>> index 0000000..fc44abf
>> --- /dev/null
>> +++ b/arch/arm/include/asm/arm-pd.h
>> @@ -0,0 +1,30 @@
>> +/*
>> + * linux/arch/arm/include/asm/arm-pd.h
>> + *
>> + * Copyright (C) 2015 Linaro Ltd.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#ifndef __ARM_PD_H__
>> +#define __ARM_PD_H__
>> +
>> +struct of_arm_pd_ops {
>> +       int (*init)(struct device_node *dn, struct generic_pm_domain *d);
>> +       int (*power_on)(struct generic_pm_domain *d);
>> +       int (*power_off)(struct generic_pm_domain *d);
>> +};
>> +
>> +struct of_arm_pd_method {
>> +       const char *handle;
>> +       struct of_arm_pd_ops *ops;
>> +};
>> +
>> +#define ARM_PD_METHOD_OF_DECLARE(_name, _handle, _ops) \
>> +       static const struct of_arm_pd_method __arm_pd_method_of_table_##_name \
>> +       __used __section(__arm_pd_method_of_table)              \
>> +       = { .handle = _handle, .ops = _ops }
>
>AFAICT, you are not using this in this series. You should add it when
>you have a user.
>
Sorry, I had a last minute change of heart about some commit text and 
could not get to send the complete series yesterday. I tried to send the
rest of the patches, the one that uses this macro, as in-reply-to but
that did not work for some reason.

Anyways, you are Cc'd in the driver series.

>Ideally, we keep some amount of uniformity across various *_OF_DECLARE
>which is why we have OF_DECLARE_1 and OF_DECLARE_2. This makes all the
>sections just arrays of struct of_device_id. Not all users follow
>this, but most do. So instead of putting the ops in here, platforms
>can provide a function callback which can then set the ops. Then you
>also don't need the .init() ops function as the callback function can
>do any initialization too.
>
Okay, will look into that.

>Rob
Thanks for your time Rob.

-- Lina
