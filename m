From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v9 4/6] ARM: Exynos: switch to using generic cpufreq driver
 for Exynos4210/5250/5420
Date: Thu, 31 Jul 2014 21:30:56 +0200
Message-ID: <53DA9970.5010202@gmail.com>
References: <1406707663-16656-1-git-send-email-thomas.ab@samsung.com>	<1406707663-16656-5-git-send-email-thomas.ab@samsung.com>	<53DA8BB9.6020702@samsung.com>	<53DA8D85.3050106@gmail.com>	<53DA90DD.6090704@gmail.com> <CAJuA9ahz_aybnFER+0JNizAto1pJNoTunPVTgF4tZCMLqHtm-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAJuA9ahz_aybnFER+0JNizAto1pJNoTunPVTgF4tZCMLqHtm-g@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <ta.omasab@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
List-Id: linux-pm@vger.kernel.org

On 31.07.2014 21:25, Thomas Abraham wrote:
> On Fri, Aug 1, 2014 at 12:24 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>>
>>
>> On 31.07.2014 20:40, Tomasz Figa wrote:
>>> Kukjin,
>>>
>>> On 31.07.2014 20:32, Kukjin Kim wrote:
>>>> On 07/30/14 17:07, Thomas Abraham wrote:
>>>>> The new CPU clock type allows the use of generic CPUfreq drivers. So for
>>>>> Exynos4210/5250, switch to using generic cpufreq driver. For Exynos5420,
>>>>> which did not have CPUfreq driver support, enable the use of generic
>>>>> CPUfreq driver.
>>>>>
>>>>> Suggested-by: Tomasz Figa<t.figa@samsung.com>
>>>>> Cc: Kukjin Kim<kgene.kim@samsung.com>
>>>>
>>>> Looks good to me,
>>>>
>>>> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
>>>>
>>>> BTW, who will handle this series? I hope see this series in 3.17.
>>>
>>> This series consists mostly of clock changes and it likely depends on
>>> patches already in my for-next, so I would be inclined toward taking it
>>> through samsung-clk tree. However, for this I would need Acks for patch
>>> 5/6 from Viresh and for patches [1] and [2] (which are dependencies of
>>> this series) from you. I also need to make sure that the two mentioned
>>> patches don't have any dependencies already in your tree.
>>>
>>> [1] ARM: dts: add CPU nodes for Exynos4 SoCs
>>>    - https://lkml.org/lkml/2014/7/21/315
>>> [2] ARM: dts: smdk5250: Specify MAX77686 pmic interrupt
>>>    - http://www.spinics.net/lists/arm-kernel/msg351134.html
>>
>> Aha, I'm not quite sure we really want to hurry with this series for
>> 3.17. I'd prefer it to be picked up early after 3.17-rc1 shows up to sit
>> in linux-next for a while an be thoroughly tested on a number of boards.
> 
> The v9 revision of this series has completed about 2 days of testing
> now on 4210/5250/5420 boards. I will let it run for few more days. For
> v8 and previous versions, the tests had completed 3 or more days. So I
> really don't think there is anything fundamentally wrong with this
> series. It would be nice to have this series merged and we start
> migrating other Exynos based boards to use generic cpufreq drivers.

We have 22 Exynos-based boards currently supported in mainline. Is the
testing running on all of them? This is the purpose of linux-next and
for series that completely replace one driver with another I'd consider
this as the only reasonable choice, if not keeping the old driver for a
release.

Of course we have never had good testing traditions on Samsung SoC (see
OMAP and Tegra baseline tests), but does it mean that we shouldn't start
doing the right thing?

Best regards,
Tomasz
