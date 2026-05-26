Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C0B3FDBFC;
	Tue, 26 May 2026 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815797; cv=none; b=n9xaC79lQWde28LrmgCKfCzqDB230OWtPQNguGQegM3xsU1udPHqasv+oJmYvbDug5VEBDy0UOwX+Tn2XDVB7xoEALkAdmZBNxkllhqsJXLa2/zWjo/8lqEEhp4Bfb66JiFJtqZgDqf33CspkHvGS5+euvoMgkAFiTcU5Y3Vplo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815797; c=relaxed/simple;
	bh=WIXz7WNYMvm82e1/NC/YqiOWrGAn8LR6Ted2Q5Op/Rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sRaSnFr7V6qNKNDQBIyE9bPUDF8MT4tWo4M5XMfFbEeGxr9vOj5E0qhEuNYz9tICUCqD0oO8Em2Te9+R40+dlnyWZzlCYeWxGViLS8Fw85RfocvEFEChbO03t83A9vf7Z+djAFbeKS/yBGozGUv+z4y5oswiL9XPk7A0QfuBi/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NoDmx1EH; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NoDmx1EH"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 467172880;
	Tue, 26 May 2026 10:16:30 -0700 (PDT)
Received: from [10.57.68.144] (unknown [10.57.68.144])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BF0E3F7D8;
	Tue, 26 May 2026 10:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779815795; bh=WIXz7WNYMvm82e1/NC/YqiOWrGAn8LR6Ted2Q5Op/Rc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NoDmx1EH6MEkVLU4J208rYtHLWz6gon+oh65Q+F7PorzYCyQT6i0KEwdaMtKnmoEo
	 AviwPW5HVtPXzz8E6PBMj9V7nx6V1AOK5ztiUxIHq6y4xjrKQ1Lf4QSqfj3NCjY4Mc
	 Jd3WB8wLf6dgXAq5pHG868b4/cIQLX4KxA5SBkvU=
Message-ID: <cd93c5e6-b581-4a9c-b5f7-09443ab76672@arm.com>
Date: Tue, 26 May 2026 19:16:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Revert boost in cpu_util()
To: "hongyan.xia" <hongyan.xia@transsion.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: hupu <hupu@transsion.com>, "jiazi.li" <jiazi.li@transsion.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Qais Yousef <qyousef@layalina.io>,
 Christian Loehle <christian.loehle@arm.com>
References: <20260518024039.932-1-hongyan.xia@transsion.com>
 <0f7dd656-5ee4-4c14-a27c-fa30c12a676a@arm.com>
 <bc7720fa-012c-4f0e-add6-4db526fdaa2d@transsion.com>
Content-Language: en-GB
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <bc7720fa-012c-4f0e-add6-4db526fdaa2d@transsion.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22.05.26 11:36, hongyan.xia wrote:
> On 5/22/2026 3:49 PM, Dietmar Eggemann wrote:
>> On 18.05.26 04:40, hongyan.xia(夏弘彦) wrote:
>>> From: Hongyan Xia <hongyan.xia@transsion.com>

[...]

>> Are you using Android on your devices? I remember there was some
>> functionality added to avoid janks in display pipeline.
> 
> Yes, this is Android but with scheduler vendor hooks stripped, so kernel 
> 6.6 schedutil with some GKI patches on top. There is "something to avoid 
> janks", but to make sure the results can be shared upstream, such 
> Android things are disabled, leaving basically vanilla schedutil.

OK.

Would be interesting to know how this 'avoid janks' feature can be
disabled. So all ADPF ('Performance Hints' and/or 'Performance boost for
games') hints are off? And this can be achieved by simply stripping all
Vendor Hooks?
I haven't looked at this for quite some time so I don't know how this is
all wired up and how to disable this.

>>> pinpointed the regression to the cpu_util(boost) feature. After
>>> reverting the boost feature the massive energy regression is gone.
>>> Detailed trace analysis down below. The regression is found across quite
>>> many apps but Youtube is one of the worst offenders, shown in the
>>> 1080p60fps video benchmark:
>>>
>>>   Setup      FPS   SoC Power (mW)  diff
>>> w/  boost  59.94      913.6
>>> w/o boost  59.93      720.4     -21.15%
>>>
>>> Signed-off-by: Hongyan Xia <hongyan.xia@transsion.com>
>>>
>>> ---
>>> Analysis:
>>
>> [...]
>>
>>> 2. Using the absolute value of runnable_avg to drive frequency is
>>>     too high to be reasonable:
>>>
>>> We use runnable in a _relative_ way to util to know whether there is
>>
>> Is this part of the value adds you put on top of mainline kernel? Are
>> you able to share this here?
> 
> By 'we' I mean upstream schedutil, like the comparison in 
> util_est_update between util and runnable to know whether there is 
> contention. The results I shared in this thread were always run on a 
> setup that doesn't include our internal stuff.

Ah, OK. But this condition in util_est_update() does this on individual
task level:

  /*
   * To avoid underestimate of task utilization, skip updates of EWMA if
   * we cannot grant that thread got all CPU time it wanted.
   */
   if ((dequeued + UTIL_EST_MARGIN) < READ_ONCE(se->avg.runnable_avg))
                goto done;

>>> contention in several places. However, the _absolute_ value should not
>>> be used like util. Runnable_avg tends to be significantly higher,
>>> making it much easier to saturate frequency.

[...]

>>> 3. Runnable_avg may not even reflect true contention:
>>>
>>> When tasks are dependent, the bottleneck is often the data flow between
>>> tasks, not the contention seen by runnable_avg. Boosting frequency with
>>> runnable in such scenarios wastes power without performance benefits.
>>
>> That's probably true. But here any global feature (which doesn't need
>> per-task setup) won't be able to give perfect results, only per-task
>> setup can fix this.
> 
> Our observation seems that few tasks benefit and most of our workloads 
> suffer from a big energy regression, so putting this feature on the 
> generic path might not be the best thing.

OK.

