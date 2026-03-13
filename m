Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD8C2BEC23
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 13:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407283; cv=none; b=dW+jG3ueGXWnR2ceL3lPqSF09sVpCTZBmTKk1A0KGY072ziu3brL2lkk4H01wA5tdX9MhAam7auAKh9hKjo2ugLE2Xv4RfE3rB4sDIQzmiNmJwpfLtoYg2e56dkn8kUxqlF+7vZ7CkoDw7vf6FdpSjzlaDoUBLoOzYwpODZvmFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407283; c=relaxed/simple;
	bh=VBpxCbQ7cJzWMZ6RQO4ZZjSQfLBe2X/XAM6sh8janPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p5l3HpWk6ca4Dzzn85m8Vn351+u416I+WjYS1MOCsMsKKUSrhN1hmxi5xPBWkYD++eqaLYsYf5p0yZbzgaTgWrQFqdORJbXtE2cKS6pv/ZMW4uVxkArEXqCz+kVASRJnJ8PMSD8zVarl8qmiIvnWqYqcqgfL70d1sAFdbjLgiYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akiAovu0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akiAovu0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585E8C2BC9E
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 13:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773407283;
	bh=VBpxCbQ7cJzWMZ6RQO4ZZjSQfLBe2X/XAM6sh8janPE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=akiAovu08OH7z7HD1IW6p8lq2FjK/jmqyKPNYzjb4Ey6HEe3zxB4l7lwtAjuVVRVV
	 ynZ/YaqeEslZ3WvFzx6y3dXc+V+4Pl+eMEQ//LhUqRcXynhbOwWNU4WB9zIMxQx2LC
	 JPdjZ/+FlyxIQ3Rz/U2C9gTyw+lB5y8fw45C4Iu5Jfk39w7/rGw5P7hQDWyJheFe+h
	 IamFR6BnpXoGA8lIWaGL/R2orED8pu4mxHIlMPr37qdn7naajgCMayi9xdHYki9JoE
	 4oBgEiydXL0N5O9vO8IgGlGmCrLxSdqY3hi3a5hMHXx3xhRxcP4tfuUTH1JLD0BZKA
	 jH3Py3yjHVBzA==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so1900768a34.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 06:08:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgjVzn/FG9X1Mx8p8Dp4PBg1gSWRZKkiX3rrfy0SITFD66jgKGwZouXmBIS79bLq9COePiDt6Cgg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9jkXpEKHUy2jY/ckr/FWHNm97MB4BNGou9ARiMbjtk22J2GpR
	LRhj7+XS4pcLCZc9VOAoiX/G+UsoR/fPERvIpQ7fkfZD9J/xAZgVuLn7Z/7fsXFH4qMs6hdkFbq
	L4nxt7IztiWNOqiAJtO4v4c0DAOEQiG4=
X-Received: by 2002:a4a:e841:0:b0:67b:c122:d29b with SMTP id
 006d021491bc7-67bdaa68330mr1960203eaf.52.1773407282290; Fri, 13 Mar 2026
 06:08:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4741364.LvFx2qVVIh@rafael.j.wysocki> <c1f6d920-6bd9-4131-af08-da1be1206812@arm.com>
In-Reply-To: <c1f6d920-6bd9-4131-af08-da1be1206812@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Mar 2026 14:07:50 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hnamFh6YUriWLgdWip6mRer69pNcL3ueBt5Aux6fzsgg@mail.gmail.com>
X-Gm-Features: AaiRm51MOgLxffIo2Q1J3UOblUJLemNrNrVObgaL11HkwWHbH3tAriU9pwU_E04
Message-ID: <CAJZ5v0hnamFh6YUriWLgdWip6mRer69pNcL3ueBt5Aux6fzsgg@mail.gmail.com>
Subject: Re: [PATCH v1] sched: idle: Consolidate the handling of two special cases
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Qais Yousef <qyousef@layalina.io>, 
	Frederic Weisbecker <frederic@kernel.org>, Aboorva Devarajan <aboorvad@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 1:53=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 3/13/26 12:25, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > There are two special cases in the idle loop that are handled
