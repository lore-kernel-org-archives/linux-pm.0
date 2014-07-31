From: Thomas Abraham <ta.omasab@gmail.com>
Subject: Re: [PATCH v9 0/6] cpufreq: use generic cpufreq drivers for exynos platforms
Date: Thu, 31 Jul 2014 23:55:49 +0530
Message-ID: <CAJuA9ahoke1b+=TgJQ0tfb4dKh4QmT7w1PoLkB0pZueWr0Awkw@mail.gmail.com>
References: <1406707663-16656-1-git-send-email-thomas.ab@samsung.com>
	<53DA4F73.5040400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <53DA4F73.5040400@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 31, 2014 at 7:45 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Thomas,
>
> On 30.07.2014 10:07, Thomas Abraham wrote:
>> Changes since v8:
>> - Fixes suggested by Tomasz Figa.
>>
>> This patch series removes the use of Exynos4210 and Exynos5250 specific cpufreq
>> drivers and enables the use of cpufreq-cpu0 driver for these platforms. This
>> series also enables cpufreq support for Exynos5420 using arm_big_little cpufreq
>> driver.
>>
>> This patch series is dependent on two other patches
>> 1. ARM: dts: add CPU nodes for Exynos4 SoCs
>>    - https://lkml.org/lkml/2014/7/21/315
>> 2. ARM: dts: smdk5250: Specify MAX77686 pmic interrupt
>>    - http://www.spinics.net/lists/arm-kernel/msg351134.html
>> 3. clk: exynos4: remove duplicate div_core2 divider clock instantiation
>>    - http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg34859.html
>
> I think we are at final stage of works on this series. Thanks for your
> cooperation.
>
> After addressing remaining minor comments from this thread, feel free to
> add:
>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Hi Tomasz,

Thanks for your review of this series. Your review comments has helped
to make this series better.

Regards,
Thomas.

>
> Best regards,
> Tomasz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
