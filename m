From: Thomas Abraham <ta.omasab@gmail.com>
Subject: Re: [PATCH v8 6/6] clk: samsung: remove unused clock aliases and
 update clock flags
Date: Tue, 29 Jul 2014 17:34:05 +0530
Message-ID: <CAJuA9ahgOS7ccqiaMHn9rTS4tY3ah64rzbmQugWmL3s6HXFZVQ@mail.gmail.com>
References: <1406611711-25112-1-git-send-email-thomas.ab@samsung.com>
	<1406611711-25112-7-git-send-email-thomas.ab@samsung.com>
	<53D77B01.40702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:63513 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219AbaG2MEH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Jul 2014 08:04:07 -0400
In-Reply-To: <53D77B01.40702@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>

Hi Tomasz,

On Tue, Jul 29, 2014 at 4:14 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Thomas,
>
> You can find few comments inline.
>
> On 29.07.2014 07:28, Thomas Abraham wrote:
>
> [snip]
>
>> @@ -714,15 +715,24 @@ static struct samsung_div_clock exynos4_div_clks[] __initdata = {
>                                                         ^^^
>
> Keep in mind that following clocks are common for Exynos4210 and
> Exynos4x12. Have you tested this series on a board based on Exynos4212
> or 4412 to verify that it does not break the legacy driver? (I would
> test it myself, but I am on holidays at the moment.)

Thanks for taking time to have a look at this series. I have tested
this series with the old cpufreq driver for Exynos4412 on an
Origen4412 board and it works fine. These divider clocks are not
directly used or referenced by the legacy cpufreq driver. So I marked
them as read-only here.

>
>>       DIV(0, "div_clkout_rightbus", "mout_clkout_rightbus",
>>                       CLKOUT_CMU_RIGHTBUS, 8, 6),
>>
>> -     DIV(0, "div_core", "mout_core", DIV_CPU0, 0, 3),
>> -     DIV(0, "div_corem0", "div_core2", DIV_CPU0, 4, 3),
>> -     DIV(0, "div_corem1", "div_core2", DIV_CPU0, 8, 3),
>> -     DIV(0, "div_periph", "div_core2", DIV_CPU0, 12, 3),
>
> [snip]
>
>> @@ -1501,7 +1507,7 @@ static void __init exynos4_clk_init(struct device_node *np,
>>               exynos4_soc == EXYNOS4210 ? "Exynos4210" : "Exynos4x12",
>>               _get_rate("sclk_apll"), _get_rate("sclk_mpll"),
>>               _get_rate("sclk_epll"), _get_rate("sclk_vpll"),
>> -             _get_rate("arm_clk"));
>> +             _get_rate("armclk"));
>
> This will not work on Exynos4412, because there is no "armclk" added for
> this SoC. My suggestion is to simply keep name of the clock as is, move
> current "arm_clk" divider to Exynos4x12-specific clocks and register
> Exynos4210 CPU clock as "arm_clk".

Ok. Will do this in the next version.

Thanks,
Thomas.

>
> Best regards,
> Tomasz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
