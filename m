Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA43843C049;
	Tue, 10 Mar 2026 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134304; cv=none; b=jlX4r5tXaYtp9YQ9ddUBdT9/pD8/fYLDNl74p/hAHk78W3qG3S9IVwtC1efUiDH1f8DU07iBO9E9z8vjH5ZE1EZNsubyR2mLjwryRFEbotGhoO/qFHa8CKc35E/3S8IJY45LTZGse/wyeebsnKCgRoIRylqKlfVUIPOIqjIPKJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134304; c=relaxed/simple;
	bh=vTlaRU0b4aNb04oP52gkoCgBBRi5bR5hbOyQbtmIaQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZk0ul0MgbyJoPA8XYfoXV4uyQEPOyZvvgwyZnMGCYzDCrJ4t2Ljf10vkg09CFM51ZTuNRsDasWxAhx5e6L1BB7tFnvFxRj+qKNDRDf1EL2QePHZcKvfK9dLVIbI7PLvhyGX4m60CFh8OM0OVjLlB9+8Ng47DtoFxWW2Jaeaxb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF49916A3;
	Tue, 10 Mar 2026 02:18:16 -0700 (PDT)
Received: from [10.1.27.17] (e127648.arm.com [10.1.27.17])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDA213F73B;
	Tue, 10 Mar 2026 02:18:21 -0700 (PDT)
Message-ID: <f11fc45d-314a-4e2d-bcd1-9d8b1a49c87a@arm.com>
Date: Tue, 10 Mar 2026 09:18:19 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 2/2] sched/idle: Make default_idle_call() NOHZ aware
To: Qais Yousef <qyousef@layalina.io>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
References: <20260301191959.406218221@kernel.org>
 <6250711.lOV4Wx5bFT@rafael.j.wysocki>
 <CAJZ5v0jb7wJFQEfP_-JRv4mwh3qveq+VPoy8k9dmtmigoSyKhg@mail.gmail.com>
 <2409653.ElGaqSPkdT@rafael.j.wysocki>
 <20260310035406.xnu3nlqp4ldshxww@airbuntu>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260310035406.xnu3nlqp4ldshxww@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/26 03:54, Qais Yousef wrote:
> On 03/07/26 17:25, Rafael J. Wysocki wrote:
> 
>> In the meantime I realized that if the .select() governor
>> callback is skipped, its .reflect() callback should be skipped
>> either, so I've posted this:
>>
>> https://lkml.org/lkml/2026/3/7/569
>>
>> and here's a fixed version of the last patch on top of the above (for
>> completeness):
>>
>> ---
>>  kernel/sched/idle.c |   25 ++++++++++++++++---------
>>  1 file changed, 16 insertions(+), 9 deletions(-)
>>
>> --- a/kernel/sched/idle.c
>> +++ b/kernel/sched/idle.c
>> @@ -161,6 +161,14 @@ static int call_cpuidle(struct cpuidle_d
>>  	return cpuidle_enter(drv, dev, next_state);
>>  }
>>  
>> +static void idle_call_stop_or_retain_tick(bool stop_tick)
>> +{
>> +	if (stop_tick || tick_nohz_tick_stopped())
>> +		tick_nohz_idle_stop_tick();
>> +	else
>> +		tick_nohz_idle_retain_tick();
>> +}
>> +
>>  /**
>>   * cpuidle_idle_call - the main idle function
>>   *
>> @@ -170,7 +178,7 @@ static int call_cpuidle(struct cpuidle_d
>>   * set, and it returns with polling set.  If it ever stops polling, it
>>   * must clear the polling bit.
>>   */
>> -static void cpuidle_idle_call(void)
>> +static void cpuidle_idle_call(bool stop_tick)
>>  {
>>  	struct cpuidle_device *dev = cpuidle_get_device();
>>  	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
>> @@ -186,7 +194,7 @@ static void cpuidle_idle_call(void)
>>  	}
>>  
>>  	if (cpuidle_not_available(drv, dev)) {
>> -		tick_nohz_idle_stop_tick();
>> +		idle_call_stop_or_retain_tick(stop_tick);
>>  
>>  		default_idle_call();
>>  		goto exit_idle;
>> @@ -222,17 +230,14 @@ static void cpuidle_idle_call(void)
>>  		next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
>>  		call_cpuidle(drv, dev, next_state);
>>  	} else if (drv->state_count > 1) {
>> -		bool stop_tick = true;
>> +		stop_tick = true;
> 
> Silly question, but wouldn't this benefit the normal path too to delay for one
> tick? This will only matter for the cases where the governor doesn't explicitly
> set stop_tick to either true or false - which I am not sure what they are :)
> 
Right now the governors will always set stop_tick explicitly (and overriding
that might confuse the governor-internal state).
