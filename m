From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 00/14] cpufreq: resource management in preparation for
 module build
Date: Tue, 3 Feb 2015 09:35:01 +0530
Message-ID: <CAKohpokgNwdYnc30yd72eJJtpwcDAHx=PmCRWRWPRuXLOq9bnw@mail.gmail.com>
References: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:49732 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbbBCEFC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Feb 2015 23:05:02 -0500
Received: by mail-ob0-f179.google.com with SMTP id wp4so6217038obc.10
        for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2015 20:05:01 -0800 (PST)
In-Reply-To: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>
Cc: Linux PM <linux-pm@vger.kernel.org>

On 3 February 2015 at 02:28, Eduardo Valentin <edubezval@gmail.com> wrote:
> Dear all,
>
> The exynos cpufreq driver needs to be build as module. The need is to fix
> the problem risen by Arnd due to the added OF thermal dependency [1].
>
> Therefore, this series, in preparation to allow building this driver as
> a module, changes the way this driver handles allocated resources. Now
> it is expected to free the allocated resources uppon driver exit.
>
> A couple of changes in the data structure organization and callbacks were necessary.
> Therefore, changes were added accordingly.
>
> Please review. I do not have a way to test these patch in a board today though. So, testing
> is more than welcome :-).
>
> [1] - https://lkml.org/lkml/2015/1/31/175
>
> Cheers,
>
> Eduardo Valentin (14):
>   cpufreq: exynos4210: properly put of node
>   cpufreq: exynos4210: iounmap in error path
>   cpufreq: exynos4210: use devm_clk_get
>   cpufreq: exynos4x12: properly put of node
>   cpufreq: exynos4x12: iounmap in error path
>   cpufreq: exynos4x12: use devm_clk_get
>   cpufreq: exynos5250: properly put of node
>   cpufreq: exynos5250: iounmap in error path
>   cpufreq: exynos5250: use devm_clk_get
>   cpufreq: exynox-cpufreq: pass exynos_dvfs_info to .set_freq callback
>   cpufreq: exynos4210: remove unused symbol cpufreq
>   cpufreq: exynos4x12: remove unused symbol cpufreq
>   cpufreq: exynos5250: remove unused symbol cpufreq
>   cpufreq: exynos-cpufreq: release resources by using managed allocation

Some of this might be unnecessary ..
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/304984.html

And please cc samsung maintainers next time ..
