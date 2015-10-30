From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] PM / OPP: Propagate error properly from
 dev_pm_opp_set_sharing_cpus()
Date: Fri, 30 Oct 2015 13:59:16 -0700
Message-ID: <20151030205916.GF19782@codeaurora.org>
References: <20151030120450.GH7289@mwanda>
 <e936a7f240750777c8eee41f3eed6b948ef4de70.1446208794.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47103 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbbJ3U7S (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2015 16:59:18 -0400
Content-Disposition: inline
In-Reply-To: <e936a7f240750777c8eee41f3eed6b948ef4de70.1446208794.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 10/30, Viresh Kumar wrote:
> We are returning 0 even in case of errors, fix it.
> 
> Fixes: 8d4d4e98acd6 ("PM / OPP: Add helpers for initializing CPU OPPs")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
