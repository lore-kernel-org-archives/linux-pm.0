Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0476C1A3166
	for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2026 11:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773487855; cv=none; b=Qx07O0Ga/tQZ32aPI3V6Oz0ggt2IeckJ3C7wddQSC8D/kgSly6glLZtszcxkOSwPhwmqDYe/i3bOrWSnVKOgCyZ1uBgS6RSJ3tERyZ/wayTbIjIs2ZMGG5/OrqIc/SoqXu6JupfKTHemHcX4OLgrO/mOkfFmVS1sxzteOJj+gxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773487855; c=relaxed/simple;
	bh=cmhwEiJ7YclHpAQAto7hTWj5xi+lG3Tt+kXKOmtwZHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hth2RcUkNLtEww7wU8elQR3KIOPzkMIzo1/f4d03G1pFs1KeKSnTPCcBufgN7Eb13WLYSyKp9x1DHA9d3ZnLULdkcsSt8z0llsZwZF5NPtruC9ktqRlkHSZbDhOUoLqqX86e99ohtMhVMZF4f7CZ2x26Nu5oZTTLjXg5YPliAZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Im6iR6oS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Im6iR6oS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AF9C19425
	for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2026 11:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773487854;
	bh=cmhwEiJ7YclHpAQAto7hTWj5xi+lG3Tt+kXKOmtwZHc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Im6iR6oSzttUtwHezUzZL0FSqsuknkIEZ14LBNbG3sCpSs9YeMfvSQUILq/9BZW4x
	 eBCefbBJvr67rm7KfuryjoLPg/+7xe/JclOgXq45ZakmkeMcj3NMsJh1juSzL6xPsj
	 7VNSXiIo0fDwIqTlb61oO4IrcgBCB0A4Tbkb/MXFlk4VmNZwzA7pNZ4coPtFaiYN5u
	 omUwh3p4JtuQidg67v7U9kGr06JzmQFyEO66+MR9hT3IO/NHcmG/KZDXzxQA4ntVG4
	 8WlvY542iW2bZBUPWrhFSEFhHfv3bQjK2YhIOj/YXzSw2egmes3Jy9v/nDKXz5D7So
	 oGXzfIrcdNF6g==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d556c1a79eso3413724a34.3
        for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2026 04:30:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVVwBHeeUsYkggpuEU5ufegSYwjROLM7MBthjo5yvUwsKuVSZ+0WlFkUN2cY24Y9OCcM9jgortnwA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa6QqCSscNLAPml+bSdzI3J1VO6M9ojvOoG45naSjn18rIv6m1
	tY1Af/1OYpk5NOYWi6kYaodpFcEKCBLtdt8QUz62otKv4AzvCZDECUXTQ9MJXWmB2jAhy6nV8te
	tbD0HboHC/EtlbweynyYgZ/3RFDaoRwM=
X-Received: by 2002:a05:6820:4912:b0:67b:b1e0:501a with SMTP id
 006d021491bc7-67bda9bf9bbmr3361106eaf.17.1773487853768; Sat, 14 Mar 2026
 04:30:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4741364.LvFx2qVVIh@rafael.j.wysocki> <c1f6d920-6bd9-4131-af08-da1be1206812@arm.com>
 <CAJZ5v0hnamFh6YUriWLgdWip6mRer69pNcL3ueBt5Aux6fzsgg@mail.gmail.com>
 <ae9d5cba-f525-48bb-bac4-cbd50db1dbac@arm.com> <CAJZ5v0grtJVtj7oGDRJ=gyWVs6VnGcydOURJ5aDfE6qVn8nkXg@mail.gmail.com>
 <a102eb05-9051-43bb-9f25-accf71498f6a@arm.com>
In-Reply-To: <a102eb05-9051-43bb-9f25-accf71498f6a@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 14 Mar 2026 12:30:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hifVc=bLnLwDbm7DHQKMOgKd0X0O-1CGS5_BYzzG3p6w@mail.gmail.com>
X-Gm-Features: AaiRm51yscCWCUu2xFCOJ0f8tOdPd1c7AoFaM5pq_5tNw0U1oyxPAQ_s2NwGWAw
Message-ID: <CAJZ5v0hifVc=bLnLwDbm7DHQKMOgKd0X0O-1CGS5_BYzzG3p6w@mail.gmail.com>
Subject: Re: [PATCH v1] sched: idle: Consolidate the handling of two special cases
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Qais Yousef <qyousef@layalina.io>, 
	Frederic Weisbecker <frederic@kernel.org>, Aboorva Devarajan <aboorvad@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 4:45=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 3/13/26 15:28, Rafael J. Wysocki wrote:
