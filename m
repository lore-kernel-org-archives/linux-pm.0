From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v1 2/4] ARM: keystone: pm: switch to use generic pm domains
Date: Mon, 13 Oct 2014 14:13:17 +0300
Message-ID: <543BB3CD.7040001@ti.com>
References: <1412001499-19369-1-git-send-email-grygorii.strashko@ti.com>	<1412001499-19369-3-git-send-email-grygorii.strashko@ti.com> <CAMAWPa-sKGu_o0CDLCk_uKofxwOjXiiFBedjEP=OhQFmo+ehCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMAWPa-sKGu_o0CDLCk_uKofxwOjXiiFBedjEP=OhQFmo+ehCA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 10/12/2014 03:56 PM, Kevin Hilman wrote:
> Hi Grygorii,
>
> On 9/29/14 7:38 AM, Grygorii Strashko wrote:
>> This patch switches Keystone 2 PM code to use Generic PM domains
>> instead of PM clock domains because of the lack of DT support
>> for the last.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
>
> IMO, this approach is much better.
>
> One minor nit below...
>
>> diff --git a/arch/arm/mach-keystone/pm_domain.c b/arch/arm/mach-keystone/pm_domain.c
>> index ca79dda..3eb5257 100644
>> --- a/arch/arm/mach-keystone/pm_domain.c
>> +++ b/arch/arm/mach-keystone/pm_domain.c
>> @@ -12,69 +12,110 @@
>>    * version 2, as published by the Free Software Foundation.
>>    */
>>
>> +#include <linux/clk.h>
>>   #include <linux/init.h>
>> -#include <linux/pm_runtime.h>
>>   #include <linux/pm_clock.h>
>> +#include <linux/pm_domain.h>
>>   #include <linux/platform_device.h>
>> -#include <linux/clk-provider.h>
>>   #include <linux/of.h>
>>
>> -#ifdef CONFIG_PM_RUNTIME
>> -static int keystone_pm_runtime_suspend(struct device *dev)
>> +#ifdef CONFIG_PM_GENERIC_DOMAINS
>> +
>> +struct keystone_domain {
>> + struct generic_pm_domain base;
>> + struct device *dev;
>> +};
>
> I think the name 'base' for this field leads to confusion later in the
> code, since base usually means something else in drivers.  How about
> 'genpd'?

Agree. I'll change it.

Thanks for your comments.

Regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
