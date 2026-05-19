Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236B840963D
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779197438; cv=none; b=ntrcrfxXVB1F3eZiyv2MDY9zxGC19xp5V/AZN4KOgSISOfO19zN3FcqYGLMeAdcRgLPoxjQThulqU4BOhgU2U2vdvp10UUMn4XYJFbY+JG3JN4DFWiKvmp+P0uJHR/AwoRQqE8GEIxtIdTypxMHz5U3Adm08PrUA90KnlUl6NEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779197438; c=relaxed/simple;
	bh=fHKtTJlXZyd1iIil3k8QJyiFsNUnUny4TPVKDEUS55c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQcoK3t90FIhlEZhFUcDCdkVuRQFpRE81NfS0LUpIKa1fqI/VTJz0kpHjOKQSoy1hAik6Z0mFfhr81NyC0ZhKXGMY6cbFKhaHnhAMb23VGUmmpnDQtj3IA7bcpCkCaA/eM9Wx7ZBh/4paa0rvOu/Ns7hDzKfHo5C6yeaSr1iBpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=jZGQLK53; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="jZGQLK53"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67b6da5a618so6210273a12.2
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 06:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1779197434; x=1779802234; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lP4wXes171t7PBs4WgrDgozOyy9aPVLkAZtL7GraNsQ=;
        b=jZGQLK53n1c4xqCOj3Pw6RQEsD9yrBwKKFDIP/JaAB5s6b84pcbRTikXxZPE4fo9he
         MKbMyIcfoVKVMF4nKltyaQzk7V4ElrxS9z1I2PnOPDMo1xQTjDMy2qyhfW7iNLCq59HP
         b+BnJUGhhUeqO9IG+KoMNHH7hv/Y80jXsyY/PdmTQ/nz8rfB2/i5iHbv23OOEPRwBCsn
         v8AtmySaW0i7iKyK1Kw1Kyn8mSqDYJsfYLSaQeyikKK3P9Wo9BmZau2zIKgOz/DjKF56
         umMO2f77UyBp1XnPEPZm12uZKijLxH1pyrBFJYGk12h+byQmjI+BAeU0iUmR54KcXnsZ
         6rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779197434; x=1779802234;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lP4wXes171t7PBs4WgrDgozOyy9aPVLkAZtL7GraNsQ=;
        b=f1yE95Raoa2jEzskVbuBh8l9X+wp2AatPcy9KlyLD+Q1lcZycIKYmoLt4y7WGN/9z0
         QE/Em5BEbMbNNZ8T0yoLMf+1xwuWU/4cIcypnadYhBfVeua7xDQ9xMRw3/H8b3OkTPv6
         dQM0HqU5byopPoaYaLFxv9nN/IHAIINV2sRPNlwnyKpCKg3wCGvtsP6KGB14TnGFGNxz
         UgN7Cm1wze4opnJJJDDZ9HLHCZcyd7ZEBM18qxPBZR+Ly+Zlbt/RlEXroTkKE+nmQEoI
         CDxo2c9b1+NekcN8O6jnjYmbUgtw5Au+e/aWPDNQD1klmJnVXgtzB0f0ZYXuYMTkDg7d
         UJ+Q==
X-Forwarded-Encrypted: i=1; AFNElJ/PjxyqZkiOvqwNKn0dgQeYGS1LN+EKcZsk3HjHewX/Lzg28gXwvNkBoxiEPQKePV7UtRMJdNL7ZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzCuPD8e3TuKYQk4C8eHS/CKcwLeyWGfqbJnp6vPEZGuKOPzBy
	Yf4BXxrpo0IHyzshL/jKRv9DbRSt6ey2XKAFQI9J6u9LWSxhK1RbIMgq1b4tMhqPDyk=
X-Gm-Gg: Acq92OEaIY0lA/dJpN9uN4bgnYluE4D9AD4tDXfKdoDR9BQQp/aQA99EBe6sbPaH1SP
	Jkekfb7ohmbwSaWW80O9X7e5x1s9BjRKH4ATmC0ENIxrGyLpHZn6wDuYbUnZHZemueRTum1b0ef
	UycMKDE0D16Ygf7U7lvbIbXAdFuN9boqu7ce3nCtQevEkHQZ0kitvPWhQsjh1p45dD6nCCWKrDZ
	aI3rEhKpOSGQH1XrF76uU6rbdHJUX3LsaFpi6+OYMgY7h/t0JlwkJgLRMtVeaeUv7n/QzbPoStl
	LhFJc6L62y6Zjj/Ton4nLvVftQv/i0Ls3zAdXFWitri4IUPk4paG9jsLMup2YdUnvLt7luh8bBr
	3il8426CK9xBF3sZVj60IXRiADcsPsjaHyQK2Dw54+bfbcgbOpHpe5o+h/iemE27KuFxcKbK+4J
	FecxQHz8cvA2yvspE=
