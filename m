From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH V2 1/6] PM / OPP: Free resources and properly return
 error on failure
Date: Tue, 11 Aug 2015 17:43:45 +0300
Message-ID: <20150811144345.GN5180@mwanda>
References: <cover.1439288881.git.viresh.kumar@linaro.org>
 <334a9052264630b9157fa9bfc3d4efe945054c34.1439288881.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:40662 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964946AbbHKOoO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 10:44:14 -0400
Content-Disposition: inline
In-Reply-To: <334a9052264630b9157fa9bfc3d4efe945054c34.1439288881.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, khilman@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On Tue, Aug 11, 2015 at 04:04:34PM +0530, Viresh Kumar wrote:
> _of_init_opp_table_v2() isn't freeing up resources on some errors and
> the error values returned are also not correct always.
> 
> This fixes following problems:
> - Return -ENOENT, if no entries are found in the table.
> - Use IS_ERR() to properly check return value of _find_device_opp().
> - Return error value with PTR_ERR() in above case.
> - Free table if _find_device_opp() fails.
> 
> Fixes: 274659029c9d ("PM / OPP: Add support to parse operating-points-v2" bindings")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/power/opp.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index 204c6c945168..bcbd92c3b717 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -1323,28 +1323,29 @@ static int _of_init_opp_table_v2(struct device *dev,
>  		if (ret) {
>  			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
>  				ret);
> -			break;
> +			goto free_table;
>  		}
>  	}
>  
>  	/* There should be one of more OPP defined */
> -	if (WARN_ON(!count))
> +	if (WARN_ON(!count)) {
> +		ret = -ENOENT;
>  		goto put_opp_np;
> +	}

This is weird to me, because we are going backwards.  What happens if
we goto free_table without adding anything?  I suspect it's fine, but if
it's a bug then this code still has problems.

What about if we only increment count when _opp_add_static_v2()
succeeds, and change it back to the original where we break, check
count, then check ret.  That way we don't need to know the details of
free_table to see that the code is correct.

regards,
dan carpenter

