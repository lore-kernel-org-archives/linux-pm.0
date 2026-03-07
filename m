Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C011B227565;
	Sat,  7 Mar 2026 02:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772850562; cv=none; b=uwCknird3yS8sxEzhCJr2MawbQ84B/szo7KPxXtFTHnMunuF3P+ZzEUKp9Jh+OqvBS2WVbaKz2lVxWOvDYe9lFbhCBXRRrVRyk+Q5fN0us/xs/90irp6uRGY6vi4Yl4YgAMlODiy9UjBfaBgBrXP70mJHtH/7FWeXxMOyhjQM0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772850562; c=relaxed/simple;
	bh=MWp0mghb6S8ZmAxV9y/CZoNAGWmR0S8/f7MbtfvOhyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WaPvSrRuI5k3+lybH0ZeASOzRarZ+EuUvobOBbkTMBmUnqpikjoZHf1BuUt+0GePs21cS45MmNwv3Aq/mZdDpUHxm/bws/75osNFZD/mRvrIEpIeOdeQr8Dy7yCIqiLZTAlf2ME9PYBX7GuzNesg0a9WOBhRWGZyRiaSoZrN6wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nr/Ui62I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nr/Ui62I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8378C4CEF7;
	Sat,  7 Mar 2026 02:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772850562;
	bh=MWp0mghb6S8ZmAxV9y/CZoNAGWmR0S8/f7MbtfvOhyo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nr/Ui62IF/42ul199Gn9Ug8flGIdnhw8WCdCsB6wzQD+3WKSlHE+YG1A/j0Ieq8lP
	 Y/kYUjkasKaaScIROOMoFFvRyL1ExrFLCl8BSWyv6vvLWuKlcmFB5E0+XNQGS6pTf0
	 ti/zLMA+u3+hkiXFBpjWR5ownErbF+/yZ0wr4BD/IgDoOSswTFfMhY5KFuTjIoxESQ
	 +FYp7DSn+PODRaxi3t0Nmx/m/2y9OG53AV1iZbVJ4Wi1+xc7SPAc/WKiHkJRalouy+
	 UunXvdFQ05Bc/lO9XCFk174GQitiFpKj1H438obiPhjrZHWjoapJ3i9PifEOt54uWm
	 87HQAYIWCA7hA==
Message-ID: <30bff99d-f74a-47a4-aed5-2616a32fe423@kernel.org>
Date: Fri, 6 Mar 2026 20:29:20 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] amd-pstate: Fix memory leak in
 amd_pstate_epp_cpu_init()
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260306095753.17155-1-gautham.shenoy@amd.com>
 <20260306095753.17155-2-gautham.shenoy@amd.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20260306095753.17155-2-gautham.shenoy@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/6/2026 3:57 AM, Gautham R. Shenoy wrote:
> On failure to set the epp, the function amd_pstate_epp_cpu_init()
> returns with an error code without freeing the cpudata object that was
> allocated at the beginning of the function.
> 
> Ensure that the cpudata object is freed before returning from the
> function.
> 
> This memory leak was discovered by Claude Opus 4.6 with the aid of
> Chris Mason's AI review-prompts
> (https://github.com/masoncl/review-prompts/tree/main/kernel).
> 
> Assisted-by: Claude:claude-opus-4.6 review-prompts/linux
> Fixes: f9a378ff6443 ("cpufreq/amd-pstate: Set different default EPP policy for Epyc and Ryzen")
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/cpufreq/amd-pstate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 5aa9fcd80cf51..d57969c72c9dc 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1533,7 +1533,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   
>   	ret = amd_pstate_set_epp(policy, cpudata->epp_default);
>   	if (ret)
> -		return ret;
> +		goto free_cpudata1;
>   
>   	current_pstate_driver->adjust_perf = NULL;
>   

