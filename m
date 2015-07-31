From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V3 06/16] PM / OPP: Break _opp_add_dynamic() into smaller
 functions
Date: Thu, 30 Jul 2015 22:43:56 -0700
Message-ID: <20150731054356.GI3159@codeaurora.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
 <f5778b7bf5d30d888297c9e2fd7097901e9c47d9.1438166099.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35178 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbbGaFn6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2015 01:43:58 -0400
Content-Disposition: inline
In-Reply-To: <f5778b7bf5d30d888297c9e2fd7097901e9c47d9.1438166099.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mturquette@baylibre.com, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, b.zolnierkie@samsung.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 07/29, Viresh Kumar wrote:
> Later commits would add support for new OPP bindings and this would be
> required then. So, lets do it in a separate patch to make it easily
> reviewable.
> 
> Another change worth noticing is INIT_LIST_HEAD(&opp->node). We weren't
> doing it earlier as we never tried to delete a list node before it is
> added to list. But this wouldn't be the case anymore. We might try to
> delete a node (just to reuse the same code paths), without it being
> getting added to the list.
> 
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
