Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DEC3446AF;
	Wed, 13 May 2026 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684611; cv=none; b=rX7IUzTijbORTCwfPjlCjkdxQRmhwu9iijr9XZWny1OWtPG0IbfbbGCy37cFCtA4Vxtnk+hnb2Yqf+I1Xeev3z1uuNI3Q2Dx2bOWnpcUE7jH/702pqnJHP682PcOjSBUotkP8bpU3mC1S1+cRzZ8zK5DVZGdSUDDInjkQUiXX7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684611; c=relaxed/simple;
	bh=gDzVVFe1uaVzcYmtRNqlUx2pXZrJQ31QnikRj3m18oQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HYd0xiNg77BLgKN1Td5lWG2bwbBgWlzXPVnGGs8UKrFEPJSNFZgUXYKcB08MW7lKEi5hfBVKTAbW4O0IEMc0kYQUFmZlKeBFG9U22aDm7efkagtVIGWBewGWm8uz+3rbyVWamk+UsWkJGq5CwXYm+KZvwfi613pQT2f/G/QFQNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GH0XhdRR; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GH0XhdRR"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 517651596;
	Wed, 13 May 2026 08:03:24 -0700 (PDT)
Received: from [10.57.24.48] (unknown [10.57.24.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1C4E3F836;
	Wed, 13 May 2026 08:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778684609; bh=gDzVVFe1uaVzcYmtRNqlUx2pXZrJQ31QnikRj3m18oQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GH0XhdRRe49hlmb5/56iPRHlGzqipAyp2K6rvmVTlkyYCLjNT/+c5tJze7cn1MTgP
	 8IqWkQWzm+ZOGVut4B6DMm+zY8b25JK7qJz7bf7LNl03musHljyrpr1Ey95AYuI+cJ
	 gZtG6DTa15llmGsN8FsIWPGFTko1LZsGMb20/fyU=
Message-ID: <bf7b28aa-d7a2-4d21-ad76-c9855effae43@arm.com>
Date: Wed, 13 May 2026 16:03:26 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] thermal/core: Use the thermal class pointer as init
 guard
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael@kernel.org
References: <20260508180511.1306659-1-daniel.lezcano@oss.qualcomm.com>
 <20260508180511.1306659-5-daniel.lezcano@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260508180511.1306659-5-daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/8/26 19:05, Daniel Lezcano wrote:
> The thermal class is now dynamically allocated and stored as a
> pointer.
> 
> Use the thermal_class pointer itself to check whether the thermal
> class has been created instead of keeping a separate
> thermal_class_unavailable flag.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
>   drivers/thermal/thermal_core.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 748ab76823a3..81f6bbaded65 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -950,7 +950,6 @@ static void thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
>   }
>   
>   static struct class *thermal_class;
> -static bool thermal_class_unavailable __ro_after_init = true;
>   
>   static inline
>   void print_bind_err_msg(struct thermal_zone_device *tz,
> @@ -1053,7 +1052,7 @@ __thermal_cooling_device_register(struct device_node *np,
>   	    !ops->set_cur_state)
>   		return ERR_PTR(-EINVAL);
>   
> -	if (thermal_class_unavailable)
> +	if (!thermal_class)
>   		return ERR_PTR(-ENODEV);
>   
>   	cdev = kzalloc_obj(*cdev);
> @@ -1536,7 +1535,7 @@ thermal_zone_device_register_with_trips(const char *type,
>   	if (polling_delay && passive_delay > polling_delay)
>   		return ERR_PTR(-EINVAL);
>   
> -	if (thermal_class_unavailable)
> +	if (!thermal_class)
>   		return ERR_PTR(-ENODEV);
>   
>   	tz = kzalloc_flex(*tz, trips, num_trips);
> @@ -1834,7 +1833,7 @@ static void __thermal_pm_prepare(void)
>   
>   void thermal_pm_prepare(void)
>   {
> -	if (thermal_class_unavailable)
> +	if (!thermal_class)
>   		return;
>   
>   	__thermal_pm_prepare();
> @@ -1865,7 +1864,7 @@ void thermal_pm_complete(void)
>   {
>   	struct thermal_zone_device *tz;
>   
> -	if (thermal_class_unavailable)
> +	if (!thermal_class)
>   		return;
>   
>   	guard(mutex)(&thermal_list_lock);
> @@ -1902,8 +1901,6 @@ static int __init thermal_init(void)
>   		goto unregister_governors;
>   	}
>   
> -	thermal_class_unavailable = false;
> -
>   	return 0;
>   
>   unregister_governors:


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
