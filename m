Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B4861FCE
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 01:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779153435; cv=none; b=p6m2g0Ew9nNeURt57sxqwYXgUxRc43iQuMYmAVpR4Sr82pakmgLhm/fCY2SLSOK55+ogehcm2dlmhsiFtkMHWAO/OhpODA1m7gr6xYpjkCm7dMs5B/oZ+KkJs/oOhdwjjjJZhj66mPXJArJ8XiyheLHpEZHHCCInFc3b5LwUPHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779153435; c=relaxed/simple;
	bh=PZQH1SVvps3Xv5ABULoGaf5/1IMXiBPizTUIwPNWguc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwSJ6o2L67wZNnhhKUGRyGMmbep1L8CXgObfDQlkyi4J4PAoaPXMYI9XI50Vp8Ua8DWCOYwKvZiC2iyM6Ceo03XHbp3HdcD720DYlvB6+TvA2PYc4zQ5R+xqDtRFnkeuhuC4kUI+zyHvom5xNILKCYbmRwyd5JSOP9afpvJcbG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=vDjcsODj; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="vDjcsODj"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-449d6c68ed8so326023f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 18:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1779153432; x=1779758232; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=42otkp+7fOjXvrD+kgNzYOh5RJclAl+mxKy4Q3cnT8g=;
        b=vDjcsODjnIR2LkCHwZg0wrZCxsHO3IATtpwpTJf6YagkZWNT+O63Is8dKAH4pmrf9B
         4JypWtalbwCq2NZLpFInQPfppwR+nfyrH6T6ya/r0NUxoXMCV/j52BZn+BZ0CWluhyfN
         slRQki7u8A5yZb66jwSunHpv/Np2nwIxk8LQlgJvtcMqT6vmt2tUB1rvY6ZMNboDS+TM
         ZrZybDsKoGPYZF7P0lmg37Rfeq+yOlpDeCgERGpmEuQBHAtKAqBkwfIGKktaj2jD5ce2
         ViuMcxGOYCN2r9f0mAOyjqZ7Wo5B7btySsIwafC4t9GDOSIVPnKP7Km4IanK6lsNi2LM
         yygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779153432; x=1779758232;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=42otkp+7fOjXvrD+kgNzYOh5RJclAl+mxKy4Q3cnT8g=;
        b=dgNly3ONr80/36WgF3uT9ULhn65x4mfNhdZKA9h2EpDhbOCJXEQ4vjdEeyWiRePpYh
         MbjwE/e9Tc4Zt6iXWdgI/eEyWeF4IE+q69y6I8FK7AhoGOawq1w69pc1WPO97vwYKjK6
         JdZgaz29nwmDeO/J2BMEaXMW57RcVXAbcPkc04+DENy7pMrclP49jiFdNe3L5HnXGL0V
         p8U7fk3qi1t4wvTb+CrZIgiGFopJgdWv75I+H5r7G8u0TsFclJryK5WxHTxVQcwfbvYo
         sdDM8aTzYdtEitT22acuToDgp7hyq7w94ul0/Mi37QZ9KyNRnd25HuHUsolyBlOQ+ySL
         T39Q==
X-Forwarded-Encrypted: i=1; AFNElJ87SzUn+1uQvKvX+Z2M3WM8Jb7VrEgio2WlnebOrSCNGRlmDco0ZE/wAM1Ev348SJz719844ldwHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhEHsHWL9GHw5SzhFaKXOsJEcML+x7cbyO8nCLJ23YdRVYU6JC
	v2gzFYROOzBZK0zZM9HndxQ5nBvHyHvMxmXT/NwGnaS/DB+9k0cEQT9tj9J4MArhP2c=
X-Gm-Gg: Acq92OG0altC2QKo0COUo5MITH236x4xDV+2Z6pGWAW7DzYsKRxDJVLR+3BcbE4A2qS
	7eyN8lcH00Uuv9HV4TWIVM0Nmg4a+6Zt6vqCM2TsIaDYsRhe8Bwa7zveIEcv7Vjy8L8wtymfEPb
	QZ6ieHbtJaAuw7G8mccoVx6mqw0lr8sjc00pGRPcvC+yUqYob6vyAF9pbjOXKQOG4UsrAl8z5La
	xE4ihBIPQTItBnmZeB751t7GLHRq3gyMTPjUsW3RAoLaopxHc6URHfwn4va+UmTXuyFIzHmjHp6
	QfmmrZsWYja+f/HqqnV/Y0/cPgbRn20hV4V/UkQNnyMklPVdfbZFzw5XlvQD8wF0Vg4Fhg3sVD/
	ilrrgcfaLiTMP/cnpafPpUbLq+ClaXis+wns1q9au8q5P1jGmp85f9oraiolE5mUaUy/NxwdKKn
	EWhLt6+JwpMKKh5vE=
X-Received: by 2002:a5d:5d0e:0:b0:449:fb9e:4b4e with SMTP id ffacd0b85a97d-45e5c36755dmr24968403f8f.15.1779153431696;
        Mon, 18 May 2026 18:17:11 -0700 (PDT)
