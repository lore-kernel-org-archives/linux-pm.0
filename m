From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2] clk: Provide notifier stubs when !COMMON_CLK
Date: Tue, 28 Jun 2016 13:58:49 +0200
Message-ID: <14387179.nnNuRe7g05@amdc1976>
References: <1467113104-8650-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1467113104-8650-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


Hi,

On Tuesday, June 28, 2016 01:25:04 PM Krzysztof Kozlowski wrote:
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
> Reported when testing patch [1] on ARCH=sh. I don't have the sh cross
> compile toolchain so I cannot verify whether this fixes reported issue.

FWIW I've verified with sh cross-compiler.

Tested-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

> Tested on similar configuration on MIPS (HAVE_CLK && !COMMON_CLK)
> 
> [1] http://www.gossamer-threads.com/lists/linux/kernel/2471798

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
