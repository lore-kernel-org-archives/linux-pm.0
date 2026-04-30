Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82723BF699
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 23:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777591085; cv=pass; b=NJhgQfubosuCzal/9axWyo0gFQGx2n7nEJgUlsrWVeuJ5uhvx+xTgtgtB5s9SvFpNFxZ82Ua9RsluSSy0W6pmBwnZ0FOEHl1ilCT69U6LepIiGBV8d2SrvoF1AbKdANt2abUgQIVQQadC5MlrO0TnBOALVYnupBYfFC1AbD89Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777591085; c=relaxed/simple;
	bh=qMssuPB08Ftixa7cUXrksbDoBvMFkJHrhq6Zs/nyBnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3LeDhbx++nTlbuDQNHj7kirD8wUSZjpmOGZSxk384U1J7gNj/EsTbmIfX3u+LPflOhdb+O+Yh0W/31aSI5hX2DkKsA+j7dhA3RzUdvLjLLGPWnBQlm26fzThy2JuEn0dM0ATYv5Eb06tAsOU+rrsXCQlhoSzCoXRzlMyPW0/k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGvMF6X7; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGvMF6X7"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bbe539fc355so72192466b.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 16:18:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777591080; cv=none;
        d=google.com; s=arc-20240605;
        b=DfI4WNvQVIb7m81IGcLdDQ/qk+hSQuiIGpubBX8a8cmZBre1au7kcUfWcw7MeNF1xL
         NhGouk4AwTOkIfuUxtbR5iHhHdQrc+2t5bONMM7+PJptuoXbWX1uGiYsPmOfN1pgr+fj
         wa3X6rU0oxN6Q9srh7h0S+cttelEzEQKONDnXA64Bah8F+bfdwF5tHbwyE0t4ihBZSE/
         HDZUBDi+t3Y11FsNDuMIO/tZ6MGUZGXH9LrNbGZWSUVrVAFUGoQ+IvgqD1XLHao53U3O
         5JH2Z/tS6McHYx8qG9eKT8215dDlC23Gcl1liCd5f6XNG2Gnvfq1CzYjHm+Wk1mkmIc4
         6gxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wr4f/O6tnwowWz0YOGfaBNk5o8gSqrjyXSQ8QIaml/8=;
        fh=RtFMC19aEUn0JyZpCq8AYI0pcq6vwj3rVuqdJzWVrbo=;
        b=Uun9UApa6B0Zat7RYIryzbxX1XIXSxMoSZttLeJ5uWN0FAgkHVUT1xZWP3UvzyFbMi
         fsPMnJxzvBeWUkX3HStChUcKp8Ocb+p6+HwmS8kzDQwwfDD+wS9cv0HRz2SIB00zw5rz
         8Sqsvgm+66kJyLOtTXPb3v6D39hc6L3qlzfsuBInGCzZoc70cPpLiGFRVbLqZHW7nAn1
         AlpqMbpXiqtXN2i/TwtaHG+5U0cnm4M6Fvs36hySeAKM3mr+u9KFuXVHmd0gnNPmwF27
         VlNoA9Fq/vxuHSnCCegbZp5e+Wl8QrHIPj3SDy0zVpnHq1pHAEonsrQzBzmk0/1pKwFw
         4TKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777591080; x=1778195880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wr4f/O6tnwowWz0YOGfaBNk5o8gSqrjyXSQ8QIaml/8=;
        b=PGvMF6X7BnyJBp+WQjPOkm6JwqAIQbmHj2iWmHVxxnkvzM5mAmsjNVJaIW+7uJ+Q+n
         COza2Ga4wvqoOXF8eI/807nP4cfcuxfnHCNxSGVQ9fXDWki3Sh5AUV6VThlWh/QkKyQO
         AFsLlZyFcphGA/TN6KXZqzweDHx+m3r9NmRJTBnq2oOnV+jjcbdvlof6p1nCRUV/FuIC
         3lTHA0ZZTp1I0vngnkQQ/JvtEZgkn07K/fc9nHOw7jxmjE7y2eZfC6BrtEXiFLSKkui3
         U2f9ba0cSe3sez+1M9UwBX6+OVbl8KGIn0T6a61UX6AkHJ8ilUjGvPMdL2wIemJcawFg
         6C4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777591080; x=1778195880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wr4f/O6tnwowWz0YOGfaBNk5o8gSqrjyXSQ8QIaml/8=;
        b=XbEazH1axqbngEUusYJ4jaZ6bi1zngpoECj+eGT++ZiUDB3CQITl0bD+Mc2MG9y79j
         BnGfc9catwtUqxsZNIx8IUS7Pdg4xY3bJURMMmCiCXwsA1dsrJMtui12dFh7A+Hae9JY
         HJxy3r5yOqMtib9RryuYOaWJyMcy3OLLdtZzbfxxtGY0BYtzJuxuFkMBpPirZ79g8xRL
         WpBzSN1R3NFzijD8kJ3ZZUHSG/msqxaP+6luNpRE4LfrVkpAR57XrQgw2A18XhMY59SF
         PlUoWBN9zLWgxmqpPRH2amMXAmT1vTLqFmkDo3AtZV8OX85iS0fkp05yZTJ/2A18gfFO
         C6HQ==
