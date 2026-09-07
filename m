Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886694252BE;
	Mon,  7 Sep 2026 08:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788768035; cv=none; b=mDiloaABpdWIvEarQw3K8pRnDzfgFsalGxamOPw9AiT8q2a0H4ZFmAuYEMomJu3d+FiIx71EkvGUHvEl00xFgyaLFos8K6fEwOKM9q86m6qBuRu3+A9QsUzIqKCbCH3pBKZW125Wcwk8OiSO+wLEdQO15jmQGLKZ+q68zs4KdEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788768035; c=relaxed/simple;
	bh=Tss0J1lzaawDO9UqsRhpXcAR6VYcF9+3RJb88LLnMxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F3rzptVmruRz83PhaNa+6spWipy2so0b6AL6oejnQhWer2oWgPZJas++dWu/BUuK+T7PDW2xuZd3PAtc+TmBaWfvn8hOFKzQVNqvLHCau1g2eZN+WU379y6GpEF3XWCOy7kgwbsa+tqYNR6OXTd7oErTEsgBEm8aC/sEvZth83o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Sw+OK71A; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Sw+OK71A"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 854951477;
	Mon,  7 Sep 2026 01:00:28 -0700 (PDT)
Received: from [10.57.7.146] (unknown [10.57.7.146])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBFB43F7D8;
	Mon,  7 Sep 2026 01:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788768032; bh=Tss0J1lzaawDO9UqsRhpXcAR6VYcF9+3RJb88LLnMxo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Sw+OK71AgW5+S/Uutbdw8ClQGjpTmQilmHgCX4W+nxWqS4hzGmXbWP+UBmQR+7oMD
	 QzUm2Mjmfz9LdFB9dOnVC9CO9I8lyLBfpodwzgaY3H1uFNeB8ohO8rfU7WA0eBYtx/
	 muNkM+ZNgkgwUSSbXK3GYvr7nuJbg6EIxkm0XGdU=
Message-ID: <e8be7505-52a4-4c7f-9194-6e9124df6f2e@arm.com>
Date: Mon, 7 Sep 2026 09:00:46 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: gov_power_allocator: Use common error handling
 code in power_allocator_bind()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>, kernel-janitors@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@kernel.org>
References: <a3dc82f0-7333-465d-85b4-8034b1591442@web.de>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <a3dc82f0-7333-465d-85b4-8034b1591442@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/10/26 10:30, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 10 Jun 2026 11:20:37 +0200
> 
> Adjust labels so that a bit of exception handling can be better reused
> at the end of this function implementation.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   drivers/thermal/gov_power_allocator.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index 37f2e22a999e..6b9450ffd5de 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -707,22 +707,20 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
>   	ret = check_power_actors(tz, params);
>   	if (ret < 0) {
>   		dev_warn(&tz->device, "power_allocator: binding failed\n");
> -		kfree(params);
> -		return ret;
> +		goto free_params;
>   	}
>   
>   	ret = allocate_actors_buffer(params, ret);
>   	if (ret) {
>   		dev_warn(&tz->device, "power_allocator: allocation failed\n");
> -		kfree(params);
> -		return ret;
> +		goto free_params;
>   	}
>   
>   	if (!tz->tzp) {
>   		tz->tzp = kzalloc_obj(*tz->tzp);
>   		if (!tz->tzp) {
>   			ret = -ENOMEM;
> -			goto free_params;
> +			goto free_power;
>   		}
>   
>   		params->allocated_tzp = true;
> @@ -746,8 +744,9 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
>   
>   	return 0;
>   
> -free_params:
> +free_power:
>   	kfree(params->power);
> +free_params:
>   	kfree(params);
>   
>   	return ret;

LGTM. BTW, I like the 'free_power' label ;)

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
