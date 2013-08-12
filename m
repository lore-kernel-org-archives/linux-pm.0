From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6 5/8] cpufreq:boost:Kconfig: Provide support for
 software managed BOOST
Date: Mon, 12 Aug 2013 15:58:12 +0530
Message-ID: <CAKohponDoGhAdGOyK5f2Pxreq5-ZazxmkdZWfbU3OwtOMKbiHA@mail.gmail.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
	<1374770011-22171-1-git-send-email-l.majewski@samsung.com>
	<1374770011-22171-6-git-send-email-l.majewski@samsung.com>
	<CAKohpokL57mXSQooX=4LZKtjMxJoXAB4uuzj13fgr3Gs7Wcf0A@mail.gmail.com>
	<20130726132120.5b9cf32f@amdc308.digital.local>
	<CAKohponvOXuHSS+-+m5PR9tPkAqkrYtjA3FJaNh9NJXrhQ9wmw@mail.gmail.com>
	<20130812122614.0d4d31a3@amdc308.digital.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:38929 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756269Ab3HLK2N (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2013 06:28:13 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so8860236obc.34
        for <linux-pm@vger.kernel.org>; Mon, 12 Aug 2013 03:28:12 -0700 (PDT)
In-Reply-To: <20130812122614.0d4d31a3@amdc308.digital.local>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, durgadoss.r@intel.com

On 12 August 2013 15:56, Lukasz Majewski <l.majewski@samsung.com> wrote:
> 1. at ./drivers/cpufreq/Kconfig:
>
> +config CPU_FREQ_BOOST_SW
> +       bool
> +       depends on THERMAL
>
> 2. at ./drivers/cpufreq/Kconfig.arm:
>
> +config ARM_EXYNOS_CPU_FREQ_BOOST_SW
> +       bool "EXYNOS Frequency Overclocking - Software"
> +       depends on ARM_EXYNOS_CPUFREQ
> +       select CPU_FREQ_BOOST_SW
> +       select EXYNOS_THERMAL
> +       default n
> +       help
> +         This driver supports software managed overclocking (BOOST).
> +         It allows usage of special frequencies for Samsung Exynos
> +         processors if thermal conditions are appropriate.
> +
> +         It reguires, for safe operation, thermal framework with
>   properly
> +         defined trip points.
> +
> +         If in doubt, say N.
> +
>
> Shall I split this patch to two (1. and 2.) or leave it as a single one?

Looks fine.. Keep it in a single patch.
