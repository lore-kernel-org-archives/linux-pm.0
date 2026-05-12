Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD9E47DFB1
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 07:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778572697; cv=none; b=iHnT8jOLMwnq+W7J58u/uexzR/FPCxiJJMce2v+1ybjClRb31uAoIFAeAiciyr3tKe+L8uuBtefjaNxn1lT6u3ll+R+0cziMnN8Wj0ojqxyEOob8WSiZXSgG9qLQRHE9aE1ReXKVtT4LhQV8hrvB9SFYb98TB+I7/5Iue+Ul47g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778572697; c=relaxed/simple;
	bh=feZ4t7mjU5HJzVshOlawmsgY0rhG8A1KJ6RpsJn8U3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYDhF9QmqlTbtAg6xurkLd9j+QOGIUbBnBaGAUdcdP4y9mXamDSyfQcSe/OwGI0LIzgeQtMwr2ppQiYOTOBjvl6M/VqOLUN3wqFF3KfLAodMkHC/3EA6whLxnWBSD3EC/CruFTqdE3EPkrsEmniGRTdzcLfPw9h1NPMnKNzDHFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=rHpZhh52; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="rHpZhh52"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48d102471a4so51246515e9.2
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 00:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1778572694; x=1779177494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MS76DH9RvjejEuMgGenFz7C353YqWDrjQY+mrbwYibs=;
        b=rHpZhh52Xh/Dpjy6baFAw3QkauEMn+PpsJne103ydwmB1Nf7lyAKY64NKiZdbBWzVh
         ZADIdnu5sauVL8j5MfYtXkx+OyhdWhwGgaMoucAB7ncUi0LbEjFKsvXb6y13+udDkhdh
         fDXhuMXG6kyZvWH24YrC9m/eXBhzcESo+XoSOByPk7N9bkamhoCMFu8PJpG8nqqYEtcO
         hP+kktEYZ7Cf+6Amc+j1evqMdY/gDor1dYFgHkq7mumbRjwWFZkixR81i03LOcdf7tuW
         lxk6u5iuJSpM/Pb/zhq7acbUxs4LPfmUTb7w5oShLG3I/dyS9PvelEfw0kB52hy2N557
         7exw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778572694; x=1779177494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MS76DH9RvjejEuMgGenFz7C353YqWDrjQY+mrbwYibs=;
        b=nX3DtShcZELd+HuyincoSBiWnKsxuellp1/wsIPOdb8n1k+F3AUsS9iSJx0kiuj7sb
         2BLgJRukYuVByCd9APLlSYto1DLnsSLnX/HE3FHaTf9pw+cBCDjSkPOfdVlniBIlf6jL
         W7j3jFe8QBX04jg4zIGfzUod4m62or9xcZFhJCRO8GzRBgVShe5uQp+3VJBXgxzjG5XD
         HERAFNY3DTQpyeqyjpLKF797PytT3u+0zDz6FWuIbautOuQwv5vCD5sGdovC0LTxDLBU
         75Ry6FmFVtNYmCffSpH3eTJDzYWav2qS8d3WKhoyV7Imkibw5nfLarQ7Cd/HAUSVMAGq
         +mLw==
X-Forwarded-Encrypted: i=1; AFNElJ81DUPOR5k6GHl0fnaGM+66IhOUutVNtxI7B1HmJarQ95eDmivTabsqEcZW+W8+T/L5Gafd/bozcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTj0rDu8DhUaOghF37WxAVCals+yXOXiiOTZ9RLHShB2dyjqi/
	km/UpbRV6MRrudnhD5VLtlGnR6H2ZRklvZ0Uc7ALW+c7KSGB2I131d65zvktlvCP7vk=