> > On Fri, Mar 13, 2026 at 3:04=E2=80=AFPM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> >>
> >> On 3/13/26 13:07, Rafael J. Wysocki wrote:
> >>> On Fri, Mar 13, 2026 at 1:53=E2=80=AFPM Christian Loehle
> >>> <christian.loehle@arm.com> wrote:
> >>>>
> >>>> On 3/13/26 12:25, Rafael J. Wysocki wrote:
> >>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>>>
> >>>>> There are two special cases in the idle loop that are handled
> >>>>> inconsistently even though they are analogous.
> >>>>>
> >>>>> The first one is when a cpuidle driver is absent and the default CP=
U
> >>>>> idle time power management implemented by the architecture code is =
used.
> >>>>> In that case, the scheduler tick is stopped every time before invok=
ing
> >>>>> default_idle_call().
> >>>>>
> >>>>> The second one is when a cpuidle driver is present, but there is on=
ly
> >>>>> one idle state in its table.  In that case, the scheduler tick is n=
ever
> >>>>> stopped.
> >>>>>
> >>>>> Since each of these approaches leads to suboptimal choices in some
> >>>>> cases, reconcile them with the help of one simple heuristic.  Namel=
y,
> >>>>> stop the tick if the CPU has been woken up by it in the previous
> >>>>> iteration of the idle loop, or let it tick otherwise.>
> >>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>>> ---
> >>>>>
> >>>>> Based on today's mainline.
> >>>>>
> >>>>> ---
> >>>>>  kernel/sched/idle.c |   30 +++++++++++++++++++++---------
> >>>>>  1 file changed, 21 insertions(+), 9 deletions(-)
> >>>>>
> >>>>> --- a/kernel/sched/idle.c
> >>>>> +++ b/kernel/sched/idle.c
> >>>>> @@ -161,6 +161,14 @@ static int call_cpuidle(struct cpuidle_d
> >>>>>       return cpuidle_enter(drv, dev, next_state);
> >>>>>  }
> >>>>>
> >>>>> +static void idle_call_stop_or_retain_tick(bool stop_tick)
> >>>>> +{
> >>>>> +     if (stop_tick || tick_nohz_tick_stopped())
> >>>>> +             tick_nohz_idle_stop_tick();
> >>>>> +     else
> >>>>> +             tick_nohz_idle_retain_tick();
> >>>>> +}
> >>>>> +
> >>>>>  /**
> >>>>>   * cpuidle_idle_call - the main idle function
> >>>>>   *
> >>>>> @@ -170,7 +178,7 @@ static int call_cpuidle(struct cpuidle_d
> >>>>>   * set, and it returns with polling set.  If it ever stops polling=
, it
> >>>>>   * must clear the polling bit.
> >>>>>   */
> >>>>> -static void cpuidle_idle_call(void)
> >>>>> +static void cpuidle_idle_call(bool stop_tick)
> >>>>>  {
> >>>>>       struct cpuidle_device *dev =3D cpuidle_get_device();
> >>>>>       struct cpuidle_driver *drv =3D cpuidle_get_cpu_driver(dev);
> >>>>> @@ -186,7 +194,7 @@ static void cpuidle_idle_call(void)
> >>>>>       }
> >>>>>
> >>>>>       if (cpuidle_not_available(drv, dev)) {
> >>>>> -             tick_nohz_idle_stop_tick();
> >>>>> +             idle_call_stop_or_retain_tick(stop_tick);
> >>>>>
> >>>>>               default_idle_call();
> >>>>>               goto exit_idle;
> >>>>> @@ -222,17 +230,19 @@ static void cpuidle_idle_call(void)
> >>>>>               next_state =3D cpuidle_find_deepest_state(drv, dev, m=
ax_latency_ns);
> >>>>>               call_cpuidle(drv, dev, next_state);
> >>>>>       } else if (drv->state_count > 1) {
> >>>>> -             bool stop_tick =3D true;
> >>>>> +             /*
> >>>>> +              * stop_tick is expected to be true by default by cpu=
idle
> >>>>> +              * governors, which allows them to select idle states=
 with
> >>>>> +              * target residency above the tick period length.
> >>>>> +              */
> >>>>> +             stop_tick =3D true;
> >>>>>
> >>>>>               /*
> >>>>>                * Ask the cpuidle framework to choose a convenient i=
dle state.
> >>>>>                */
> >>>>>               next_state =3D cpuidle_select(drv, dev, &stop_tick);
> >>>>>
> >>>>> -             if (stop_tick || tick_nohz_tick_stopped())
> >>>>> -                     tick_nohz_idle_stop_tick();
> >>>>> -             else
> >>>>> -                     tick_nohz_idle_retain_tick();
> >>>>> +             idle_call_stop_or_retain_tick(stop_tick);
> >>>>>
> >>>>>               entered_state =3D call_cpuidle(drv, dev, next_state);
> >>>>>               /*
> >>>>> @@ -240,7 +250,7 @@ static void cpuidle_idle_call(void)
> >>>>>                */
> >>>>>               cpuidle_reflect(dev, entered_state);
> >>>>>       } else {
> >>>>> -             tick_nohz_idle_retain_tick();
> >>>>> +             idle_call_stop_or_retain_tick(stop_tick);
> >>>>
> >>>> This would supersede e5c9ffc6ae1b ("cpuidle: Skip governor when only=
 one idle state is available")
> >>>> so we should remove that code too.
> >>>
> >>> Which code?  Do you mean the one that has been removed by
> >>>
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Dd557640e4ce589a24dca5ca7ce3b9680f471325f
> >>>
> >> Ah of course, sorry!
> >
> > No worries.
> >
> >> Reviewed-by: Christian Loehle <christian.loehle@arm.com>
> >
> > So should I regard this as a fix for 7.0?
> >
> > I guess so because I don't think it would be useful to ship 7.0
> > without it only to change the behavior immediately in 7.1.  And I
> > think that it can be treated as a fix for e5c9ffc6ae1b (above).
>
> Yes I think it being a fix for e5c9ffc6ae1b should be fine (fingers cross=
ed).

OK

So I'm going to queue it up for the next -rc.  If anyone has
objections, please let me know.
