From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Fix build error on some platforms that use cpufreq_for_each_*
Date: Thu, 8 May 2014 11:09:02 +0530
Message-ID: <CAKohponPkv1gyCVca3Vigv2jSv7G49Jyu_dHDJ2BEMXDkfr-jw@mail.gmail.com>
References: <536A605D.6030009@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:47774 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbaEHFjD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 May 2014 01:39:03 -0400
Received: by mail-oa0-f41.google.com with SMTP id m1so2534303oag.0
        for <linux-pm@vger.kernel.org>; Wed, 07 May 2014 22:39:02 -0700 (PDT)
In-Reply-To: <536A605D.6030009@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 7 May 2014 22:03, Stratos Karafotis <stratosk@semaphore.gr> wrote:
> On platforms that use cpufreq_for_each_* macros, build fails if
> CONFIG_CPU_FREQ=n, e.g. ARM/shmobile/koelsch/non-multiplatform:
>
> drivers/built-in.o: In function `clk_round_parent':
> clkdev.c:(.text+0xcf168): undefined reference to `cpufreq_next_valid'
> drivers/built-in.o: In function `clk_rate_table_find':
> clkdev.c:(.text+0xcf820): undefined reference to `cpufreq_next_valid'
> make[3]: *** [vmlinux] Error 1
>
> Fix this making cpufreq_next_valid function inline and move it to
> cpufreq.h.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> ---
>  drivers/cpufreq/cpufreq.c | 11 -----------
>  include/linux/cpufreq.h   | 11 +++++++++--
>  2 files changed, 9 insertions(+), 13 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
