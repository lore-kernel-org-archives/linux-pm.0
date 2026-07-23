Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BA3361950;
	Thu, 23 Jul 2026 21:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784841482; cv=none; b=qKSc7WpxVE5k5ZiWHS4NcNQYHzZQZjR5mtWrZ0obsaZSw4n6Zwd/CyuyNjD+x5G92MZk1ujfDrG8rniFAfMmD7XtDmN2dGwFR6LssuLPB8CGYPfoxqckU4ENGVxZ5OyVD4NTOvX6vZxw2j4svcN7DmYcVxHb+Ob30bmwFtY4ss4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784841482; c=relaxed/simple;
	bh=PvycJfw2YJ7EJsqNas+p3DcQM/cHV+FFptvyM6ywcGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZlNJscKnoT/Kq9DZZNhuS1fVR4h3ZGzxDeVUB5mKxCg9WXXDItq7w+HoiFrFJcBWQRp77DEhtR3mLefKRI6HOFh/SLlPW7XxRASR28TvYeD1pnCxB5qe3wcFqTEZPwSTTworL1205kZEsBfbnTcnsvOyOQk45sa0yom78IyA2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3esReP1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3esReP1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C8C1F000E9;
	Thu, 23 Jul 2026 21:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784841481;
	bh=HrFDkBHY0uYX0EJvpa0+U93lr23ZHVYaVaw6l1qC4m0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=K3esReP1X23czSXJtvyAuum7Myq4aH1tCqfIl5NLH4FLFbW7zebWT2cFC0heBKNEY
	 RpAnszb5xdHuWm+iKtDmGR1ra+SfdiD1JOmF93yw28B5X+fkh95ic8tNoUPkyX0o1/
	 G3HrozTF33gn6+VXiV3m2nWaqMKiIEJoVyj1bbEbpIU3Lv7MbLWNVpXM3Pm58Bm2JB
	 7EqtwFsL6q6IEL5/gr6fSN2nR8BVyAify/d+f7XD/xXVdegzwC+6VuuhOioiJvJRtW
	 3FASDZ4Pc1gOnpyKG46Jze33B0nJOfFU/KT5ac6uGwMDl2azK70hTCHImJFONB7zHD
	 8lbdowwlphucA==
Message-ID: <93e11ca9-de68-4a62-8bf3-c14a499612da@kernel.org>
Date: Thu, 23 Jul 2026 16:17:59 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] cpufreq/amd-pstate: Remove the defensive check for
 bios_min_perf
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>, Huang Rui <ray.huang@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mario Limonciello <superm1@kernel.org>, Perry Yuan <perry.yuan@amd.com>,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260723201228.22584-1-kprateek.nayak@amd.com>
 <20260723201228.22584-3-kprateek.nayak@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260723201228.22584-3-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/23/26 15:12, K Prateek Nayak wrote:
> Initialization of bios_min_perf (BIOS Requested CPU Min Freq.) only
> succeeds when the driver init finds the CPPC_REQ MSRs to have all 0s
> except for MIN_PERF bits.
> 
> A kexec puts the driver through the suspend path which, although resets
> the min_perf back to bios_min_perf, keeps the rest of the CPPR_REQ
> intact with the last value at the time of suspend.
> 
> The defensive check for bios_min_perf exists to prevent the min perf
> from last CPPC_REQ being incorrectly considered as bios_min_perf when
> a kexec switches from an older kernel running the version of driver
> which is not aware of bios_min_perf to a newer one.
> 
> This scenario is extremely unlikely and Mario suggested it is better to
> simplify the initialization rather than complicating the suspend resume
> paths.
> 
> Drop the defensive check for bios_min_perf initialization and add a
> debug message to dump the BIOS Requested Min Freq. to console leaving
> enough breadcrumbs for debug if a situation so arises.
> 
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
> Changelog rfc v1..v2:
> 
> o Reworked based on review comments from Mario.
> ---
>   drivers/cpufreq/amd-pstate.c | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 1157f05df10f..02308e95636e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -462,7 +462,6 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
>   {
>   	union perf_cached perf = READ_ONCE(cpudata->perf);
>   	u64 cap1, numerator, cppc_req;
> -	u8 min_perf;
>   
>   	int ret = rdmsrq_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
>   				     &cap1);
> @@ -478,16 +477,6 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
>   		return ret;
>   
>   	WRITE_ONCE(cpudata->cppc_req_cached, cppc_req);
> -	min_perf = FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cppc_req);
> -
> -	/*
> -	 * Clear out the min_perf part to check if the rest of the MSR is 0, if yes, this is an
> -	 * indication that the min_perf value is the one specified through the BIOS option
> -	 */
> -	cppc_req &= ~(AMD_CPPC_MIN_PERF_MASK);
> -
> -	if (!cppc_req)
> -		perf.bios_min_perf = min_perf;
>   
>   	perf.highest_perf = numerator;
>   	perf.max_limit_perf = numerator;
> @@ -495,6 +484,7 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
>   	perf.nominal_perf = FIELD_GET(AMD_CPPC_NOMINAL_PERF_MASK, cap1);
>   	perf.lowest_nonlinear_perf = FIELD_GET(AMD_CPPC_LOWNONLIN_PERF_MASK, cap1);
>   	perf.lowest_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
> +	perf.bios_min_perf = FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cppc_req);
>   	WRITE_ONCE(cpudata->perf, perf);
>   	WRITE_ONCE(cpudata->prefcore_ranking, FIELD_GET(AMD_CPPC_HIGHEST_PERF_MASK, cap1));
>   	WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
> @@ -1043,6 +1033,13 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>   		return -EINVAL;
>   	}
>   
> +	if (perf.bios_min_perf) {
> +		u32 bios_min_freq = perf_to_freq(perf, cpudata->nominal_freq, perf.bios_min_perf);
> +
> +		pr_debug("Found Requested CPU Min Frequency of %uMHz on CPU%d\n",
> +			 bios_min_freq, cpudata->cpu);
> +	}
> +
>   	return 0;
>   }
>   

