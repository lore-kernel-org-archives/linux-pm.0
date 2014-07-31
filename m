From: Thomas Abraham <ta.omasab@gmail.com>
Subject: Re: [PATCH v9 4/6] ARM: Exynos: switch to using generic cpufreq
 driver for Exynos4210/5250/5420
Date: Fri, 1 Aug 2014 00:55:26 +0530
Message-ID: <CAJuA9ahz_aybnFER+0JNizAto1pJNoTunPVTgF4tZCMLqHtm-g@mail.gmail.com>
References: <1406707663-16656-1-git-send-email-thomas.ab@samsung.com>
	<1406707663-16656-5-git-send-email-thomas.ab@samsung.com>
	<53DA8BB9.6020702@samsung.com>
	<53DA8D85.3050106@gmail.com>
	<53DA90DD.6090704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:34249 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752946AbaGaTZ2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Jul 2014 15:25:28 -0400
In-Reply-To: <53DA90DD.6090704@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Aug 1, 2014 at 12:24 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>
>
> On 31.07.2014 20:40, Tomasz Figa wrote:
>> Kukjin,
>>
>> On 31.07.2014 20:32, Kukjin Kim wrote:
>>> On 07/30/14 17:07, Thomas Abraham wrote:
>>>> The new CPU clock type allows the use of generic CPUfreq drivers. So for
>>>> Exynos4210/5250, switch to using generic cpufreq driver. For Exynos5420,
>>>> which did not have CPUfreq driver support, enable the use of generic
>>>> CPUfreq driver.
>>>>
>>>> Suggested-by: Tomasz Figa<t.figa@samsung.com>
>>>> Cc: Kukjin Kim<kgene.kim@samsung.com>
>>>
>>> Looks good to me,
>>>
>>> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
>>>
>>> BTW, who will handle this series? I hope see this series in 3.17.
>>
>> This series consists mostly of clock changes and it likely depends on
>> patches already in my for-next, so I would be inclined toward taking it
>> through samsung-clk tree. However, for this I would need Acks for patch
>> 5/6 from Viresh and for patches [1] and [2] (which are dependencies of
>> this series) from you. I also need to make sure that the two mentioned
>> patches don't have any dependencies already in your tree.
>>
>> [1] ARM: dts: add CPU nodes for Exynos4 SoCs
>>    - https://lkml.org/lkml/2014/7/21/315
>> [2] ARM: dts: smdk5250: Specify MAX77686 pmic interrupt
>>    - http://www.spinics.net/lists/arm-kernel/msg351134.html
>
> Aha, I'm not quite sure we really want to hurry with this series for
> 3.17. I'd prefer it to be picked up early after 3.17-rc1 shows up to sit
> in linux-next for a while an be thoroughly tested on a number of boards.

The v9 revision of this series has completed about 2 days of testing
now on 4210/5250/5420 boards. I will let it run for few more days. For
v8 and previous versions, the tests had completed 3 or more days. So I
really don't think there is anything fundamentally wrong with this
series. It would be nice to have this series merged and we start
migrating other Exynos based boards to use generic cpufreq drivers.

Thanks,
Thomas.

>
> This would also have the advantage of having the two patches mentioned
> above already merged.
>
> Best regards,
> Tomasz
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
