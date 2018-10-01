From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: Refactor counting of added OPPs for v2 to
 avoid unsupported OPPs
Date: Mon, 1 Oct 2018 10:49:26 +0530
Message-ID: <20181001051925.u3lpcg537xomsckp@vireshk-i7>
References: <20180822031035.6937-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180822031035.6937-1-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Keerthy J <j-keerthy@ti.com>
List-Id: linux-pm@vger.kernel.org

On 21-08-18, 22:10, Dave Gerlach wrote:

Please ping people back if you haven't received a response for too long. Sorry
that I missed getting to this at an earlier point of time.

> Currently the _of_add_opp_table_v2 call loops through the OPP nodes in
> the operating-points-v2 table in the device tree and calls
> _opp_add_static_v2 for each to add them to the table. It counts each
> iteration through this loop as an added OPP, however on platforms making
> use of the opp-supported-hw property, _opp_add_static_v2 does not add
> OPPs that are not seen as supported on the platform but still returns
> success, as this is valid. Because of this the count variable will
> contain the number of OPP nodes in the table in device tree but not
> necessarily the ones that are supported and actually added.
> 
> As this count value is what is checked to determine if there are any
> valid OPPs, if a platform has an operating-points-v2 table with all OPP
> nodes containing opp-supported-hw values that are not currently
> supported then _of_add_opp_table_v2 will fail to abort as it should due
> to an empty table.
> 
> Additionally, since commit 3ba98324e81a ("PM / OPP: Get
> performance state using genpd helper"), the same count variable is
> compared against the number of OPPs containing performance states and
> requires that either all or none have pstates set, however in the case
> of any opp table that has any entries that do not get added by
> _opp_add_static_v2 due to incompatible opp-supported-hw fields, these
> numbers will not match and _of_add_opp_table_v2 will incorrectly fail.
> 
> In order to ensure the count variable reflects the number of OPPs
> actually in the table, increment it during the existing loop which walks
> the opp table to check if pstate is set and then use that for the
> aforementioned checks.
> 
> Fixes: 3ba98324e81a ("PM / OPP: Get performance state using genpd helper")
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  drivers/opp/of.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 7af0ddec936b..f288f83a2e62 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -399,8 +399,6 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
>  
>  	/* We have opp-table node now, iterate over it and add OPPs */
>  	for_each_available_child_of_node(opp_np, np) {
> -		count++;
> -
>  		ret = _opp_add_static_v2(opp_table, dev, np);
>  		if (ret) {
>  			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
> @@ -411,15 +409,22 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
>  		}
>  	}
>  
> +	/*
> +	 * Iterate over the list of OPPs that were actually added, as
> +	 * OPPs not supported by the hardware will be ignored by
> +	 * _opp_add_static_v2 above.
> +	 */
> +	list_for_each_entry(opp, &opp_table->opp_list, node) {
> +		count++;
> +		pstate_count += !!opp->pstate;
> +	}

So the problem is genuine and is still true with the latest code in linux-next,
but this patch wouldn't fix all cases. What if some OPPs were dynamically added
using dev_pm_opp_add() and everything failed in this routine? We will still have
the problem you are trying to fix here.

What needs to be done is to identify the case where the OPP wasn't supported.
Maybe return the new OPPs pointer from _opp_add_static_v2(), return -ve ERR_PTR
values on error and NULL for the case where OPP isn't added but that's not an
error. Apart from your example another case is of duplicate OPPs where we return
0 without adding the OPP.

Please post patch against linux-next as some updates are already pushed for OPP
core there.

-- 
viresh
