From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH v9 4/6] ARM: Exynos: switch to using generic cpufreq driver
 for Exynos4210/5250/5420
Date: Mon, 25 Aug 2014 17:56:36 +0200
Message-ID: <53FB5CB4.4050705@samsung.com>
References: <1406707663-16656-1-git-send-email-thomas.ab@samsung.com>
 <1406707663-16656-5-git-send-email-thomas.ab@samsung.com>
 <53DA8BB9.6020702@samsung.com> <53DA8D85.3050106@gmail.com>
 <7hbnrc6px3.fsf@paris.lan> <53F7DA13.6090305@gmail.com>
 <CADWw7OgAS-z-UOrJU-hL2fzuefJmLtCTg57jYk2Df7f5KfLJmA@mail.gmail.com>
 <7h8umc60we.fsf@paris.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:47450 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932811AbaHYP4l (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Aug 2014 11:56:41 -0400
In-reply-to: <7h8umc60we.fsf@paris.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>, Chander Kashyap <k.chander@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Mike Turquette <mturquette@linaro.org>, =?windows-1252?Q?Heiko_St=FCbn?= =?windows-1252?Q?er?= <heiko@sntech.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, amit.kucheria@linaro.org, Chanwoo Choi <cw00.choi@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linaro-kernel@lists.linaro.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>

On 25.08.2014 17:32, Kevin Hilman wrote:
> Hi Chander,
> 
> Chander Kashyap <k.chander@samsung.com> writes:
> 
> [...]
> 
>>>> I'm trying it on the 5800/Chromebook2 and it's not terribly stable.  I'm
>>>> testing along with CPUidle, so there may be some untested interactions
>>>> there as it seems a bit more stable without CPUidle enabled.
>>>>
>>>> I'd love to hear from anyone else that's testing CPUidle and CPUfreq
>>>> together big.LITTLE 5420/5800, with or without the switcher.
>>
>> I have tested this patch series on SMDK5420 with cpuidle (with and
>> without b.L switcher enabled).
>>
>> As of now voltage scaling support is not there in generic big-little
>> cpufreq driver (arm_big_little.c).
>> Hence need to tie arm and kfc voltages to highest level for testing.
> 
>> Without this change stability issues are there, but with this change
>> everything is stable.
> 
> Can you clarify how you're setting the voltages to ensure stability?
> 
> Tomasz, I didn't mean to suggest this isn't ready for mainline.

I haven't said that either. I'd just like to know in what state this
series is in case of those SoCs. However, if there are stability issues
on them, there is also a chance that the same is true for other boards.

Anyway, we're early in releasy cycle, so probably we could get better
test coverage with this series in linux-next.

Kukjin, Viresh, how would you want to proceed with merging it? It
touches mach-exynos, cpufreq and samsung-clk, so it is non-trivial to
merge. However as far as I can see the cpufreq-related changes are just
a number of full file deletes and minor Makefile/Kconfig updates. It
will be more difficult with mach-exynos changes, as they are more likely
to produce conflict.

The only solution that comes to my mind is that I first apply patches 1
and 2, create a stable branch for Kukjin, then he applies patches 3, 4,
and 5 and creates a stable branch for me, on top of which I apply patch 6.

Best regards,
Tomasz
