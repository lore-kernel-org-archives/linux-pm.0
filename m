Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FE22D8DD0;
	Mon,  7 Sep 2026 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767467; cv=none; b=s58lGrDADmQjwNnfezK8Sk1zNTHBAf0aggs8ITVBQx9WrhHnF2LTMThgHv0oUR0Wghe2bjgRrH6o4E03MgNQYUlHPjKTp7KquO0139E7JegAjEDaKdSpFUYLPD24m9vm0M7JJzgOznqyepM0M9Fji5nZBTTmBgmPcCPCuIORKSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767467; c=relaxed/simple;
	bh=ebLBQtPrjU4gp1KUCxeFk5SffvdJ64+gWA08vNBPWLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jefQi/BJ9E20Jak/DsGzMsNZWVyJKR5b236WO1op7dHplOOpP+YXZfddGJFPCstyarl0Yy9VAa4yfa/1w65otXkohsIj8FnO8ziAs04Hf51PAtsKwqXZyTtj1fBxosSMWUdqp8dMPiWlWBwpAVKLicMSVJGIcTt1HCD510iyiZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sXIu8+RJ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sXIu8+RJ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D9E41477;
	Mon,  7 Sep 2026 00:51:00 -0700 (PDT)
Received: from [10.57.7.146] (unknown [10.57.7.146])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFFDF3F7D8;
	Mon,  7 Sep 2026 00:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788767464; bh=ebLBQtPrjU4gp1KUCxeFk5SffvdJ64+gWA08vNBPWLA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sXIu8+RJt5Fqfg4Zs35LnsPFw3Td73XmrGIeZwnl7XBN76YyeeNOBvEFaseCzfuNN
	 9DZvpGywhz3X714a6bgHutIqw8HWgmcHOXA46lmZfuELHfhyqcYiW1Pix/bxfqHK1u
	 sFkSzwcr3qTwgIIx5iZWJJdgH9pQjFfbQW96Sc/Y=
Message-ID: <3284bfcb-2dd9-4ca2-be08-c7ecc7571695@arm.com>
Date: Mon, 7 Sep 2026 08:51:19 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: gov_power_allocator: Fix NULL pointer
 dereference in update_tz()
To: Sumeet Pawnikar <sumeet4linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, rafael@kernel.org,
 linux-pm@vger.kernel.org, rui.zhang@intel.com, daniel.lezcano@kernel.org
References: <20260822114236.15998-1-sumeet4linux@gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260822114236.15998-1-sumeet4linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/22/26 12:42, Sumeet Pawnikar wrote:
> power_allocator_update_tz() unconditionally derives the trip descriptor of
> params->trip_max as below,
>    const struct thermal_trip_desc *td = trip_to_trip_desc(params->trip_max);
> and then walks td->thermal_instances. However, params->trip_max is allowed
> to be NULL and in that case the list walk dereferences a bogus pointer
> derived from NULL which oops the kernel.
> 
> get_governor_trips() picks trip_switch_on and trip_max out of the trip
> table of the zone. When the zone has neither a passive nor an active trip
> point, last_active is NULL and params->trip_max is left NULL. This is an
> explicitly supported configuration, as documented in the function
> get_governor_trips() as below,
>    If there are no passive or active trip points, then the governor won't
>    do anything. In fact, its throttle function won't be called at all.
> 
> Return early from power_allocator_update_tz() when params->trip_max is NULL
> and only compute the trip descriptor after that check. There is nothing to
> update in that case anyway, with no trip_max and there are no thermal
> instances for the governor to account for, num_actors stays zero and
> total_weight is irrelevant.
> 
> Fixes: 912e97c67cc3 ("thermal: gov_power_allocator: Move memory allocation out of throttle()")
> 
> Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
> ---
>   drivers/thermal/gov_power_allocator.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index 37f2e22a999e..b5c254187628 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -660,10 +660,15 @@ static void power_allocator_update_tz(struct thermal_zone_device *tz,
>   				      enum thermal_notify_event reason)
>   {
>   	struct power_allocator_params *params = tz->governor_data;
> -	const struct thermal_trip_desc *td = trip_to_trip_desc(params->trip_max);
> +	const struct thermal_trip_desc *td;
>   	struct thermal_instance *instance;
>   	int num_actors = 0;
>   
> +	if (!params->trip_max)
> +		return;
> +
> +	td = trip_to_trip_desc(params->trip_max);
> +
>   	switch (reason) {
>   	case THERMAL_TZ_BIND_CDEV:
>   	case THERMAL_TZ_UNBIND_CDEV:


LGTM,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
