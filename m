Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6CB1991D4;
	Fri, 22 May 2026 07:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779436162; cv=none; b=XlCip+cdrRVWEi2zctmxlutI7GQyw/X1WT0f1Lns7fYKjSsgsnjCv5SqebE1NWjJlW7LTJ/jg/7bbCLLAC78VkWdD6HEWUGGjcQaD7XrrJN/5mctkT/C28IqgVRKf2WGKTRDOo/I4THeE/DYqcZE0MZMR67nSIuDus/2T3OMCM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779436162; c=relaxed/simple;
	bh=YrY7ixiPcCfLBxWM6J+jznQYF4i8oxMkGDgKtM/OfL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFnipFfYxnpoCx4GMqe4BTgQCCV7vjnZZyyydXhzpcZq0fR7db020Bs0FVaKyaTnUi5DtHCO/CtsUg5nYlxWIA9x4W65xJjKHYTmx8CIfBf5oh4zowcYZwQg+jwkk20NZJ21Q7SE6xMIrjm2bFRESPRCE7+b/PbFgxlWO3C1wiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=l96C3OFN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="l96C3OFN"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 938154A92;
	Fri, 22 May 2026 00:49:14 -0700 (PDT)
Received: from [192.168.113.113] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6AB53F7B4;
	Fri, 22 May 2026 00:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779436159; bh=YrY7ixiPcCfLBxWM6J+jznQYF4i8oxMkGDgKtM/OfL4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l96C3OFNdrCA8Z3XCywg7wpCeWPjETvO6fsKfcEkFu5v5DnZtJtOTCOLloN84jCNo
	 WCDa/PcXVtsKIT9Iz/x4G+xRwXdoj2suu0i0xVuFtDrZvtsg0ie2qm+feME17XGCOO
	 nowuHkCYKDbMrOlXeDQJ9rKI2ogYmdXNciq07Qc0=
Message-ID: <0f7dd656-5ee4-4c14-a27c-fa30c12a676a@arm.com>
Date: Fri, 22 May 2026 09:49:13 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Revert boost in cpu_util()
To: =?UTF-8?B?aG9uZ3lhbi54aWEo5aSP5byY5b2mKQ==?= <hongyan.xia@transsion.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: =?UTF-8?B?aHVwdSjog6Hnkp4p?= <hupu@transsion.com>,
 =?UTF-8?B?amlhemkubGko5p2O55Sy5a2QKQ==?= <jiazi.li@transsion.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260518024039.932-1-hongyan.xia@transsion.com>
Content-Language: en-GB
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20260518024039.932-1-hongyan.xia@transsion.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18.05.26 04:40, hongyan.xia(夏弘彦) wrote:
> From: Hongyan Xia <hongyan.xia@transsion.com>

I'm on vacation this week so will have a closer look beginning of next week.

> We have seen a massive power consumption regression (20% SoC power
> increase in many apps) after updating our kernel. After bisection we

What is the kernel version you updated to? Which one you have been using
so far?

Are you using Android on your devices? I remember there was some
functionality added to avoid janks in display pipeline.

> pinpointed the regression to the cpu_util(boost) feature. After
> reverting the boost feature the massive energy regression is gone.
> Detailed trace analysis down below. The regression is found across quite
> many apps but Youtube is one of the worst offenders, shown in the
> 1080p60fps video benchmark:
> 
>  Setup      FPS   SoC Power (mW)  diff
> w/  boost  59.94      913.6
> w/o boost  59.93      720.4     -21.15%
> 
> Signed-off-by: Hongyan Xia <hongyan.xia@transsion.com>
> 
> ---
> Analysis:

[...]

> 2. Using the absolute value of runnable_avg to drive frequency is
>    too high to be reasonable:
> 
> We use runnable in a _relative_ way to util to know whether there is

Is this part of the value adds you put on top of mainline kernel? Are
you able to share this here?

> contention in several places. However, the _absolute_ value should not
> be used like util. Runnable_avg tends to be significantly higher,
> making it much easier to saturate frequency.
> 
> For example, if three tasks each with a util of 100 contend on the same
> rq, the rq util is 300 but runnable_avg shoots up to 900. 900 drives the
> CPU at the max frequency, and it's highly questionable whether this
> boost is the right decision.

Shouldn't this be max 600, in case the task's runtime overlap perfectly?
In case they don't overlap at all runnable_avg should be util_avg. Is
this a theoretical example or taken from your traces?

> 3. Runnable_avg may not even reflect true contention:
> 
> When tasks are dependent, the bottleneck is often the data flow between
> tasks, not the contention seen by runnable_avg. Boosting frequency with
> runnable in such scenarios wastes power without performance benefits.

That's probably true. But here any global feature (which doesn't need
per-task setup) won't be able to give perfect results, only per-task
setup can fix this.

