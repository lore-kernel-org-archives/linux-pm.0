Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ED526056A
	for <linux-pm@vger.kernel.org>; Fri,  1 May 2026 12:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777636845; cv=none; b=b720vUiuSWVWTdkHMqigyDayKe9jcb6qUscVggBgHrFklhQqO1WYsZVH1ma7n7N9RigeGNEoKnu4Ud3C64oMq+H1w8YjZ1jONr1q5zLcDO+RWn+ubDvForihaZtSVthLWnmu4uSiMmZbhPLssfjYAokbDce89sCr9CR0m2WPMZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777636845; c=relaxed/simple;
	bh=Prvv7B0ov4/EhjwbeFDd/isxbU+ETX0Tg1NWb+ujt4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=adZxyyeC58T1V5dMVy1oe3IW7M6nvIcL/lV5DPxEmDsbZ9nXuVuAu+XoJkt+6JboCZ0JH/GFb/gaa36jrdTil1ANbmPaNsqUDLjXyviaLeJJOIh0JuakdX73i592+Z+IJw7VFpdLzrJcvNyYqypclN3nn4TFb2I6Tm+IzE+ihog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DC6M8WON; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DC6M8WON"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD2FC2BCC7
	for <linux-pm@vger.kernel.org>; Fri,  1 May 2026 12:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777636845;
	bh=Prvv7B0ov4/EhjwbeFDd/isxbU+ETX0Tg1NWb+ujt4c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DC6M8WON5YvLORhN4QtI6pjt5reE5F0a+Wa1WMFUuH0ZsAr5ih8+mRJazO/x28+/j
	 ImoTl4LyLMcbz1wKLFNc9UgYiyUhKOkaMGb+FvytX2LwqecmdtG+jdgbC8yNpJPxx2
	 GzESMNHmqxZtUTb3BE87gJHegOpNtceIM33HAYPOJ5s2i0gRzo/dDdILWprKh/ecet
	 uepihGtnJCB2Xt2q5VhEfuYuTrzyMgE3tyBGeotjkfCObc3YrswYP0f1kSjtEV2ka+
	 ENvksu/nE+NHKDinzpaTAdmQqGtJRM+vJPE0XPbe9ZjepBibNHxoLZAmOEyu+3uAXI
	 U9pfsXhb3qeGA==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a2c500750dso3289125e87.1
        for <linux-pm@vger.kernel.org>; Fri, 01 May 2026 05:00:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9N7+DyBeRf/me3y1+S6FEpjm0qJ6hEcHjKzo+pz/h8wnCechWjUSwzTDdExzfvuRgrwPqBuR5TqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYwrZ5f7h+FXQdjDYTre/MX47AV0ss33MObjjB1x3DTFVeiPXp
	9HftCLOefLQntaHO6lD9ctb+3z5TufFL3QWN1VZXCg421cLC4WR9Qrv7CXVsBYbI6XKbqlE4vfm
	PdH83T+kLpA4hrT2m5bbPKPyBHmny6z8=
X-Received: by 2002:a05:6512:1253:b0:5a2:b51a:6a55 with SMTP id
 2adb3069b0e04-5a8522d919emr2916721e87.29.1777636843461; Fri, 01 May 2026
 05:00:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12879883.O9o76ZdvQC@rafael.j.wysocki> <CAGAxtY3h4sEphqKL-jiSn4p0NT9mdZtOFrVxW7CDo22XdL56iw@mail.gmail.com>
 <CAJZ5v0ixuF=AQf0_VcPH=4jo5X-HbEB3WvJAnk8_fZes+bjyLg@mail.gmail.com>
 <12909238.O9o76ZdvQC@rafael.j.wysocki> <CAGAxtY2J3vBJ9oUh1nt1c9ytRE_o=-rwk7nLKuDN==jW2kodbA@mail.gmail.com>
In-Reply-To: <CAGAxtY2J3vBJ9oUh1nt1c9ytRE_o=-rwk7nLKuDN==jW2kodbA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 1 May 2026 14:00:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gX3O5rQ21WedZD8v-hJgBN=U67TwETGNuPquk4u+AhtQ@mail.gmail.com>
X-Gm-Features: AVHnY4LyegHNXIktJOgi8NQ9SuD6HKNF69LprPtSs1OL2JnnuUQxHDKy9ENV8iw
Message-ID: <CAJZ5v0gX3O5rQ21WedZD8v-hJgBN=U67TwETGNuPquk4u+AhtQ@mail.gmail.com>
Subject: Re: Pressing the power button causes the device to freeze completely
 (schedutil involved)
To: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Thorsten Leemhuis <regressions@leemhuis.info>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Wysocki Rafael J <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2026 at 1:18=E2=80=AFAM Evgeny Sagatov <evgeny.sagatov@gmail=
.com> wrote:
>
> Rafael,
>
> I'm leaving on vacation today. I'll be able to conduct new checks
> starting May 17th.