> > inconsistently even though they are analogous.
> >
> > The first one is when a cpuidle driver is absent and the default CPU
> > idle time power management implemented by the architecture code is used=
.
> > In that case, the scheduler tick is stopped every time before invoking
> > default_idle_call().
> >
> > The second one is when a cpuidle driver is present, but there is only
> > one idle state in its table.  In that case, the scheduler tick is never
> > stopped.
> >
> > Since each of these approaches leads to suboptimal choices in some
> > cases, reconcile them with the help of one simple heuristic.  Namely,
> > stop the tick if the CPU has been woken up by it in the previous
> > iteration of the idle loop, or let it tick otherwise.>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > Based on today's mainline.
> >
> > ---
> >  kernel/sched/idle.c |   30 +++++++++++++++++++++---------
> >  1 file changed, 21 insertions(+), 9 deletions(-)
> >
> > --- a/kernel/sched/idle.c
> > +++ b/kernel/sched/idle.c
> > @@ -161,6 +161,14 @@ static int call_cpuidle(struct cpuidle_d
> >       return cpuidle_enter(drv, dev, next_state);
> >  }
> >
> > +static void idle_call_stop_or_retain_tick(bool stop_tick)
> > +{
> > +     if (stop_tick || tick_nohz_tick_stopped())
> > +             tick_nohz_idle_stop_tick();
> > +     else
> > +             tick_nohz_idle_retain_tick();
> > +}
> > +
> >  /**
> >   * cpuidle_idle_call - the main idle function
> >   *
> > @@ -170,7 +178,7 @@ static int call_cpuidle(struct cpuidle_d
> >   * set, and it returns with polling set.  If it ever stops polling, it
> >   * must clear the polling bit.
> >   */
> > -static void cpuidle_idle_call(void)
> > +static void cpuidle_idle_call(bool stop_tick)
> >  {
> >       struct cpuidle_device *dev =3D cpuidle_get_device();
> >       struct cpuidle_driver *drv =3D cpuidle_get_cpu_driver(dev);
> > @@ -186,7 +194,7 @@ static void cpuidle_idle_call(void)
> >       }
> >
> >       if (cpuidle_not_available(drv, dev)) {
> > -             tick_nohz_idle_stop_tick();
> > +             idle_call_stop_or_retain_tick(stop_tick);
> >
> >               default_idle_call();
> >               goto exit_idle;
> > @@ -222,17 +230,19 @@ static void cpuidle_idle_call(void)
> >               next_state =3D cpuidle_find_deepest_state(drv, dev, max_l=
atency_ns);
> >               call_cpuidle(drv, dev, next_state);
> >       } else if (drv->state_count > 1) {
> > -             bool stop_tick =3D true;
> > +             /*
> > +              * stop_tick is expected to be true by default by cpuidle
> > +              * governors, which allows them to select idle states wit=
h
> > +              * target residency above the tick period length.
> > +              */
> > +             stop_tick =3D true;
> >
> >               /*
> >                * Ask the cpuidle framework to choose a convenient idle =
state.
> >                */
> >               next_state =3D cpuidle_select(drv, dev, &stop_tick);
> >
> > -             if (stop_tick || tick_nohz_tick_stopped())
> > -                     tick_nohz_idle_stop_tick();
> > -             else
> > -                     tick_nohz_idle_retain_tick();
> > +             idle_call_stop_or_retain_tick(stop_tick);
> >
> >               entered_state =3D call_cpuidle(drv, dev, next_state);
> >               /*
> > @@ -240,7 +250,7 @@ static void cpuidle_idle_call(void)
> >                */
> >               cpuidle_reflect(dev, entered_state);
> >       } else {
> > -             tick_nohz_idle_retain_tick();
> > +             idle_call_stop_or_retain_tick(stop_tick);
>
> This would supersede e5c9ffc6ae1b ("cpuidle: Skip governor when only one =
idle state is available")
> so we should remove that code too.

Which code?  Do you mean the one that has been removed by

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dd557640e4ce589a24dca5ca7ce3b9680f471325f

> LGTM otherwise.

Cool.

> >
> >               /*
> >                * If there is only a single idle state (or none), there =
is
> > @@ -268,6 +278,7 @@ exit_idle:
> >  static void do_idle(void)
> >  {
> >       int cpu =3D smp_processor_id();
> > +     bool got_tick =3D false;
> >
> >       /*
> >        * Check if we need to update blocked load
> > @@ -338,8 +349,9 @@ static void do_idle(void)
> >                       tick_nohz_idle_restart_tick();
> >                       cpu_idle_poll();
> >               } else {
> > -                     cpuidle_idle_call();
> > +                     cpuidle_idle_call(got_tick);
> >               }
> > +             got_tick =3D tick_nohz_idle_got_tick();
> >               arch_cpu_idle_exit();
> >       }
> >
> >
> >
> >
>
