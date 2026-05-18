Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF5431AA87;
	Mon, 18 May 2026 10:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779098697; cv=none; b=evlnaiyOi+bxDW4Ad1/NHE0ETaafcmu9aLH62lQOY7kZn6TFOh6Rk7OtazSOJuL8SZvH5p6ILMV3TvJLs4t0lDkBxwhdAtGBgMpBGQzTNzB+fdHJMoHqQUS+HwsUsaU1TEIkED0Ni1dHoC2RduziEcpKNoLD1hJyn3KWDGSLLX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779098697; c=relaxed/simple;
	bh=3SGirsIQ39+kMKyqY/YimrKHEAqax2zBIq2Eju3EyJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qilScxtpJ4arCo/c20GScRSOkSPfD0PJv3VSoiRVIhLlgLWZ/D+VjC+ilNw5uIl2+/Rjwq38ygMA7Z545lHv/4r0KJBxrNGGcHt3XuhXWr1EL0eTrmEArFZVSyAIhNpUDbdoSb7F2He7dClCgF3plP3ut/a3FPlUwAta11LUPf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=AZyI8ktY; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="AZyI8ktY"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48F844617;
	Mon, 18 May 2026 03:04:49 -0700 (PDT)
Received: from [10.1.36.66] (e127648.arm.com [10.1.36.66])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB9CB3F85F;
	Mon, 18 May 2026 03:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779098694; bh=3SGirsIQ39+kMKyqY/YimrKHEAqax2zBIq2Eju3EyJs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AZyI8ktYKPVnwUVNlvYnn4fyOfEHC9aKsQPLH25Bf1nBPGMi7U3JlRweInCLwORDn
	 hlqawdcL94sPHLIDyXc1xEGGaC+M1WKMCGdvLazXPaSMm/Kgs7u97RHbptTsxffxYe
	 UnJvcdneL2ur8a/ThJujjgXxUe+oHn0G2FAj/UXg=
Message-ID: <97ac52d6-98b4-4b15-b50b-f606b53a2288@arm.com>
Date: Mon, 18 May 2026 11:04:48 +0100
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
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: =?UTF-8?B?aHVwdSjog6Hnkp4p?= <hupu@transsion.com>,
 =?UTF-8?B?amlhemkubGko5p2O55Sy5a2QKQ==?= <jiazi.li@transsion.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Qais Yousef <qyousef@layalina.io>
References: <20260518024039.932-1-hongyan.xia@transsion.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260518024039.932-1-hongyan.xia@transsion.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/18/26 03:40, hongyan.xia(夏弘彦) wrote:
> From: Hongyan Xia <hongyan.xia@transsion.com>
> 
> We have seen a massive power consumption regression (20% SoC power
> increase in many apps) after updating our kernel. After bisection we
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
> 
> We found several problems that result in the power spike:
> 
> 1. Arithmetic should not happen between util_avg and runnable_avg:
> 
> After util = max(util, runnable) which potentially picks runnable value
> in cpu_util(), we then add or subtract task util values from it. This
> produces a value that is half-runnable-half-util which is ill-defined.
> This alone should be a warning sign. This breaks EAS calculations in
> many cases, leading to sub-optimal task placements.
> 
> 2. Using the absolute value of runnable_avg to drive frequency is
>    too high to be reasonable:
> 
> We use runnable in a _relative_ way to util to know whether there is
> contention in several places. However, the _absolute_ value should not
> be used like util. Runnable_avg tends to be significantly higher,
> making it much easier to saturate frequency.
> 
> For example, if three tasks each with a util of 100 contend on the same
> rq, the rq util is 300 but runnable_avg shoots up to 900. 900 drives the
> CPU at the max frequency, and it's highly questionable whether this
> boost is the right decision.
> 
> 3. Runnable_avg may not even reflect true contention:
> 
> When tasks are dependent, the bottleneck is often the data flow between
> tasks, not the contention seen by runnable_avg. Boosting frequency with
> runnable in such scenarios wastes power without performance benefits.
> 
> We found 1 has minor power regression but 2 and 3 regresses power
> significantly. We have seen multiple applications with the
> producer-consumer model with many worker threads suffer. When there is
> IPC between producer and consumer, boosting frequency blindly does not
> help performance at all if consumer is limited by how much data is flown
> through. Youtube suffer from 1, 2 and 3 at the same time, leading to a
> total SoC power regression of 20% shown in the results above.

We did discuss removing runnable boost internally as well, but I’d love to see
more data too.
The original issue it was trying to solve was avoiding jank frames during load
spikes, which YouTube does not really exercise. Some gaming workload data would
therefore be a useful addition here.

Runnable boost was considered as an alternative to approaches like reducing the
PELT half-life and similar changes. Qais’ current ideas also try to tackle this
problem, of course, so +CC.

If you have run many workloads, do you also have data on where this feature actually
helped, especially in reducing jank frames?

Some discussion from back then:
https://lore.kernel.org/lkml/20230406155030.1989554-1-dietmar.eggemann@arm.com/
https://lore.kernel.org/lkml/20220829055450.1703092-1-dietmar.eggemann@arm.com/

> [snip]
