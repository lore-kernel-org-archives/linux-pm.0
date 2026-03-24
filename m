Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB39E3A0E8A
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368479; cv=none; b=t03yDkJslnv7dE3Fy/qQZb+e9TyzrnRmutH0uaHUBN9mNOYLRlou5CA5y/VEk5ITWiFZJIZMaLHElKfqy15X/fUSPSZzc4fG7Kf37DgofcbBxLiYpSGtnC8jD9OO3cOAvFthL9xFqzVS1cG1LWRRABDEw8tebyKEbDTa+D1g8JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368479; c=relaxed/simple;
	bh=cAR1U+jVrfynBh7q7pzypJQ+wadlaqXvjXHvw8GnY98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQIUphmi5zkhbTvLjdoxGxUcSKcWk4Uxz2IcSbdO7QvdD5myI+/uSmTuuMdXTC+jPVOErHCp4yy1g3nIXJ4pXntGkFm/A96KoLtt/QehMpjnKCVU/vf0hD2iAQwFxyJQ2ECnbSOcdnM9abPnDL3qFKMQEH9PcAGrjGE07V7cqu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3P5uE0F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3P5uE0F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D616C2BCB7
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 16:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774368479;
	bh=cAR1U+jVrfynBh7q7pzypJQ+wadlaqXvjXHvw8GnY98=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b3P5uE0F01Dn3tQUebRTNIvbICiphJ5yZptQ6eQWau751YCvJGQ6BygAHLIL2L2Ff
	 fww6DO7G9bN8a4Ye+1kTgu6uWDJ2uIvppsl/SRWctJkdrfxo/xtNAiBhpayKmewgXE
	 O+7eZU145flvZaS6cWCMorFDbOX0ijPY1gk8Q84ZVHRy5De3yFTSnu29vJNC4SwDC4
	 4PmrGYIW72wkOmHKdn2OGmKUaQEYw/g54wQ4f5NnmTl7jjM8RAfVwdOia0xROWsFst
	 +FhGJcGFcKV2uuttedy1yqdqJlh/kJ98W+8ymEN/4F7XJavVHxpZc9XZu77CynLtXS
	 1+BSx4UxU5OiA==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-404254ffe8aso25456fac.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 09:07:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWqOCAnreu95e/V6eeQMBCLP0VjDJNsGTfk0lmrBaXIHifwheAnFJI1x7lQhTpyQalbTZYrMA7VZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3/lvaJn77ktJ1XX5XaAUXoix9HqCSdO61lc8GEvWnhb+SSNqr
	FDf8zemDgWQmCE5Pe3BWG98hD1nA4IVhAoD8QBiqiFCfoI5oytTw8nRETFplnqYtmF2jBhtFsFB
	9EPIwbUXwa4f5wPK9N2YwG57uG6gf18o=
X-Received: by 2002:a05:6870:e0a9:b0:409:628c:ca6e with SMTP id
 586e51a60fabf-41ca5fef88fmr184827fac.2.1774368478209; Tue, 24 Mar 2026
 09:07:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316-cpuidle_ipi-v1-1-d0ff6350f4e2@oss.qualcomm.com>
 <CAJZ5v0hv+t8=mT39-xOkGUS5i6vckJxwfQfqGZ4foxK2rFn8gw@mail.gmail.com> <fcb05fb8-ed4f-4df1-9aa2-18bc3320cad5@oss.qualcomm.com>
In-Reply-To: <fcb05fb8-ed4f-4df1-9aa2-18bc3320cad5@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 24 Mar 2026 17:07:46 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jL6ms3jaB5Ra9h5FA4WY6J7sGgFLnXTOEC+dvVpW7eaA@mail.gmail.com>
X-Gm-Features: AaiRm525iVtJqV4wPSBJkCn6sD2ed_Y2Vu33snPRWfnAEoiM8t2Kpva4jazsVUY
Message-ID: <CAJZ5v0jL6ms3jaB5Ra9h5FA4WY6J7sGgFLnXTOEC+dvVpW7eaA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Deny idle entry when CPU already have IPI
 interrupt pending
