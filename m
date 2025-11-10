Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8557E3F9FB;
	Mon, 10 Nov 2025 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762761503; cv=none; b=b69M+FwWmQud2O8MseS/u7uRQoXiH7XMCAYxRw63X03UJm4jvsJGgUEsndI9vdNUBvFKGMUidAWYMCqfjX3pEpD9cDJn2xGGWwCPHq9AvN9upX8uPTbCurV3GyTxKLipfHGFhhh4nKy40i6k66BhMTHZ4qRiw95GqymC71E4TFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762761503; c=relaxed/simple;
	bh=LXZMOcDw+7IrvIz/VaN4tZqsfZyNEhgyEz8akMeEqbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jziLRvxWZItkpSskq8RDfGzsuDH4xbQsUglwXkVmcjE5Pp9otrSK1PbpDiElwCGoreI/j5Spxp6egc33Bmx1Ys2TL5AnXl34il0kgKNddgSDDW3cFeruqtibD3+OCUXacLUwAkc7/cgkigURGezQxUSWUh1GLpLgsXObpyOkIQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00487497;
	Sun,  9 Nov 2025 23:58:07 -0800 (PST)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDC2B3F66E;
	Sun,  9 Nov 2025 23:58:13 -0800 (PST)
Message-ID: <ccf56821-6553-4bcc-8f87-1367fe27d734@arm.com>
Date: Mon, 10 Nov 2025 07:58:11 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpuidle: Add sanity check for exit latency and target
 residency
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
References: <12779486.O9o76ZdvQC@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <12779486.O9o76ZdvQC@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/25 19:07, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make __cpuidle_driver_init() fail if the exit latency of one of the
> driver's idle states is less than its exit latency which would break

s/exit latency/target residency/
for the second one here.

Apart from that
Reviewed-by: Christian Loehle <christian.loehle@arm.com>

> cpuidle assumptions.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2: Make __cpuidle_driver_init() fail if the check is not passed (Artem).
> 
> ---
>  drivers/cpuidle/driver.c |   16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -152,7 +152,7 @@ static void cpuidle_setup_broadcast_time
>   * __cpuidle_driver_init - initialize the driver's internal data
>   * @drv: a valid pointer to a struct cpuidle_driver
>   */
> -static void __cpuidle_driver_init(struct cpuidle_driver *drv)
> +static int __cpuidle_driver_init(struct cpuidle_driver *drv)
>  {
>  	int i;
>  
> @@ -193,7 +193,17 @@ static void __cpuidle_driver_init(struct
>  			s->exit_latency_ns =  0;
>  		else
>  			s->exit_latency = div_u64(s->exit_latency_ns, NSEC_PER_USEC);
> +
> +		/*
> +		 * Ensure that the exit latency of a CPU idle state does not
> +		 * exceed its target residency which is assumed in cpuidle in
> +		 * multiple places.
> +		 */
> +		if (s->exit_latency_ns > s->target_residency_ns)
> +			return -EINVAL;
>  	}
> +
> +	return 0;
>  }
>  
>  /**
> @@ -223,7 +233,9 @@ static int __cpuidle_register_driver(str
>  	if (cpuidle_disabled())
>  		return -ENODEV;
>  
> -	__cpuidle_driver_init(drv);
> +	ret = __cpuidle_driver_init(drv);
> +	if (ret)
> +		return ret;
>  
>  	ret = __cpuidle_set_driver(drv);
>  	if (ret)
> 
> 
> 
> 

