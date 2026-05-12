Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECED39A057
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 08:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778576041; cv=none; b=TSYHnezdZpUIMiHSiwx0uK9NvrKoicL+RlKX6ya3/vpd0+EtGyOYbceHyYCcxrAqzt0nVjTy7Usi2ID9QXOk0IAfursq8Tiv3JhGhSo+igzO7iJo6LqBCTVFzmjgMTNenZRqvnaWtLOl8C4cVxx7tY8czwPQR3OuN/WN4rL9Snk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778576041; c=relaxed/simple;
	bh=FQEISqTgdZiMh0KP4GjzTuSxHeaZkxfEzfOkwaZOH3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6amZqHby/ZxVR/Nj2MgfSxQlOrQQobqGEn6mBVQqXTyINFa9gCToABj4K/OaxU5pSNNXxBHRIC0l48qE+cVJindPRapGA0/pYnosXIH8lVPx/5YIu+X+H+D1Y0b/u2SfnqRTtmPSbvN825C9rBRJW6E+0NOFZco0SfASNuZCnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=SrpCOYiP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="SrpCOYiP"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so35203955e9.1
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 01:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1778576034; x=1779180834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mt9llTXbgdTzJLFg8fa9CAFyRn8LwzIvj0IHNSgxg+Y=;
        b=SrpCOYiPmr0k02Ky4DI/BLGSYoUkFPZyVOf6tkiFu6KBnJjB0UL6kWRdJL6ltFhmK+
         zSr+I9UJsyRbGEoXTfxlw4OXuNyMkjk3P5//pm9aLlVi6LyLpAWWpRxv4uvvFueXpwu5
         6U/0llr8aG7Tr8Ey5k7CvjU6woa1BaRvH+iEB74x+85ewvayawXDHqC81UV4I1eHVuQ8
         PqLjr5yb0azect+OBbz5S5g99kVKmxjV3rANrfJVOWyI2VgvTnktIG+79p+7vRRA2qdT
         m6eeNRfgCZOjPUjTPZro4+jkoeFc53UfvkJ1BfPY6h1Lne+4/epbHALLTF0H9dmapAgy
         YT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778576034; x=1779180834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mt9llTXbgdTzJLFg8fa9CAFyRn8LwzIvj0IHNSgxg+Y=;
        b=WSSNawh6xoFxzIq2Em9O3Bx1YhtAIyJ5Uk0gCFHKrnWH5FXLPCrfq9KfUMLVb+4Q+C
         3Jc3iMEHMfHXPU2dLjPTJ2E/vnhikzGB2Bbno+MUYf+5IYN2dH/afrIHAcGJxYX6bl2c
         Hj8yDxnP+wqWJMzXkjvjg/Wq1fxRgyM4onMSipvz5wKiy5AbULxP6AcB0tFuJrdgje6N
         s97Vvf4LJIOnXhkBBhUja+/A//H4p5lJpPvCotKj1321FC2OfMv7vrw7vYTQrgev/ndN
         a4fdwokMDwiDn27yv6Blz9dB2+3pZzRx7OATDcsysbczsjso7oS0uobg+82tEakqrqxA
         ATYw==
X-Forwarded-Encrypted: i=1; AFNElJ9SD6iqklaDzIvMfv4M7eNOW7g452yQ5pzMt1jx61StB6TOT1vyCLJAV29dFMr+jXYQulppgsdkYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YydlEC1oNOQVkvT4TDKd1ZNhlXhe9vDsJnMS18LLK3lkjWxOMpO
	CcXHO2XSqCEfbar5Ixqmw6W27kOORWT4wdmm8a99eQ8NA43u3jRhMYCML7hUnOdFuNE=
X-Gm-Gg: Acq92OFrrWewwLhm2SkloHwZnMa6pHSinUxCDukgLjWcA4V6uL8omq1BAbKstBESyqy
	FhxKHBoOBE9mpp2NQEConpVOxrk6d8qj051bDGMR7usceCbqx8nBcJsLGuOnMaUktMWmE6ItozF
	a11ol0SeznUVgYlpbJvshRAK5v8KC6IjIOIto6OCOMc4pibM4KfaCJUhpQHn/uhbxHyDQz5W7a0
	m1iZNnfN7hZNv2v89SkkHZnqojnGCOQwS3426wnaiZh/5K0xyImigluZr83gVTLqunHGTGEkUSm
	g7yrl2Bua89gZpQ2UwohTJ04ubNOcJIYV3Kp4EXqeN7TnmdirkIEQ9qvcSo2tKSu3T/0arDrRr3
	17AOHfm5sAh4X107d7OvMDtdyDXFubfPmAwvT52yHBHuDVaCJoQpd84K3k6PW+yGqxkNLkV7lsZ
	eUk9E1dj3Ba1zRqtM1
X-Received: by 2002:a05:600c:c167:b0:48a:761:5816 with SMTP id 5b1f17b1804b1-48e8e207f2bmr45010705e9.8.1778576034084;
        Tue, 12 May 2026 01:53:54 -0700 (PDT)