Received: from airbuntu ([149.40.48.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a19a0csm39442282f8f.20.2026.05.18.18.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 18:17:11 -0700 (PDT)
Date: Tue, 19 May 2026 02:17:07 +0100
From: Qais Yousef <qyousef@layalina.io>
To: =?utf-8?B?aG9uZ3lhbi54aWEo5aSP5byY5b2mKQ==?= <hongyan.xia@transsion.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	=?utf-8?B?aHVwdSjog6Hnkp4p?= <hupu@transsion.com>,
	=?utf-8?B?amlhemkubGko5p2O55Sy5a2QKQ==?= <jiazi.li@transsion.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/fair: Revert boost in cpu_util()
Message-ID: <20260519011707.bh6fol5xollfgyhn@airbuntu>
References: <20260518024039.932-1-hongyan.xia@transsion.com>
 <97ac52d6-98b4-4b15-b50b-f606b53a2288@arm.com>
 <b136fd7e-e062-48ce-a039-803cad969322@transsion.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b136fd7e-e062-48ce-a039-803cad969322@transsion.com>

On 05/18/26 11:37, hongyan.xia(夏弘彦) wrote:
> On 5/18/2026 6:04 PM, Christian Loehle wrote:
> > [Some people who received this message don't often get email from christian.loehle@arm.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > On 5/18/26 03:40, hongyan.xia(夏弘彦) wrote:
> >> From: Hongyan Xia <hongyan.xia@transsion.com>
> >>
> >> We have seen a massive power consumption regression (20% SoC power
> >> increase in many apps) after updating our kernel. After bisection we
> >> pinpointed the regression to the cpu_util(boost) feature. After
> >> reverting the boost feature the massive energy regression is gone.
> >> Detailed trace analysis down below. The regression is found across quite
> >> many apps but Youtube is one of the worst offenders, shown in the
> >> 1080p60fps video benchmark:
> >>
> >>   Setup      FPS   SoC Power (mW)  diff
> >> w/  boost  59.94      913.6
> >> w/o boost  59.93      720.4     -21.15%
> >>
> >> Signed-off-by: Hongyan Xia <hongyan.xia@transsion.com>
> >>
> >> ---
> >> Analysis:
> >>
> >> We found several problems that result in the power spike:
> >>
> >> 1. Arithmetic should not happen between util_avg and runnable_avg:
> >>
> >> After util = max(util, runnable) which potentially picks runnable value
> >> in cpu_util(), we then add or subtract task util values from it. This
> >> produces a value that is half-runnable-half-util which is ill-defined.
> >> This alone should be a warning sign. This breaks EAS calculations in
> >> many cases, leading to sub-optimal task placements.

I don't think it does. The util signal itself has issues too :)

> >>
> >> 2. Using the absolute value of runnable_avg to drive frequency is
> >>     too high to be reasonable:
> >>
> >> We use runnable in a _relative_ way to util to know whether there is
> >> contention in several places. However, the _absolute_ value should not
> >> be used like util. Runnable_avg tends to be significantly higher,
> >> making it much easier to saturate frequency.
> >>
> >> For example, if three tasks each with a util of 100 contend on the same
> >> rq, the rq util is 300 but runnable_avg shoots up to 900. 900 drives the
> >> CPU at the max frequency, and it's highly questionable whether this
> >> boost is the right decision.

I think this is the idea. These tasks are waiting behind other tasks.

> >>
> >> 3. Runnable_avg may not even reflect true contention:
> >>
> >> When tasks are dependent, the bottleneck is often the data flow between
> >> tasks, not the contention seen by runnable_avg. Boosting frequency with
> >> runnable in such scenarios wastes power without performance benefits.

I believe contention is used to describe several tasks fighting for CPU time
but only a single task can run and the other will be waiting. But I think
I know what you mean, I think this is the same I was highlighting in [1].
We don't care if some tasks end up waiting for more.

> >>
> >> We found 1 has minor power regression but 2 and 3 regresses power
> >> significantly. We have seen multiple applications with the
> >> producer-consumer model with many worker threads suffer. When there is
> >> IPC between producer and consumer, boosting frequency blindly does not
> >> help performance at all if consumer is limited by how much data is flown
> >> through. Youtube suffer from 1, 2 and 3 at the same time, leading to a
> >> total SoC power regression of 20% shown in the results above.
> >
> > We did discuss removing runnable boost internally as well, but I’d love to see
> > more data too.
> > The original issue it was trying to solve was avoiding jank frames during load
> > spikes, which YouTube does not really exercise. Some gaming workload data would
> > therefore be a useful addition here.
> 
> Although I would be glad to provide more data (after more benchmarks and
> pending our internal approval), I wonder, what level of performance gain
> do we expect from this feature to justify the big energy regression?
> 
> > Runnable boost was considered as an alternative to approaches like reducing the
> > PELT half-life and similar changes. Qais’ current ideas also try to tackle this
> > problem, of course, so +CC.

A lot of the current behavior is actually good for power by accident. And this
runnable approach helps performance as a workaround to these issues. We need to
defer some decisions to userspace and just give them a better way to decide
their trade-offs. One person's regression is another person's gain..

> >
> > If you have run many workloads, do you also have data on where this feature actually
> > helped, especially in reducing jank frames?
> 
> We ran our Day of Use (DoU, including Facebook, Youtube and other
> popular apps) test model and we did see a 6.6% increase in jank frames
> after the revert. Dropped frames went up from 106 to 113 in a total of
> 70210 frames. However, in our test model there is no way an increase of
> 7 frames within 70210 justifies the energy regression between 10% and
> 20% in a lot of apps, hence for us the trade-off decision is very clear
> here.
> 
> Another question from me is, if this feature has potentially buggy
> corners or mathematical unsoundness (mostly the half-util-half-runnable
> value inside cpu_util()), should we rely on its performance gain?
> 
> >
> > Some discussion from back then:
> > https://lore.kernel.org/lkml/20230406155030.1989554-1-dietmar.eggemann@arm.com/
> > https://lore.kernel.org/lkml/20220829055450.1703092-1-dietmar.eggemann@arm.com/

Generally I remember I had concerns on this approach then [1]. I kept quite
after it got merged and won't complain if it is removed now.

[1] https://lore.kernel.org/lkml/20230504152328.twh3rqgq2o2gvd4u@airbuntu/
