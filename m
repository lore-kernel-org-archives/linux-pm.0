From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: Re: [PATCH v6 0/6] add cpuidle support for Exynos5420
Date: Thu, 29 May 2014 10:07:15 +0530
Message-ID: <CANuQgHGM_PsDO0RmEKDVXSs1u50VMuLrx-=0sYhDut1gSjspcg@mail.gmail.com>
References: <CANuQgHGSA+R__raSa_tzrgpceqLD2SZw+s0XQUHGF4wscgh6Kg@mail.gmail.com>
	<1400227438-27155-1-git-send-email-chander.kashyap@linaro.org>
	<53831795.9070006@gmail.com>
	<CANuQgHH284A9QY7M5zGbSE-mXjm2KDqr54VWmtKVkbma3zZvvw@mail.gmail.com>
	<015f01cf7a2e$3b141590$b13c40b0$@samsung.com>
	<5385A638.2000001@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5385A638.2000001@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On 28 May 2014 14:32, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> On 05/28/2014 06:35 AM, Kukjin Kim wrote:
>>
>> Chander Kashyap wrote:
>>>
>>>
>>> On 26 May 2014 15:59, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>>>>
>>>> Hi Chander,
>>>>
>>>> On 16.05.2014 10:03, Chander Kashyap wrote:
>>>>>
>>>>> Exynos5420 is a big-little Soc from Samsung. It has 4 A15 and 4 A=
7
>>>
>>> cores.
>>>>>
>>>>>
>>>>> This patchset adds cpuidle support for Exynos5420 SoC based on
>>>>> generic big.little cpuidle driver.
>>>>>
>>>>> Tested on SMDK5420.
>>>>>
>>>>> This patch set depends on:
>>>>>        1. [PATCH 0/5] MCPM backend for Exynos5420
>>>>>           http://www.spinics.net/lists/arm-kernel/msg331100.html
>>>>> Changelog is in respective patches.
>>>>> Chander Kashyap (5):
>>>>>    driver: cpuidle-big-little: add of_device_id structure
>>>>>    arm: exynos: add generic function to calculate cpu number
>>>>>    cpuidle: config: Add ARCH_EXYNOS entry to select cpuidle-big-l=
ittle
>>>>>      driver
>>>>>    driver: cpuidle: cpuidle-big-little: init driver for Exynos542=
0
>>>>>    exynos: cpuidle: do not allow cpuidle registration for Exynos5=
420
>>>>>    mcpm: exynos: populate suspend and powered_up callbacks
>>>>>
>>>>>   arch/arm/mach-exynos/exynos.c        |    4 +++-
>>>>>   arch/arm/mach-exynos/mcpm-exynos.c   |   36
>>>
>>> ++++++++++++++++++++++++++++++++++
>>>>>
>>>>>   arch/arm/mach-exynos/regs-pmu.h      |    9 +++++++++
>>>>>   drivers/cpuidle/Kconfig.arm          |    2 +-
>>>>>   drivers/cpuidle/cpuidle-big_little.c |   12 +++++++++++-
>>>>>   5 files changed, 60 insertions(+), 3 deletions(-)
>>>>>
>>>>
>>>> For the whole series,
>>>>
>>>> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
>>>
>>>
>>> Thanks Tomasz.
>>>
>>> Dear Kukjin,
>>> Can you take these patches.
>>>>
>>>>
>> When I looked at this series quickly, looks good to me but I need to=
 get
>> ack from cpuidle maintainer Rafael or Daniel.
>
>
> Acked the different cpuidle bits.

Hi Kukjin,
Can you take it now?


>
> Thanks
>   -- Daniel
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software f=
or ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>



--=20
with warm regards,
Chander Kashyap
