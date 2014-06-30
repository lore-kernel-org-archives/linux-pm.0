From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH] thermal: Add braces around suspect code
Date: Mon, 30 Jun 2014 16:03:12 +0100
Message-ID: <9hhionibftb.fsf@arm.com>
References: <1403134328-4668-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403134328-4668-1-git-send-email-sboyd@codeaurora.org> (Stephen
	Boyd's message of "Wed, 18 Jun 2014 16:32:08 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Stephen Boyd <sboyd@codeaurora.org> writes:

> It looks like this code is missing braces, otherwise the if
> statement shouldn't have been indented. Fix it.
>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/thermal/of-thermal.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index 04b1be7fa018..a95ee2889b19 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -712,11 +712,12 @@ thermal_of_build_thermal_zone(struct device_node *np)
>  	}
>  
>  	i = 0;
> -	for_each_child_of_node(child, gchild)
> +	for_each_child_of_node(child, gchild) {
>  		ret = thermal_of_populate_bind_params(gchild, &tz->tbps[i++],
>  						      tz->trips, tz->ntrips);
>  		if (ret)
>  			goto free_tbps;
> +	}
>  
>  finish:
>  	of_node_put(child);

Looks good to me.

Reviewed-by: Punit Agrawal <punit.agrawal@arm.com>
