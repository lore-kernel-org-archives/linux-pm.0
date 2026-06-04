Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ED615A864;
	Thu,  4 Jun 2026 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579324; cv=none; b=Hnr6XAzabF0DAZlXbRZ01ozpybqCbyMKbgEVxiABtWjnC5wQ5jeW1y9z+BTaXTL3V3p+OQ9UkIkvrJuEjBr7gnqyCNqwZTPkBL3eYKUwN3pxDDo3DPap2U0j8wKHapRxNxU25XJH5R2R5N73wZZyFZtkDMaoxrfTihFiW0poUPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579324; c=relaxed/simple;
	bh=HNwh1E/cfx8uzGjIRwUKJ4fakEUoQ43l44GYxynLN6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fp7bwuAkDckMLcBPnsAs1zs7+sXyVKaMJ56FE3dEXw0kDiMEO2E4TIy20fRhzHMAX6sH6YaMPAkjpNRGgAVfo0NERdJ133Ds5ll70hNnMnBWK0uhRLNWA4/3Vf5WuqsPkyf7q+1LaZmNGcrqLRdjwno5OkzlZ2ZV+qhLqdMe/Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=By0HBxfA; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="By0HBxfA"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69CBD3161;
	Thu,  4 Jun 2026 06:21:57 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC2453F86F;
	Thu,  4 Jun 2026 06:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780579322; bh=HNwh1E/cfx8uzGjIRwUKJ4fakEUoQ43l44GYxynLN6s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=By0HBxfAVO9hFZY32lk7JKYklpldZnowTlBMz1/RbD/UBemzIzKUMgoifv0+I0ljD
	 UWPA15znFl8TMmlgwvtQ3Trlv9LLJkMtW88lfkbSr42oFs3Qgd9WVSk6K2sr5IIGuW
	 jGGsN1RUxx0d59+zV+dePPvlPbEIwBWHOhP0ppMw=
Message-ID: <8f5f944e-b150-47a3-b1e4-bcaac6151b7b@arm.com>
Date: Thu, 4 Jun 2026 15:21:57 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/fair: Revert boost in cpu_util()
To: Hongyan Xia <hongyan.xia@transsion.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Pu Hu <hupu@transsion.com>,
 Jiazi Li <jiazi.li@transsion.com>,
 "christian.loehle@arm.com" <christian.loehle@arm.com>,
 "qyousef@layalina.io" <qyousef@layalina.io>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260528023611.2433-1-hongyan.xia@transsion.com>
 <CAKfTPtCnXrwBBvj6vGJfmLgESf4_3zwA4-m-N1ceMJ3ghOvFKQ@mail.gmail.com>
 <d665e99b-31f6-46e1-9cb4-6931642388ce@transsion.com>
 <CAKfTPtBJOtgMJLm1PhiLPFup9OWYLPCChumy5EKuLuEEbu2gYg@mail.gmail.com>
 <2886fddf-8f58-491c-ac27-e4d9b34b66ad@transsion.com>
Content-Language: en-GB
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <2886fddf-8f58-491c-ac27-e4d9b34b66ad@transsion.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04.06.26 11:21, Hongyan Xia wrote:
> On 6/4/2026 4:48 PM, Vincent Guittot wrote:
>> On Thu, 4 Jun 2026 at 10:21, Hongyan Xia <hongyan.xia@transsion.com> wrote:
>>>
>>> On 6/4/2026 3:42 PM, Vincent Guittot wrote:
>>>> On Thu, 28 May 2026 at 04:36, Hongyan Xia <hongyan.xia@transsion.com> wrote:
>>>>>
>>>>> From: Hongyan Xia <hongyan.xia@transsion.com>

[...]

>>>>> Analysis:
>>>>>
>>>>> We found several problems that result in the power spike:
>>>>>
>>>>> 1. Arithmetic should not happen between util_avg and runnable_avg:
>>>>>
>>>>> After util = max(util, runnable) which potentially picks runnable value
>>>>> in cpu_util(), we then add or subtract task util values from it. This
>>>>> produces a value that is half-runnable-half-util which is ill-defined.
>>>>> This alone should be a warning sign. This breaks EAS calculations in
>>>>> many cases, leading to sub-optimal task placements.
>>>>
>>>> This can be easily fixed
>>>
>>> I thought about adding or subtracting runnable_avg instead, but that is
>>> still wrong. Given three tasks each with 100 util, if they wake up at
>>> the same time and running on the same rq, their util is 100, 100, 100,
>>> rq total util is 300. Their runnable_avg is 100, 200, 300, rq total
>>> runnable_avg is 600. If the 1st task leaves the rq, the remaining two
>>> task runnable_avg will then become 100, 200, giving a total rq
>>> runnable_avg of 300. However, subtracting the runnable_avg of the 1st
>>> task gives 600 - 100 = 500, which is very wrong.
>>
>> Substracting/adding se.avg.runnable_avg is still the right solution
>> because this is what will happen if the task migrate
> 
> One difference is that before runnable boost, runnable_avg really 
> doesn't affect EAS and CPUFreq much. Runnable boost is the first 
> instance where we directly use raw runnable_avg values in EAS and 
> frequency selection, and this value is often too high to be reasonable. 
> I'm mostly arguing that we should use it in proper places (like the one 
> in util_est_update()) and not here.
> 
> Actually this is the very first fix we tried internally. There is minor 
> improvement in EAS spreading out tasks, but energy regression is pretty 
> much the same, and Youtube is still at 20% regression.

I thought the issue was that, in your low-power test cases, most of the
tasks involved in these contention scenarios are raising CPU frequency,
but they are not directly contributing to the workload (including
Android Graphics Pipeline (AGP) progress). If that's the case, the
additional power consumption is essentially wasted.

Could you collect some information about these contention events and
identify the tasks involved?

By the way, I still assume that all per-task ADPF boosting (including
AGP boosting) is disabled on your system. I also assume that the number
of janky frames is negligible, since you're only showing FPS data.

[...]
