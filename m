From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH V3 3/6] PM / OPP: Prefix exported opp routines with
 dev_pm_opp_
Date: Sun, 6 Sep 2015 20:27:16 +0800
Message-ID: <20150906122716.GU30746@tiger>
References: <cover.1441354424.git.viresh.kumar@linaro.org>
 <5304383f1a99f2fd3a90c0a4cc1df4930b26a843.1441354424.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39238 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751099AbbIFM2I (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 6 Sep 2015 08:28:08 -0400
Content-Disposition: inline
In-Reply-To: <5304383f1a99f2fd3a90c0a4cc1df4930b26a843.1441354424.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Len Brown <len.brown@intel.com>, "moderated list:ARM SUB-ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" <linux-samsung-soc@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Russell King <linux@arm.linux.org.uk>, Sascha Hauer <kernel@pengutronix.de>, Sudeep Holla <sudeep.holla@arm.com>

On Fri, Sep 04, 2015 at 01:47:24PM +0530, Viresh Kumar wrote:
> That's the naming convention followed in most of opp core, but few
> routines didn't follow this, fix them.
> 
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/mach-imx/mach-imx6q.c       |  2 +-
...
>  drivers/cpufreq/imx6q-cpufreq.c      |  6 +++---

Acked-by: Shawn Guo <shawnguo@kernel.org>
