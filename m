From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6 0/7] cpufreq: add generic cpufreq driver support for
 Exynos542x/5800 platforms
Date: Wed, 16 Dec 2015 07:44:46 +0530
Message-ID: <20151216021446.GC3111@ubuntu>
References: <1450200801-24539-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33142 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932944AbbLPCOu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2015 21:14:50 -0500
Received: by mail-pf0-f171.google.com with SMTP id e66so3806008pfe.0
        for <linux-pm@vger.kernel.org>; Tue, 15 Dec 2015 18:14:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1450200801-24539-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ben Gamari <ben@smart-cactus.org>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 15-12-15, 18:33, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> This patch series adds generic cpufreq-dt driver support for
> Exynos542x/5800 (using the new CPU clock type which allows it).
> 
> It has been tested on Exynos5422 based ODROID-XU3 Lite board.
> 
> Depends on:
> - next-20151211 branch of linux-next kernel tree
> - "[PATCH] ARM: dts: Make CPU configuration more readable for
>   exynos542x/5800" patch (https://lkml.org/lkml/2015/12/11/107)
> 
> Changes since v5:
> - rebased over next-20151211 branch (something is broken in
>   newer branches, namely next-2015121[45])
> - rebased on top of "ARM: dts: Make CPU configuration more
>   readable for exynos542x/5800" patch
> - renamed cpu0_opp_table to cluster_a15_opp_table and
>   cpu1_opp_table to cluster_a7_opp_table
> - added Reviewed-by from Krzysztof

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
