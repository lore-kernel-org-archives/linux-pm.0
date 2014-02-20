From: Josh Cartwright <joshc@codeaurora.org>
Subject: Re: [PATCH 3/8] spi: pl022: Let runtime PM callbacks be available
 for CONFIG_PM
Date: Thu, 20 Feb 2014 11:25:24 -0600
Message-ID: <20140220172523.GE31820@joshc.qualcomm.com>
References: <1392910280-12891-1-git-send-email-ulf.hansson@linaro.org>
 <1392910280-12891-4-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:51052 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266AbaBTR1y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2014 12:27:54 -0500
Content-Disposition: inline
In-Reply-To: <1392910280-12891-4-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, Russell King <linux@arm.linux.org.uk>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, linux-arm-kernel@lists.infradead.org, Alessandro Rubini <rubini@unipv.it>

(comments below only marginally related to this change)

On Thu, Feb 20, 2014 at 04:31:15PM +0100, Ulf Hansson wrote:
> Convert to the SET_PM_RUNTIME_PM macro while defining the runtime PM
> callbacks. This means the callbacks becomes available for both
> CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME, which is needed to handle the
> combinations of these scenarios.
> 
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/spi/spi-pl022.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index 74a0729..6dfcabf 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -2277,7 +2277,7 @@ pl022_remove(struct amba_device *adev)
>  	return 0;
>  }
>  
> -#if defined(CONFIG_SUSPEND) || defined(CONFIG_PM_RUNTIME)
> +#ifdef CONFIG_PM

I wish we could get rid of PM-related #ifdefery in drivers...

For what it's worth, while working on another project, I discovered that
using a ternary operator in initializers might actually be able to help
out a bit:

	/*
	 * Intended for use in static object initializers,
	 * assign_if(const_expr, function) evaluates to 'function' if
	 * 'const_expr', otherwise NULL.
	 *
	 * The type of the assign_if() expression is typeof(function),
	 * and therefore can provide typechecking regardless of
	 * 'const_expr'.
	 *
	 * gcc considers 'function' to be used and will not generate a
	 * 'defined but not used' when not 'const_expr', however, gcc is
	 * smart enough to eliminate 'function' if assign_if() is the
	 * only reference.
	 */
	#define assign_if(const_expr, function)			\
		((const_expr) ? function : NULL)

	#define assign_if_enabled(option, function)		\
		assign_if(IS_ENABLED(option), function)

	#define assign_if_rpm(function)				\
		assign_if_enabled(CONFIG_PM_RUNTIME, function)

	static int foo_runtime_suspend(struct device *dev)
	{
		return 0;
	}

	static struct dev_pm_ops foo_pm_ops = {
		.runtime_suspend	= assign_if_rpm(foo_runtime_suspend),
	};

So, in this example, wrapping the definition of foo_runtime_suspend in
#ifdef CONFIG_PM_RUNTIME is unnecessary, as gcc will not emit it if
!CONFIG_PM_RUNTIME is not set (at least from my experiments).

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
