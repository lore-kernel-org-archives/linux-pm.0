From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 1/6] PM / OPP: reuse of_parse_phandle()
Date: Mon, 10 Aug 2015 23:02:29 -0700
Message-ID: <20150811060229.GG9678@codeaurora.org>
References: <cover.1439187821.git.viresh.kumar@linaro.org>
 <8c4503fe1c1c545d5f7ac68351d81d0238532b54.1439187821.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58949 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933326AbbHKGCc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 02:02:32 -0400
Content-Disposition: inline
In-Reply-To: <8c4503fe1c1c545d5f7ac68351d81d0238532b54.1439187821.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, khilman@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 08/10, Viresh Kumar wrote:
> We already have a better API to get the opp descriptor block's node from
> cpu-node. Lets reuse that instead of creating our own routines for the
> same stuff. That cleans the code a lot.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index 204c6c945168..1daaa1a418a2 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
>  	/*
>  	 * TODO: Support for multiple OPP tables.
>  	 *
>  	 * There should be only ONE phandle present in "operating-points-v2"
>  	 * property.
>  	 */
> -	if (prop->length != sizeof(__be32)) {
> -		dev_err(dev, "%s: Invalid opp desc phandle\n", __func__);
> -		return ERR_PTR(-EINVAL);
> -	}

But we lost this check? Perhaps we can use
of_count_phandle_with_args() to make suer we only have one
phandle?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
