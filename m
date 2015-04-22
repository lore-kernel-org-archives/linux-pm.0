From: Pi-Cheng Chen <pi-cheng.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] cpufreq: mediatek: Add MT8173 cpufreq driver
Date: Wed, 22 Apr 2015 11:14:50 +0800
Message-ID: <CALx668VD7KZv1ejRsWTtZ=EKPej6mEi3ahdhKPoOEwd+oD-QYA@mail.gmail.com>
References: <1429522047-16675-1-git-send-email-pi-cheng.chen@linaro.org>
	<1429522047-16675-2-git-send-email-pi-cheng.chen@linaro.org>
	<1429554517.14597.38.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1429554517.14597.38.camel@x220>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Joe.C" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Howard Chen <ibanezchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chen Fan <fan.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linaro Kernel Mailman List <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 21, 2015 at 2:28 AM, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org> wrote:
> On Mon, 2015-04-20 at 17:27 +0800, pi-cheng.chen wrote:
>> --- a/drivers/cpufreq/Kconfig.arm
>> +++ b/drivers/cpufreq/Kconfig.arm
>
>> +config ARM_MT8173_CPUFREQ
>> +     bool "Mediatek MT8173 CPUFreq support"
>> +     depends on ARCH_MEDIATEK && REGULATOR
>> +     help
>> +       This adds the CPUFreq driver support for Mediatek MT8173 SoC.
>
>> --- a/drivers/cpufreq/Makefile
>> +++ b/drivers/cpufreq/Makefile
>
>> +obj-$(CONFIG_ARM_MT8173_CPUFREQ)     += mt8173-cpufreq.o
>
> ARM_MT8173_CPUFREQ is a bool symbol, so mt8173-cpufreq.o will never be
> part of a module.
>
> (If that's incorrect you can stop reading here.)
>
>> --- /dev/null
>> +++ b/drivers/cpufreq/mt8173-cpufreq.c
>
>> +#include <linux/module.h>
>
> I guess this include is not needed. And, for what it's worth,
>     make ARCH=arm CROSS_COMPILE=arm-linux-gnu- drivers/cpufreq/mt8173-cpufreq.o
>
> compiles silently even if it's dropped.
>
>> +module_init(mt8173_cpufreq_driver_init);
>
> According to include/linux/init.h, for built-in only code, this is
> equivalent to device_initcall([...]). And two runs of
>     make ARCH=arm CROSS_COMPILE=arm-linux-gnu- drivers/cpufreq/mt8173-cpufreq.i
>
> confirm that.

Hi Paul,

Thanks for your reviewing.
The <linux/module.h> is not needed here.
I'll remove it.

Best Regards,
Pi-Cheng

>
> Thanks,
>
>
> Paul Bolle
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
