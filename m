From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq-dt: add suspend frequency support
Date: Thu, 3 Sep 2015 08:20:19 +0530
Message-ID: <20150903025019.GA13140@linux>
References: <1441212121-21021-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35762 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756335AbbICCu3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2015 22:50:29 -0400
Received: by pacfv12 with SMTP id fv12so31348152pac.2
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2015 19:50:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1441212121-21021-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 02-09-15, 18:42, Bartlomiej Zolnierkiewicz wrote:
> Add suspend frequency support and set it to the boot frequency,
> this matches what the old exynos-cpufreq driver has been doing.
> 
> This patch fixes suspend/resume support on Exynos4412 based
> Trats2 board and reboot hang on Exynos4412 based Odroid U3
> board.
> 
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> This patch supersedes "[PATCH] ARM: dts: exynos4412-odroid-*: add
> workaround for CPUfreq/reboot issue" one from yesterday.
> 
>  drivers/cpufreq/cpufreq-dt.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index c3583cd..c9138c7 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -329,6 +329,10 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	policy->driver_data = priv;
>  
>  	policy->clk = cpu_clk;
> +
> +	/* capture boot frequency */
> +	policy->suspend_freq = clk_get_rate(cpu_clk) / 1000;;

We should be using opp-v2's suspend-opp thing for this now..

-- 
viresh
