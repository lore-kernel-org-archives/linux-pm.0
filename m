Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392B7C433EF
	for <linux-pm@archiver.kernel.org>; Tue, 12 Jul 2022 11:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbiGLLPY (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 12 Jul 2022 07:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbiGLLPA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jul 2022 07:15:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66627B1852;
        Tue, 12 Jul 2022 04:14:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E8E11515;
        Tue, 12 Jul 2022 04:13:52 -0700 (PDT)
Received: from [10.57.13.42] (unknown [10.57.13.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA44A3F70D;
        Tue, 12 Jul 2022 04:13:50 -0700 (PDT)
Message-ID: <c0b1ba1e-2935-3ca6-9474-3966d4db9352@arm.com>
Date:   Tue, 12 Jul 2022 12:13:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/3] thermal/core: Encapsulate the trip point crossed
 function
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     quic_manafm@quicinc.com, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>, rafael@kernel.org
References: <20220708183210.1334839-1-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220708183210.1334839-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/8/22 19:32, Daniel Lezcano wrote:
> The routine where the trip point crossed is detected is a strategic
> place where different processing will happen. Encapsulate the code in
> a function, so all specific actions related with a trip point crossed
> can be grouped.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/thermal_core.c | 30 ++++++++++++++++++++----------
>   1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index cdc0552e8c42..d9f771b15ed8 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -358,6 +358,25 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
>   		tz->ops->critical(tz);
>   }
>   
> +static void handle_thermal_trip_crossed(struct thermal_zone_device *tz, int trip,
> +					int trip_temp, int trip_hyst, enum thermal_trip_type trip_type)
> +{
> +	if (tz->last_temperature == THERMAL_TEMP_INVALID)
> +		return;
> +
> +	if (tz->last_temperature < trip_temp &&
> +	    tz->temperature >= trip_temp) {
> +		thermal_notify_tz_trip_up(tz->id, trip,
> +					  tz->temperature);
> +	}
> +
> +	if (tz->last_temperature >= trip_temp &&
> +	    tz->temperature < (trip_temp - trip_hyst)) {
> +		thermal_notify_tz_trip_down(tz->id, trip,
> +					    tz->temperature);
> +	}
> +}
> +
>   static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
>   {
>   	enum thermal_trip_type type;
> @@ -372,16 +391,7 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
>   	if (tz->ops->get_trip_hyst)
>   		tz->ops->get_trip_hyst(tz, trip, &hyst);
>   
> -	if (tz->last_temperature != THERMAL_TEMP_INVALID) {
> -		if (tz->last_temperature < trip_temp &&
> -		    tz->temperature >= trip_temp)
> -			thermal_notify_tz_trip_up(tz->id, trip,
> -						  tz->temperature);
> -		if (tz->last_temperature >= trip_temp &&
> -		    tz->temperature < (trip_temp - hyst))
> -			thermal_notify_tz_trip_down(tz->id, trip,
> -						    tz->temperature);
> -	}
> +	handle_thermal_trip_crossed(tz, trip, trip_temp, hyst, type);
>   
>   	if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
>   		handle_critical_trips(tz, trip, type);


LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
