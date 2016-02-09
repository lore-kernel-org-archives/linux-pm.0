From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V3 01/16] PM / OPP: get/put regulators from OPP core
Date: Tue, 9 Feb 2016 11:04:16 -0800
Message-ID: <20160209190416.GE31947@codeaurora.org>
References: <cover.1454992186.git.viresh.kumar@linaro.org>
 <cfc33f1cd2e6a1f59d90b5d1ee3161efa3038fb0.1454992186.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55043 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbcBITET (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2016 14:04:19 -0500
Content-Disposition: inline
In-Reply-To: <cfc33f1cd2e6a1f59d90b5d1ee3161efa3038fb0.1454992186.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>

On 02/09, Viresh Kumar wrote:
> This allows the OPP core to request/free the regulator resource,
> attached to a device OPP. The regulator device is fetched using the name
> provided by the driver, while calling: dev_pm_opp_set_regulator().
> 
> This will work for both OPP-v1 and v2 bindings.
> 
> This is a preliminary step for moving the OPP switching logic into the
> OPP core.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
