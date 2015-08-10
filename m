From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 3/6] PM / OPP: Prefix exported opp routines with
 dev_pm_opp_
Date: Mon, 10 Aug 2015 12:24:21 -0700
Message-ID: <20150810192421.GD9678@codeaurora.org>
References: <cover.1439187821.git.viresh.kumar@linaro.org>
 <d1519381968d3cda4440c3240954b890aaac7601.1439187821.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:32870 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754809AbbHJTYX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Aug 2015 15:24:23 -0400
Content-Disposition: inline
In-Reply-To: <d1519381968d3cda4440c3240954b890aaac7601.1439187821.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, khilman@linaro.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 08/10, Viresh Kumar wrote:
> That's the naming convention followed in most of opp core, but few
> recent additions didn't follow this, fix them.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
