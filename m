Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0873A4503;
	Fri,  6 Mar 2026 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772804957; cv=none; b=BT0YN3dcZVZL65EXYtoA91paQwMRQCaYZhvP4OfC6AHw+szM+Ich26p3iHnjT2EMKgMsGF2ODXfKNpNALf8udxpQnJWCYMlZgKmyJDP4+qX437VuqEx+kKuchMKwRNrbvnHiH/R0BmQaNucJydXYL8o1gp7KYUeGNLhXJtSWHn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772804957; c=relaxed/simple;
	bh=HYEuHYxowuESD5sIfkldKpJ9nDTALWN8xtSskq3KQsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NMlOBbyFEvBV0JRCxfgEiYwA1YWVgOoOPqe1KdyxhptZpGP90EqAFEhWrYFJT2B6XJKyKIxXcMVEQ+hjt+8AGPGhDoi5Ry3ZPNcoKobG1FYSoLydSb1rXFhHet9sFS9OL1B7A3Or/5oatldyAgvLaxwATD3XCUkyEwlGN3Dq+HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F895497;
	Fri,  6 Mar 2026 05:49:04 -0800 (PST)
Received: from [10.57.11.75] (unknown [10.57.11.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D153C3F836;
	Fri,  6 Mar 2026 05:49:09 -0800 (PST)
Message-ID: <245c2251-9661-4d49-b2a7-df3027059df5@arm.com>
Date: Fri, 6 Mar 2026 13:49:21 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] thermal/of: Add OF node address to output message
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <20260305163508.2643106-1-alexander.stein@ew.tq-group.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260305163508.2643106-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/5/26 16:35, Alexander Stein wrote:
> Temperature sensors are supposed to have the DT node name
> temperature-sensors. Having multiple ones the node name alone isn't very
> helpful. Add the node address to make them more distinguishable.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> Old error messages:
> thermal_sys: Failed to find thermal zone for temperature-sensor id=0
> thermal_sys: Failed to find thermal zone for temperature-sensor id=0
> 
> New error messages:
> thermal_sys: Failed to find thermal zone for temperature-sensor@1c id=0
> thermal_sys: Failed to find thermal zone for temperature-sensor@1b id=0
> 
>   drivers/thermal/thermal_of.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 6ebb83cb70b2f..99085c806a1f6 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -144,7 +144,7 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
>   		count = of_count_phandle_with_args(child, "thermal-sensors",
>   						   "#thermal-sensor-cells");
>   		if (count <= 0) {
> -			pr_err("%pOFn: missing thermal sensor\n", child);
> +			pr_err("%pOFP: missing thermal sensor\n", child);
>   			return ERR_PTR(-EINVAL);
>   		}
>   
> @@ -156,14 +156,14 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
>   							 "#thermal-sensor-cells",
>   							 i, &sensor_specs);
>   			if (ret < 0) {
> -				pr_err("%pOFn: Failed to read thermal-sensors cells: %d\n", child, ret);
> +				pr_err("%pOFP: Failed to read thermal-sensors cells: %d\n", child, ret);
>   				return ERR_PTR(ret);
>   			}
>   
>   			of_node_put(sensor_specs.np);
>   			if ((sensor == sensor_specs.np) && id == (sensor_specs.args_count ?
>   								  sensor_specs.args[0] : 0)) {
> -				pr_debug("sensor %pOFn id=%d belongs to %pOFn\n", sensor, id, child);
> +				pr_debug("sensor %pOFP id=%d belongs to %pOFP\n", sensor, id, child);
>   				return no_free_ptr(child);
>   			}
>   		}
> @@ -180,7 +180,7 @@ static int thermal_of_monitor_init(struct device_node *np, int *delay, int *pdel
>   	if (ret == -EINVAL) {
>   		*pdelay = 0;
>   	} else if (ret < 0) {
> -		pr_err("%pOFn: Couldn't get polling-delay-passive: %d\n", np, ret);
> +		pr_err("%pOFP: Couldn't get polling-delay-passive: %d\n", np, ret);
>   		return ret;
>   	}
>   
> @@ -188,7 +188,7 @@ static int thermal_of_monitor_init(struct device_node *np, int *delay, int *pdel
>   	if (ret == -EINVAL) {
>   		*delay = 0;
>   	} else if (ret < 0) {
> -		pr_err("%pOFn: Couldn't get polling-delay: %d\n", np, ret);
> +		pr_err("%pOFP: Couldn't get polling-delay: %d\n", np, ret);
>   		return ret;
>   	}
>   
> @@ -380,23 +380,23 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
>   	np = of_thermal_zone_find(sensor, id);
>   	if (IS_ERR(np)) {
>   		if (PTR_ERR(np) != -ENODEV)
> -			pr_err("Failed to find thermal zone for %pOFn id=%d\n", sensor, id);
> +			pr_err("Failed to find thermal zone for %pOFP id=%d\n", sensor, id);
>   		return ERR_CAST(np);
>   	}
>   
>   	trips = thermal_of_trips_init(np, &ntrips);
>   	if (IS_ERR(trips)) {
> -		pr_err("Failed to parse trip points for %pOFn id=%d\n", sensor, id);
> +		pr_err("Failed to parse trip points for %pOFP id=%d\n", sensor, id);
>   		ret = PTR_ERR(trips);
>   		goto out_of_node_put;
>   	}
>   
>   	if (!trips)
> -		pr_info("No trip points found for %pOFn id=%d\n", sensor, id);
> +		pr_info("No trip points found for %pOFP id=%d\n", sensor, id);
>   
>   	ret = thermal_of_monitor_init(np, &delay, &pdelay);
>   	if (ret) {
> -		pr_err("Failed to initialize monitoring delays from %pOFn\n", np);
> +		pr_err("Failed to initialize monitoring delays from %pOFP\n", np);
>   		goto out_kfree_trips;
>   	}
>   
> @@ -417,7 +417,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
>   						     pdelay, delay);
>   	if (IS_ERR(tz)) {
>   		ret = PTR_ERR(tz);
> -		pr_err("Failed to register thermal zone %pOFn: %d\n", np, ret);
> +		pr_err("Failed to register thermal zone %pOFP: %d\n", np, ret);
>   		goto out_kfree_trips;
>   	}
>   


Thank you for the patch, LGTM.
Please add the tag and send the v2

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

