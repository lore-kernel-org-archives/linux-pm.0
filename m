Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E47481660;
	Wed, 17 Jun 2026 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781713918; cv=none; b=GBmau6felN/wfCV9gNjqv3A6BJm28r6rOIFYq8RpWByYeRFrr40ulBMsjfPBFBQ2aJ1r+qRjmD2P7eTr8LFgrH71okKyKwmqwhA+Ie1Yroty/n8AdwwlcLAURRBpPWRYmJ6jJEamZPYpBDbATDyXiY3S2pF6FWNP4lAYbmnO1ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781713918; c=relaxed/simple;
	bh=WpAQPL2jFHBZxASmLIJFlo4iZJZSCrk1qr0tduk6A0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGqIUNo1gAfreyBQkdplTb8dZ5gp8G1VARWS5Ifmnd8s3/WV3yd7B06ysTm2oEbnuQmiPBCgJd8GNHq2RJEhTnCEPhxxYWTRCrkULmEUsnKo/4vPLfKhDANeVoLSoW4eXIkAr5E8kGMK4d7aj389WFrjmSELeQNpXZhD2nzYuG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ojavS/YM; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ojavS/YM"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 370292BCD;
	Wed, 17 Jun 2026 09:31:45 -0700 (PDT)
Received: from [10.57.28.160] (unknown [10.57.28.160])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13F5B3F905;
	Wed, 17 Jun 2026 09:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781713909; bh=WpAQPL2jFHBZxASmLIJFlo4iZJZSCrk1qr0tduk6A0s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ojavS/YMj5n5gxhAsfNDJJikPeKUIMsSni3nC8BIcbTHbX0PxyxDYgC7UDVwvy+Ph
	 Ofgx7f8uEDhu9zm7PHwmuP9Yqp6sspMfSJgbkbyxbH5U6NrP3dSzBIV6s9RpDHPbc6
	 rZ5F/1C43ivYbAVLl3s8/Y3cFDPiIZC6tHngZjfA=
Message-ID: <bc20f2a1-66ad-4655-99e0-ad59e597f831@arm.com>
Date: Wed, 17 Jun 2026 17:31:47 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpufreq: Allow exit latency to exceed target residency
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <3444162.aeNJFYEL58@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <3444162.aeNJFYEL58@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/26 17:16, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 76934e495cdc ("cpuidle: Add sanity check for exit latency and
> target residency") had added a check to prevent the exit latency of an
> idle state from exceeding its target residency that later was limited to
> printing a warning message in that case in commit 4bf944f3fcb6 ("cpuidle:
> Warn instead of bailing out if target residency check fails").
> 
> However, a thorough code inspection with that in mind leads to the
> conclusion that actually there are no assumptions in cpuidle regarding
> the relationship between the exit latency and target residency of a
> given idle state.  It is generally assumed that the idle states table
> provided by a cpuidle driver will be sorted by both the target residency
> and exit latency in ascending order, but that's a different matter.
> 
> Accordingly, drop the check in question along with the message printed
> when it triggers and the inaccurate comment preceding it.
> 
> Fixes: 4bf944f3fcb6 ("cpuidle: Warn instead of bailing out if target residency check fails")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/driver.c           |    8 --------
>  drivers/cpuidle/governors/ladder.c |    2 ++

ladder.c?

>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -195,14 +195,6 @@ static void __cpuidle_driver_init(struct
>  			s->exit_latency_ns =  0;
>  		else
>  			s->exit_latency = div_u64(s->exit_latency_ns, NSEC_PER_USEC);
> -
> -		/*
> -		 * Warn if the exit latency of a CPU idle state exceeds its
> -		 * target residency which is assumed to never happen in cpuidle
> -		 * in multiple places.
> -		 */
> -		if (s->exit_latency_ns > s->target_residency_ns)
> -			pr_warn("Idle state %d target residency too low\n", i);
>  	}
>  }
>  
> 

Fine with me, but the title is cpufreq: instead of cpuidle.
If you'll fix it when applying:
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