To: "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Christian Loehle <christian.loehle@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 1:13=E2=80=AFPM Maulik Shah (mkshah)
<maulik.shah@oss.qualcomm.com> wrote:
>
>
>
> On 3/20/2026 11:59 PM, Rafael J. Wysocki wrote:
> > On Mon, Mar 16, 2026 at 8:38=E2=80=AFAM Maulik Shah
> > <maulik.shah@oss.qualcomm.com> wrote:
> >>
> >> CPU can get IPI interrupt from another CPU while it is executing
> >> cpuidle_select() or about to execute same. The selection do not accoun=
t
> >> for pending interrupts and may continue to enter selected idle state o=
nly
> >> to exit immediately.
> >>
> >> Example trace collected when there is cross CPU IPI.
> >>
> >>  [000] 154.892148: sched_waking: comm=3Dsugov:4 pid=3D491 prio=3D-1 ta=
rget_cpu=3D007
> >>  [000] 154.892148: ipi_raise: target_mask=3D00000000,00000080 (Functio=
n call interrupts)
> >>  [007] 154.892162: cpu_idle: state=3D2 cpu_id=3D7
> >>  [007] 154.892208: cpu_idle: state=3D4294967295 cpu_id=3D7
> >>  [007] 154.892211: irq_handler_entry: irq=3D2 name=3DIPI
> >>  [007] 154.892211: ipi_entry: (Function call interrupts)
> >>  [007] 154.892213: sched_wakeup: comm=3Dsugov:4 pid=3D491 prio=3D-1 ta=
rget_cpu=3D007
> >>  [007] 154.892214: ipi_exit: (Function call interrupts)
> >>
> >> This impacts performance and the above count increments.
> >>
> >> commit ccde6525183c ("smp: Introduce a helper function to check for pe=
nding
> >> IPIs") already introduced a helper function to check the pending IPIs =
and
> >> it is used in pmdomain governor to deny the cluster level idle state w=
hen
> >> there is a pending IPI on any of cluster CPUs.
> >
> > You seem to be overlooking the fact that resched wakeups need not be
> > signaled via IPIs, but they may be updates of a monitored cache line.
> >
> >> This however does not stop CPU to enter CPU level idle state. Make use=
 of
> >> same at CPUidle to deny the idle entry when there is already IPI pendi=
ng.
> >>
> >> With change observing glmark2 [1] off screen scores improving in the r=
ange
> >> of 25% to 30% on Qualcomm lemans-evk board which is arm64 based having=
 two
> >> clusters each with 4 CPUs.
> >>
> >> [1] https://github.com/glmark2/glmark2
> >>
> >> Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
> >> ---
> >>  drivers/cpuidle/cpuidle.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> >> index c7876e9e024f9076663063ad21cfc69343fdbbe7..c88c0cbf910d6c2c09697e=
6a3ac78c081868c2ad 100644
> >> --- a/drivers/cpuidle/cpuidle.c
> >> +++ b/drivers/cpuidle/cpuidle.c
> >> @@ -224,6 +224,9 @@ noinstr int cpuidle_enter_state(struct cpuidle_dev=
ice *dev,
> >>         bool broadcast =3D !!(target_state->flags & CPUIDLE_FLAG_TIMER=
_STOP);
> >>         ktime_t time_start, time_end;
> >>
> >> +       if (cpus_peek_for_pending_ipi(drv->cpumask))
> >> +               return -EBUSY;
> >> +
> >
> > So what if the driver handles all CPUs in the system and there are
> > many of them (say ~500) and if IPIs occur rarely (because resched
> > events are not IPIs)?
>
> Missed the case of driver handling multiple CPUs,
> In v2 would fix this as below, which checks pending IPI on single
> CPU trying to enter idle.
>
>      if (cpus_peek_for_pending_ipi(cpumask_of(dev->cpu)))

And the for_each_cpu() loop in cpus_peek_for_pending_ipi() would then
become useless overhead, wouldn't ir?

> I see IPIs do occur often, in the glmark2 offscreen case
> mentioned in commit text, out of total ~12.2k IPIs across all 8 CPUs,
> ~9.6k are function call IPIs, ~2k are IRQ work IPIs, ~560 Timer broadcast
> IPIs while rescheduling IPIs are only 82.

So how many of those IPIs actually wake up CPUs from idle prematurely?
