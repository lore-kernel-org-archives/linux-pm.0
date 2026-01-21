Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA45E3A7F45;
	Wed, 21 Jan 2026 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769002491; cv=none; b=ligBWEMyhZSewmQUBtGHD+6E90iqNctsO5JKe5/CYBM+LBaJLt+GygHdFv1wtPPIASGI4ND2Fih4Rm7XDx6Cqpn4C6V5GjRcVk1SxVZ+qjJXUsZks2+Dm15KKCb1smhrsIF75HwhmkW17AiWGy7dVDP9jVAOW4bLJrQyQBf/nc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769002491; c=relaxed/simple;
	bh=x5HQhfxWvrE7q7DqwIpP7JLi4Mm2u/pB36vrOQzeCoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uAU8ODvLxFv6pmSCwbt2EJgWVELgBlmdprFzNlJpaYd1Woa7nj4pUPJUiURMCq97nE8XWEUgddNSPERkdXFbnhlm0pDNtNOZJaExM9ivLWoff0YeIAzrONxZbM8gn7S75vYKskTRp4V8klEX6tVQoVFKB9WktSugnHTTXjZmgbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 734C41476;
	Wed, 21 Jan 2026 05:34:42 -0800 (PST)
Received: from [10.1.35.68] (e127648.arm.com [10.1.35.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1556E3F632;
	Wed, 21 Jan 2026 05:34:47 -0800 (PST)
Message-ID: <f32d40ff-dc1d-4c37-a607-77dd9423ec91@arm.com>
Date: Wed, 21 Jan 2026 13:34:46 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/5] cpuidle: governors: teo: Avoid fake intercepts
 produced by tick
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
References: <2257365.irdbgypaU6@rafael.j.wysocki>
 <3404606.44csPzL39Z@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <3404606.44csPzL39Z@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/14/26 19:44, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Tick wakeups can lead to fake intercepts that may skew idle state
> selection towards shallow states, so it is better to avoid counting
> them as intercepts.
> 
> For this purpose, add a check causing teo_update() to only count
> tick wakeups as intercepts if intercepts within the tick period
> range are at least twice as frequent as any other events.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/teo.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -239,6 +239,17 @@ static void teo_update(struct cpuidle_dr
>  			cpu_data->state_bins[drv->state_count-1].hits += PULSE;
>  			return;
>  		}
> +		/*
> +		 * If intercepts within the tick period range are not frequent
> +		 * enough, count this wakeup as a hit, since it is likely that
> +		 * the tick has woken up the CPU because an expected intercept
> +		 * was not there.  Otherwise, one of the intercepts may have
> +		 * been incidentally preceded by the tick wakeup.
> +		 */
> +		if (3 * cpu_data->tick_intercepts < 2 * total) {
> +			cpu_data->state_bins[idx_timer].hits += PULSE;
> +			return;
> +		}
>  	}

Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Makes sense to me, let me try to find something that triggers this (often)
