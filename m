From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 6/6] cpufreq: remove no longer needed
 CPU_FREQ_BOOST_SW config option
Date: Fri, 7 Aug 2015 10:01:16 +0530
Message-ID: <20150807043116.GI6325@linux>
References: <1438868514-8814-1-git-send-email-b.zolnierkie@samsung.com>
 <1438868514-8814-7-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:33464 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbbHGEbV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Aug 2015 00:31:21 -0400
Received: by pdrh1 with SMTP id h1so22485147pdr.0
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2015 21:31:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1438868514-8814-7-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>

On 06-08-15, 15:41, Bartlomiej Zolnierkiewicz wrote:
> Remove no longer needed CPU_FREQ_BOOST_SW config option.
> 
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/cpufreq/Kconfig      | 4 ----
>  drivers/cpufreq/freq_table.c | 3 ---
>  2 files changed, 7 deletions(-)

This must be applied only after fixing 1/6.

-- 
viresh
