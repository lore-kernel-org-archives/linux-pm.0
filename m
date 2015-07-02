From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 06/10] OPP: Add clock-latency-ns support
Date: Wed, 1 Jul 2015 18:27:18 -0700
Message-ID: <20150702012718.GC7143@codeaurora.org>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <1376f9ac3f955e67bd56327ea0ac9aecd06a6070.1434369079.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50411 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194AbbGBB1U (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2015 21:27:20 -0400
Content-Disposition: inline
In-Reply-To: <1376f9ac3f955e67bd56327ea0ac9aecd06a6070.1434369079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, broonie@kernel.org, mike.turquette@linaro.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 06/15, Viresh Kumar wrote:
> With "operating-points-v2" bindings, clock-latency is defined per OPP.
> Users of this value expect a single value which defines the latency to
> switch to any clock rate. Find maximum clock-latency-ns from the OPP
> table to service requests from such users.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
