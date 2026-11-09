Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239682;
	b=q6t+bOeqSuRktMZoWcwqYc5URrswxdTEhkN+U6QA3RTom1K+9pYiEv/ZJXx/gZERUrsZ
	 xe3LwqKozo0uVtgaQEGeHYbekGGdJw8FnNqQ/Ij2TEXNPph0dgZUzFc0Rt3Dptf9yUtMX
	 s/necX6lWaaP3lCApNPHYSuMDORPkRSSF1UyessZ2L/INaT0YFOlx+Y1g6bw0eU/HjMM8
	 IaoExxJ8zYj+MCS6HGkrNc1jEJq02L6KgFtq9PRhU/pAoaE22a/w6cSaVzlQ+DpeKFMJ/
	 SLz+d0l2qX0Ckstj0RfwGJjyOm2vwpolTviK3tvpXOqrF34ZmiWr4nnBZq9zHnhc9pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239682;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+VkAVcjgFq8xZaM7uRYAgPL6bY7r/rKvNqG7d8ZK/lk=;
	b=MGxGWzhGCalkgv/BNarZ1WqV3/Mgenm8CT8d4tEOCvJi6qQTCQ7rwBbMgmWg1I6gOqb6
	 KThwdk26+z2psf3+h0SBHI6IgXi68wUq5pZntMfDDZmydM05+MzQYFH7jtoggWxF+GZE2
	 mcBSdgzt9st5AUj5toyKPULpiiBATYsE/T6XzIRiEXdVCWjETZhsj7H7k5dX+TClpJEGG
	 9TTnFJ/qccYiBJD9Tj4qwmbcUA/M51EQB0tk7Bx7Rv54gVnftmwpubRnU2QhwMWe7uboQ
	 vu/oMAU9+zLNdSJ6bgbUkaak03+hTark+K1dPnsOqGsy0UyYohLtBhNIjECK//P8bng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ebUlOGdu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16800606A325
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ebUlOGdu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DAC1F0089F
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 15:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239681;
	bh=+VkAVcjgFq8xZaM7uRYAgPL6bY7r/rKvNqG7d8ZK/lk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ebUlOGduMKF7qKdEu0T4kGCWDhDnPgCmHqgNT0Vts3paVbU4xEJxwgamIJVz8dUII
	 WKGHKVDjGfSUmXOacWGusuKcmhl5EC4p3/M/IWOpZuKktXpaipcIXVT38YHiouRyxl
	 HNcoCRQiK9jIl2APujkcuQfPM/vA6AFAMBpa2jGau6EhAUCBr6ueHc5LUDCroiXa0O
	 QMN2iEAMktxqCMFEkMXMMzv6918B9jsql3TmJgi0SUKI2d/sQQfsqi2nI2+eSHsoYd
	 XXWRjAcHTCbtmD4a6cV0UtWZ8s/qRjmdTnUxyum/0NP7pz2F1hKSJDSy4GBmixhe5j
	 +2UaDDWq78EgA==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3aced9804e8so8697911fa.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 07:54:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFrIKshaGX7n0HyCNirSKGsKV4M2kgiHrLB6qGfOCt5WADqhN18juBoKrynx86kPLDnfRjLt0fv2w==@vger.kernel.org
X-Gm-Message-State: APuU4Z+oJUkJ6VOlYRsue18hq2AjzGXSYqMoTZB2ydP/hRfyUmH7fecg
	nwNH8BDG7B9uAz+yCgDFHIrqjmZfWa1N0hjp8A3IV7n6r2QT2Z8ZzyBrN54NAPrKMPkvT/9di1b
	WrQjgHvkOh+UBWN8Dg4cSjf8ydqmf7wE=
X-Received: by 2002:a05:651c:150d:b0:3a6:10d4:61c4 with SMTP id
 38308e7fff4ca-3adfa48f107mr11733841fa.28.1794239680276; Mon, 09 Nov 2026
 07:54:40 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106125814.1112331-1-saranya.gopal@intel.com>
