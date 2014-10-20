From: Thomas Abraham <ta.omasab@gmail.com>
Subject: Re: [PATCH v11 0/6] cpufreq: use generic cpufreq drivers for exynos platforms
Date: Mon, 20 Oct 2014 17:18:45 +0530
Message-ID: <CAJuA9ajv_e0FriiPL0aHWLv7+AoZAF2E+G-0r6UGC6RzxM_wmA@mail.gmail.com>
References: <1413805281-6269-1-git-send-email-thomas.ab@samsung.com>
	<5444F38A.1000101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <5444F38A.1000101@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Tomasz,

On Mon, Oct 20, 2014 at 5:05 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On 20.10.2014 13:41, Thomas Abraham wrote:
>> Changes since v10:
>> - Rebased on top of v3.18-rc1
>>
>> This patch series removes the use of Exynos4210 and Exynos5250 specific cpufreq
>> drivers and enables the use of cpufreq-dt driver for these platforms. This
>> series also enables cpufreq support for Exynos5420 using arm_big_little cpufreq
>> driver.
>>
>> This patch series is based and tested on v3.18-rc1 and depends on the patch
>> - "clk: exynos4: remove duplicate div_core2 divider clock instantiation"
>>   (http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg34859.html)
>>   This patch has been merged in "arm-soc/samsung/dt3" branch of arm-soc tree.
>>
>
> That patch actually went through clock tree, but it doesn't matter,
> because AFAIK all the dependencies for this series are already in
> 3.18-rc1. I'll try to apply it in next days

Thanks. The patch "clk: exynos4: remove duplicate div_core2 divider
clock instantiation" is not available in 3.18-rc1. So for testing, I
picked this patch from samsung/dt3 branch from arm-soc tree.

Regards,
Thomas.


>
> Best regards,
> Tomasz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
