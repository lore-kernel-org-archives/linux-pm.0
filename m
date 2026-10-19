Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54597491591;
	Mon, 19 Oct 2026 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420639; cv=none; b=f2zM0I1kER8Wa04zUUodCFb+TiSHXgA8OJfJfRbGdNCb+Tt6TYqJhyOSuMMEhB7I5AUfnonxZpPWBegAJe934vOOR9jQH1L/cN1JRauMcG0Ffi9YVllGrcupCRx23C7YtqebhxujM7sJ/vrozuwBXG/IJm3+F96iAy7oy8Hbsqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420639; c=relaxed/simple;
	bh=faxRUhTxvTfkVZeM6s3QqNHE6m+DBAqDUARXNJ9nV6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUW1nIxa2cSvA2ztahD6uowsjvkKrgRPTRBubvB7q/DNxRuMey0/B/1/7Wr8uUqbtuwgyXTGlSaN4ZuR/w/BidAU9w6kRDJFqYmXSFuzsCSNSuBZcPIwLeYSeKvQ3xWwV2x0C+Japczn8a/0vgNY6czUkjhe0SsLOeJ4Rr6fjs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3mE0wXx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3mE0wXx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64651F000C4;
	Mon, 19 Oct 2026 14:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792420638;
	bh=DmyE052xRXB1BSS4uThP3UUuu8BmwPmlB4p2QGb/65M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=O3mE0wXxb+oMwo7sMSi/oA2B8FO+f0jF8LCRpUKROlTOGSjyHOYM0+JXYEBdSf026
	 kPGOp785nPltf9+jo9oIj8YLwWN+mo4A29I+1L06PTHI7duee57Vcc3b54SYQHsthH
	 pWGvahqaAyUgFPcuca55ufnjiadxdXXXT6N1d3yN/ChHr5hEJ+tV4zKw9SyvoOOoEp
	 4wVYVpCPoqqtO32khX77mG6XOKvCFBSX7alYGraJ46W/NesPRRpB1nS3fWbYnqoZLC
	 /Hv+78/XZslXzABSxupdOfjVLSCyGYgSuaD6ZMNdN2h5iEpLzkPZuzPfDHuhaA9iGe
	 KqLTj0I9IAG+g==
Message-ID: <b48284b4-68d1-493c-a34b-20306c564cae@kernel.org>
Date: Mon, 19 Oct 2026 16:37:14 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: max17042_battery: infer the status when no
 supplier is described
To: Derek Ross <derekross@gmail.com>, Sebastian Reichel <sre@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, kernel@puri.sm,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261019143307.2109629-1-derekross@gmail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20261019143307.2109629-1-derekross@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 19-Oct-26 4:33 PM, Derek Ross wrote:
> When no power supply is described as supplying the battery,
> power_supply_am_i_supplied() returns -ENODEV and the driver reports
> POWER_SUPPLY_STATUS_UNKNOWN, even though the gauge measures the battery
> current itself.
> 
> That is the case on the Pixel 7 Pro, where the charger is left running
> by the bootloader and no charger driver is bound yet. The battery read
> "Unknown" while taking in 1.2 A, so the desktop showed no charging
> indicator and upower treated the phone as discharging: at its critical
> percentage it put a charging phone to sleep.
> 
> When no supplier is described and current sense is enabled, take the
> status from the measured current: charging while current flows into the
> battery, full when the gauge reports end of charge and no current flows,
> discharging otherwise. A described supplier keeps the existing logic, and
> without current sense the status stays unknown.
> 
> Signed-off-by: Derek Ross <derekross@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans



> ---
>  drivers/power/supply/max17042_battery.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
> index 8138b52e05e1..c437d80700a6 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -148,18 +148,26 @@ static int max17042_get_status(struct max17042_chip *chip, int *status)
>  {
>  	int ret, charge_full, charge_now;
>  	int current_now;
> +	bool supplied, full;
>  	u32 data;
>  
>  	ret = power_supply_am_i_supplied(chip->battery);
> -	if (ret < 0) {
> -		*status = POWER_SUPPLY_STATUS_UNKNOWN;
> -		return 0;
> -	}
>  	if (ret == 0) {
>  		*status = POWER_SUPPLY_STATUS_DISCHARGING;
>  		return 0;
>  	}
>  
> +	/*
> +	 * A negative value means no supplier is described, e.g. a charger the
> +	 * bootloader left running that no driver owns. The gauge's own current
> +	 * sense still tells which way charge flows, so use it when it's there.
> +	 */
> +	supplied = ret > 0;
> +	if (!supplied && !chip->enable_current_sense) {
> +		*status = POWER_SUPPLY_STATUS_UNKNOWN;
> +		return 0;
> +	}
> +
>  	/*
>  	 * The MAX170xx has builtin end-of-charge detection and will update
>  	 * FullCAP to match RepCap when it detects end of charging.
> @@ -178,7 +186,8 @@ static int max17042_get_status(struct max17042_chip *chip, int *status)
>  	if (ret < 0)
>  		return ret;
>  
> -	if ((charge_full - charge_now) <= MAX17042_FULL_THRESHOLD) {
> +	full = (charge_full - charge_now) <= MAX17042_FULL_THRESHOLD;
> +	if (supplied && full) {
>  		*status = POWER_SUPPLY_STATUS_FULL;
>  		return 0;
>  	}
> @@ -200,6 +209,8 @@ static int max17042_get_status(struct max17042_chip *chip, int *status)
>  
>  	if (current_now > 0)
>  		*status = POWER_SUPPLY_STATUS_CHARGING;
> +	else if (full && current_now == 0)
> +		*status = POWER_SUPPLY_STATUS_FULL;
>  	else
>  		*status = POWER_SUPPLY_STATUS_DISCHARGING;
>  

