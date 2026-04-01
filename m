Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2DD3630AD;
	Wed,  1 Apr 2026 21:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775077328; cv=none; b=kTQGKnrWetejwnKMfSGtuY/idGxAwm7TKtCaYJsc5Kt9bniBd+7EY9Q0uo8xCmyk8IZw1zwvAEOu8sMmCTZnmCuWK/64yisBMk7AWmgYbWegJtYGVXzgU5jqYPC4RfKDtke1yyHIilnMYyIaUbtazadw4K0BKvnrrp/CBR2uZc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775077328; c=relaxed/simple;
	bh=sfQydlmDJCD5GuQ5AkwqAxclU6VsGGaTiIgymtAYTc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QkNSGyMS5hP7TdM7T5L+6IMr8llkFi+COXy6R6qTbH+8fWVeRKZkaRanMYZI2jgiIwSfA1ni0E875W6WDlzBCLiakiHhQFxu5uavfFBXHN5yCzeMYOEs1yKAGMl20+bjA4mjCsdxASt1QAr9/SxiGIinO96JhVdGO8m28CaJras=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kCwLDW6L; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kCwLDW6L"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6777E32D3;
	Wed,  1 Apr 2026 14:01:59 -0700 (PDT)
Received: from [10.57.22.6] (unknown [10.57.22.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AA953F7D8;
	Wed,  1 Apr 2026 14:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775077325; bh=sfQydlmDJCD5GuQ5AkwqAxclU6VsGGaTiIgymtAYTc4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kCwLDW6LNuFU0LcL98OxJtRCNoGs5FZhcdbenjFO4r/uPZJcHOapzrUjj8Z9SHf+C
	 TVkcS17JP3fdzlaIQIZdfQQdERdhkLg4xVii9ApIrq9UmajLHPb20iXLc38JkuwFx5
	 Tk5Av9u9/jw/9vejJ2B63ZC3QDs3vtm5wm4GCXc4=
Message-ID: <0dbea939-0d7c-487a-8f2e-5214cffb5310@arm.com>
Date: Wed, 1 Apr 2026 22:02:24 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: core: Fix thermal zone device registration
 error path
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
References: <2849815.mvXUDI8C0e@rafael.j.wysocki>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2849815.mvXUDI8C0e@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

On 4/1/26 15:33, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If thermal_zone_device_register_with_trips() fails after registering
> a thermal zone device, it needs to wait for the tz->removal completion
> like thermal_zone_device_unregister(), in case user space has managed
> to take a reference to the thermal zone device's kobject, in which case
> thermal_release() may not be called by the error path itself and tz may
> be freed prematurely.
> 
> Add the missing wait_for_completion() call to the thermal zone device
> registration error path.
> 
> Fixes: 04e6ccfc93c5 ("thermal: core: Fix NULL pointer dereference in zone registration error path")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: All applicable <stable@vger.kernel.org>
> ---
>   drivers/thermal/thermal_core.c |    1 +
>   1 file changed, 1 insertion(+)
> 
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1651,6 +1651,7 @@ unregister:
>   	device_del(&tz->device);
>   release_device:
>   	put_device(&tz->device);
> +	wait_for_completion(&tz->removal);
>   remove_id:
>   	ida_free(&thermal_tz_ida, id);
>   free_tzp:
> 
> 
> 

LGTM. I have also tested that code path with a faked
failure from device_register() - the mechanism works.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