Sure, thanks for the notice!

> Thanks for helping with resolving the issue!

No problem.

> =D1=87=D1=82, 30 =D0=B0=D0=BF=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 17:42, R=
afael J. Wysocki <rafael@kernel.org>:
> >
> > On Thursday, April 30, 2026 3:57:41 PM CEST Rafael J. Wysocki wrote:
> > > On Thu, Apr 30, 2026 at 1:41=E2=80=AFPM Evgeny Sagatov <evgeny.sagato=
v@gmail.com> wrote:
> > > >
> > > > I noticed that for powersave mode, I'm getting the following values=
:
> > >
> > > I guess you mean with the powersave governor.
> > >
> > > > cat /proc/cpuinfo | grep MHz
> > > > cpu MHz         : 2798.689
> > > > cpu MHz         : 1999.659
> > > > cpu MHz         : 1999.797
> > > > cpu MHz         : 2741.103
> > > > Also, there's now no difference in the single-core benchmark betwee=
n
> > > > schedutil, ondemand, powersave and performance modes. The benchmark
> > > > always gives a very high result.
> > > > This wasn't the case before; the modes had different performance le=
vels.
> > >
> > > I would expect schedutil, ondemand and performance to give similar
> > > scores, but for powersave I would expect the score to be lower.
> > >
> > > With the same patch applied, can you please switch over to powersave,
> > > reset the stats and then capture the output of
> > >
> > > grep -r . /sys/devices/system/cpu/cpufreq/
> > >
> > > Also, I'd still like to see the output of
> > >
> > > grep . /sys/firmware/acpi/interrupts/sci*
> >
> > Additionally, please remove all of the debug patches sent so far, apply
> > the one below and send a dmesg boot log.
> >
> > I want to check if all of the CPUs use the same control values when
> > they write to the frequency scaling control register.
> >
> > ---
> >  drivers/cpufreq/acpi-cpufreq.c |   12 +++++++++---
> >  drivers/cpufreq/cpufreq.c      |    1 +
> >  2 files changed, 10 insertions(+), 3 deletions(-)
> >
> > --- a/drivers/cpufreq/acpi-cpufreq.c
> > +++ b/drivers/cpufreq/acpi-cpufreq.c
> > @@ -887,9 +887,14 @@ static int acpi_cpufreq_cpu_init(struct
> >                  * unknown and not detectable via IO ports.
> >                  */
> >                 policy->cur =3D acpi_cpufreq_guess_freq(data, policy->c=
pu);
> > +               pr_info("CPU%u: Using I/O space for frequency scaling\n=
", cpu);
> > +               pr_info("CPU%u: frequency scaling control address: %llu=
, bit width: %u\n",
> > +                       cpu, perf->control_register.address,
> > +                       perf->control_register.bit_width);
> >                 break;
> >         case ACPI_ADR_SPACE_FIXED_HARDWARE:
> >                 acpi_cpufreq_driver.get =3D get_cur_freq_on_cpu;
> > +               pr_info("CPU%u: Using FFH for frequency scaling\n", cpu=
);
> >                 break;
> >         default:
> >                 break;
> > @@ -898,13 +903,14 @@ static int acpi_cpufreq_cpu_init(struct
> >         /* notify BIOS that we exist */
> >         acpi_processor_notify_smm(THIS_MODULE);
> >
> > -       pr_debug("CPU%u - ACPI performance management activated.\n", cp=
u);
> > +       pr_info("CPU%u - ACPI performance management activated.\n", cpu=
);
> >         for (i =3D 0; i < perf->state_count; i++)
> > -               pr_debug("     %cP%d: %d MHz, %d mW, %d uS\n",
> > +               pr_info("     %cP%d: %d MHz, %d mW, %d uS, %u\n",
> >                         (i =3D=3D perf->state ? '*' : ' '), i,
> >                         (u32) perf->states[i].core_frequency,
> >                         (u32) perf->states[i].power,
> > -                       (u32) perf->states[i].transition_latency);
> > +                       (u32) perf->states[i].transition_latency,
> > +                       (u32) perf->states[i].control);
> >
> >         /*
> >          * the first call to ->target() should result in us actually
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -473,6 +473,7 @@ void cpufreq_enable_fast_switch(struct c
> >         if (cpufreq_fast_switch_count >=3D 0) {
> >                 cpufreq_fast_switch_count++;
> >                 policy->fast_switch_enabled =3D true;
> > +               pr_info("CPU%u: Fast frequency switching enabled\n", po=
licy->cpu);
> >         } else {
> >                 pr_warn("CPU%u: Fast frequency switching not enabled\n"=
,
> >                         policy->cpu);
> >
> >
> >
> >
