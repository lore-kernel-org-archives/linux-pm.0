Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4F5375AB5;
	Fri, 20 Mar 2026 12:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774009934; cv=none; b=Ky0xXEVrL1AULc21JQXNW42zzL/x3Zjy4DwOfigwlk+s/bXAS4bwpLzn4m2mVmUN5VDHkKw46tF13ULokHB4ZR7m5b85D6xR6z6pG+pObC1uj/bzxu23PJJ8tY1dcosifW3lJXs/hhL7rAcFROrKk25PJDfDBmc+hi2+to/l9oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774009934; c=relaxed/simple;
	bh=ww50xqn+WniPd8UeeRmih4YEcaxX0wGw7j4IRmlZB9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ru4c7po3fRdx7hWHAKEUN25fFGcokyNRXYB7yOxFSQJ9Coxb8f2F704IglYMFLOFjjjIufoEVhhSnN0QqiAnhZi8jJsPn4VNMbAAay4DU9Swku3YKymkDdi6nvkSZzgofq+WphzSQhpKQRchcYBtgXXsTn6evJY3RPo3I87/FX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C7EA165C;
	Fri, 20 Mar 2026 05:32:05 -0700 (PDT)
Received: from [10.57.20.9] (unknown [10.57.20.9])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B89F3F7BD;
	Fri, 20 Mar 2026 05:32:08 -0700 (PDT)
Message-ID: <031562ee-b88f-49b9-8b1e-dbbbe1a508c6@arm.com>
Date: Fri, 20 Mar 2026 12:32:23 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] thermal/cpufreq_cooling: remove unused cpu_idx in
 get_load()
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: rui.zhang@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org,
 viresh.kumar@linaro.org, amit.kachhap@gmail.com, daniel.lezcano@kernel.org,
 linux-kernel@vger.kernel.org, ke.wang@unisoc.com, di.shen@unisoc.com,
 jeson.gao@unisoc.com, xuewen.yan94@gmail.com
References: <20260320113148.7308-1-xuewen.yan@unisoc.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260320113148.7308-1-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Xuewen,

On 3/20/26 11:31, Xuewen Yan wrote:
> From: Di Shen <di.shen@unisoc.com>
> 
> The cpu_idx variable in the get_load function is now
> unused and can be safely removed.
> 
> No code logic is affected.
> 
> Signed-off-by: Di Shen <di.shen@unisoc.com>
> ---
>   drivers/thermal/cpufreq_cooling.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index 32bf5ab44f4a..d030dbeb2973 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -151,26 +151,23 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
>    * get_load() - get load for a cpu
>    * @cpufreq_cdev: struct cpufreq_cooling_device for the cpu
>    * @cpu: cpu number
> - * @cpu_idx: index of the cpu in time_in_idle array
>    *
>    * Return: The average load of cpu @cpu in percentage since this
>    * function was last called.
>    */
>   #ifdef CONFIG_SMP
> -static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
> -		    int cpu_idx)
> +static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu)
>   {
>   	unsigned long util = sched_cpu_util(cpu);
>   
>   	return (util * 100) / arch_scale_cpu_capacity(cpu);
>   }
>   #else /* !CONFIG_SMP */
> -static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
> -		    int cpu_idx)
> +static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu)
>   {
>   	u32 load;
>   	u64 now, now_idle, delta_time, delta_idle;
> -	struct time_in_idle *idle_time = &cpufreq_cdev->idle_time[cpu_idx];
> +	struct time_in_idle *idle_time = &cpufreq_cdev->idle_time[cpu];

This is a bug. We allocate 'num_cpus' size of array based on
number of CPU in the cpumask for a given cpufreq policy.
If there are 4 cpus in the CPU cluster but CPUs have ids:
CPU4-7 then accessing it with this change would explode.

Please re-design this patch set slightly and I will have a look
on the 2nd version (and particularly the part in current patch 2/2).

Regards,
Lukasz
