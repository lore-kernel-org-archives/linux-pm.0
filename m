From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v9 4/6] ARM: Exynos: switch to using generic cpufreq driver for Exynos4210/5250/5420
Date: Mon, 25 Aug 2014 08:32:01 -0700
Message-ID: <7h8umc60we.fsf@paris.lan>
References: <1406707663-16656-1-git-send-email-thomas.ab@samsung.com>
	<1406707663-16656-5-git-send-email-thomas.ab@samsung.com>
	<53DA8BB9.6020702@samsung.com> <53DA8D85.3050106@gmail.com>
	<7hbnrc6px3.fsf@paris.lan> <53F7DA13.6090305@gmail.com>
	<CADWw7OgAS-z-UOrJU-hL2fzuefJmLtCTg57jYk2Df7f5KfLJmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CADWw7OgAS-z-UOrJU-hL2fzuefJmLtCTg57jYk2Df7f5KfLJmA@mail.gmail.com>
	(Chander Kashyap's message of "Mon, 25 Aug 2014 17:45:07 +0530")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chander Kashyap <k.chander@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, amit.kucheria@linaro.org, Chanwoo Choi <cw00.choi@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linaro-kernel@lists.linaro.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Chander,

Chander Kashyap <k.chander@samsung.com> writes:

[...]

>>> I'm trying it on the 5800/Chromebook2 and it's not terribly stable.  I'm
>>> testing along with CPUidle, so there may be some untested interactions
>>> there as it seems a bit more stable without CPUidle enabled.
>>>
>>> I'd love to hear from anyone else that's testing CPUidle and CPUfreq
>>> together big.LITTLE 5420/5800, with or without the switcher.
>
> I have tested this patch series on SMDK5420 with cpuidle (with and
> without b.L switcher enabled).
>
> As of now voltage scaling support is not there in generic big-little
> cpufreq driver (arm_big_little.c).
> Hence need to tie arm and kfc voltages to highest level for testing.

> Without this change stability issues are there, but with this change
> everything is stable.

Can you clarify how you're setting the voltages to ensure stability?

Tomasz, I didn't mean to suggest this isn't ready for mainline.  For the
5420/5800 it seems cpufreq support is a new feature, so this isn't a
regression against previous (mainline) behavior.  Maybe the big.LITTLE
cpufreq support should've been separated out from the cleanup since it's
more of a new feature, but that's up to you.

Kevin
