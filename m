Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43713955D8;
	Mon, 15 Jun 2026 08:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781511119; cv=none; b=ddupDpAzxJS/xmv1gFG0aa9XU4bPkabpqazJ4E+P8MC0nlApxcwQHVLaQclICsA1cWtnqAAF3G8vpZ1y7LbuzVhUkvPX3TBydDqSuVu6uFd4FIwRJGKdXZZNwmiGuGqfSMJDP8F1QA9BKRBjhnDaEi8JbilnhV7fyDaEvh8qmAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781511119; c=relaxed/simple;
	bh=i0FKMMog95cdDHeUw0hIpFnauAROqRy7yLFU4heJdPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sd0q3FklYnzzOpLPqQIudhwmEXkwaePstDR1vJpAyUHpxUsgGpozDJFlpaixc6ThqlghVdAIdFn6mIDMOsvqWqLVCCS5wRuewqTz/oRt+EIgepMypH6P8Y739bzajO8wpv2RDFt2QeP5cv8UQEij9U9tw+HGQ64Wt1Tddmi8buY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=koFvlMWH; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="koFvlMWH"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C9A31BB0;
	Mon, 15 Jun 2026 01:11:52 -0700 (PDT)
Received: from [10.57.29.103] (unknown [10.57.29.103])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C99C73F905;
	Mon, 15 Jun 2026 01:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781511117; bh=i0FKMMog95cdDHeUw0hIpFnauAROqRy7yLFU4heJdPw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=koFvlMWHKfmbra2jzLhEtqrrYnPqlsbftYuO2L0X8nNShCe0KTyqaHf5VOoY+46Ns
	 WHFrljRkq9nQv0c563fUv+Au2dIQHNrWAxdGbqhXid2fRrtOkGo0HRIrSQqdj1Knyy
	 XfsWGoxqJ5rCWzSnGv6zovy6NA1LcIHmItdyyMaQ=
Message-ID: <bc5e1109-473a-4c00-9578-8d468af8e2ca@arm.com>
Date: Mon, 15 Jun 2026 09:11:53 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: of: Match trip property helper types
To: "Rob Herring (Arm)" <robh@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260612215009.1884665-1-robh@kernel.org>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260612215009.1884665-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/12/26 22:50, Rob Herring (Arm) wrote:
> The thermal-zone binding defines "temperature" as a signed int32
> value and "hysteresis" as an unsigned int32 value. Using helpers with
> matching types avoids dt_property_check mismatches and preserves the
> signed interpretation needed for trips below zero.
> 
> Read "temperature" with the signed helper and keep "hysteresis" on the
> unsigned helper using separate typed temporaries before storing them in
> the trip structure.
> 
> Assisted-by: Codex:gpt-5-5
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>   drivers/thermal/thermal_of.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 99085c806a1f..196cb29afae9 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -63,22 +63,23 @@ static int thermal_of_get_trip_type(struct device_node *np,
>   static int thermal_of_populate_trip(struct device_node *np,
>   				    struct thermal_trip *trip)
>   {
> -	int prop;
> +	u32 hysteresis;
> +	s32 temperature;
>   	int ret;
>   
> -	ret = of_property_read_u32(np, "temperature", &prop);
> +	ret = of_property_read_s32(np, "temperature", &temperature);
>   	if (ret < 0) {
>   		pr_err("missing temperature property\n");
>   		return ret;
>   	}
> -	trip->temperature = prop;
> +	trip->temperature = temperature;
>   
> -	ret = of_property_read_u32(np, "hysteresis", &prop);
> +	ret = of_property_read_u32(np, "hysteresis", &hysteresis);
>   	if (ret < 0) {
>   		pr_err("missing hysteresis property\n");
>   		return ret;
>   	}
> -	trip->hysteresis = prop;
> +	trip->hysteresis = hysteresis;
>   
>   	ret = thermal_of_get_trip_type(np, &trip->type);
>   	if (ret < 0) {


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