X-Forwarded-Encrypted: i=1; AFNElJ+H3TYX085MWo6gvFcImho0sY/CYLDppQejM7iE8/MQz+NJm1av3Q3qeioKReKolGEBMYxzNZJBig==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBafGB56juttSJbMgnQ84lQDBRx8TTaGbDxu+4jFN0Kh3RJnKX
	35vEv8yDemoifUgh4r/PFtNU5fvxK3O7cHfnfo7zNyDECGHE9o8g3749QL7SaPWZYfraQvH7x47
	O2yiE/pIIR4R4o7QjUAYnOVylDYW4ASY=
X-Gm-Gg: AeBDievTzoSymbMDRYsnbCvYaWv/DS7bBRhzbMrqU8V5PcrUNhJcjZw4LONIPlZ5WZ9
	aGGC7v82WuuC7qsnvL4o65AmDtcIqHpHQzj833G8/+7s+fe7EfJvNtqxvu+MjW1gy35rWz7fAY6
	msVqfXdqCQ7VYjsQD7LMb5cHDy/1XBBgfiFZgIAM2GyUgPbd7UtXwncOzqcmTHUtJaSOcsyA2K0
	2BFg0Ez29pOIce3YQdEWo2KsO84UrYTBTQplarbGMJKVClUWYvs6AHvsN9FbJrjaP2EzrGv4cA2
	osQs4unAHTNUcnFYFg==
X-Received: by 2002:a17:907:3e82:b0:ba7:e65:a5f0 with SMTP id
 a640c23a62f3a-bbebe614a46mr27887066b.5.1777591080209; Thu, 30 Apr 2026
 16:18:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12879883.O9o76ZdvQC@rafael.j.wysocki> <CAGAxtY3h4sEphqKL-jiSn4p0NT9mdZtOFrVxW7CDo22XdL56iw@mail.gmail.com>
 <CAJZ5v0ixuF=AQf0_VcPH=4jo5X-HbEB3WvJAnk8_fZes+bjyLg@mail.gmail.com> <12909238.O9o76ZdvQC@rafael.j.wysocki>
In-Reply-To: <12909238.O9o76ZdvQC@rafael.j.wysocki>
From: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Date: Fri, 1 May 2026 02:17:48 +0300
X-Gm-Features: AVHnY4Jqj25Kx5PBJv7oNLRVP3qU3f7s4xB1XbA1jZxGD5_AcSNv8SeOCrXOIeU
Message-ID: <CAGAxtY2J3vBJ9oUh1nt1c9ytRE_o=-rwk7nLKuDN==jW2kodbA@mail.gmail.com>
Subject: Re: Pressing the power button causes the device to freeze completely
 (schedutil involved)
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Thorsten Leemhuis <regressions@leemhuis.info>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Wysocki Rafael J <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Rafael,

I'm leaving on vacation today. I'll be able to conduct new checks
starting May 17th.

Thanks for helping with resolving the issue!

