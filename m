From: Thomas Abraham <ta.omasab@gmail.com>
Subject: Re: [PATCH v7 0/6] cpufreq: use generic cpufreq drivers for exynos platforms
Date: Fri, 18 Jul 2014 07:34:10 +0530
Message-ID: <CAJuA9airHPrnkGMR9HvB3UmHeCyEfoPeujO+L7TfdXd_Z6SmOQ@mail.gmail.com>
References: <1405345118-4269-1-git-send-email-thomas.ab@samsung.com>
	<CAJuA9ahWbL8v2nS6wuDosn-bi+pga57KUe5wQN14Mot_-RTc6w@mail.gmail.com>
	<CAJuA9aiVFFZiN7_xBg6iQEX-LJKLMmHKvPhmdmOduouQzBtQJw@mail.gmail.com>
	<53C86DF3.1040303@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:36664 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbaGRCEM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jul 2014 22:04:12 -0400
In-Reply-To: <53C86DF3.1040303@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>

On Fri, Jul 18, 2014 at 6:14 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> Hi Thomas,
>
> On 07/17/2014 02:58 PM, Thomas Abraham wrote:
>> Hi Mike,
>>
>> On Tue, Jul 15, 2014 at 9:20 AM, Thomas Abraham <ta.omasab@gmail.com> wrote:
>>> Hi Tomasz,
>>>
>>> On Mon, Jul 14, 2014 at 7:08 PM, Thomas Abraham <thomas.ab@samsung.com> wrote:
>>>> Changes since v6:
>>>> - Fixes suggested by Amit Daniel <amit.daniel@samsung.com>.
>>>>
>>>> This patch series removes the use of Exynos4210 and Exynos5250 specific cpufreq
>>>> drivers and enables the use of cpufreq-cpu0 driver for these platforms. This
>>>> series also enabled cpufreq support for Exynos5420 using arm_big_little cpufreq
>>>> driver.
>>>>
>>>> Thomas Abraham (6):
>>>>   clk: samsung: add infrastructure to register cpu clocks
>>>>   clk: samsung: register exynos5420 apll/kpll configuration data
>>>>   clk: exynos: use cpu-clock provider type to represent arm clock
>>>>   ARM: dts: Exynos: add cpu nodes, opp and cpu clock configuration data
>>>>   ARM: Exynos: switch to using generic cpufreq driver for exynos4210/5250
>>>>   cpufreq: exynos: remove exynos4210/5250 specific cpufreq driver support
>>>
>>> In this series, support for Exynos5420 has been included. If there are
>>> any more changes required, could you please let me know.
>>
>> This patch series migrates exynos cpufreq support to use generic
>> cpufreq drivers. For this, cpu clock blocks are encapsulated into a
>> cpu clock type and cpufreq driver operates the cpu clock type.
>>
>> We had discussed in the [1] about using coordinated clocks. This
>> series is not using the concept of coordinated clocks but the code in
>> this series can be migrated to use coordinated clocks when it is
>> available.
>>
>> Is it okay to consider this series for v3.17-rc1. I will update this
>> code to use coordinated clocks when it is available. This series helps
>> with cpufreq support for newer Exynos SoCs such as Exynos5420/3250.
>>
>> [1] http://www.spinics.net/lists/cpufreq/msg10042.html
>>
>
> I tested this patchset with Exynos3250 cpufreq patchset[1] on Exynos3250 SoC.
>  [1] https://lkml.org/lkml/2014/6/18/126
>
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>

Hi Chanwoo,

Thanks for using these patches for Exynos3250 cpufreq support.

Regards,
Thomas.


>
> Best Regards,
> Chanwoo Choi
>
