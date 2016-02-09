From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V3 07/16] PM / OPP: Add dev_pm_opp_set_rate()
Date: Tue, 9 Feb 2016 11:06:48 -0800
Message-ID: <20160209190648.GB30978@codeaurora.org>
References: <cover.1454992186.git.viresh.kumar@linaro.org>
 <f284be9717a3bd6c52a917c012947071cdb7f3b8.1454992186.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55223 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbcBITGu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2016 14:06:50 -0500
Content-Disposition: inline
In-Reply-To: <f284be9717a3bd6c52a917c012947071cdb7f3b8.1454992186.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>

On 02/09, Viresh Kumar wrote:
> This adds a routine, dev_pm_opp_set_rate(), responsible for configuring
> power-supply and clock source for an OPP.
> 
> The OPP is found by matching against the target_freq passed to the
> routine. This shall replace similar code present in most of the OPP
> users and help simplify them a lot.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
