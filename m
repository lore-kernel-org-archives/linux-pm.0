Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D09C309F09
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 07:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778572799; cv=none; b=T54as/HY2cF1sHs407ZJg6LUJJ+mmJ7ks93/SJDu6hWsoCzXQcGFXXITQWU4iEuzRO067aUShqEOQ4m+VdTc3bL0mbg7GGNUY4NqkGTM6R8WLwtDmHgdaTQ75eryiX/G0fRTRUCM43udqGD/p87I1RmHhGhrlhrFZEJdOyzyW68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778572799; c=relaxed/simple;
	bh=ozzbqAetBY7tA+9G+2kunB80D92Jzt8hn13uvJNzADA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6kOU5hfGGREaStpm3TFQjKaMyuZZFppyewBPWdK7WFsFq2ztf8tTGg9HQbCXKfVytnp70S2wlgwLFmMuvFkWInNtR8q3ewZLaqb6SalZJyrk4useKqyzG1WNnisn2qsRIiFKtzsvE5to3RekkpMAROQ/SYlX16q13l4n12X3uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=lwPpyaGv; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="lwPpyaGv"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-449d6c68ed8so4437952f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 00:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1778572796; x=1779177596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1QlP6Wsz/Gz7VnLdCroLUX3lCPeogYc4BDIhxVKwiZE=;
        b=lwPpyaGvaZVGNemyABY6hTZ88jnSF1IiGBfTLk6JDBAUQVKfjjc7RjTojm1Ebpht25
         Ai0+cIqLVzSU9bM7dFXN2Ofeg2+Py2bqJ/uozjY8RmpQ1ijv4IGhQneifcK8hJt58r8I
         SPiRrQnQWTcPP76V5A0a3lIta29ehSqeeoqjY85ZeUYqG38cVV6YHDW14CYpCwOQSgQP
         jofj+7ikFrOUBHJ7BHRFkB1imB3GQS1IfOH18ntohaSfbUOyB9ZUWH1QpTbVIMXSFXYd
         pJ+Iw+2/XDFUTP8mcFoK3Be6C4QzU3JPw73Oit6YtDrF7Dm1jcB59TC2PDjxBKZx656x
         wMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778572796; x=1779177596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QlP6Wsz/Gz7VnLdCroLUX3lCPeogYc4BDIhxVKwiZE=;
        b=q5wz5ZdFHmSI72EDvA6d4Bz/id74pE2z6JwCnYRPINyiqYwmOu4w0IvBFbN1dBkCHC
         HHodFc78w+o0IUnTRvod9z4+pQkbcP1C7Hzh5cD1jnw2OHr8euPDlxSBezaHQ1azUidc
         KK4mP+Ai0Pz0Y9N9DN4yJyLYTgVMI5CQBBQKh08defYGEfNsElV67Xb3+paY6eFSzNuZ
         /FI3TqTtKsktShUvblK/KGeYu5z6djyLSisAphJS9qFAZPCG8DBS3YAsE3WhD7hbxpzK
         tAG2+3TBsVPgojRPgA5zjHOM/HV3/gOfwQs6ZZYK5zHJ3CKwJ0/5sxEkV2FIltuSrUCf
         WZig==
X-Forwarded-Encrypted: i=1; AFNElJ/kMi2UOLUGjGErqrZQQ3y7R4hSbQnbIKKiwM9ATunjQdP3XzOMeccuGH6ioMUbeT9e/EdX9AxF1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzigG+HR4Jy2QBOwHsLAw07Ri170p2H/HEuGD8A5gENYbjqnW/H
	OhFcuwjrVyuXQh5c/LQnU1VmgbtHhMkvgR9i3hpngqqoWoStX2spaT3dcvV06Z9KDz0=
X-Gm-Gg: Acq92OFRUmXBzRcAfdHzww+8bk1z5sYbU+Utpv7PZy0xJdylP7igZD68ZgIyU66wVeo
	DO179Zq9zBcbKetXzXPDVvkAlffQSB1QYtola3d2kjc7peAv8esLVM84EgIyuf0FZcc8ZR3+Gjg
	bAZ1xDSGf+9DvMWIDqL5HsIWaTYQKbTJ2fOABeca2cFM5ORUn0l7sI7VGLR+90kjPpttCx3sEb6
	5MPZlfJKRZfX3yojIupeoTIV0xzZ9NFfD46TM5+4K/XAlZn3rxgbn9eJTXaxqmDj7ZahKHi65Nq
	XyHkKQ9FhC48YBQ1/exa6Tse0eTfhhHmO8J4Z85G3xVYXfa1HAFxtpZUjrL6gwe965T9iFEzIuU
	pDQhmOZaSqEa3W7wRgoxNBlE5OanbLJzvahapn28/kPqTGoQeuAEJP8ZMbSKvlwCehGjdPdq+qw
	Cary23woWOGEstUeh5
