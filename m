Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312E34BCAD5;
	Fri,  5 Jun 2026 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650181; cv=none; b=UIfdIiP6APS3/BH3Q+peGcrm3CATifqd5w92EJr19G2YIQg9tHhrVLQ19yruEydffaglhOesAzjCTYaTf+HW11S5RLE+dZcEYc7kFllAMea3utZuQ5vxXrXVRDKv4kOZddc55k4SUNaS/qFRaXMrUlLHWEUnH42HdVjtNjvFphA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650181; c=relaxed/simple;
	bh=F5//uWxhtQzYIqPSIQYuyTpPtv3sIpS58/YekVvQmEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qKXrevDchaF2eVoJRZW5m4EWlpx08MfYwEC9URPrG30Kt2+lHulYjAxfhWUprKBnz2IAnBGrlMdjNmwdoVnLFxgtxrGq53eYwNDfuTwZFf6MsYeeBP35AAK2kdoNTsXcBiJuB4Ggg4GUCWjGOc2i5ARFbp64HG65Iqga5DFXLzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=k/sZ7EUY; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="k/sZ7EUY"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE9381516;
	Fri,  5 Jun 2026 02:02:47 -0700 (PDT)
Received: from [10.1.38.38] (unknown [10.1.38.38])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB98E3F632;
	Fri,  5 Jun 2026 02:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780650172; bh=F5//uWxhtQzYIqPSIQYuyTpPtv3sIpS58/YekVvQmEU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k/sZ7EUYJYHC031Vq4NqQATW22n+70Xt2JBXmWAV1Net/uSTNg+cQdDytr/lYa0qB
	 BFb1DPTO8Ni0Q4F9vsl8/r7cwDKC9RXcADPTxVKjtoKfZqvVpoTbSYK7sKmEPET764
	 G50w+pVQQCNTIci30KYcBIxeNnW34UCeCH/cgfrw=
Message-ID: <a92159ac-2fca-48bc-8efc-442b5924b3c4@arm.com>
Date: Fri, 5 Jun 2026 10:02:45 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/fair: Revert boost in cpu_util()
To: Hongyan Xia <hongyan.xia@transsion.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Pu Hu <hupu@transsion.com>,
 Jiazi Li <jiazi.li@transsion.com>, "qyousef@layalina.io"
 <qyousef@layalina.io>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260528023611.2433-1-hongyan.xia@transsion.com>
 <CAKfTPtCnXrwBBvj6vGJfmLgESf4_3zwA4-m-N1ceMJ3ghOvFKQ@mail.gmail.com>
 <d665e99b-31f6-46e1-9cb4-6931642388ce@transsion.com>
 <CAKfTPtBJOtgMJLm1PhiLPFup9OWYLPCChumy5EKuLuEEbu2gYg@mail.gmail.com>
 <2886fddf-8f58-491c-ac27-e4d9b34b66ad@transsion.com>
 <8f5f944e-b150-47a3-b1e4-bcaac6151b7b@arm.com>
 <4adbab4d-f9e4-4354-aa1e-48f11b1fd208@transsion.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <4adbab4d-f9e4-4354-aa1e-48f11b1fd208@transsion.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/5/26 03:48, Hongyan Xia wrote:
