From: Thomas Abraham <ta.omasab@gmail.com>
Subject: Re: [PATCH v9 6/6] clk: samsung: remove unused clock aliases and
 update clock flags
Date: Thu, 31 Jul 2014 23:54:28 +0530
Message-ID: <CAJuA9ahCVnG8st0t_U+Nw9+eHV3fh57EjUeJw=LxCA0QzSm=AA@mail.gmail.com>
References: <1406707663-16656-1-git-send-email-thomas.ab@samsung.com>
	<1406707663-16656-7-git-send-email-thomas.ab@samsung.com>
	<53DA4F1A.5040604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:37754 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbaGaSYa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Jul 2014 14:24:30 -0400
In-Reply-To: <53DA4F1A.5040604@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lukasz Majewski <l.majewski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Viresh Kumar <viresh.kumar@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>

Hi Tomasz,

On Thu, Jul 31, 2014 at 7:43 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On 30.07.2014 10:07, Thomas Abraham wrote:
>> With some of the Exynos SoCs switched over to use the generic CPUfreq drivers,
>> the unused clock aliases can be removed. In addition to this, the individual
>> clock blocks which are now encapsulated with the consolidate CPU clock type
>> can now be marked with read-only flags.
>
> [snip]
>
>> @@ -1500,6 +1499,7 @@ static void __init exynos4_clk_init(struct device_node *np,
>>               exynos4_soc == EXYNOS4210 ? "Exynos4210" : "Exynos4x12",
>>               _get_rate("sclk_apll"), _get_rate("sclk_mpll"),
>>               _get_rate("sclk_epll"), _get_rate("sclk_vpll"),
>> +             exynos4_soc == EXYNOS4210 ? _get_rate("armclk") :
>>               _get_rate("div_core2"));
>
> I believe "div_core2" should work fine here for all SoCs without the
> need for this if.

The following patch is a pre-requisite for this patch.
http://www.spinics.net/lists/arm-kernel/msg351540.html

The rate can be obtained from div_core2 as well but with the cpu clock
now registered, the rate can be obtained from the cpu clock instance
instead of the div_core2 divider. And when Exynos4412 also add cpu
clock instance, the 'if' above will be removed.

>
>>  }
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
>> index e19e365..1d958f1 100644
>> --- a/drivers/clk/samsung/clk-exynos5250.c
>> +++ b/drivers/clk/samsung/clk-exynos5250.c
>
> [snip]
>
>> @@ -848,6 +851,6 @@ static void __init exynos5250_clk_init(struct device_node *np)
>>       samsung_clk_of_add_provider(np, ctx);
>>
>>       pr_info("Exynos5250: clock setup completed, armclk=%ld\n",
>> -                     _get_rate("div_arm2"));
>> +                     _get_rate("armclk"));
>
> Similarly here, no need for this change.

Same here. Instead of getting the rate from div_core2 divider block,
the cpu clock instance is used to find the rate. I would prefer to use
cpu clock here. Is there any reason to prefer div_core2 over the cpu
clock instance?

Thanks,
Thomas.

>
> Best regards,
> Tomasz
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
