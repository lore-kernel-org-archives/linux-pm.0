Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7923A6EF7
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 15:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773415747; cv=none; b=gLfSx1Zjb0eS2ifgDI7dcZyWgwf+4lPYgw5CA5POXNaldhoXjL1xo05x4ZV+eWDCSOiihcRitHiaEkCSdzo7yxuannJ0PbRNMUePMudIelmAc8SPCYloG+p9oEG+AIuQX/nWFk0NHFSX543fxyXQ1psEe4wToyb5vn4OwuI9v+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773415747; c=relaxed/simple;
	bh=ywaeVirycj8FBKFmQIFkPS7dhmfA1HtHARIV34Oy3ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MPL71HSQ7kVp3kkBxE7YOgHbIkeXXdD20sCnMEu9cOyrRQbNqqtgA7W2GbcFs4yeyPckwAoORhZ3GxNYK+Vx1bbud1sFPzxOsTc0HK5f9YOCBKQ+xTGTBlgCxA/XuEAmB5ZhS6c7jnLSUIcnldV7qefuBlK6ty8SJiiau3DR43s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZvHWK6C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZvHWK6C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10225C2BC86
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 15:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773415747;
	bh=ywaeVirycj8FBKFmQIFkPS7dhmfA1HtHARIV34Oy3ko=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sZvHWK6CP7Zzzx6ZrW6+gewsiUEW+xWiS2XG+nVGhrueaembBl+myU1xLhl7B1pbg
	 ZCuYhiuPOPXYgiA+te4P8DZf7hNJy3pd0SPLhQ76RIx5m0XCVFwl2P9j8cJ2D0hlqW
	 m2D05chyK4ji2YtzTq37da7JYW/Nrl4csAXyGv2pcEqC2tTD2niGRFXCVfmfZCyYGY
	 US1tlHI/n7UvEZ2R0jBVIrnVQoxnJemgYB7onD1NkJ2F6WeoOenX4H0ScTJqW6DHTX
	 BUo6WQuX/7l9RF88+vhmrULHeWajX4nVo6NDBoHeIOusZau5yD/hCz7dOR40b9EvT5
	 rMRV2zribokBw==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d76a331ebbso1519608a34.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 08:29:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvHN/8KDYOsDACfLwPqSJLP+wFKc4Vm0iuvn5yLE1R4KSsVup/4Q7Ggd6Nx2wduwsrdAmRrgCArA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqQXLFYl6zIxjE2vLCWlw6DZlNsDHFOXuwvnLPrYjpccLuHm6I
	OtHENLxefU7mWFQkUSMJfgclSHra6f50jf7eZtjOcX7zO2YGKChs1YPa/5nt4aAcvt/TenfSayu
	pEYG2Rafb5UX0CrLfr2tOEQ99dKfNqVs=
X-Received: by 2002:a05:6820:60e:b0:67b:a77a:e679 with SMTP id
 006d021491bc7-67bda9e0978mr2006541eaf.31.1773415745971; Fri, 13 Mar 2026
 08:29:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4741364.LvFx2qVVIh@rafael.j.wysocki> <c1f6d920-6bd9-4131-af08-da1be1206812@arm.com>
 <CAJZ5v0hnamFh6YUriWLgdWip6mRer69pNcL3ueBt5Aux6fzsgg@mail.gmail.com> <ae9d5cba-f525-48bb-bac4-cbd50db1dbac@arm.com>
In-Reply-To: <ae9d5cba-f525-48bb-bac4-cbd50db1dbac@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Mar 2026 16:28:54 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0grtJVtj7oGDRJ=gyWVs6VnGcydOURJ5aDfE6qVn8nkXg@mail.gmail.com>
X-Gm-Features: AaiRm53-DKU3ZBa-3EdsVGeJFklQkPyPy3cwJB0gphef3mZ8Ef4d6VoKDoT2qzQ
Message-ID: <CAJZ5v0grtJVtj7oGDRJ=gyWVs6VnGcydOURJ5aDfE6qVn8nkXg@mail.gmail.com>
Subject: Re: [PATCH v1] sched: idle: Consolidate the handling of two special cases
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Qais Yousef <qyousef@layalina.io>, 
	Frederic Weisbecker <frederic@kernel.org>, Aboorva Devarajan <aboorvad@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 3:04=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 3/13/26 13:07, Rafael J. Wysocki wrote:
> > On Fri, Mar 13, 2026 at 1:53=E2=80=AFPM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> >>
> >> On 3/13/26 12:25, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> There are two special cases in the idle loop that are handled
> >>> inconsistently even though they are analogous.
> >>>
> >>> The first one is when a cpuidle driver is absent and the default CPU
> >>> idle time power management implemented by the architecture code is us=
ed.
> >>> In that case, the scheduler tick is stopped every time before invokin=
g
> >>> default_idle_call().
> >>>
> >>> The second one is when a cpuidle driver is present, but there is only
> >>> one idle state in its table.  In that case, the scheduler tick is nev=
er
> >>> stopped.
> >>>
> >>> Since each of these approaches leads to suboptimal choices in some
> >>> cases, reconcile them with the help of one simple heuristic.  Namely,
> >>> stop the tick if the CPU has been woken up by it in the previous
> >>> iteration of the idle loop, or let it tick otherwise.>
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>> ---
> >>>
> >>> Based on today's mainline.
> >>>
> >>> ---
> >>>  kernel/sched/idle.c |   30 +++++++++++++++++++++---------
> >>>  1 file changed, 21 insertions(+), 9 deletions(-)
> >>>
> >>> --- a/kernel/sched/idle.c
> >>> +++ b/kernel/sched/idle.c
> >>> @@ -161,6 +161,14 @@ static int call_cpuidle(struct cpuidle_d
> >>>       return cpuidle_enter(drv, dev, next_state);
> >>>  }
> >>>
> >>> +static void idle_call_stop_or_retain_tick(bool stop_tick)
> >>> +{
> >>> +     if (stop_tick || tick_nohz_tick_stopped())
> >>> +             tick_nohz_idle_stop_tick();
> >>> +     else
> >>> +             tick_nohz_idle_retain_tick();
> >>> +}
> >>> +
> >>>  /**
> >>>   * cpuidle_idle_call - the main idle function
> >>>   *
> >>> @@ -170,7 +178,7 @@ static int call_cpuidle(struct cpuidle_d
> >>>   * set, and it returns with polling set.  If it ever stops polling, =
it
> >>>   * must clear the polling bit.
> >>>   */
> >>> -static void cpuidle_idle_call(void)
> >>> +static void cpuidle_idle_call(bool stop_tick)
> >>>  {
> >>>       struct cpuidle_device *dev =3D cpuidle_get_device();
> >>>       struct cpuidle_driver *drv =3D cpuidle_get_cpu_driver(dev);
> >>> @@ -186,7 +194,7 @@ static void cpuidle_idle_call(void)
> >>>       }
> >>>
> >>>       if (cpuidle_not_available(drv, dev)) {
> >>> -             tick_nohz_idle_stop_tick();
> >>> +             idle_call_stop_or_retain_tick(stop_tick);
> >>>
> >>>               default_idle_call();
> >>>               goto exit_idle;
> >>> @@ -222,17 +230,19 @@ static void cpuidle_idle_call(void)
> >>>               next_state =3D cpuidle_find_deepest_state(drv, dev, max=
_latency_ns);
> >>>               call_cpuidle(drv, dev, next_state);
> >>>       } else if (drv->state_count > 1) {
> >>> -             bool stop_tick =3D true;
> >>> +             /*
> >>> +              * stop_tick is expected to be true by default by cpuid=
le
> >>> +              * governors, which allows them to select idle states w=
ith
> >>> +              * target residency above the tick period length.
> >>> +              */
> >>> +             stop_tick =3D true;
> >>>
> >>>               /*
> >>>                * Ask the cpuidle framework to choose a convenient idl=
e state.
> >>>                */
> >>>               next_state =3D cpuidle_select(drv, dev, &stop_tick);
> >>>
> >>> -             if (stop_tick || tick_nohz_tick_stopped())
> >>> -                     tick_nohz_idle_stop_tick();
> >>> -             else
> >>> -                     tick_nohz_idle_retain_tick();
> >>> +             idle_call_stop_or_retain_tick(stop_tick);
> >>>
> >>>               entered_state =3D call_cpuidle(drv, dev, next_state);
> >>>               /*
> >>> @@ -240,7 +250,7 @@ static void cpuidle_idle_call(void)
> >>>                */
> >>>               cpuidle_reflect(dev, entered_state);
> >>>       } else {
> >>> -             tick_nohz_idle_retain_tick();
> >>> +             idle_call_stop_or_retain_tick(stop_tick);
> >>
> >> This would supersede e5c9ffc6ae1b ("cpuidle: Skip governor when only o=
ne idle state is available")
> >> so we should remove that code too.
> >
> > Which code?  Do you mean the one that has been removed by
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dd557640e4ce589a24dca5ca7ce3b9680f471325f
> >
> Ah of course, sorry!

No worries.

> Reviewed-by: Christian Loehle <christian.loehle@arm.com>

So should I regard this as a fix for 7.0?

I guess so because I don't think it would be useful to ship 7.0
without it only to change the behavior immediately in 7.1.  And I
think that it can be treated as a fix for e5c9ffc6ae1b (above).