> [snip]
> 
> Hi Dietmar,
> 
> On 6/4/2026 9:21 PM, Dietmar Eggemann wrote:
>> On 04.06.26 11:21, Hongyan Xia wrote:
>>> On 6/4/2026 4:48 PM, Vincent Guittot wrote:
>>>> On Thu, 4 Jun 2026 at 10:21, Hongyan Xia <hongyan.xia@transsion.com> wrote:
>>>>>
>>>>> On 6/4/2026 3:42 PM, Vincent Guittot wrote:
>>>>>> On Thu, 28 May 2026 at 04:36, Hongyan Xia <hongyan.xia@transsion.com> wrote:
>>>>>>>
>>>>>>> From: Hongyan Xia <hongyan.xia@transsion.com>
>>
>> [...]
>>
>>>>>>> Analysis:
>>>>>>>
>>>>>>> We found several problems that result in the power spike:
>>>>>>>
>>>>>>> 1. Arithmetic should not happen between util_avg and runnable_avg:
>>>>>>>
>>>>>>> After util = max(util, runnable) which potentially picks runnable value
>>>>>>> in cpu_util(), we then add or subtract task util values from it. This
>>>>>>> produces a value that is half-runnable-half-util which is ill-defined.
>>>>>>> This alone should be a warning sign. This breaks EAS calculations in
>>>>>>> many cases, leading to sub-optimal task placements.
>>>>>>
>>>>>> This can be easily fixed
>>>>>
>>>>> I thought about adding or subtracting runnable_avg instead, but that is
>>>>> still wrong. Given three tasks each with 100 util, if they wake up at
>>>>> the same time and running on the same rq, their util is 100, 100, 100,
>>>>> rq total util is 300. Their runnable_avg is 100, 200, 300, rq total
>>>>> runnable_avg is 600. If the 1st task leaves the rq, the remaining two
>>>>> task runnable_avg will then become 100, 200, giving a total rq
>>>>> runnable_avg of 300. However, subtracting the runnable_avg of the 1st
>>>>> task gives 600 - 100 = 500, which is very wrong.
>>>>
>>>> Substracting/adding se.avg.runnable_avg is still the right solution
>>>> because this is what will happen if the task migrate
>>>
>>> One difference is that before runnable boost, runnable_avg really
>>> doesn't affect EAS and CPUFreq much. Runnable boost is the first
>>> instance where we directly use raw runnable_avg values in EAS and
>>> frequency selection, and this value is often too high to be reasonable.
>>> I'm mostly arguing that we should use it in proper places (like the one
>>> in util_est_update()) and not here.
>>>
>>> Actually this is the very first fix we tried internally. There is minor
>>> improvement in EAS spreading out tasks, but energy regression is pretty
>>> much the same, and Youtube is still at 20% regression.
>>
>> I thought the issue was that, in your low-power test cases, most of the
>> tasks involved in these contention scenarios are raising CPU frequency,
>> but they are not directly contributing to the workload (including
>> Android Graphics Pipeline (AGP) progress). If that's the case, the
>> additional power consumption is essentially wasted.
>>
>> Could you collect some information about these contention events and
>> identify the tasks involved?
> 
> Our profiling shows that there is a very typical scenario in these 
> energy regressions, which is IPC.
> 
> Quite a lot of apps have per-CPU worker threads taking data from 
> producers. When a producer sends the first piece of data (mostly using 
> wake_up_sync()), a worker thread on the same CPU gets woken up, but that 
> worker is not immediately switched to, which is right because you want 
> the producer to finish producing data. But, because that worker thread 
> is already runnable, it starts to shoot up its runnable_avg and the rq 
> runnable_avg. When the producer is done and we finally context switch to 
> the worker, the frequency is already super high and it takes time for 
> the frequency to decay.
> 
> Two problems with this:
> 
> 1. In this common scenario, the producer and per-CPU consumer threads 
> are not really 'contending'. They are accomplishing the same job but 
> just split into multiple stages. The 'contention' here should be much 
> smaller than two independent threads doing two separate jobs.

I would have expected this to be relatively rare, since feec() should
normally place the consumer on another CPU in the same cluster according
to max-spare-capacity. The producer should already have consumed some spare
capacity on its current CPU, so another CPU should look preferable.

Why does this not happen in practice? Is the consumer wakeup not going
through that path for some other reason, or is the spare-capacity delta
too small?

On your 4+3+1 SoC, does this “dominated by runnable_avg” scenario happen
mostly on a specific cluster, or is it fairly evenly distributed?

> [snip]
