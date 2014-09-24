From: Thomas Abraham <ta.omasab@gmail.com>
Subject: Re: [PATCH v10 0/6] cpufreq: use generic cpufreq drivers for exynos platforms
Date: Wed, 24 Sep 2014 17:56:54 +0530
Message-ID: <CAJuA9ai8f1wut5v2iZN4YJfJ1tEWyo4WXJtjLAF9bYLj214fuA@mail.gmail.com>
References: <1411531078-10671-1-git-send-email-thomas.ab@samsung.com>
	<026501cfd7ca$0857a140$1906e3c0$@kernel.org>
	<5422A635.2020607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <5422A635.2020607@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lukasz Majewski <l.majewski@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Viresh Kumar <viresh.kumar@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Tomasz,

On Wed, Sep 24, 2014 at 4:38 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On 24.09.2014 09:34, Kukjin Kim wrote:
>> Thomas Abraham wrote:
>>>
>>> This patch series removes the use of Exynos4210 and Exynos5250 specific cpufreq
>>> drivers and enables the use of cpufreq-cpu0 driver for these platforms. This
>>> series also enables cpufreq support for Exynos5420 using arm_big_little cpufreq
>>> driver.
>>>
>>> This patch series is dependent on two other patches
>>> 1. ARM: dts: add CPU nodes for Exynos4 SoCs
>>>    - https://lkml.org/lkml/2014/7/21/315
>>> 2. clk: exynos4: remove duplicate div_core2 divider clock instantiation
>>>    - http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg34859.html
>
> I have applied 2) to Samsung clock tree.

Ok.

>
>>>
>>> Thomas Abraham (6):
>>>   clk: samsung: add infrastructure to register cpu clocks
>>>   clk: samsung: add cpu clock configuration data and instantiate cpu clock
>>>   ARM: dts: Exynos: add CPU OPP and regulator supply property
>>>   ARM: Exynos: switch to using generic cpufreq driver for Exynos4210/5250/5420
>>>   cpufreq: exynos: remove exynos4210/5250 specific cpufreq driver support
>>>   clk: samsung: remove unused clock aliases and update clock flags
>>>
>>>  arch/arm/boot/dts/exynos4210-origen.dts         |    4 +
>>>  arch/arm/boot/dts/exynos4210-trats.dts          |    4 +
>>>  arch/arm/boot/dts/exynos4210-universal_c210.dts |    4 +
>>>  arch/arm/boot/dts/exynos4210.dtsi               |   14 +-
>>>  arch/arm/boot/dts/exynos5250-arndale.dts        |    4 +
>>>  arch/arm/boot/dts/exynos5250-smdk5250.dts       |    4 +
>>>  arch/arm/boot/dts/exynos5250-snow.dts           |    4 +
>>>  arch/arm/boot/dts/exynos5250.dtsi               |   25 ++-
>>>  arch/arm/boot/dts/exynos5420.dtsi               |   38 +++
>>>  arch/arm/mach-exynos/exynos.c                   |   24 ++-
>>>  drivers/clk/samsung/Makefile                    |    2 +-
>>>  drivers/clk/samsung/clk-cpu.c                   |  335 +++++++++++++++++++++++
>>>  drivers/clk/samsung/clk-cpu.h                   |   91 ++++++
>>>  drivers/clk/samsung/clk-exynos4.c               |   63 +++--
>>>  drivers/clk/samsung/clk-exynos5250.c            |   44 +++-
>>>  drivers/clk/samsung/clk-exynos5420.c            |   72 +++++-
>>>  drivers/cpufreq/Kconfig.arm                     |   22 --
>>>  drivers/cpufreq/Makefile                        |    2 -
>>>  include/dt-bindings/clock/exynos5250.h          |    1 +
>>>  include/dt-bindings/clock/exynos5420.h          |    2 +
>>
>> Looks good to me,
>> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
>>
>> BTW, who will handle this series? I think this is already ready for v3.18.
>
> I believe Viresh already acked this series too and since it does quite a
> lot of shuffling in clock code, I'd prefer to take this through clock
> tree, but apparently there is a dependency on patch 1), which already
> went through another tree?

Not yet. The v2 version of the patch does not cleanly apply and needs
to be refreshed.
Bartlomiej, would be posting an updated version of this patch?

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
