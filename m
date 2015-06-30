From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 4/4] cpufreq: exynos: remove Exynos5250 specific cpufreq
 driver support
Date: Tue, 30 Jun 2015 09:22:06 +0900
Message-ID: <5591E12E.7060007@samsung.com>
References: <1435598772-21708-1-git-send-email-b.zolnierkie@samsung.com>
 <1435598772-21708-5-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:20128 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbbF3AWM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2015 20:22:12 -0400
In-reply-to: <1435598772-21708-5-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 30.06.2015 02:26, Bartlomiej Zolnierkiewicz wrote:
> Exynos5250 based platforms have switched over to use generic
> cpufreq driver for cpufreq functionality. So the Exynos
> specific cpufreq support for these platforms can be removed.
> 
> Based on the earlier work by Thomas Abraham.
> 
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/cpufreq/Kconfig.arm          |  11 --
>  drivers/cpufreq/Makefile             |   1 -
>  drivers/cpufreq/exynos-cpufreq.c     |   3 -
>  drivers/cpufreq/exynos-cpufreq.h     |  17 ---
>  drivers/cpufreq/exynos5250-cpufreq.c | 210 -----------------------------------
>  5 files changed, 242 deletions(-)
>  delete mode 100644 drivers/cpufreq/exynos5250-cpufreq.c

Nice diff stat, I like it!

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Few thoughts:
1. Javier's email has changed, CC-ed the correct one. Can you update it
in all patches (CC-tags)?

2. It looks like the patchset should go through one tree so the
Exynos5250 cpufreq support won't disappear, right?


Best regards,
Krzysztof

