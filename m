From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 0/2] cpufreq: exynos: Fixes for v3.12
Date: Fri, 11 Oct 2013 13:22:57 +0200
Message-ID: <1457107.oQjJi4YKRz@vostro.rjw.lan>
References: <1380108138-30402-1-git-send-email-l.majewski@samsung.com> <1381320523-28183-1-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50879 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932485Ab3JKLLM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Oct 2013 07:11:12 -0400
In-Reply-To: <1381320523-28183-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, Yadwinder Singh Brar <yadi.brar01@gmail.com>, Tomasz Figa <t.figa@samsung.com>

On Wednesday, October 09, 2013 02:08:41 PM Lukasz Majewski wrote:
> Attached commits provide cpufreq regression fixes for Trats and Trats2
> Exynos4 boards.
> Since v3.12 Exynos4 uses common clock framework for clock manipulation.
> Those patches restore correct output for cpuinfo_cur_freq [1] sysfs
> attribute.
> Without them, the [1] provides default frequency (800 MHz) set at driver
> initialization.
> 
> 
> Lukasz Majewski (2):
>   cpufreq: exynos4x12: Use the common clock framework to set APLL clock
>     rate
>   cpufreq: exynos4210: Use the common clock framework to set APLL clock
>     rate
> 
>  drivers/cpufreq/exynos4210-cpufreq.c |   67 ++++-----------------------------
>  drivers/cpufreq/exynos4x12-cpufreq.c |   69 ++++------------------------------
>  2 files changed, 16 insertions(+), 120 deletions(-)

Can you please resend [1/2], it got lost somewhere (at least I can't see it
now)?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
