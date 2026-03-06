Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275AF35B63A;
	Fri,  6 Mar 2026 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772805918; cv=none; b=PzBN6s2tjwYwAdAH22dErDIesNmi0UPy7azFKBTvEu2WChNlSP/7X463hxNqKcP3bCRjHkSie3GXpcBMPAtdiWP58hDCYYAinL8LzXTp6wGM4+vvlEe/ntfDjtO+rv1aiyr0eMZ9Cf7a3IvK10tx0d5xdQuNy+B6XcyfXWm9KJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772805918; c=relaxed/simple;
	bh=UIL6zThPs99aztkkYgw6R6ExioDjna2WpCtzQyU0GLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GdH4EdQNxe4EWAdHduyjr6Ko0CRpH57hpFY/sypL/ZMAljKDR3n7SSeE4Gh7B9pk009ubKuqNlPskHVnkDXNqjxR5Swyb8NewI9rhJIsnrqt+0OkIkaofV5bS1625A88qUKh/suRIbpTL2r9PWnlUDzS0P7QmVb/KLeUvezlADI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CFBB497;
	Fri,  6 Mar 2026 06:05:10 -0800 (PST)
Received: from [10.57.11.75] (unknown [10.57.11.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26FEF3F694;
	Fri,  6 Mar 2026 06:05:15 -0800 (PST)
Message-ID: <b9981ace-4af9-4b42-a474-65239b372297@arm.com>
Date: Fri, 6 Mar 2026 14:05:25 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: core: Replace sprintf in
 thermal_bind_cdev_to_trip
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>
References: <20260223073245.321298-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260223073245.321298-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/23/26 07:32, Thorsten Blum wrote:
> Replace unbounded sprintf() with the safer snprintf(). While the
> current code works correctly, snprintf() is safer and follows secure
> coding best practices.  No functional changes.

Agree

> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   drivers/thermal/thermal_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 17ca5c082643..89dd1666805f 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -861,7 +861,7 @@ static int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
>   		goto free_mem;
>   
>   	dev->id = result;
> -	sprintf(dev->name, "cdev%d", dev->id);
> +	snprintf(dev->name, sizeof(dev->name), "cdev%d", dev->id);
>   	result =
>   	    sysfs_create_link(&tz->device.kobj, &cdev->device.kobj, dev->name);
>   	if (result)


LGTM, please add the tag and re-send so it's on top
so faster to pick-up for merging

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
