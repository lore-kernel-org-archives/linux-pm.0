From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v9 4/6] ARM: Exynos: switch to using generic cpufreq
 driver for Exynos4210/5250/5420
Date: Tue, 26 Aug 2014 08:15:40 -0700
Message-ID: <CAGa+x85-Anb+HsSUQRaaeex19-HK+yZDW0UpFBwAtsQ8Sf2Aqg@mail.gmail.com>
References: <1406707663-16656-1-git-send-email-thomas.ab@samsung.com>
	<1406707663-16656-5-git-send-email-thomas.ab@samsung.com>
	<53DA8BB9.6020702@samsung.com>
	<53DA8D85.3050106@gmail.com>
	<7hbnrc6px3.fsf@paris.lan>
	<53F7DA13.6090305@gmail.com>
	<CADWw7OgAS-z-UOrJU-hL2fzuefJmLtCTg57jYk2Df7f5KfLJmA@mail.gmail.com>
	<7h8umc60we.fsf@paris.lan>
	<CADWw7OgW+o3tB=ptnsy-PsmXmNv8oXzt_WfK6NswQiEWWwAzNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:61185 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177AbaHZPPl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Aug 2014 11:15:41 -0400
Received: by mail-qg0-f53.google.com with SMTP id z60so11249364qgd.40
        for <linux-pm@vger.kernel.org>; Tue, 26 Aug 2014 08:15:40 -0700 (PDT)
In-Reply-To: <CADWw7OgW+o3tB=ptnsy-PsmXmNv8oXzt_WfK6NswQiEWWwAzNA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chander Kashyap <k.chander@samsung.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Amit Kucheria <amit.kucheria@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>

On Mon, Aug 25, 2014 at 10:25 PM, Chander Kashyap <k.chander@samsung.com> wrote:
> Hi Kevin,
>
> On Mon, Aug 25, 2014 at 9:02 PM, Kevin Hilman <khilman@linaro.org> wrote:
>> Hi Chander,
>>
>> Chander Kashyap <k.chander@samsung.com> writes:
>>
>> [...]
>>
>>>>> I'm trying it on the 5800/Chromebook2 and it's not terribly stable.  I'm
>>>>> testing along with CPUidle, so there may be some untested interactions
>>>>> there as it seems a bit more stable without CPUidle enabled.
>>>>>
>>>>> I'd love to hear from anyone else that's testing CPUidle and CPUfreq
>>>>> together big.LITTLE 5420/5800, with or without the switcher.
>>>
>>> I have tested this patch series on SMDK5420 with cpuidle (with and
>>> without b.L switcher enabled).
>>>
>>> As of now voltage scaling support is not there in generic big-little
>>> cpufreq driver (arm_big_little.c).
>>> Hence need to tie arm and kfc voltages to highest level for testing.
>>
>>> Without this change stability issues are there, but with this change
>>> everything is stable.
>>
>> Can you clarify how you're setting the voltages to ensure stability?
>
> below is the diff :  wip/exynos/integ

Thanks.

I've applied your patch, and bootup shows vdd_arm and vdd_kfc at
1500mV, but still when booting with cpuidle enabled (bL switcher
disabled), I'm seeing lockups with no kernel output.  With CPUidle
disabled, things are pretty stable.

What tree are you using to test this out on 5420?  I'm using mainline
v3.17-rc1 + DT patch for CPUidle and this cpufreq series.  See my
wip/exynos/integ branch at
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux.git.

Are there other out of tree dependencies that I'm missing?  Is the
max77802 regulator support that's in mainline sufficient?  or am I
missing some stuff there?

Kevin
