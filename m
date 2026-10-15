Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77541374E5B;
	Thu, 15 Oct 2026 08:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053740; cv=none; b=Lh4WKaLDA9A3DlNWZ+20xx3jMg+u550wkrfv41gcjV2NpDKRqGJeEddZak9Rp3x4MX4RKpS9yW/F0MVXKZfShVH6EHr8iC5RilcE3HZIn7fMwaCzOqPv58l5az6yJrSDaYhqqeJ4/whbvZ+iR8d+Mv/3gTGfiRvG+chXVoTRVNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053740; c=relaxed/simple;
	bh=9GBPsf2TYrF1WKkd14vDla3aDWEmCnmg+Xy1qG/ihJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+z72PwKSkJcwlSqRWr8iZRErop0TI4QpqyAu6J0Tz6nsHovvMLByZpwR3SU9m93ess7KMoWrTIwFL1sEj3iwIjJs2P3tHnsx9emDMhjRCs0Sit8PVSwx6TxBvbch+8RuqiPpZaP3Us4sopMuCLKvLmDQD/OXRD3BT+1VmZzy14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Nee64o6N; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Nee64o6N"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 691432F;
	Thu, 15 Oct 2026 01:42:15 -0700 (PDT)
Received: from [10.57.88.29] (unknown [10.57.88.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3608B3F871;
	Thu, 15 Oct 2026 01:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792053738; bh=9GBPsf2TYrF1WKkd14vDla3aDWEmCnmg+Xy1qG/ihJQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Nee64o6NbJ/uOFSeeVA7kSe5s+Rslj3Fawt0GxsjC3aYuRDql59/I3ZOhep54Upvm
	 AkbejZrCHgOTPbMcTNaIWnSIRCH1dDdAblo9mQoAK0b27atXdJqwulE0e4L9EpxlDx
	 ymWwg/89SaKjaVGpQEtBR/UqYc6Vq6yrZMINtXlM=
Message-ID: <0d05f4b5-b7f3-4fb5-b5cb-8b4d75ab78b3@arm.com>
Date: Thu, 15 Oct 2026 09:42:12 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: cppc: Enable boost by default when supported
To: Pengjie Zhang <zhangpengjie2@huawei.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linuxarm@huawei.com, zhanjie9@hisilicon.com, prime.zeng@hisilicon.com,
 wanghuiqiang@huawei.com, xuwei5@huawei.com, zhenglifeng1@huawei.com,
 yubowen8@huawei.com, pierre.gondois@arm.com, sumitg@nvidia.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, mojunjun4@huawei.com
References: <20261015015812.867988-1-zhangpengjie2@huawei.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20261015015812.867988-1-zhangpengjie2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/26 02:58, Pengjie Zhang wrote:
> The CPPC driver leaves boost disabled by default, even when Highest

"even"? That's the only case where disabling it even means something?

> Performance exceeds Nominal Performance. Userspace must explicitly
> enable boost before governors can use the full advertised performance
> range.
> 
> For user convenience, enable boost by default when at least one possible
> CPU reports support. Check the performance capabilities before registering
> the driver so that the cpufreq core enables boost for each policy that
> supports it.
> 
> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>

I often wonder if we should keep boost altogether, the power and
thermal envelope on silicon nowadays is complex enough for this to have
little meaning, it in no way guarantees no throttling or that you receive
the requested performance.
The (silicon-aware) user can always individually set the ceilings s.t.
it 'works' for their platform/workload/environment combination via
scaling_max_freq.

Since commit 54e74df5d76d
was also introduced by Huawei I'd be curious about the usage there,
AFAICS having a platform with NOMINAL_PERF != HIGHEST_PERF is just
additional headache on linux for now?

> ---
>  drivers/cpufreq/cppc_cpufreq.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 80893844353c..0a4255a36f60 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -1052,6 +1052,25 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>  	.name = "cppc_cpufreq",
>  };
>  
> +static void __init cppc_cpufreq_default_boost_init(void)
> +{
> +	struct cppc_perf_caps caps;
> +	bool enable = false;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		if (cppc_get_perf_caps(cpu, &caps))
> +			continue;
> +
> +		if (caps.highest_perf > caps.nominal_perf) {
> +			enable = true;
> +			break;
> +		}
> +	}
> +
> +	cppc_cpufreq_driver.boost_enabled = enable;
> +}
> +
>  static int __init cppc_cpufreq_init(void)
>  {
>  	int ret;
> @@ -1061,6 +1080,7 @@ static int __init cppc_cpufreq_init(void)
>  
>  	cppc_freq_invariance_init();
>  	populate_efficiency_class();
> +	cppc_cpufreq_default_boost_init();
>  
>  	ret = cpufreq_register_driver(&cppc_cpufreq_driver);
>  	if (ret)

