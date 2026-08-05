Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8B82DB7B4;
	Wed,  5 Aug 2026 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785925950; cv=none; b=LHm4rs7tVdFG1Ahkc8yzZaD6GxhLMbmRpcTgz7NuWFMpiL20TMQgVsIrFqY2P9QoLD2gvzV7FOAvuSodmWF7SjnEK7w3vaPSA2TkCcxufeHcLiL9PsYtbyoOYzgUCqn9Hbr1aHbDImpwWS97hfxkfeBd5I9a7aQEUCCxs0/1K1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785925950; c=relaxed/simple;
	bh=zr90A9Ucrf29uareVH4ynQl6TUwZK8iZbV5vETP6KRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G2FG7b9iVTh8GL2Tv96X3hOl1n22TbUUPE36HHf/zUSIPQ+vnOcUvojzpHOfvxgSzWMnK08ka8tGH2GQG655uxhAC+CQb4FZPBMesU15fAh49rCxyGZMrkbHVoQTJlN6zN9Jbvv8XXTD9blvzkiH4FH5K/ynVQNfh/+Dmdw30MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UY8oU8lq; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UY8oU8lq"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA9B9153B;
	Wed,  5 Aug 2026 03:32:22 -0700 (PDT)
Received: from [192.168.33.9] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93BF53F632;
	Wed,  5 Aug 2026 03:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785925947; bh=zr90A9Ucrf29uareVH4ynQl6TUwZK8iZbV5vETP6KRI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UY8oU8lqZt0tBnD6LdGVS8uYlrT85AMHlQ4CbpjLrfVIT6nzLH5RfFllovydAOKno
	 90SYbTFJ246v2kl3KBFAsmfSaBvCtjOfAx4ffXGW0WYdx+bXPoFcV4pUqZ283DIA3Q
	 XvQ1bk7F1Ghl9ReA9iTL7535vIc7rbUD4XLOXhgg=
Message-ID: <7011fec6-f2ac-4ceb-bdb9-adbccdabf6d8@arm.com>
Date: Wed, 5 Aug 2026 11:32:30 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] Revert "thermal/drivers/hwmon: Cleanup coding
 style a bit"
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Armin Wolf <w_armin@gmx.de>,
 Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
References: <12947893.O9o76ZdvQC@rafael.j.wysocki>
 <5123895.31r3eYUQgx@rafael.j.wysocki>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <5123895.31r3eYUQgx@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/4/26 21:09, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Revert commit 030a48b0f6ce ("thermal/drivers/hwmon: Cleanup coding style
> a bit") that introduced a use-after-free into the error path of
> thermal_add_hwmon_sysfs() by removing a valid check from it.
> 
> Link: https://lore.kernel.org/linux-hwmon/20260803183915.4ED7D1F000E9@smtp.kernel.org/
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_hwmon.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
> index 597c33c8a555..ec73d03a1e60 100644
> --- a/drivers/thermal/thermal_hwmon.c
> +++ b/drivers/thermal/thermal_hwmon.c
> @@ -212,7 +212,8 @@ int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
>   	if (new_hwmon_device)
>   		hwmon_device_unregister(hwmon->device);
>    free_mem:
> -	kfree(hwmon);
> +	if (new_hwmon_device)
> +		kfree(hwmon);
>   
>   	return result;
>   }

LGTM, a tricky plumbing. I'm sorry for being late with review.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
