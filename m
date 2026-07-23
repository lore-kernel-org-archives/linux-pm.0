Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BC64A13B6;
	Thu, 23 Jul 2026 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784810705; cv=none; b=ZgU4PfjSTsAn30Vqt5Djjk+CkWDdEVpj4lZP984PAwggTTnSQtVo8xRRlCxOXkq2wS9yP+KQs5YKy0J1EK/g7aiT30OOyzyNryr51IP83DpW5wkujMFetF37C/TxBDkbKyrttBdD3x46+GqVwey+0gjFhmMXLIea8Fxv1Oxa6OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784810705; c=relaxed/simple;
	bh=BuUzWCouzpbbg2lPlgVYUKj5Ugh36+qSD5tNZJolJJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fPHbFh8igHG1Gi/GKtKrAgPqfDfnkqhXGoregc0uztWDw6sT6FgSnPsno3WUbXrXr1rKkBezLevpeweQnaGMWaQ0EjpLj19X6z5f/dqykjg8m1bMa3UNZUKWf6eUsgKLidJgWXfrFv5yKMGp3KeWqFqDddOwv/TqcWT5r5MVsr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=h3iKsP1m; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="h3iKsP1m"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC4E71477;
	Thu, 23 Jul 2026 05:44:48 -0700 (PDT)
Received: from [10.1.39.91] (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDC523F59E;
	Thu, 23 Jul 2026 05:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784810693; bh=BuUzWCouzpbbg2lPlgVYUKj5Ugh36+qSD5tNZJolJJs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h3iKsP1moCJAhfAuwc685G5jUgL/Xz8jD4QcjUKj9EtWiwEvpf1YWW+dykI6sJYs7
	 p/EbrgiDQGQOscZTsLxe4/88mRhxTg7t4SIowXEz1IvqBL3okDeoY4A5QJ1qth86ew
	 nS91XcAKy86wHOi8uuG7HRZXfCepJZkfY7QsTO4w=
Message-ID: <cfea177c-b618-4cac-9a74-1a442353849a@arm.com>
Date: Thu, 23 Jul 2026 13:44:48 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] cpuidle: cache aggregated governor latency QoS
 constraint
To: Yaxiong Tian <tianyaxiong@kylinos.cn>, rafael@kernel.org,
 daniel.lezcano@kernel.org, lenb@kernel.org, pavel@kernel.org,
 shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260721092324.17508-1-tianyaxiong@kylinos.cn>
 <20260721092559.18921-1-tianyaxiong@kylinos.cn>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260721092559.18921-1-tianyaxiong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/26 10:25, Yaxiong Tian wrote:
> cpuidle_governor_latency_req() runs on every idle-state selection and
> aggregates per-CPU resume latency with the global CPU latency and
> wakeup latency QoS limits.  That path repeatedly walks get_cpu_device()
> and pm_qos_read_value(), which shows up hot under menu_select().
> 
> Cache the aggregated constraint per CPU and refresh it only when the
> corresponding per-CPU generation changes.  The generation is already
> bumped by the global and per-CPU resume latency QoS notifiers added
> earlier in this series.
> 
> On a menu governor profile, cpuidle_governor_latency_req() drops from
> about 19.9% of menu_select time to about 4.2%, roughly a 6x reduction
> in cost per call (~1.9 us down to ~0.3 us).
> 
> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> ---
>  drivers/cpuidle/governor.c | 37 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
> index d286ccf19a69..67909470c14b 100644
> --- a/drivers/cpuidle/governor.c
> +++ b/drivers/cpuidle/governor.c
> @@ -32,11 +32,17 @@ struct cpuidle_governor *cpuidle_prev_governor;
>   */
>  static DEFINE_PER_CPU(atomic_t, latency_req_gen);
>  
> +struct cpuidle_latency_req_cache {
> +	unsigned int gen;
> +	s64 latency_ns;
> +};
> +
>  struct cpuidle_cpu_qos_nb {
>  	struct notifier_block nb;
>  	unsigned int cpu;
>  };
>  
> +static DEFINE_PER_CPU(struct cpuidle_latency_req_cache, latency_req_cache);

So this will initialize with latency_req_cache.gen = 0 and latency.req_cache.latency_ns = 0...
Come to think of it maybe a no-req run is also good as the first and last selftest case.

>  static DEFINE_PER_CPU(struct cpuidle_cpu_qos_nb, cpuidle_cpu_qos_nb);
>  
>  static void cpuidle_latency_req_invalidate_cpu(unsigned int cpu)
> @@ -212,10 +218,22 @@ int cpuidle_register_governor(struct cpuidle_governor *gov)
>   */
>  s64 cpuidle_governor_latency_req(unsigned int cpu)
>  {
> -	struct device *device = get_cpu_device(cpu);
> -	int device_req = dev_pm_qos_raw_resume_latency(device);
> -	int global_req = cpu_latency_qos_limit();
> -	int global_wake_req = cpu_wakeup_latency_qos_limit();
> +	struct cpuidle_latency_req_cache *cache;
> +	unsigned int gen;
> +	struct device *device;
> +	int device_req, global_req, global_wake_req;
> +	s64 latency_ns;
> +
> +	cache = per_cpu_ptr(&latency_req_cache, cpu);
> +	gen = atomic_read(per_cpu_ptr(&latency_req_gen, cpu));
> +
> +	if (likely(READ_ONCE(cache->gen) == gen))
> +		return READ_ONCE(cache->latency_ns);
> +
> +	device = get_cpu_device(cpu);
> +	device_req = dev_pm_qos_raw_resume_latency(device);
> +	global_req = cpu_latency_qos_limit();
> +	global_wake_req = cpu_wakeup_latency_qos_limit();
>  
>  	if (global_req > global_wake_req)
>  		global_req = global_wake_req;
> @@ -223,5 +241,14 @@ s64 cpuidle_governor_latency_req(unsigned int cpu)
>  	if (device_req > global_req)
>  		device_req = global_req;
>  
> -	return (s64)device_req * NSEC_PER_USEC;
> +	latency_ns = (s64)device_req * NSEC_PER_USEC;
> +
> +	WRITE_ONCE(cache->latency_ns, latency_ns);
> +	/*
> +	 * Store gen last so a concurrent invalidate cannot leave a stale
> +	 * latency_ns marked as current.
> +	 */

This doesn't guarantee the ordering.

> +	WRITE_ONCE(cache->gen, gen);
> +
> +	return latency_ns;
>  }

