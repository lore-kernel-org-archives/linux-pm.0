From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 02/10] OPP: Create _remove_device_opp() for freeing
 dev_opp
Date: Wed, 1 Jul 2015 18:25:38 -0700
Message-ID: <20150702012538.GB7143@codeaurora.org>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <fba1ec728e2ecf9303e13372a2557d886aa7e49c.1434369079.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50249 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416AbbGBBZk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2015 21:25:40 -0400
Content-Disposition: inline
In-Reply-To: <fba1ec728e2ecf9303e13372a2557d886aa7e49c.1434369079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, broonie@kernel.org, mike.turquette@linaro.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 06/15, Viresh Kumar wrote:
> This will be used from multiple places later. Lets create a separate
> routine for that.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