Received: from airbuntu ([146.70.179.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e908cb403sm29824365e9.9.2026.05.12.01.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:53:53 -0700 (PDT)
Date: Tue, 12 May 2026 09:53:51 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
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
Subject: Re: [PATCH v2 09/13] sched/qos: Add rampup multiplier QoS
Message-ID: <20260512085351.2gq3jr4xskxwbygw@airbuntu>
References: <20260504020003.71306-1-qyousef@layalina.io>
 <20260504020003.71306-10-qyousef@layalina.io>
 <20260511110328.GS3126523@noisy.programming.kicks-ass.net>
 <20260512075953.uoicyuwwvqcejxpn@airbuntu>
 <1745c99b-4e31-4d7e-8221-c775ed30436f@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1745c99b-4e31-4d7e-8221-c775ed30436f@arm.com>

On 05/12/26 09:37, Christian Loehle wrote:
> On 5/12/26 08:59, Qais Yousef wrote:
> > On 05/11/26 13:03, Peter Zijlstra wrote:
> >> On Mon, May 04, 2026 at 02:59:59AM +0100, Qais Yousef wrote:
> >>
> >>> diff --git a/Documentation/scheduler/sched-qos.rst b/Documentation/scheduler/sched-qos.rst
> >>> index 0911261cb124..f68856f23b6b 100644
> >>> --- a/Documentation/scheduler/sched-qos.rst
> >>> +++ b/Documentation/scheduler/sched-qos.rst
> >>> @@ -42,3 +42,25 @@ need for extension will arise; and when this happen the task should be
> >>>  simpler to add the kernel extension and allow userspace to use readily by
> >>>  setting the newly added flag without having to update the whole of
> >>>  sched_attr.
> >>> +
> >>> +2. QoS Tags
> >>> +===========
> >>> +
> >>> +SCHED_QOS_RAMPUP_MULTIPLIER
> >>> +---------------------------
> >>> +
> >>> +Controls how fast util signal rises. Affects frequency selection when schedutil
> >>> +is in use. And affects how fast tasks migrate between clusters on HMP systems.
> >>> +
> >>> +It affects bursty tasks only. Perfectly periodic tasks are well described by
> >>> +util_avg and the rampup multiplier will have no effect on them.
> >>> +
> >>> +When set to 0, util_est will be disabled to help further with power saving.
> >>> +This behavior can be controlled via UTIL_EST_RAMPUP_ZERO sched_feature.
> >>> +
> >>> +Value is not capped to retain flexibility, but it tapers off very quickly to
> >>> +notice a difference above 16. Roughly it takes ~200ms to reach a util_avg of
> >>> +1000 starting from 0. With 16 it should take ~12.5ms. A range of 0-8 is
> >>> +advised for general use.
> >>> +
> >>> +Cookie must always be set to 0.
> >>
> >> So this is a very specific feature. This is made possible by basically
> >> having a huge type space, allowing for throw-away hints (as per the
> >> previous email).
> > 
> > Hmm. It is specific and generic. It is specific in a sense it is about the rise
> > time through performance level and scheduler integration with schedutil. It is
> > generic also because it is about the time it takes scheduler/kernel to move
> > through performance levels. I could change the description to focus on these
> > generic elements of DVFS response time and migration time for HMP systems.
> > 
> > I think if we move away from PELT etc, the concept will still be valid but
> > implemented differently unless the new implementation can't use the concept of
> > a multiplier for some reason to speed up the rise time.
> > 
> >>
> >> I suppose having these specific hints is easy, but as per always there
> >> is the discussion about describing task behaviour vs implementation
> >> details. With the argument being that task behaviour might be a more
> >> lasting / stable hint, while implementation details are far easier to
> >> actually do.
> >>
> >> I'm missing this discussion.
> > 
> > The intention is to describe task behavior. But being practical as well and
> > allow solve real world problems with ease - so if implementation detail
> > description will help us fix problems simply and easily, then I am for it.
> > 
> > The question is how to protect ourselves? :-)
> > 
> > This is where the two levels of QoS can help.
> > 
> > One level is for app developers, which is high level abstraction that is
> > detached from OS internals and details. This is done in schedqos I announced
> > recently. The goal is for users to use the QoS exposed by this service and not
> > to interact directly with scheduler/kernel.
> > 
> > The other level is this one proposed here; which is to enable this smart
> > service to provide a meaningful abstraction for end users, but not directly
> > being used by them - and we can define it whatever we like.
> > 
> > And this brings us to a contentious point, how to protect and enforce this
> > behavior?
> > 
> > I think we need to enforce that these hints are used by some all knowing entity
> > and for sched_attr to be locked down by everyone except it. Vincent was
> > suggesting to use SELinux to lockdown sched_attrs, but given recent issues with
> > tcmalloc I think we must eneforce something at kernel level. CAP_NICE is spread
> > around and we don't want to mix and match how sched_attr and these new QoS are
> > used.
> > 
> > To address this I think we need to introduce a new CAP_PERF_MANAGER (or pick
> > your favourite name here) that can only be set for specific binaries and only
> > one binary is allowed to exec with this capability. If two binaries with this
> > capability try to run, then the second one will fail unless the first one has
> > exited first. And when it is running, we lock down sched_setattr() except for
> > this CAP_PERF_MANAGER.> 
> > I am not sure if this is enough, but I think we must enforce the usage pattern
> > else we can end up with a mess. I think we all agree it is hard for
> > applications to use sched_attr in general directly, given the benefit of
> > a hindsight. I commonly see the simple nice value misused in practice for
> > example.
> > 
> > Ideally I'd love to enforce a single trusted binary if that can be done :p
> > 
> 
> 
> Just to follow along, does that mean if an application runs with CAP_PERF_MANAGER
> any other that doesn't have CAP_PERF_MANAGER and calls any of
> sched_setattr()
> sched_setscheduler()
> sched_setparam()
> nice()
> setpriority()
> 
> would get EPERM? Or silently be dropped?

I think EPERM.

> Either seems error-prone and potentially no longer work as a "Zero API adoption mechanism".

How come it is error-prone, could you explain more?

What's the relationship between this and zero api?

> Chromium and Unity seem to handle sched_setattr() failing, but unsure what the
> situation looks like generally.

You think they will crash if we block usage? These already can fail if admins
block via selinux for example.
