Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EEB33E347;
	Mon, 27 Jul 2026 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159951; cv=none; b=gN6HMMs4AevbNLp1az2Rl0tkSt8cuUGm2gcB2q/zAy2P2Aj4JgJrp+TxgSR0lt1Bl2SbPuEU0uppbaw+xKwnZKQk06O4uFSxGt4WmvYrETgHjygU/LBnZ3roned3k7rnJguLN0Oha6Ryvh0UvPjzpKtDnHLiKvvfMqxP2kYo7PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159951; c=relaxed/simple;
	bh=V85cSh5AtWAKe8T7pNKXhHm4+YU52Evm52b5hv8auq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HMFIp4fOFuw8ZjPt/2EH6PhylhNXz79FGNSsGXP34xBsdnIxtQWwWqgsE/euD2T5ZoIgCT/viD5+qvaemmIgRey+1uuE2w5eEg6wBaNGJv7F0Pl6+5h0r04xsMBvK/wkVRSS/kGfmgOOKhtSHdYSy3L5Kv4/jEt53Ism0uQ2I00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YzWaEYDp; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YzWaEYDp"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C79AC1596;
	Mon, 27 Jul 2026 06:45:44 -0700 (PDT)
Received: from [10.57.1.72] (unknown [10.57.1.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 959243F763;
	Mon, 27 Jul 2026 06:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785159948; bh=V85cSh5AtWAKe8T7pNKXhHm4+YU52Evm52b5hv8auq0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YzWaEYDpwiJ5lMniXb11mVfPzSytHZF1tkdhmyXFfDaxuMv4IWrS5DZBqfVISJyFm
	 Aaary8+0a0CKYAB3EyXGFCppNqECu1nEAEccGE/baaCqq9j7A5MqSrQx9Wu1Q7538R
	 ojrPgM2lMIbSh7kkWSfymJnX/s8dzrvkfxSDpOLE=
Message-ID: <443cae7f-bd01-4022-9703-7a1e6ae883bb@arm.com>
Date: Mon, 27 Jul 2026 14:45:41 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] cpufreq: CPPC: Preserve OSPM-set registers across
 suspend/resume
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, lenb@kernel.org,
 saket.dumbre@intel.co, ray.huang@amd.com, mario.limonciello@amd.com,
 perry.yuan@amd.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
References: <20260724215937.3368276-1-sumitg@nvidia.com>
 <20260724215937.3368276-5-sumitg@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260724215937.3368276-5-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/26 22:59, Sumit Gupta wrote:
> The previous patch preserves the OSPM-set registers across CPU hotplug,
> but system suspend/resume is a separate path. On platforms that reset
> those registers or the performance controls across suspend, the values
> are lost.
> 
> Reuse the same save/restore mechanism for suspend/resume:
> 
>   - suspend() only saves the current OSPM-set values. It does not revert
>     them to firmware, since a later offline() already does that when
>     system suspend offlines the secondary CPUs.
>   - resume() needs the same steps as online(), so .resume points at
>     online() directly.
> 
> Suggested-by: Christian Loehle <christian.loehle@arm.com>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 8a13ec49eb9d..be2d873ccd84 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -921,6 +921,22 @@ static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> +/*
> + * suspend() only saves the OSPM-set values. It does not revert them to the
> + * firmware values.
> + *
> + * This is because system suspend may later offline the secondary CPUs.
> + * That runs offline(), which saves the values and then reverts to firmware.
> + * If suspend() had already reverted, offline() would save the firmware value
> + * instead of the user's request, and the request would be lost.
> + */
> +static int cppc_cpufreq_cpu_suspend(struct cpufreq_policy *policy)
> +{
> +	cppc_cpufreq_save_requested_regs(policy);
> +
> +	return 0;
> +}
> +

Wouldn't it be safer to commit everything here and not rely on the later
offline() to still need a fully usable CPPC platform (in particular for
PCC), as at this stage all but 2 CPUs might already be offline()d?
Also either the later offline() saves registers successfully, and overwrites
this snapshot, or it fails and overwrites them with U64, right?


>  static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>  {
>  	struct cppc_cpudata *cpu_data = policy->driver_data;
> @@ -1235,6 +1251,8 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>  	.exit = cppc_cpufreq_cpu_exit,
>  	.online = cppc_cpufreq_cpu_online,
>  	.offline = cppc_cpufreq_cpu_offline,
> +	.suspend = cppc_cpufreq_cpu_suspend,
> +	.resume = cppc_cpufreq_cpu_online,
>  	.set_boost = cppc_cpufreq_set_boost,
>  	.attr = cppc_cpufreq_attr,
>  	.name = "cppc_cpufreq",

