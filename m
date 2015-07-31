From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V3 13/16] cpufreq: Update boost flag while initializing
 freq table from OPPs
Date: Thu, 30 Jul 2015 23:11:08 -0700
Message-ID: <20150731061108.GM3159@codeaurora.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
 <62971ce19528d707b89e6521f50779fef3ecf145.1438166099.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:36874 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752763AbbGaGLK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2015 02:11:10 -0400
Content-Disposition: inline
In-Reply-To: <62971ce19528d707b89e6521f50779fef3ecf145.1438166099.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mturquette@baylibre.com, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, b.zolnierkie@samsung.com, Tomasz Figa <tomasz.figa@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, Thomas Abraham <thomas.ab@samsung.com>, open list <linux-kernel@vger.kernel.org>

On 07/29, Viresh Kumar wrote:
> From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> cpufreq table entries for OPPs with turbo modes enabled, should be
> marked with CPUFREQ_BOOST_FREQ flag. This ensures that these states are
> only used while operating in boost or turbo mode.
> 
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
