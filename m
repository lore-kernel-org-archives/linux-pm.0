From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V3 15/16] cpufreq: dt: Add support for
 operating-points-v2 bindings
Date: Thu, 30 Jul 2015 23:15:24 -0700
Message-ID: <20150731061524.GO3159@codeaurora.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
 <c7e42623089a04f1d607f0912736aa1ec1d5c48a.1438166099.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:37451 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbbGaGP1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2015 02:15:27 -0400
Content-Disposition: inline
In-Reply-To: <c7e42623089a04f1d607f0912736aa1ec1d5c48a.1438166099.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mturquette@baylibre.com, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, b.zolnierkie@samsung.com, open list <linux-kernel@vger.kernel.org>

On 07/29, Viresh Kumar wrote:
> Support for parsing operating-points-v2 bindings is in place now, lets
> modify cpufreq-dt driver to use them.
> 
> For backward compatibility we will continue to support earlier bindings.
> Special handling for that is required, to make sure OPPs are initialized
> for all the CPUs.
> 
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
