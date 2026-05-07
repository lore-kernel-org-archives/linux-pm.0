Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3349133262A
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778147725; cv=none; b=aC6thwRrADUQIXENMaicx8HbmkV5SbFLbKlQpZ/ScL9egoHzxztkiWzoUI2Zvn1xuDNzOFyer7GvLdorT80YEgZpS+Y9M+BSfcI+u9tHlGEUCMFkYjx97V1KbofS6lRKPFVQRiJ3gDBS/5ZiInnwjaCqZUtRW4p8cYYA90WfUSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778147725; c=relaxed/simple;
	bh=la5GBb/qjFJDBd0cmtfhPBlQAUFlcJqggm5HPizD5/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQV6eUqERwG5SQ7g5h2vwOIazo09fQjYpwAxNNOXeq+JpQPJDc1LMhoqFgiz4AclyRNOHQ05l2hBvMAsPE/Lsi53GxsvqyVwz6SbzJ+nwmuXtnp0pERglWrnrkvLpgHX9Dyh2OGS9dnMzVIhtuEz0CLUILZHBzLYuhZue27fJXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=DwAVHMAS; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="DwAVHMAS"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45297094718so526860f8f.3
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 02:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1778147721; x=1778752521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Y9OUrxI1EEhChI+FN7an5sN3VNq14WY8yokYelYb1c=;
        b=DwAVHMASberoIqtWej8FGIfw29C6Eam4mw9TBr9inguIsaslmF6HKST4LFc2r8U9kt
         ln3bzj6hxkfX6KWF2h8F4QkJysJcgpeY81/66dEw3arTuR04MuTRMantKnVMyN3tWsLY
         xX2SzIk+yhzPbewcnRVd7fb4JbrBUEl2K+Qq2bGOq1ar+dXnAPT+LV3SnRdvGk9rjLNr
         omnB0i974V6HHpltkRI332qALgiT7nsk2T4bK1bVHUM1u0qJceBriRJVakoqmqGjC5Ki
         jV/cP6vC872zOt+yaQFZ9eNqymZbiT4ZV9FWk5zZYXfWDpU1qspRCusxXN52YrFMpRvC
         gDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778147721; x=1778752521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Y9OUrxI1EEhChI+FN7an5sN3VNq14WY8yokYelYb1c=;
        b=s+aDA5c5E5Rl/ngkwDNtsB5C+oVLyI6eahsLuuiPaeVMSDbU1ar1x63hArxUTU+H+b
         Gb04QqEOYU3WuS1dEOkhYDcbTaR2K1iJ54xo0ALcJnIVoLaTSTT6z/vpT1n44IunOyFA
         PwyQfdS+iizdyxCoU3s5F4Bl0R2Db455BjY6PCGQsYzXxR+uhYD5jvvgrYKwfKaK7Ofo
         nmXVWjp1o/r/sQcp4Jd25sRkBhCUQqNJI9WevVQaOMct0Vlt9oeLQIvBBEiO+Myosf2a
         +IgLder/DSNo84wPVWMhvhokUnUwC0goZAw3N/e3hU8mTMbbT1j9LUg02J3pWkGuslyC
         SG3w==
X-Forwarded-Encrypted: i=1; AFNElJ+O22yUMwebj4wEum92tuaFvjgevbPH/h9xsdhR9vt5RWL35yTl3xT25PTs019BL6M+X3iLwf+KNA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz2cWdtj2HrVHN0S4NEhwbZj8WesnD/IVRw8LtFN4pvv2odMM2
	QWfTh4p1unG3tiWYDntmz7W22fdNlbaAG/yoPf9m2f0e/waUUvIuGE7Aw4LfGeHtnvA=
X-Gm-Gg: AeBDieuPNZCc55mwmfH77sdUwySP93Ibbm1371mr6K2SwP4A5Ir9fatdymOHNFfF82q
	QjnFaKZnM/CJ46EQjSeHFCpa+rOyzH4V2X+IBg9s34UR4/ASivCs9Llc1srTdq+fgDKoQonT8Uc
	7AflNci05nVi2iYLtlkNZfCh/9hd1DfpXTBYe/2394a2I9RAM1IGrCfw+Lkvew5chSf123PS41B
	HLEGRxMy6/wQV+A8cMupitOqtL1RJhJE5VF9wys7iTK0x3i6jL0Yw8L+DnnxW56yJh7MDPO87It
	dL8iImy+jWyL0vUfznOk7Y/HowxEh6rpmXZP/8FWeSe03jyivmPdngvWW7pLLiVruYQGi6pDERG
	ocOwXJKE/0nfl4KVF/I7pZLBA23wpzK0mpIKEpRbJbIt1g4erWqQ1mUWepkZw7BR83W9Hl9pxHG
	R2cemGYK1j7pRrOUZ9cdX8CMP5BTY=
X-Received: by 2002:a05:6000:1acf:b0:446:189c:ac4e with SMTP id ffacd0b85a97d-4515d5c63f0mr11429737f8f.34.1778147720994;
        Thu, 07 May 2026 02:55:20 -0700 (PDT)
