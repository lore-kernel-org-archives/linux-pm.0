Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5DE2C028F;
	Wed, 28 Jan 2026 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594984; cv=none; b=GQ+2UdSvn43WkiKCf9o4BzvbRMRqMIOKGsbTND2AVpZHJFCSUcBL7Mo3q/RWTxyhQFSqvqPIOPVYyZK+4kV1mp9gOd/dARv7FMbP8stbmaN/08dOxycAvzeVScrFBdDgHkW+klrNI1kk+iNE0MuR/dLPnfzl15sU45UlvgO5+4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594984; c=relaxed/simple;
	bh=OcWYAdegVat6FxDyCF9VSx531W/V1LRB6j8sSAuLjpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=befQ8rwJ92REpfmHKMxI0y+2gletlcVmud+4j7aBTKkSdIQEL3Al6JwJtbJZ9XbfxNfaEgCA6PzMsBbVPXq/obXULdA6S9ZIEAUezkBfhiwiv2/UQLHSj3bf0RWk66oXJNITTh0uGBXAr6fjJIUe/Zai01OKhcAGYnICmJXVhy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86ED11515;
	Wed, 28 Jan 2026 02:09:34 -0800 (PST)
Received: from [10.57.17.95] (unknown [10.57.17.95])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBD123F5CA;
	Wed, 28 Jan 2026 02:09:39 -0800 (PST)
Message-ID: <79619479-8d59-4894-90a5-b83cd24fc987@arm.com>
Date: Wed, 28 Jan 2026 10:09:41 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: core: thermal_core.h: fix all kernel-doc
 warnings
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 linux-pm@vger.kernel.org
References: <20260128062446.402175-1-rdunlap@infradead.org>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260128062446.402175-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/28/26 06:24, Randy Dunlap wrote:
> Resolve all kernel-doc warnings in thermal_core.h:
> 
> Warning: drivers/thermal/thermal_core.h:99 bad line: trip point.
> Warning: drivers/thermal/thermal_core.h:101 bad line: passive trip point.
> Warning: drivers/thermal/thermal_core.h:152 struct member 'trips_attribute_group' not described in 'thermal_zone_device'
> Warning: drivers/thermal/thermal_core.h:152 struct member 'debugfs' not described in 'thermal_zone_device'
> Warning: drivers/thermal/thermal_core.h:152 struct member 'user_thresholds' not described in 'thermal_zone_device'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: linux-pm@vger.kernel.org
> 
>   drivers/thermal/thermal_core.h |    7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> --- linux-next-20260126.orig/drivers/thermal/thermal_core.h
> +++ linux-next-20260126/drivers/thermal/thermal_core.h
> @@ -77,6 +77,7 @@ struct thermal_governor {
>    * @device:	&struct device for this thermal zone
>    * @removal:	removal completion
>    * @resume:	resume completion
> + * @trips_attribute_group: trip point sysfs attributes
>    * @trips_high:	trips above the current zone temperature
>    * @trips_reached:	trips below or at the current zone temperature
>    * @trips_invalid:	trips with invalid temperature
> @@ -97,9 +98,9 @@ struct thermal_governor {
>    * @emul_temperature:	emulated temperature when using CONFIG_THERMAL_EMULATION
>    * @passive:		1 if you've crossed a passive trip point, 0 otherwise.
>    * @prev_low_trip:	the low current temperature if you've crossed a passive
> -			trip point.
> + *			trip point.
>    * @prev_high_trip:	the above current temperature if you've crossed a
> -			passive trip point.
> + *			passive trip point.
>    * @ops:	operations this &thermal_zone_device supports
>    * @tzp:	thermal zone parameters
>    * @governor:	pointer to the governor for this thermal zone
> @@ -111,6 +112,8 @@ struct thermal_governor {
>    * @poll_queue:	delayed work for polling
>    * @notify_event: Last notification event
>    * @state: 	current state of the thermal zone
> + * @debugfs:	this thermal zone device's thermal zone debug info
> + * @user_thresholds: list of userspace thresholds for temp. limit notifications
>    * @trips:	array of struct thermal_trip objects
>    */
>   struct thermal_zone_device {


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
