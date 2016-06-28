From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2] clk: Provide notifier stubs when !COMMON_CLK
Date: Tue, 28 Jun 2016 10:26:53 -0700
Message-ID: <20160628172653.GB1521@codeaurora.org>
References: <1467113104-8650-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41231 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbcF1Rfk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jun 2016 13:35:40 -0400
Content-Disposition: inline
In-Reply-To: <1467113104-8650-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On 06/28, Krzysztof Kozlowski wrote:
> The clk notifier symbols are hidden by COMMON_CLK.  However on some
> platforms HAVE_CLK might be set while COMMON_CLK not which leads to
> compile test build errors like:
> 
> $ make.cross ARCH=sh
>    drivers/devfreq/tegra-devfreq.c: In function 'tegra_actmon_rate_notify_cb':
> >> drivers/devfreq/tegra-devfreq.c:391:16: error: 'POST_RATE_CHANGE' undeclared (first use in this function)
>      if (action != POST_RATE_CHANGE)
>                    ^
>    drivers/devfreq/tegra-devfreq.c: In function 'tegra_devfreq_probe':
> >> drivers/devfreq/tegra-devfreq.c:654:8: error: implicit declaration of function 'clk_notifier_register' [-Werror=implicit-function-declaration]
>      err = clk_notifier_register(tegra->emc_clock, &tegra->rate_change_nb);
>            ^
> 
> Export the macros and data type declarations outside of COMMON_CLK ifdef
> and provide stubs to fix the compile testing.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> ---
> 

Ok. Did you want some stable branch to pull this in and base your
use case on?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