Received: from airbuntu ([146.70.179.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052a48911sm19172094f8f.11.2026.05.07.02.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 02:55:20 -0700 (PDT)
Date: Thu, 7 May 2026 10:55:16 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Stultz <jstultz@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	"Chen, Yu C" <yu.c.chen@intel.com>,
	Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 RFC 08/13] sched/qos: Add a new sched-qos interface
Message-ID: <20260507095516.vv7blulzskkyezin@airbuntu>
References: <20260504020003.71306-1-qyousef@layalina.io>
 <20260504020003.71306-9-qyousef@layalina.io>
 <2b9fd875df1f71d2c12c21938784a6c1fd38c04a.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b9fd875df1f71d2c12c21938784a6c1fd38c04a.camel@linux.intel.com>

On 05/06/26 13:38, Tim Chen wrote:
> On Mon, 2026-05-04 at 02:59 +0100, Qais Yousef wrote:
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
> > 
> > [1] https://github.com/qais-yousef/schedqos
> > 
> > Signed-off-by: Qais Yousef <qyousef@layalina.io>
> > ---
> >  Documentation/scheduler/index.rst             |  1 +
> >  Documentation/scheduler/sched-qos.rst         | 44 ++++++++++++++++++
> >  include/uapi/linux/sched.h                    |  4 ++
> >  include/uapi/linux/sched/types.h              | 46 +++++++++++++++++++
> >  kernel/sched/syscalls.c                       | 10 ++++
> >  .../trace/beauty/include/uapi/linux/sched.h   |  4 ++
> >  6 files changed, 109 insertions(+)
> >  create mode 100644 Documentation/scheduler/sched-qos.rst
> > 
> > diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
> > index 17ce8d76befc..6652f18e553b 100644
> > --- a/Documentation/scheduler/index.rst
> > +++ b/Documentation/scheduler/index.rst
> > @@ -23,5 +23,6 @@ Scheduler
> >      sched-stats
> >      sched-ext
> >      sched-debug
> > +    sched-qos
> >  
> >      text_files
> > diff --git a/Documentation/scheduler/sched-qos.rst b/Documentation/scheduler/sched-qos.rst
> > new file mode 100644
> > index 000000000000..0911261cb124
> > --- /dev/null
> > +++ b/Documentation/scheduler/sched-qos.rst
> > @@ -0,0 +1,44 @@
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
> 
> Qais,
> 
> Thanks for your proposal. I have some follow up thoughts.
> 
> How can we query all the tasks that use a cookie?

At the moment you can use sched_getattr() to query the cookie set for
a specific QOS.

We'll probably have to expose something in procfs to allow parsing all tasks
that share a cookie.

Generally the idea is that this is managed by userspace and I'd expect schedqos
service to already know this info as it has to set it.

> A scenario I can think of is there may be two group of tasks, and we may

To be clear, two group of tasks belonging to the same process, right?

I am still not clear on grouping tasks to different processes. Nothing in the
API prevents it, but I am wary of inter-process task grouping as same
application can have several instances running in the system and this is
a layer of complexity that I am not sure warranted. That said, nothing in the
proposal prevents us from handling this if it ends up really making sense.
It'd be a matter of saying QOS_TYPE_XYZ cookie has to be system wide unique and
can be used to tag tasks to different processes, unlike the default behavior
which is unique per process. It's still have to be unique per sched_qos_type.

> want to merge the two group of tasks into one when they start sharing
> data in the context of cache aware scheduling.  In that case, we
> need to get all the tasks under the second cookie and change them to
> that of the first.  We may need to link together tasks sharing a cookie.

My implementation for cookie should have been explicit to return EOPNOTSUP if
spescified. And the doc text could have been clearer.

The idea is that the cookie is per QOS per process. So QOS_TYPE_A would have
its unique cookie range, and QOS_TYPE_B would have its independent unique
cookie range. To allow flexibility and extensibilty to describe independent
behavior that requires independent grouping.

So in your example assuming the grouping is done for a single process, group_a
would have QOS_DATA_DEP with cookie value of 1, and group_b would have
QOS_DATA_DEP with cookie value of 2. To merge them, you'd change group_a or
group_b cookie to match the other group's value.

I still haven't thought fully through how to do this with schedqos configs, but
one idea

{
	"process_a" {
		"thread_qos" {
			"task_1": [ ... ],
			"task_2": [ ... ],
			"task_3": [ ... ],
			"task_4": [ ... ]
		},
		"qos_groups" {
			"group_a" {
				"QOS_DATA_DEP": ["task_1", "task_2"],
			},
			"group_b" {
				"QOS_DATA_DEP": ["task_3", "task_4"],
			}
		}
	}
}

It implies of course to merge you'd have to change the description and restart
the service..

If you want to merge and unmerge at runtime, then I'd have big question marks
on the fact they belong to a group. From experience for this to be really
beneficial you need to describe the dominant behavior even if sometimes it is
untrue. Trying to be exact tends to backfire.

If we really want to do something at runtime, then group control (the planned
userspace extension to exercise QOS control based on cgroup grouping) would be
the way to go IMO.

> 
> We probably need a sched_qos_cookie structure defined analogous to
> the sched_core_cookie to anchor the tasks.  And sched_qos_cookie could be a ptr value
> to sched_qos_cookie, as in sched_core_cookie instead of it being a __u32
> as in the patch below.

As part of the API or internal implementation detail? I think we do need
a cookie structure that stores the sched_qos_type and sched_qos_cookie tuple
internally as implementation detail. But not expose it as an interface.

I think the cookie values should be userspace managed. From experience, this
has to be done in a centralized way via a service otherwise you'd end up with
a mess. There has to be an all knowledgeable entity managing things, which is
what I am proposing in schedqos service. That's why the whole QOS now is
protected with CAP_NICE capability - which I forgot to mention this change from
v1.

We want the interface to be flexible and survive the test of time. I don't just
want to support extensibility, but for us to be able to say we know better now
and we must deprecate something in favour of a new thing that does it better.
It means schedqos has to deal with some complexity to manage deprecation, but
kernel side hopefully we can just delete code with ease. Hopefully there will
be one or few centralized entities around.
