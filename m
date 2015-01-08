From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v12 0/6] cpufreq: use generic cpufreq drivers for exynos platforms
Date: Thu, 8 Jan 2015 13:17:35 -0800
Message-ID: <CAMAWPa9fUJVjJ8V+93AkHy9DtEmUUnGs4MJDGcsoMdWwGmg5qg@mail.gmail.com>
References: <1416576682-5255-1-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38706 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752315AbbAHVRm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 8 Jan 2015 16:17:42 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id EFF87204E0
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2015 21:17:40 +0000 (UTC)
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com [209.85.212.182])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id CFE93204E1
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2015 21:17:37 +0000 (UTC)
Received: by mail-wi0-f182.google.com with SMTP id h11so5984428wiw.3
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2015 13:17:35 -0800 (PST)
In-Reply-To: <1416576682-5255-1-git-send-email-thomas.ab@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>

On Fri, Nov 21, 2014 at 5:31 AM, Thomas Abraham <thomas.ab@samsung.com> wrote:
> Changes since v11:
> - Rebased on top of git://linuxtv.org/snawrocki/samsung.git for-v3.19-exynos-clk
>
> This patch series removes the use of Exynos4210 and Exynos5250 specific cpufreq
> drivers and enables the use of cpufreq-dt driver for these platforms. This
> series also enables cpufreq support for Exynos5420 using arm_big_little cpufreq
> driver.
>
> This series is based on the following branch.
> git://linuxtv.org/snawrocki/samsung.git for-v3.19-exynos-clk
>
> This series depends on the following patch which can be picked from
> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git samsung/dt
> e540920cf21c (ARM: dts: add CPU nodes for Exynos4 SoCs).
>
> This patch series has been tested on Exynos4210/5250/5420 based boards.
> Tomasz Figa had plans to take this in the Samsung clock tree for v3.19
> (http://www.spinics.net/lists/linux-samsung-soc/msg37933.html).
> Sylwester, could you consider to merge this in your tree?

CPUfreq for exynos is still not upstream.  What's the status of this
series?  It's been ver a month since there's been any activity here
(or any responses to the issues I reported.)

On a related note, this series only does frequency scaling. Is there
any work going on to also enable voltage scaling for the CPU rails as
well?

Thanks,

Kevin
