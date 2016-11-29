From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH V4 07/10] PM / OPP: Separate out _generic_opp_set_rate()
Date: Mon, 28 Nov 2016 17:09:51 -0800
Message-ID: <20161129010951.GU6095@codeaurora.org>
References: <cover.1479986491.git.viresh.kumar@linaro.org>
 <1f8634c64ccec1d24119afea4b6bd2d7d1a911cf.1479986492.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1f8634c64ccec1d24119afea4b6bd2d7d1a911cf.1479986492.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, nm-l0cyMroinI0@public.gmane.org, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, d-gerlach-l0cyMroinI0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 11/24, Viresh Kumar wrote:
> Later patches would add support for custom opp_set_rate callbacks. This
> patch separates out the code for generic opp_set_rate handler in order
> to prepare for that.

s/opp_set_rate/set_opp/ twice?

> 
> Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Tested-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
> ---

Besides the naming confusion.

Reviewed-by: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

> @@ -1422,6 +1488,11 @@ int dev_pm_opp_set_regulators(struct device *dev, const char * const names[],
>  
>  	opp_table->regulator_count = count;
>  
> +	/* Allocate block only once to pass to ->set_rate() */

_generic_set_opp()? Or just set_opp when that gets introduced in
the next patch.

> +	ret = _allocate_set_opp_data(opp_table);
> +	if (ret)
> +		goto free_regulators;
> +
>  	mutex_unlock(&opp_table_lock);
>  	return 0;
>  

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
