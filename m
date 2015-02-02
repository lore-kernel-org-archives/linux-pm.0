From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 00/14] cpufreq: resource management in preparation for module build
Date: Mon, 02 Feb 2015 23:54:14 +0100
Message-ID: <2098692.BxEgDJcz1q@vostro.rjw.lan>
References: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58431 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965109AbbBBWbV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Feb 2015 17:31:21 -0500
In-Reply-To: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

On Monday, February 02, 2015 04:58:03 PM Eduardo Valentin wrote:
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
> 
>  drivers/cpufreq/exynos-cpufreq.c     | 101 ++++++++++++++++++++++-------------
>  drivers/cpufreq/exynos-cpufreq.h     |   7 ++-
>  drivers/cpufreq/exynos4210-cpufreq.c |  47 ++++++++--------
>  drivers/cpufreq/exynos4x12-cpufreq.c |  49 +++++++++--------
>  drivers/cpufreq/exynos5250-cpufreq.c |  49 +++++++++--------
>  5 files changed, 140 insertions(+), 113 deletions(-)

Since this only seems to touch the Exynos files, I'm leaving the cpufreq part
of it to Viresh.

Eventually, it should go it through the Samsung tree anyway.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
