From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 00/14] cpufreq: resource management in preparation for
 module build
Date: Wed, 04 Feb 2015 09:52:44 +0100
Message-ID: <20150204095244.25a56a0a@amdc2363>
References: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:48784 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932953AbbBDIwv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Feb 2015 03:52:51 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NJ800HH3OO11C90@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 04 Feb 2015 17:52:49 +0900 (KST)
In-reply-to: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>

Hi Eduardo,

> Dear all,
> 
> The exynos cpufreq driver needs to be build as module. 

I might be wrong, but as fair as I remember there was a discussion
(when BOOST was developed) about having CPUfreq build as a module.

And the answer then was that it is not feasible to have cpufreq
compiled as a module, because it is an integral part of the platform.

After regarding [1]:

I can imagine that in "real life" (not caused by build allmodconf error)
we might want to insert cpufreq module (including core and e.g.
Exynos4412 specific callbacks) after booting the board.

However, it seems hard to predict problems which emerge when we would
like to remove cpufreq support (especially data in exynos4x12-cpufreq.c
- responsible for setting APLL/MPLL) after some time. 

And one more thought - why (as of 3.19.0-rc5) there is no tri state on
CONFIG_CPU_FREQ? Is there any ongoing work to provide this?


> The need is to
> fix the problem risen by Arnd due to the added OF thermal dependency
> [1].
> 
> Therefore, this series, in preparation to allow building this driver
> as a module, changes the way this driver handles allocated resources.
> Now it is expected to free the allocated resources uppon driver exit.
> 
> A couple of changes in the data structure organization and callbacks
> were necessary. Therefore, changes were added accordingly.
> 
> Please review. I do not have a way to test these patch in a board
> today though. So, testing is more than welcome :-).
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
	     ^^^^^^ exynos

>   cpufreq: exynos4210: remove unused symbol cpufreq
>   cpufreq: exynos4x12: remove unused symbol cpufreq
>   cpufreq: exynos5250: remove unused symbol cpufreq
>   cpufreq: exynos-cpufreq: release resources by using managed
> allocation
> 
>  drivers/cpufreq/exynos-cpufreq.c     | 101
> ++++++++++++++++++++++-------------
> drivers/cpufreq/exynos-cpufreq.h     |   7 ++-
> drivers/cpufreq/exynos4210-cpufreq.c |  47 ++++++++--------
> drivers/cpufreq/exynos4x12-cpufreq.c |  49 +++++++++--------
> drivers/cpufreq/exynos5250-cpufreq.c |  49 +++++++++-------- 5 files
> changed, 140 insertions(+), 113 deletions(-)
> 

Eduardo, could you provide the exact information about the branch (and
any prerequisite patches) on which shall I apply this work?

I'm able to test it on Exynos 4210, 4x12 and 5250.

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