=D1=87=D1=82, 30 =D0=B0=D0=BF=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 17:42, Raf=
ael J. Wysocki <rafael@kernel.org>:
>
> On Thursday, April 30, 2026 3:57:41 PM CEST Rafael J. Wysocki wrote:
> > On Thu, Apr 30, 2026 at 1:41=E2=80=AFPM Evgeny Sagatov <evgeny.sagatov@=
gmail.com> wrote:
> > >
> > > I noticed that for powersave mode, I'm getting the following values:
> >
> > I guess you mean with the powersave governor.
> >
> > > cat /proc/cpuinfo | grep MHz
> > > cpu MHz         : 2798.689
> > > cpu MHz         : 1999.659
> > > cpu MHz         : 1999.797
> > > cpu MHz         : 2741.103
> > > Also, there's now no difference in the single-core benchmark between
> > > schedutil, ondemand, powersave and performance modes. The benchmark
> > > always gives a very high result.
> > > This wasn't the case before; the modes had different performance leve=
ls.
> >
> > I would expect schedutil, ondemand and performance to give similar
> > scores, but for powersave I would expect the score to be lower.
> >
> > With the same patch applied, can you please switch over to powersave,
> > reset the stats and then capture the output of
> >
> > grep -r . /sys/devices/system/cpu/cpufreq/
> >
> > Also, I'd still like to see the output of
> >
> > grep . /sys/firmware/acpi/interrupts/sci*
>
> Additionally, please remove all of the debug patches sent so far, apply
> the one below and send a dmesg boot log.
>
> I want to check if all of the CPUs use the same control values when
> they write to the frequency scaling control register.
>
> ---
>  drivers/cpufreq/acpi-cpufreq.c |   12 +++++++++---
>  drivers/cpufreq/cpufreq.c      |    1 +
>  2 files changed, 10 insertions(+), 3 deletions(-)
>
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -887,9 +887,14 @@ static int acpi_cpufreq_cpu_init(struct
>                  * unknown and not detectable via IO ports.
>                  */
>                 policy->cur =3D acpi_cpufreq_guess_freq(data, policy->cpu=
);
> +               pr_info("CPU%u: Using I/O space for frequency scaling\n",=
 cpu);
> +               pr_info("CPU%u: frequency scaling control address: %llu, =
bit width: %u\n",
> +                       cpu, perf->control_register.address,
> +                       perf->control_register.bit_width);
>                 break;
>         case ACPI_ADR_SPACE_FIXED_HARDWARE:
>                 acpi_cpufreq_driver.get =3D get_cur_freq_on_cpu;
> +               pr_info("CPU%u: Using FFH for frequency scaling\n", cpu);
>                 break;
>         default:
>                 break;
> @@ -898,13 +903,14 @@ static int acpi_cpufreq_cpu_init(struct
>         /* notify BIOS that we exist */
>         acpi_processor_notify_smm(THIS_MODULE);
>
> -       pr_debug("CPU%u - ACPI performance management activated.\n", cpu)=
;
> +       pr_info("CPU%u - ACPI performance management activated.\n", cpu);
>         for (i =3D 0; i < perf->state_count; i++)
> -               pr_debug("     %cP%d: %d MHz, %d mW, %d uS\n",
> +               pr_info("     %cP%d: %d MHz, %d mW, %d uS, %u\n",
>                         (i =3D=3D perf->state ? '*' : ' '), i,
>                         (u32) perf->states[i].core_frequency,
>                         (u32) perf->states[i].power,
> -                       (u32) perf->states[i].transition_latency);
> +                       (u32) perf->states[i].transition_latency,
> +                       (u32) perf->states[i].control);
>
>         /*
>          * the first call to ->target() should result in us actually
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -473,6 +473,7 @@ void cpufreq_enable_fast_switch(struct c
>         if (cpufreq_fast_switch_count >=3D 0) {
>                 cpufreq_fast_switch_count++;
>                 policy->fast_switch_enabled =3D true;
> +               pr_info("CPU%u: Fast frequency switching enabled\n", poli=
cy->cpu);
>         } else {
>                 pr_warn("CPU%u: Fast frequency switching not enabled\n",
>                         policy->cpu);
>
>
>
>
