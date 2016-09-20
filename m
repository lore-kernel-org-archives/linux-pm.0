From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 1/2] PM / devfreq: exynos-nocp: Select REGMAP_MMIO
Date: Tue, 20 Sep 2016 18:30:54 +0900
Message-ID: <57E101CE.4050502@samsung.com>
References: <CGME20160920085823epcas1p1f0fed4f248efcccccbce71438c03a9a1@epcas1p1.samsung.com>
 <1474361863-2319-1-git-send-email-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:44677 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752758AbcITJa4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Sep 2016 05:30:56 -0400
In-reply-to: <1474361863-2319-1-git-send-email-axel.lin@ingics.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org

Hi,

On 2016년 09월 20일 17:57, Axel Lin wrote:
> This drvier uses devm_regmap_init_mmio(), so select REGMAP_MMIO to avoid
> build failure.

s/drvier/driver

> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/devfreq/event/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/devfreq/event/Kconfig b/drivers/devfreq/event/Kconfig
> index 0fdae86..cd94980 100644
> --- a/drivers/devfreq/event/Kconfig
> +++ b/drivers/devfreq/event/Kconfig
> @@ -17,6 +17,7 @@ config DEVFREQ_EVENT_EXYNOS_NOCP
>  	tristate "EXYNOS NoC (Network On Chip) Probe DEVFREQ event Driver"
>  	depends on ARCH_EXYNOS || COMPILE_TEST
>  	select PM_OPP
> +	select REGMAP_MMIO
>  	help
>  	  This add the devfreq-event driver for Exynos SoC. It provides NoC
>  	  (Network on Chip) Probe counters to measure the bandwidth of AXI bus.
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
