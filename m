Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A1A26C3BD;
	Thu, 12 Mar 2026 20:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773348070; cv=none; b=omdEqAoov7l+kUOiuRJhNjUXQhFceD0t4LcGclgSCOcUExT0JVpCikejFVKI3x07+D4JbxGbB4mu55Ql3TFJnmg5AZ5dxq2a+SV8Zz6h6cLsJaFKhkL9U/LBTQTbxtJchB9ehBQ5JWl6VJW/n/wHaH55C2hIon7gu0DpE24gPzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773348070; c=relaxed/simple;
	bh=Gb4LVB9Fx1wvu/Fr99C7YP376NEyE1vUn7CNWw+bGFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oiRL2VqA80tCyGP4itATQZcsLi5Pcs1ClFDIkHq2GZcGj1bgBWLwABDv543DH1l5NMKnKvsGD3dmohUEQBl2YO1TEUdn32L5UtWv6hTeg+V4EiQDFNNG3jDyRfvElg1VEkrlf0xAhZXXwMbpLcCtmcoTLhKchKS6npUbetgzQNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuH6psX9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuH6psX9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EA5C2BC87;
	Thu, 12 Mar 2026 20:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773348070;
	bh=Gb4LVB9Fx1wvu/Fr99C7YP376NEyE1vUn7CNWw+bGFA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TuH6psX9E2oD7/7tXD9A8DaQ3qUrOhHyLxsgZm8n8p2W2uQXYC4vXrD+0rmh1TRM2
	 +Ts07/mmvyKsr5gjJ/myLY50XSu/DMTqBbauRN6E/OK1P/RK3UnWn0ZOwlCOn/ot37
	 z6/DHuvosT/aU/reCtHvuMjFKdo0xy+I+e3iOJw0EibyxXQcUCSefawlK1bPx+cGkP
	 rvYnLeHjvMYW7VHgPWiIYxf+rr+9yIaPM6JxG3cDKQocNacXoMzsnGakIPQosLmMUm
	 yl9Zmj0bvGLFhOb3tv7A/xoDQwm2rZ2lKA5J220K0Td7cztI86W/8tsY3QIj8AMBwx
	 jVw2RdUpFRhTA==
Message-ID: <d38cfe28-6934-4ebf-9241-ba043d4c7771@kernel.org>
Date: Thu, 12 Mar 2026 15:41:08 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] amd-pstate: Update cppc_req_cached in fast_switch
 case
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260311140116.19604-1-gautham.shenoy@amd.com>
 <20260311140116.19604-3-gautham.shenoy@amd.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20260311140116.19604-3-gautham.shenoy@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/11/2026 9:01 AM, Gautham R. Shenoy wrote:
> The function msr_update_perf() does not cache the new value that is
> written to MSR_AMD_CPPC_REQ into the variable cpudata->cppc_req_cached
> when the update is happening from the fast path.
> 
> Fix that by caching the value everytime the MSR_AMD_CPPC_REQ gets
> updated.
> 
> This issue was discovered by Claude Opus 4.6 with the aid of Chris
> Mason's AI review-prompts
> (https://github.com/masoncl/review-prompts/tree/main/kernel).
> 
> Assisted-by: Claude:claude-opus-4.6 review-prompts/linux
> Fixes: fff395796917 ("cpufreq/amd-pstate: Always write EPP value when updating perf")
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/cpufreq/amd-pstate.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index d57969c72c9dc..24cdeffbcd40e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -261,7 +261,6 @@ static int msr_update_perf(struct cpufreq_policy *policy, u8 min_perf,
>   
>   	if (fast_switch) {
>   		wrmsrq(MSR_AMD_CPPC_REQ, value);
> -		return 0;
>   	} else {
>   		int ret = wrmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
>   

