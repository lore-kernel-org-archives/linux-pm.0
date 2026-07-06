Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E5439B4B9;
	Mon,  6 Jul 2026 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348199; cv=none; b=nAK58Spmp/ZZV2qEIcYQcGHnz7b+4K3+OiJ04EY5ilsVqXM7lMM8eFSs5leIcfw3VwFevpwvkoNK3naoKlKQXri0EXZTmKW+aLr+Tx1uofxWi2kkL/0QPiuwynJ6ADILe9DhnovgUH48/rBU4g0WgQ1BT4F7v5+rKO9fWcMrOEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348199; c=relaxed/simple;
	bh=EHTVXpLQN4gAdnhonC+dqDnLj3DCyY4jhjDQXN2MSiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UpM9JBP7Pr2LuTuWE2IE9L5xOEtd/LowRQBJiXbZpZIlUSt3szXs8qmknIP4tRiQhm/1AL3w7BcRKrHtatw9NzGGtmBgw1XRACZbVSivGO13iFGf2R08431RtpJxjFgB6M83Vcg9rk5uVz3DtgaDDA6HlcUmKA5L8Ag7KaOq/QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HslELLYI; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HslELLYI"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DF3A2BCB;
	Mon,  6 Jul 2026 07:29:53 -0700 (PDT)
Received: from [10.1.27.96] (e127648.arm.com [10.1.27.96])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9165B3F905;
	Mon,  6 Jul 2026 07:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783348197; bh=EHTVXpLQN4gAdnhonC+dqDnLj3DCyY4jhjDQXN2MSiI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HslELLYIvlxSEpjExw8Mql4VMl+Zixo9nWuUac3ORv0qmLQ1UuA1F7Dif+aNSG085
	 yS4/8GRFt2LNuvxll2feRGFKpgYr5u+rsBU5tgcW7l2X4tAH1OhT9lQ9kvk0sB/Xek
	 2F6OojsHheuTP5kHx9p3dqqDpKjca0vOa/Q6a9G0=
Message-ID: <5f5cb821-92ae-4539-ae81-a43e33a7ded5@arm.com>
Date: Mon, 6 Jul 2026 15:29:53 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] sched/idle: Sysbench threads regression after
 f4c31b07b136
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
 Joseph Salisbury <joseph.salisbury@oracle.com>
Cc: rafael.j.wysocki@intel.com, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, frederic@kernel.org,
 linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 regressions@lists.linux.dev
References: <096b42fa-107f-450d-b3b1-03bcad3f1e04@oracle.com>
 <CAJZ5v0g+SkTxuP5fqUMisQAh19v-JzpmRZHiKtYzJH1sVt656g@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0g+SkTxuP5fqUMisQAh19v-JzpmRZHiKtYzJH1sVt656g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/2/26 19:47, Rafael J. Wysocki (Intel) wrote:
> Hi,
> 
> On Thu, Jul 2, 2026 at 6:30 PM Joseph Salisbury
> <joseph.salisbury@oracle.com> wrote:
>>
>> Hi Rafael,
>>
>> We are seeing a reproducible MySQL Sysbench threads regression.  A
>> bisect indicated the following commit as the first bad commit:
>> f4c31b07b136 ("sched: idle: Consolidate the handling of two special cases")
>>
>> The regression was found in Oracle kernel performance testing on OCI VM
>> shapes:
>>
>> VM Details:
>> * VM.Standard2.1:
>>        x86 OCI VM shape, 1 OCPU / 2 hardware threads, about 14.5 GB RAM
>>
>>   * VM.Standard.A1.Flex.2:
>>        Arm/Ampere A1 flexible VM shape, 2 vCPU threads, about 10.9 GB RAM
>>
>>
>> The ResultsDB runs show the regression in the Sysbench threads metric:
>>
>>    - VM.Standard2.1:       333 -> 236  (-29.1%)
>>    - VM.Standard.A1.Flex.2: 1286 -> 1152 (-10.4%)
>>
>> A test kernel was built with f4c31b07b136 reverted and the performance
>> regression was recovered.
>>
>>  From the code, it is possible the regression is due to the new
>> previous-wakeup heuristic in the special idle cases.  Before the commit:
>>
>>    - no cpuidle driver:
>>        tick_nohz_idle_stop_tick()
>>        default_idle_call()
>>
>>    - one idle state:
>>        tick_nohz_idle_retain_tick()
>>        cpuidle state 0
> 
> I think that this is your case and the tick stops for you sometimes
> now while it had never stopped before.
> 
> Can you confirm?
> 
> Overall, it would be good to know the idle state lists for both the VM
> and the host.
> 
+1, but also which HZ are you using?
Both systems reported have 2 logical CPUs then? Were higher core counts also
tested and how does it affect them?
