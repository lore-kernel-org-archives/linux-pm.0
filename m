From: Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH v3 0/4] ARM: EXYNOS: cpuidle: fix AFTR mode on boards with
 secure firmware enabled
Date: Mon, 14 Jul 2014 16:41:25 +0100
Message-ID: <CAD8Lp46mp-tHcwGpFd0YHRDE4pKWDoPpUvu-Y0QzxSi-jnYtWg@mail.gmail.com>
References: <1404926274-18411-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:62709 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755709AbaGNPl1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jul 2014 11:41:27 -0400
Received: by mail-wg0-f46.google.com with SMTP id m15so4315301wgh.17
        for <linux-pm@vger.kernel.org>; Mon, 14 Jul 2014 08:41:25 -0700 (PDT)
In-Reply-To: <1404926274-18411-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org

Hi Bartlomiej,

On Wed, Jul 9, 2014 at 6:17 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> This patch series adds support for AFTR idle mode on boards with
> secure firmware enabled and allows EXYNOS cpuidle driver usage on
> Exynos4x12 SoCs.
>
> It has been tested on Trats2 board (using Exynos4412 SoC with secure
> firmware enabled) on which AFTR mode reduces power consumption by ~12%
> when EXYNOS cpuidle driver is enabled (in both cases the default
> exynos_defconfig config is used and CPU1-3 are offlined).

Thanks for this, I have tested it on ODROID-U2.

I don't have any equipment to measure the power usage, but after
offlining CPUs 1,2,3 via sysfs "online" file, a printk I added
confirms that the system is going to enter aftr mode, and system
stability seems as good as ever.

Is there any automatic way that the cpus should be offlined, or is the
intention that it must be done "by hand" like this?

Thanks,
Daniel
