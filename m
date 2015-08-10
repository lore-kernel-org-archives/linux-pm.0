From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 2/6] PM / OPP: restructure _of_init_opp_table_v2()
Date: Mon, 10 Aug 2015 12:23:37 -0700
Message-ID: <20150810192336.GC9678@codeaurora.org>
References: <cover.1439187821.git.viresh.kumar@linaro.org>
 <804c420eb23e70448c3c2c93f867a0eab3536bfd.1439187821.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:32825 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754360AbbHJTXj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Aug 2015 15:23:39 -0400
Content-Disposition: inline
In-Reply-To: <804c420eb23e70448c3c2c93f867a0eab3536bfd.1439187821.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, khilman@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 08/10, Viresh Kumar wrote:
> 'dev_opp' will always be NULL in _of_init_opp_table_v2() after creating
> OPPs for a device. There is no point comparing it against NULL there.
> 
> Restructure code a bit to make it more efficient.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Curious if these are a response to the static checker mails? If
so it would be good to add a reported-by tag.

> ---
>  drivers/base/power/opp.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index 1daaa1a418a2..c9747fb192b1 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -1295,20 +1295,19 @@ static int _of_init_opp_table_v2(struct device *dev,
>  	if (WARN_ON(!count))
>  		goto out;
>  
> -	if (!ret) {
> -		if (!dev_opp) {
> -			dev_opp = _find_device_opp(dev);
> -			if (WARN_ON(!dev_opp))
> -				goto out;
> -		}
> -
> -		dev_opp->np = opp_np;
> -		dev_opp->shared_opp = of_property_read_bool(opp_np,
> -							    "opp-shared");
> -	} else {
> +	if (ret) {
>  		of_free_opp_table(dev);
> +		goto out;
>  	}
>  
> +	dev_opp = _find_device_opp(dev);
> +	if (WARN_ON(!dev_opp))
> +		goto out;

Doesn't ret = 0 in this case? Why not drop the goto and just
return some error code. Same for the goto out up above.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