X-Received: by 2002:a17:907:d411:b0:bcb:9366:4cfb with SMTP id a640c23a62f3a-bd5177f443bmr1205299466b.15.1779197434168;
        Tue, 19 May 2026 06:30:34 -0700 (PDT)
Received: from airbuntu ([149.40.48.74])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4ded6dfsm725813766b.39.2026.05.19.06.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:30:33 -0700 (PDT)
Date: Tue, 19 May 2026 14:30:31 +0100
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
Message-ID: <20260519133031.bqyezffxn44ud4lm@airbuntu>
References: <20260518024039.932-1-hongyan.xia@transsion.com>
 <97ac52d6-98b4-4b15-b50b-f606b53a2288@arm.com>
 <b136fd7e-e062-48ce-a039-803cad969322@transsion.com>
 <20260519011707.bh6fol5xollfgyhn@airbuntu>
 <c1affa89-08b1-4d9e-9573-86e4cb592a55@transsion.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1affa89-08b1-4d9e-9573-86e4cb592a55@transsion.com>

On 05/19/26 02:41, hongyan.xia(夏弘彦) wrote:
> On 5/19/2026 9:17 AM, Qais Yousef wrote:
> > On 05/18/26 11:37, hongyan.xia(夏弘彦) wrote:
> >> On 5/18/2026 6:04 PM, Christian Loehle wrote:
> >>> [Some people who received this message don't often get email from christian.loehle@arm.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >>>
> >>> On 5/18/26 03:40, hongyan.xia(夏弘彦) wrote:
> >>>> From: Hongyan Xia <hongyan.xia@transsion.com>
> >>>>
> >>>> We have seen a massive power consumption regression (20% SoC power
> >>>> increase in many apps) after updating our kernel. After bisection we
> >>>> pinpointed the regression to the cpu_util(boost) feature. After
> >>>> reverting the boost feature the massive energy regression is gone.
> >>>> Detailed trace analysis down below. The regression is found across quite
> >>>> many apps but Youtube is one of the worst offenders, shown in the
> >>>> 1080p60fps video benchmark:
> >>>>
> >>>>    Setup      FPS   SoC Power (mW)  diff
> >>>> w/  boost  59.94      913.6
> >>>> w/o boost  59.93      720.4     -21.15%
> >>>>
> >>>> Signed-off-by: Hongyan Xia <hongyan.xia@transsion.com>
> >>>>
> >>>> ---
> >>>> Analysis:
> >>>>
> >>>> We found several problems that result in the power spike:
> >>>>
> >>>> 1. Arithmetic should not happen between util_avg and runnable_avg:
> >>>>
> >>>> After util = max(util, runnable) which potentially picks runnable value
> >>>> in cpu_util(), we then add or subtract task util values from it. This
> >>>> produces a value that is half-runnable-half-util which is ill-defined.
> >>>> This alone should be a warning sign. This breaks EAS calculations in
> >>>> many cases, leading to sub-optimal task placements.
> >
> > I don't think it does. The util signal itself has issues too :)
> 
> One issue I found is that it sometimes piles up tasks on the same CPU,
> because rq.runnable_avg - task.util_avg is still very high and not much
> lower than rq.runnable_avg, making EAS think there is no benefit in
> spreading out tasks when other CPUs are empty.
> 
> But this problem is usually temporary and doesn't last long in reality.

I see. I think the major problem with this logic is that runnable is useful
only during this transient time. But it will take a long time to decay which
I think (guess really) what causes these problems you're observing. The
contention has gone, but the signal can take 50-100ms to resolve to previous
behavior - I think.

> 
> >>>>
> >>>> 2. Using the absolute value of runnable_avg to drive frequency is
> >>>>      too high to be reasonable:
> >>>>
> >>>> We use runnable in a _relative_ way to util to know whether there is
> >>>> contention in several places. However, the _absolute_ value should not
> >>>> be used like util. Runnable_avg tends to be significantly higher,
> >>>> making it much easier to saturate frequency.
> >>>>
> >>>> For example, if three tasks each with a util of 100 contend on the same
> >>>> rq, the rq util is 300 but runnable_avg shoots up to 900. 900 drives the
> >>>> CPU at the max frequency, and it's highly questionable whether this
> >>>> boost is the right decision.
> >
> > I think this is the idea. These tasks are waiting behind other tasks.
> >
> >>>>
> >>>> 3. Runnable_avg may not even reflect true contention:
> >>>>
> >>>> When tasks are dependent, the bottleneck is often the data flow between
> >>>> tasks, not the contention seen by runnable_avg. Boosting frequency with
> >>>> runnable in such scenarios wastes power without performance benefits.
> >
> > I believe contention is used to describe several tasks fighting for CPU time
> > but only a single task can run and the other will be waiting. But I think
> > I know what you mean, I think this is the same I was highlighting in [1].
> > We don't care if some tasks end up waiting for more.
> >
> >>>>
> >>>> We found 1 has minor power regression but 2 and 3 regresses power
> >>>> significantly. We have seen multiple applications with the
> >>>> producer-consumer model with many worker threads suffer. When there is
> >>>> IPC between producer and consumer, boosting frequency blindly does not
> >>>> help performance at all if consumer is limited by how much data is flown
> >>>> through. Youtube suffer from 1, 2 and 3 at the same time, leading to a
> >>>> total SoC power regression of 20% shown in the results above.
> >>>
> >>> We did discuss removing runnable boost internally as well, but I’d love to see
> >>> more data too.
> >>> The original issue it was trying to solve was avoiding jank frames during load
> >>> spikes, which YouTube does not really exercise. Some gaming workload data would
> >>> therefore be a useful addition here.
> >>
> >> Although I would be glad to provide more data (after more benchmarks and
> >> pending our internal approval), I wonder, what level of performance gain
> >> do we expect from this feature to justify the big energy regression?
> >>
> >>> Runnable boost was considered as an alternative to approaches like reducing the
> >>> PELT half-life and similar changes. Qais’ current ideas also try to tackle this
> >>> problem, of course, so +CC.
> >
> > A lot of the current behavior is actually good for power by accident. And this
> > runnable approach helps performance as a workaround to these issues. We need to
> > defer some decisions to userspace and just give them a better way to decide
> > their trade-offs. One person's regression is another person's gain..
> 
> To be honest, yes, we live in a world where many things work by accident
> and there are definitely a lot of 'accidents' in schedutil. Our
> motivation for this patch is mostly our real world test scenarios that
> mimic customer day of use patterns, and it looks like the perf gain is
> small compared with the energy regression across common apps.
> 
> >>>
> >>> If you have run many workloads, do you also have data on where this feature actually
> >>> helped, especially in reducing jank frames?
> >>
> >> We ran our Day of Use (DoU, including Facebook, Youtube and other
> >> popular apps) test model and we did see a 6.6% increase in jank frames
> >> after the revert. Dropped frames went up from 106 to 113 in a total of
> >> 70210 frames. However, in our test model there is no way an increase of
> >> 7 frames within 70210 justifies the energy regression between 10% and
> >> 20% in a lot of apps, hence for us the trade-off decision is very clear
> >> here.
> >>
> >> Another question from me is, if this feature has potentially buggy
> >> corners or mathematical unsoundness (mostly the half-util-half-runnable
> >> value inside cpu_util()), should we rely on its performance gain?
> >>
> >>>
> >>> Some discussion from back then:
> >>> https://lore.kernel.org/lkml/20230406155030.1989554-1-dietmar.eggemann@arm.com/
> >>> https://lore.kernel.org/lkml/20220829055450.1703092-1-dietmar.eggemann@arm.com/
> >
> > Generally I remember I had concerns on this approach then [1]. I kept quite
> > after it got merged and won't complain if it is removed now.
> >
> > [1] https://lore.kernel.org/lkml/20230504152328.twh3rqgq2o2gvd4u@airbuntu/
> 
> I must say I'm now almost completely echoing what you were saying. Sad
> that I didn't see this thread back then. Our test results confirmed the
> concerns in that thread, namely:
> 
> 1. Whether it's a global win: The performance gain seems limited, like
> the jank results (not with Jankbench, but actual animations animated by
> common apps) I just shared with Christian.
> 2. Hurts power: Yes, we saw a dramatic 20% SoC power increase in certain
> apps like Youtube playback.
> 3. Being selective: This is also our concern. In our analysis, looks
> like it boosts frequency often in cases where it doesn't help perf.
> 
> Sad that these questions are answered 3 years later, but better late
> than never :)

:)