X-Gm-Gg: Acq92OHiIak+hnDmzUz/yttprY52cdWJnCi73n+Q4BHcE6l5XOJRXJrS7SOv1dGNmeR
	bLC8CW+kV7/Gcr0DyWD5Uan+RQxAteBxmnZs/A2n6yIKUrFb0Wc7jRs/xoRmBj9ChzuQz0YkAdB
	nmKMNhcMZw6zA1SX0kgGRZqUzrvJmCrCCZiKL1c29VNPVOZpNnuGI4GC1WKS924yzsAJu89KafY
	gxx9c2SePwk1GnSrYx/h6iQUfWHmA06oKaYe8VWRJaylw1ukakFc1vqW8WRWnC8mGuNnBBsEfTx
	gUYRU0dL14+mIcSmxf0EhVevQA83qzRYzHgBS+hOTnUqEqYpmEfS1lhZJb1gRTRuBC1DUEB8lX8
	kUHUz8RC9Xr8nsJ+tUZU+OiE5Ot/DBYPiX2249I1cmFzYhjMqK3eYCskzMDmHwQK7l42HwXBXi/
	2R9aoevAKwbJMzKKO8
X-Received: by 2002:a05:600c:8b62:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-48e6748afe8mr257970535e9.5.1778572693865;
        Tue, 12 May 2026 00:58:13 -0700 (PDT)
