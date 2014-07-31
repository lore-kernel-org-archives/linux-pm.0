From: Thomas Abraham <ta.omasab@gmail.com>
Subject: Re: [PATCH v9 0/6] cpufreq: use generic cpufreq drivers for exynos platforms
Date: Fri, 1 Aug 2014 00:04:10 +0530
Message-ID: <CAJuA9ajCP85aWL8ke_2sZ0bNXYxPHOLDHMfTVG1F7Z1aMCAyNA@mail.gmail.com>
References: <1406707663-16656-1-git-send-email-thomas.ab@samsung.com>
	<53DA4F73.5040400@gmail.com>
	<CAJuA9ahoke1b+=TgJQ0tfb4dKh4QmT7w1PoLkB0pZueWr0Awkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:47997 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbaGaSeM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Jul 2014 14:34:12 -0400
In-Reply-To: <CAJuA9ahoke1b+=TgJQ0tfb4dKh4QmT7w1PoLkB0pZueWr0Awkw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>

Hi Viresh,

On Thu, Jul 31, 2014 at 11:55 PM, Thomas Abraham <ta.omasab@gmail.com> wrote:
> On Thu, Jul 31, 2014 at 7:45 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> Hi Thomas,
>>
>> On 30.07.2014 10:07, Thomas Abraham wrote:
>>> Changes since v8:
>>> - Fixes suggested by Tomasz Figa.
>>>
>>> This patch series removes the use of Exynos4210 and Exynos5250 specific cpufreq
>>> drivers and enables the use of cpufreq-cpu0 driver for these platforms. This
>>> series also enables cpufreq support for Exynos5420 using arm_big_little cpufreq
>>> driver.
>>>
>>> This patch series is dependent on two other patches
>>> 1. ARM: dts: add CPU nodes for Exynos4 SoCs
>>>    - https://lkml.org/lkml/2014/7/21/315
>>> 2. ARM: dts: smdk5250: Specify MAX77686 pmic interrupt
>>>    - http://www.spinics.net/lists/arm-kernel/msg351134.html
>>> 3. clk: exynos4: remove duplicate div_core2 divider clock instantiation
>>>    - http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg34859.html
>>
>> I think we are at final stage of works on this series. Thanks for your
>> cooperation.
>>
>> After addressing remaining minor comments from this thread, feel free to
>> add:
>>
>> Reviewed-by: Tomasz Figa <t.figa@samsung.com>

You had acked the cpufreq related changes in  v7 of this series. But
there were some changes in v8 and so I have not included your Ack for
v8 and v9. Could you please have one more look at the patches 4/6 [1]
and 5/6 [2] of this v9 series and let me know if it looks okay.

[1] http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg34865.html
[2] http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg34864.html

Thanks,
Thomas.

>
> Hi Tomasz,
>
> Thanks for your review of this series. Your review comments has helped
> to make this series better.
>
> Regards,
> Thomas.
>
>>
>> Best regards,
>> Tomasz
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
