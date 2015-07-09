From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 0/4] cpufreq: use generic cpufreq drivers for
 Exynos5250 platform
Date: Thu, 9 Jul 2015 15:52:54 +0530
Message-ID: <20150709102254.GA5627@linux>
References: <1435756238-845-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35501 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbbGIKW7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2015 06:22:59 -0400
Received: by pactm7 with SMTP id tm7so148496297pac.2
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2015 03:22:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1435756238-845-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 01-07-15, 15:10, Bartlomiej Zolnierkiewicz wrote:
> This patch series removes the use of Exynos5250 specific support
> from cpufreq-exynos driver and enables the use of cpufreq-dt driver
> for this platform.
> 
> This patch series has been tested on Exynos5250 based Arndale board.
> 
> Changes since v1 (http://lkml.org/lkml/2015/4/13/611):
> - rebased on top of next-20150629 branch of linux-next kernel tree
> - dropped dependency on "[PATCH 0/6] cpufreq: use generic cpufreq
>   drivers for Exynos4x12 platform" patch series as it needs more
>   work (Viresh has requested porting of cpufreq-dt's boost mode
>   support over opp-v2 patches)
> 
> Changes since v2 (http://lkml.org/lkml/2015/6/29/361):
> - put the new cpu nodes in alphabetical order
> - updated Javier's and Mike's e-mail adresses
> - removed Cc: tag with stale Sachin's e-mail adress
> - added Reviewed-by: tag from Krzysztof to patches #3 and #4

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