Received: from airbuntu ([185.253.98.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f410558sm20864685e9.5.2026.05.12.00.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 00:58:13 -0700 (PDT)
Date: Tue, 12 May 2026 08:58:09 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Stultz <jstultz@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	"Chen, Yu C" <yu.c.chen@intel.com>,
	Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 RFC 08/13] sched/qos: Add a new sched-qos interface
Message-ID: <20260512075809.5on43u3wrnelqe4i@airbuntu>
References: <20260504020003.71306-1-qyousef@layalina.io>
 <20260504020003.71306-9-qyousef@layalina.io>
 <20260511105704.GR3126523@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260511105704.GR3126523@noisy.programming.kicks-ass.net>

On 05/11/26 12:57, Peter Zijlstra wrote:
> On Mon, May 04, 2026 at 02:59:58AM +0100, Qais Yousef wrote:
> > Provide a generic and extensible interface to describe arbitrary QoS
> > tags to tell the kernel about specific behavior that is doesn't fall
> > into the existing sched_attr.
> > 
> > The interface is broken into three parts:
> > 
> > * Type
> > * Value
> > * Cookie
> > 
> > Type is an enum that should be give us enough space to extend (and
> > deprecate) comfortably.
> > 
> > Value is a signed 64bit number to allow for arbitrary high values.
> > 
> > Cookie is to help group tasks selectively so that some QoS might want to
> > operate on tasks per groups. A value of 0 indicates system wide.
> > 
> > There are two anticipated users being discussed on the list.
> > 
> > 1. Per task rampup multiplier to allow controlling how fast util rises,
> >    and by implication it can migrate between cores on HMP systems and
> >    cause freqs to rise with schedutil.
> > 
> > 2. Tag a group of task that are memory dependent for Cache Aware
> >    Scheduling.
> > 
> > The interface is anticipated to be provisioned to apps via utilities and
> > libraries. schedqos [1] is an example how such interface can be used to
> > provide higher level QoS abstraction to describe workloads without
> > baking it into the binaries, and by implication without worrying about
> > potential abuse. The interface requires privileged access since QoS is
> > considered scarce resource and requires admin control to ensure it is
> > set properly. Again that admin control is anticipated to be the schedqos
> > utility service.
> > 
> > QoS is treated as a scarce resource and the intention is for the
> > a syscall to be done for each individual QoS tag. QoS tags are not
> > inherited on fork by default too for the same reason.
> > 
> > A reasonable point of debate is whether to make the sched_qos an array
> > of 3 or 5 value to avoid potential bottleneck if this grows large and
> > users do end up hitting a bottleneck of having to issue too many
> > syscalls to set all QoS. Being limited as it is now helps enforce
> > intentionality and scarcity of tagging.
> 
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=============
> > +Scheduler QoS
> > +=============
> > +
> > +1. Introduction
> > +===============
> > +
> > +Different workloads have different scheduling requirements to operate
> > +optimally. The same applies to tasks within the same workload.
> > +
> > +To enable smarter usage of system resources and to cater for the conflicting
> > +demands of various tasks, Scheduler QoS provides a mechanism to provide more
> > +information about those demands so that scheduler can do best-effort to
> > +honour them.
> > +
> > +  @sched_qos_type	what QoS hint to apply
> > +  @sched_qos_value	value of the QoS hint
> > +  @sched_qos_cookie	magic cookie to tag a group of tasks for which the QoS
> > +			applies. If 0, the hint will apply globally system
> > +			wide. If not 0, the hint will be relative to tasks that
> > +			has the same cookie value only.
> > +
> > +QoS hints are set once and not inherited by children by design. The
> > +rationale is that each task has its individual characteristics and it is
> > +encouraged to describe each of these separately. Also since system resources
> > +are finite, there's a limit to what can be done to honour these requests
> > +before reaching a tipping point where there are too many requests for
> > +a particular QoS that is impossible to service for all of them at once and
> > +some will start to lose out. For example if 10 tasks require better wake
> > +up latencies on a 4 CPUs SMP system, then if they all wake up at once, only
> > +4 can perceive the hint honoured and the rest will have to wait. Inheritance
> > +can lead these 10 to become a 100 or a 1000 more easily, and then the QoS
> > +hint will lose its meaning and effectiveness rapidly. The chances of 10
> > +tasks waking up at the same time is lower than a 100 and lower than a 1000.
> > +
> > +To set multiple QoS hints, a syscall is required for each. This is a
> > +trade-off to reduce the churn on extending the interface as the hope for
> > +this to evolve as workloads and hardware get more sophisticated and the
> > +need for extension will arise; and when this happen the task should be
> > +simpler to add the kernel extension and allow userspace to use readily by
> > +setting the newly added flag without having to update the whole of
> > +sched_attr.
> 
> So 'type' is effectively meant to be an ephemeral space of hints. A
> kernel can, or can not, support this arbitrary set of hints.

Yes. A 'type' is not expected to be recycled if deprecated. It'll just return
an error if no longer supported.

> 
> If a particular type is supported across two kernels, it is assumed to
> be the same -- although its implementation might be different.

Yes. If implementation details were too different that a 'type' no longer
makes sense, it'd be just deprecated (return EOPNOTSUP) in favour of whatever
makes sense then, if still necessary.

Will document this more explicitly.

> 
> Your next patch implements type-0 to be this pelt multiplier thing.
> 
> I wonder about discoverability, suppose we create and discard a fair
> number of these types, just because. Then how is someone (this
> muddle-ware component for example) to discover which set of hints is
> supported by the kernel of the day?
> 
> I suppose it can go and scan the space, by trying to set hints on itself
> or something, but that seems sub-optimal.

Yes, I think that would be best starting point. If you saw schedqos code
I already have to parse procfs to discover all existing running processes/tasks
after connecting to netlink socket to listen to new forks/execs (and plug the
race). Inefficient, but done once at service start is simple enough and
unlikely to be a real bottleneck or pain point.

Current line of thought is to keep as much in userspace until we have enough
data on usage and bottlenecks to drive any kernel changes. userspace here means
schedqos service.

One thing to note also, with the schedqos integration when folks need to add
a new hint they can actually deploy at scale more easily. I am hoping the
development process would be:

* Add new hint to address particular problem
* Integrate with schedqos to auto tag applications that can benefit from this
  hint
* Deploy on production or production like system to prove the benefit,
  trade-offs
* Discuss inclusion with upstream

IOW, I am hoping we can get more real life data on benefit for real workloads
and systems outside of usual synthetic cases. I am expecting any (well, most at
least) kernel hint is connected somehow to higher level of abstraction in
schedqos service - expectation so far is that kernel level hint are hard for
apps to use directly. More on this in reply to your next email.