In-Reply-To: <20261106125814.1112331-1-saranya.gopal@intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 9 Nov 2026 16:54:26 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jTx2jZ2j3bKCcYxPpWVWtOQu+RWpeV8Zp6mmCt1Ys9iQ@mail.gmail.com>
X-Gm-Features: AclHuK9isenKf0n6872RcaroQP2S1n3PV8buEVL_VTJNfINW60Ut6WFslnN2qOI
Message-ID: <CAJZ5v0jTx2jZ2j3bKCcYxPpWVWtOQu+RWpeV8Zp6mmCt1Ys9iQ@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: s2idle: Handle shared _Ixx GPEs without an EC
To: Saranya Gopal <saranya.gopal@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 1:59=E2=80=AFPM Saranya Gopal <saranya.gopal@intel.c=
om> wrote:
>
> When first_ec is NULL, acpi_ec_dispatch_gpe() previously treated any
> active GPE as a wake source. On platforms where an _Ixx GPE is shared
> by user-wakeup and background events, that can cause unnecessary
> wakeups.
>
> Make acpi_ec_dispatch_gpe() return an int and return -ENODEV when no
> EC instance is available so that acpi_s2idle_wake() can handle that
> case: on x86, treat the first GPE armed for wake via an _Ixx method
> like the EC GPE, mirroring acpi_ec_dispatch_gpe(). That is, report a
> wakeup if the status bit is set for any enabled GPE other than the
> _Ixx one. Otherwise, cancel the SCI-related wakeup and dispatch the
> _Ixx GPE if its status bit is set, so the events behind it can be
> processed. Drivers handling genuine wake events are expected to
> report them via pm_wakeup_event(), which the common s2idle path will
> catch after synchronizing event processing.
>
> If no _Ixx GPEs have been armed, and in the non-x86 fallback, the
> previous any-GPE status check is retained. If GPEs are armed via more
> than one _Ixx method, the first one is used as the wake indicator and
> the remaining ones are treated as regular wake sources.
>
> Fixes: 46767b17fda3 ("ACPI: PM: s2idle: Add _Ixx GPE wake indicator suppo=
rt")
> Signed-off-by: Saranya Gopal <saranya.gopal@intel.com>
> ---
> Changes from v2:
>  - Restructured ret checks in sleep.c as per Rafael's suggestion to
>    cover !CONFIG_ACPI_EC case that returns -EOPNOTSUPP (Sashiko report)
>  - Drop the open-coded scan over acpi_current_gpe_count that conflated
>    sequential GPE indices with raw GPE numbers (Sashiko report)
>  - Mirror acpi_ec_dispatch_gpe() with the first GPE armed via an _Ixx
>    method playing the role of the EC GPE, so the existing single-skip
>    acpi_any_gpe_status_set() is sufficient and no ACPICA changes are
>    needed.
>  - Follow acpi_ec_dispatch_gpe() for the status check and dispatch of
>    the _Ixx GPE as well, which also drops the error paths that
>    requested a system wakeup in v2 (questioned by Rafael).
>  - Add a comment describing acpi_x86_s2idle_check_ixx_gpes(), including
>    the role of pm_system_cancel_wakeup().
>  - Preserve the previous any-GPE behavior when no _Ixx GPEs have been
>    armed for wakeup.
> Changes from v1:
>  - -ENOTSUP replaced with the correct -EOPNOTSUPP for !CONFIG_PM_SLEEP
>    case
>
>  drivers/acpi/ec.c         | 10 +++----
>  drivers/acpi/internal.h   |  6 ++--
>  drivers/acpi/sleep.c      | 11 +++++--
>  drivers/acpi/sleep.h      |  8 +++++
>  drivers/acpi/x86/s2idle.c | 61 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 86 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 64ad4cfa6208..8be572af4115 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -2155,19 +2155,19 @@ static bool acpi_ec_work_in_progress(struct acpi_=
ec *ec)
>         return ec->events_in_progress + ec->queries_in_progress > 0;
>  }
>
> -bool acpi_ec_dispatch_gpe(void)
> +int acpi_ec_dispatch_gpe(void)
>  {
>         bool work_in_progress =3D false;
>
>         if (!first_ec)
> -               return acpi_any_gpe_status_set(U32_MAX);
> +               return -ENODEV;
>
>         /*
>          * Report wakeup if the status bit is set for any enabled GPE oth=
er
>          * than the EC one.
>          */
>         if (acpi_any_gpe_status_set(first_ec->gpe))
> -               return true;
> +               return 1;
>
>         /*
>          * Cancel the SCI wakeup and process all pending events in case t=
here
> @@ -2195,7 +2195,7 @@ bool acpi_ec_dispatch_gpe(void)
>         spin_unlock_irq(&first_ec->lock);
>
>         if (!work_in_progress)
> -               return false;
> +               return 0;
>
>         pm_pr_dbg("ACPI EC GPE dispatched\n");
>
> @@ -2212,7 +2212,7 @@ bool acpi_ec_dispatch_gpe(void)
>                 spin_unlock_irq(&first_ec->lock);
>         } while (work_in_progress && !pm_wakeup_pending());
>
> -       return false;
> +       return 0;
>  }
>  #endif /* CONFIG_PM_SLEEP */
>
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 40f875b265a9..d5435338d6ca 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -236,7 +236,7 @@ void acpi_ec_register_opregions(struct acpi_device *a=
dev);
>
>  #ifdef CONFIG_PM_SLEEP
>  void acpi_ec_flush_work(void);
> -bool acpi_ec_dispatch_gpe(void);
> +int acpi_ec_dispatch_gpe(void);
>  #endif
>
>  #else
> @@ -256,9 +256,9 @@ static inline void acpi_ec_remove_query_handler(struc=
t acpi_ec *ec, u8 query_bit
>  static inline void acpi_ec_register_opregions(struct acpi_device *adev) =
{}
>
>  static inline void acpi_ec_flush_work(void) {}
> -static inline bool acpi_ec_dispatch_gpe(void)
> +static inline int acpi_ec_dispatch_gpe(void)
>  {
> -       return false;
> +       return -EOPNOTSUPP;
>  }
>
>  #endif
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 132a9df98471..09bd661187b6 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -761,6 +761,8 @@ bool acpi_s2idle_wake(void)
>                 return pm_wakeup_pending();
>
>         while (pm_wakeup_pending()) {
> +               int ret;
> +
>                 /*
>                  * If IRQD_WAKEUP_ARMED is set for the SCI at this point,=
 the
>                  * SCI has not triggered while suspended, so bail out (th=
e
> @@ -789,11 +791,16 @@ bool acpi_s2idle_wake(void)
>
>                 /*
>                  * Check non-EC GPE wakeups and if there are none, cancel=
 the
> -                * SCI-related wakeup and dispatch the EC GPE.
> +                * SCI-related wakeup and dispatch the EC GPE.  If there =
is no
> +                * EC to consult, check the GPEs armed for wakeup via _Ix=
x
> +                * methods instead.
>                  */
> -               if (acpi_ec_dispatch_gpe()) {
> +               ret =3D acpi_ec_dispatch_gpe();
> +               if (ret > 0) {
>                         pm_pr_dbg("ACPI non-EC GPE wakeup\n");
>                         return true;
> +               } else if (ret < 0 && acpi_x86_s2idle_check_ixx_gpes()) {
> +                       return true;
>                 }
>
>                 acpi_os_wait_events_complete();
> diff --git a/drivers/acpi/sleep.h b/drivers/acpi/sleep.h
> index 9c3cb109c5d2..955e9c22bf0d 100644
> --- a/drivers/acpi/sleep.h
> +++ b/drivers/acpi/sleep.h
> @@ -20,6 +20,14 @@ extern int acpi_s2idle_prepare(void);
>  extern bool acpi_s2idle_wake(void);
>  extern void acpi_s2idle_restore(void);
>  extern void acpi_s2idle_end(void);
> +#if defined(CONFIG_X86) && defined(CONFIG_SUSPEND)
> +extern bool acpi_x86_s2idle_check_ixx_gpes(void);
> +#else
> +static inline bool acpi_x86_s2idle_check_ixx_gpes(void)
> +{
> +       return acpi_any_gpe_status_set(U32_MAX);
> +}
> +#endif
>
>  extern void acpi_s2idle_setup(void);
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index c278ea14c0b3..b79bf0fa9a7f 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -24,6 +24,13 @@
>
>  #ifdef CONFIG_SUSPEND
>
> +/*
> + * First GPE armed for wake via an _Ixx method, U32_MAX if none.  On
> + * platforms without an ACPI-enumerated EC, this GPE plays the role of
> + * the EC GPE in acpi_ec_dispatch_gpe().
> + */
> +static u32 acpi_s2idle_ixx_gpe =3D U32_MAX;
> +
>  static void acpi_setup_ixx_gpes(void)
>  {
>         acpi_handle gpe_root;
> @@ -47,11 +54,65 @@ static void acpi_setup_ixx_gpes(void)
>
>                 acpi_mark_gpe_for_wake(NULL, i);
>                 acpi_set_gpe_wake_mask(NULL, i, ACPI_GPE_ENABLE);
> +               if (acpi_s2idle_ixx_gpe =3D=3D U32_MAX)
> +                       acpi_s2idle_ixx_gpe =3D i;
>
>                 pm_pr_dbg("ACPI: GPE0x%02x armed for wake via %s\n", i, g=
pe_nr_str);
>         }
>  }
>
> +/*
> + * acpi_x86_s2idle_check_ixx_gpes - Handle an SCI wakeup without an EC
> + *
> + * Called to decide whether or not to wake up the system when an SCI has
> + * triggered during suspend-to-idle on a platform without an EC instance=
,
> + * mirroring acpi_ec_dispatch_gpe() with the first GPE armed for wake vi=
a
> + * an _Ixx method playing the role of the EC GPE.
> + *
> + * Report a wakeup if the status bit is set for any enabled GPE other th=
an
> + * the _Ixx one.  If no _Ixx GPE has been armed, acpi_s2idle_ixx_gpe is
> + * U32_MAX and this amounts to checking all of the GPEs, which is the
> + * previous behavior.
> + *
> + * Otherwise, cancel the pending SCI-related wakeup, so it does not caus=
e
> + * the pm_wakeup_pending() check in the caller to succeed by itself, and
> + * dispatch the _Ixx GPE if it is active, so the events behind it can be
> + * processed.  If any of those events turn out to be genuine wake events=
,
> + * the drivers handling them are expected to call pm_wakeup_event() and
> + * the caller will catch that via pm_wakeup_pending() after synchronizin=
g
> + * the event processing.
> + */
> +bool acpi_x86_s2idle_check_ixx_gpes(void)
> +{
> +       acpi_event_status status =3D 0;
> +
> +       /*
> +        * Report wakeup if the status bit is set for any enabled GPE oth=
er
> +        * than the _Ixx one.
> +        */
> +       if (acpi_any_gpe_status_set(acpi_s2idle_ixx_gpe))
> +               return true;
> +
> +       if (acpi_s2idle_ixx_gpe =3D=3D U32_MAX)
> +               return false;
> +
> +       /*
> +        * Cancel the SCI wakeup and dispatch the _Ixx GPE in case there =
are
> +        * any wakeup events behind it.
> +        */
> +       pm_system_cancel_wakeup();
> +
> +       acpi_get_gpe_status(NULL, acpi_s2idle_ixx_gpe, &status);
> +       if (status & ACPI_EVENT_FLAG_STATUS_SET) {
> +               pm_pr_dbg("ACPI _Ixx GPE 0x%02x dispatched\n",
> +                         acpi_s2idle_ixx_gpe);
> +
> +               acpi_dispatch_gpe(NULL, acpi_s2idle_ixx_gpe);
> +       }
> +
> +       return false;
> +}
> +
>  static bool sleep_no_lps0 __read_mostly;
>  module_param(sleep_no_lps0, bool, 0644);
>  MODULE_PARM_DESC(sleep_no_lps0, "Do not use the special LPS0 device inte=
rface");
> --

Applied as 7.4-rc material, thanks!
