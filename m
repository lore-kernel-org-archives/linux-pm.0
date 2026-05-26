Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900093A7F4D;
	Tue, 26 May 2026 17:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815811; cv=none; b=LgIVKimLWOxifycez+nBA8WpOkG29bqaPF12sfj+PxM/oogGn9DV5H35phZZNnN94pa2UkIsuVggrBpUKzOVMsuRs2rtMei8eD6fajP3EdLO3912fuAMJSBA6+PBTAwXDxaO06FGIFEN+ncvi9MO2uHo4RZFoxNMxppO8THjgcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815811; c=relaxed/simple;
	bh=9mbtf3bz236rtl+P0fxNr5UW+nDUrG5KTgwMb2aUp7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KMr+4Feb+LjoE3IXOBS5ZazEeWUGQOiXcqrYeeB3LI/b02e9Ae6OzJNOqKr5ewRQK3OSk222JcqFNzVFdkTSnS1IX16FIvwtI2/3rw2F4DX8vqBFCei2MsNxg+5E3VbjZShdEO+A4zD10tMVhAwEqyNEHr+fT9lHiHi4ra4Lhq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=U9TyEYQT; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="U9TyEYQT"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8DA32880;
	Tue, 26 May 2026 10:16:44 -0700 (PDT)
Received: from [10.57.68.144] (unknown [10.57.68.144])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C8873F7D8;
	Tue, 26 May 2026 10:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779815810; bh=9mbtf3bz236rtl+P0fxNr5UW+nDUrG5KTgwMb2aUp7Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U9TyEYQTA0dv30LyeUbI4yWh8grLnPULwnkAFuedf03uJRxt63oAkMZ5GEDg/HfvP
	 GTrPSwFWOHtai+z4yjztfTNVxdh81BJzAvDt7uY5KiN0kicWGG5RuAKBolfht1MdRN
	 bTrmF2lm/gqVEDzX1QwPR/8P8LvuvGoMPp9F0W0o=
Message-ID: <d6b41012-923b-4d0e-bc31-42dd74033d3e@arm.com>
Date: Tue, 26 May 2026 19:16:45 +0200
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
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-GB
In-Reply-To: <20260518024039.932-1-hongyan.xia@transsion.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18.05.26 04:40, hongyan.xia(夏弘彦) wrote:
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

Looks like I missed running one of the low-power test cases back then.

That said, boosting tasks under contention does not seem like a
particularly good idea.

Jankbench, being primarily a UI rendering benchmark, was probably
overemphasizing stress on the Android Graphics Pipeline (AGP), where the
runnable_avg boosting happened to help. Support for Jankbench also
appears to have stopped with Android 12 — I am not sure why.

At the same time, low-power benchmarks, and even games, do not seem to
have equally strict requirements for consistently meeting UI rendering
deadlines.

It is also possible that the AGP itself has evolved since then. I
vaguely remember a Google Bootcamp presentation discussing the injection
of performance hints at the beginning of a frame-rendering cycle to
mitigate early jank, but I can no longer find it. I also do not know how
that approach relates to the removal of all vendor hooks.

Given all of this, I would also lean toward removing the runnable_avg
boosting functionality entirely, rather than keeping it behind a sched
feature flag that defaults to false.

> @@ -8229,16 +8222,10 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>   * Return: (Boosted) (estimated) utilization for the specified CPU.

s/(Boosted) (e/(E/

>   */
>  static unsigned long
> -cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
> +cpu_util(int cpu, struct task_struct *p, int dst_cpu)
>  {
>  	struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
>  	unsigned long util = READ_ONCE(cfs_rq->avg.util_avg);
> -	unsigned long runnable;
> -
> -	if (boost) {
> -		runnable = READ_ONCE(cfs_rq->avg.runnable_avg);
> -		util = max(util, runnable);
> -	}
>  
>  	/*
>  	 * If @dst_cpu is -1 or @p migrates from @cpu to @dst_cpu remove its