X-Received: by 2002:a5d:6e4e:0:b0:456:d5bf:e24d with SMTP id ffacd0b85a97d-456d5bfe26dmr12873428f8f.2.1778572796286;
        Tue, 12 May 2026 00:59:56 -0700 (PDT)
Received: from airbuntu ([185.253.98.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6c221sm31691448f8f.13.2026.05.12.00.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 00:59:55 -0700 (PDT)
Date: Tue, 12 May 2026 08:59:53 +0100
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
Subject: Re: [PATCH v2 09/13] sched/qos: Add rampup multiplier QoS
Message-ID: <20260512075953.uoicyuwwvqcejxpn@airbuntu>
References: <20260504020003.71306-1-qyousef@layalina.io>
 <20260504020003.71306-10-qyousef@layalina.io>
 <20260511110328.GS3126523@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260511110328.GS3126523@noisy.programming.kicks-ass.net>

On 05/11/26 13:03, Peter Zijlstra wrote:
> On Mon, May 04, 2026 at 02:59:59AM +0100, Qais Yousef wrote:
> 
> > diff --git a/Documentation/scheduler/sched-qos.rst b/Documentation/scheduler/sched-qos.rst
> > index 0911261cb124..f68856f23b6b 100644
> > --- a/Documentation/scheduler/sched-qos.rst
> > +++ b/Documentation/scheduler/sched-qos.rst
> > @@ -42,3 +42,25 @@ need for extension will arise; and when this happen the task should be
> >  simpler to add the kernel extension and allow userspace to use readily by
> >  setting the newly added flag without having to update the whole of
> >  sched_attr.
> > +
> > +2. QoS Tags
> > +===========
> > +
> > +SCHED_QOS_RAMPUP_MULTIPLIER
> > +---------------------------
> > +
> > +Controls how fast util signal rises. Affects frequency selection when schedutil
> > +is in use. And affects how fast tasks migrate between clusters on HMP systems.
> > +
> > +It affects bursty tasks only. Perfectly periodic tasks are well described by
> > +util_avg and the rampup multiplier will have no effect on them.
> > +
> > +When set to 0, util_est will be disabled to help further with power saving.
> > +This behavior can be controlled via UTIL_EST_RAMPUP_ZERO sched_feature.
> > +
> > +Value is not capped to retain flexibility, but it tapers off very quickly to
> > +notice a difference above 16. Roughly it takes ~200ms to reach a util_avg of
> > +1000 starting from 0. With 16 it should take ~12.5ms. A range of 0-8 is
> > +advised for general use.
> > +
> > +Cookie must always be set to 0.
> 
> So this is a very specific feature. This is made possible by basically
> having a huge type space, allowing for throw-away hints (as per the
> previous email).

Hmm. It is specific and generic. It is specific in a sense it is about the rise
time through performance level and scheduler integration with schedutil. It is
generic also because it is about the time it takes scheduler/kernel to move
through performance levels. I could change the description to focus on these
generic elements of DVFS response time and migration time for HMP systems.

I think if we move away from PELT etc, the concept will still be valid but
implemented differently unless the new implementation can't use the concept of
a multiplier for some reason to speed up the rise time.

> 
> I suppose having these specific hints is easy, but as per always there
> is the discussion about describing task behaviour vs implementation
> details. With the argument being that task behaviour might be a more
> lasting / stable hint, while implementation details are far easier to
> actually do.
> 
> I'm missing this discussion.

The intention is to describe task behavior. But being practical as well and
allow solve real world problems with ease - so if implementation detail
description will help us fix problems simply and easily, then I am for it.

The question is how to protect ourselves? :-)

This is where the two levels of QoS can help.

One level is for app developers, which is high level abstraction that is
detached from OS internals and details. This is done in schedqos I announced
recently. The goal is for users to use the QoS exposed by this service and not
to interact directly with scheduler/kernel.

The other level is this one proposed here; which is to enable this smart
service to provide a meaningful abstraction for end users, but not directly
being used by them - and we can define it whatever we like.

And this brings us to a contentious point, how to protect and enforce this
behavior?

I think we need to enforce that these hints are used by some all knowing entity
and for sched_attr to be locked down by everyone except it. Vincent was
suggesting to use SELinux to lockdown sched_attrs, but given recent issues with
tcmalloc I think we must eneforce something at kernel level. CAP_NICE is spread
around and we don't want to mix and match how sched_attr and these new QoS are
used.

To address this I think we need to introduce a new CAP_PERF_MANAGER (or pick
your favourite name here) that can only be set for specific binaries and only
one binary is allowed to exec with this capability. If two binaries with this
capability try to run, then the second one will fail unless the first one has
exited first. And when it is running, we lock down sched_setattr() except for
this CAP_PERF_MANAGER.

I am not sure if this is enough, but I think we must enforce the usage pattern
else we can end up with a mess. I think we all agree it is hard for
applications to use sched_attr in general directly, given the benefit of
a hindsight. I commonly see the simple nice value misused in practice for
example.

Ideally I'd love to enforce a single trusted binary if that can be done :p
