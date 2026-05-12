Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FF330DEB8;
	Tue, 12 May 2026 08:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778575063; cv=none; b=WAozmkdW/ZB4fCJlHOjdlugDsnI/ob1mu2rdgaHpNJS896/Oj8OI41PMTO4ygz+Q4sQ+1fAOkNNLd2MCjJu89GW70H0lXvFRHUUiSY+kEewe/sXZ12pts/2t6roExAtvgGsFOrpiKPmh+U0UArvddq+zNXJDc8r/zTDILzqvwXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778575063; c=relaxed/simple;
	bh=l5xq3vh/HJzjjyxvQH7htzddiAPqIIthJrzYqzSn+rY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BtVMeeQS36OCgzQOhWenhKMLWs7pjIdVTqKKUGYUfhCRGF4zpAVpsEFl6KjoIVu5yaBwAPGeW3iUwQeYcuU9szoHD/qxN0hJA/btgoGztkSIjREIkeSZlGsyo6G6Iq+i3SR3w4IL9LhjP3QsdlI/kaOApjpG2JKPi3r/FnuoGJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZUUdFPOA; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZUUdFPOA"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 511521691;
	Tue, 12 May 2026 01:37:35 -0700 (PDT)
Received: from [10.57.32.148] (unknown [10.57.32.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBF313F7B4;
	Tue, 12 May 2026 01:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778575060; bh=l5xq3vh/HJzjjyxvQH7htzddiAPqIIthJrzYqzSn+rY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZUUdFPOA4xI9EbuUaSFPWgiP1+aO6bV91sQMmO0HARFXFZUKLTbNDxgOcnBBvaIMN
	 Qp7f+NST29CzFyl2pkKec/b4CoX4sxnvADoHYOajSrIRsDe3eozQAjVgTc13lVvTzf
	 m+fAe1CQS4N4HN+3C9mweFbiVhd0h05Np1b72e4s=
Message-ID: <1745c99b-4e31-4d7e-8221-c775ed30436f@arm.com>
Date: Tue, 12 May 2026 09:37:32 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/13] sched/qos: Add rampup multiplier QoS
To: Qais Yousef <qyousef@layalina.io>, Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, John Stultz <jstultz@google.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Tim Chen <tim.c.chen@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>,
 Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20260504020003.71306-1-qyousef@layalina.io>
 <20260504020003.71306-10-qyousef@layalina.io>
 <20260511110328.GS3126523@noisy.programming.kicks-ass.net>
 <20260512075953.uoicyuwwvqcejxpn@airbuntu>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260512075953.uoicyuwwvqcejxpn@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/26 08:59, Qais Yousef wrote:
> On 05/11/26 13:03, Peter Zijlstra wrote:
>> On Mon, May 04, 2026 at 02:59:59AM +0100, Qais Yousef wrote:
>>
>>> diff --git a/Documentation/scheduler/sched-qos.rst b/Documentation/scheduler/sched-qos.rst
>>> index 0911261cb124..f68856f23b6b 100644
>>> --- a/Documentation/scheduler/sched-qos.rst
>>> +++ b/Documentation/scheduler/sched-qos.rst
>>> @@ -42,3 +42,25 @@ need for extension will arise; and when this happen the task should be
>>>  simpler to add the kernel extension and allow userspace to use readily by
>>>  setting the newly added flag without having to update the whole of
>>>  sched_attr.
>>> +
>>> +2. QoS Tags
>>> +===========
>>> +
>>> +SCHED_QOS_RAMPUP_MULTIPLIER
>>> +---------------------------
>>> +
>>> +Controls how fast util signal rises. Affects frequency selection when schedutil
>>> +is in use. And affects how fast tasks migrate between clusters on HMP systems.
>>> +
>>> +It affects bursty tasks only. Perfectly periodic tasks are well described by
>>> +util_avg and the rampup multiplier will have no effect on them.
>>> +
>>> +When set to 0, util_est will be disabled to help further with power saving.
>>> +This behavior can be controlled via UTIL_EST_RAMPUP_ZERO sched_feature.
>>> +
>>> +Value is not capped to retain flexibility, but it tapers off very quickly to
>>> +notice a difference above 16. Roughly it takes ~200ms to reach a util_avg of
>>> +1000 starting from 0. With 16 it should take ~12.5ms. A range of 0-8 is
>>> +advised for general use.
>>> +
>>> +Cookie must always be set to 0.
>>
>> So this is a very specific feature. This is made possible by basically
>> having a huge type space, allowing for throw-away hints (as per the
>> previous email).
> 
> Hmm. It is specific and generic. It is specific in a sense it is about the rise
> time through performance level and scheduler integration with schedutil. It is
> generic also because it is about the time it takes scheduler/kernel to move
> through performance levels. I could change the description to focus on these
> generic elements of DVFS response time and migration time for HMP systems.
> 
> I think if we move away from PELT etc, the concept will still be valid but
> implemented differently unless the new implementation can't use the concept of
> a multiplier for some reason to speed up the rise time.
> 
>>
>> I suppose having these specific hints is easy, but as per always there
>> is the discussion about describing task behaviour vs implementation
>> details. With the argument being that task behaviour might be a more
>> lasting / stable hint, while implementation details are far easier to
>> actually do.
>>
>> I'm missing this discussion.
> 
> The intention is to describe task behavior. But being practical as well and
> allow solve real world problems with ease - so if implementation detail
> description will help us fix problems simply and easily, then I am for it.
> 
> The question is how to protect ourselves? :-)
> 
> This is where the two levels of QoS can help.
> 
> One level is for app developers, which is high level abstraction that is
> detached from OS internals and details. This is done in schedqos I announced
> recently. The goal is for users to use the QoS exposed by this service and not
> to interact directly with scheduler/kernel.
> 
> The other level is this one proposed here; which is to enable this smart
> service to provide a meaningful abstraction for end users, but not directly
> being used by them - and we can define it whatever we like.
> 
> And this brings us to a contentious point, how to protect and enforce this
> behavior?
> 
> I think we need to enforce that these hints are used by some all knowing entity
> and for sched_attr to be locked down by everyone except it. Vincent was
> suggesting to use SELinux to lockdown sched_attrs, but given recent issues with
> tcmalloc I think we must eneforce something at kernel level. CAP_NICE is spread
> around and we don't want to mix and match how sched_attr and these new QoS are
> used.
> 
> To address this I think we need to introduce a new CAP_PERF_MANAGER (or pick
> your favourite name here) that can only be set for specific binaries and only
> one binary is allowed to exec with this capability. If two binaries with this
> capability try to run, then the second one will fail unless the first one has
> exited first. And when it is running, we lock down sched_setattr() except for
> this CAP_PERF_MANAGER.> 
> I am not sure if this is enough, but I think we must enforce the usage pattern
> else we can end up with a mess. I think we all agree it is hard for
> applications to use sched_attr in general directly, given the benefit of
> a hindsight. I commonly see the simple nice value misused in practice for
> example.
> 
> Ideally I'd love to enforce a single trusted binary if that can be done :p
> 


Just to follow along, does that mean if an application runs with CAP_PERF_MANAGER
any other that doesn't have CAP_PERF_MANAGER and calls any of
sched_setattr()
sched_setscheduler()
sched_setparam()
nice()
setpriority()

would get EPERM? Or silently be dropped?
Either seems error-prone and potentially no longer work as a "Zero API adoption mechanism".
Chromium and Unity seem to handle sched_setattr() failing, but unsure what the
situation looks like generally.

