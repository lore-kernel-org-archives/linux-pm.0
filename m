Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799856;
	b=jn+rs+YEFXFSwNETdFfzki9OaoHWB14Y2rgfCAgrK86oygAoP/gb2Shi1PfZWOf78ofO
	 a3I+ytKnqZWRpOoQYGZZZM6poeudFgewAUfNZ0y/8BOxEryo20kPpqRqcwKs8ol3i54Lk
	 Qwqbf3X1Yi2DyOt1T8MsNBU7G1/1tWzRWwhpwir1kyB/Ll/zx36VzjtlUIZLL1AqsOxDp
	 2hhyhivAz1xgznsDQdlsZDeEMIkI9X/AyBVTEcX54Gw2dHFxrI0rZsu+cc5vETBKo+2Zs
	 gT3sSjWKC6FrgQYn3j97vaN/80Ac/hRxr6SglkmSTEOux3tZA0j04lAqTJsdRhOO2Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799856;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cOmIFwTPg4grUFjf5xJohI/b0Te3xOw9Vtme90eUUU0=;
	b=IIEqKSc2RDJ2x5wq+xPVhCH6ooeZb+aauF8hqYw7fdel/+YJkW25910XCgCJY1gHgob2
	 Z8EY8bj2nRdyaclrUGQCUcEhWjMlA6p21M6Irwa8dFFLwL1t3kQo/Mfm+HtbukmssoM2c
	 NNHE/7A659Qagnf2VM0UdTQMfHyXEVzxh/G6E0smObJn5THSkux8OF1ziOegEHaAZSZOw
	 38sx8ZsoVgLJvLmC5/U09Azu9U33PFQ1vtkWAPbUOG6OWDLySXMKDgkGqHo/dQJwQo90A
	 UXxkJd/zQ5z4aVmQf2cx5V64PIyBkb+ucO83Su04kp4W7pzoMJ5yZFmHd1EMrOmFKtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JWVUT4f+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670AB606A328
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 13:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JWVUT4f+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357C91F00A1B
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 13:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793799856;
	bh=cOmIFwTPg4grUFjf5xJohI/b0Te3xOw9Vtme90eUUU0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JWVUT4f+se+Y7fA7L3OjiENsaS44ZlEdSXx74NMgRX0M2y9uQn7XU6cNUf7nseyz5
	 v3VRQZXRSE08/Vqd7vPDKH6iSms9LZclJGueRjHxry+3SfuDh87h/daN7S/wOyaxqR
	 xcvexOhQSqNiM7O07PqqDjeIM5ZFdhvE0/MioF/sQ+rvDHlPI0XJfiOndXsKNLqaaa
	 Afiae1LY2AgVrytxkiNyrhCOzXSncIecub8z7DtgPV/kdMDx0eiIQJ0fUIUOUeIcA8
	 nSxjYNqCoyYuaf6u3cWH03sVLui//K+2hCJ2m4FrRykwtSVp9vxvVb8k29E4xB6kF3
	 tLmy1csKx7yHg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5bcb440d1cbso455833e87.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 05:44:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwazImuXnaXdn2o9AM2zC2pNXl4CEpjFRs2sHKMqpiP+gEgbFsSWk+rKoEUfCqkMP67N1cG7E/8sA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+zi1MXTV9EvulGoN6Nz853jXVM5Zp7S7ZFpVyBdYsMeL130Df/
	Bv+UAJg9tIPY89QQwuuBJDHI/YyLK9RUlUe0jlRywGgUUL2AA1SI6VWDtZgWO8nkUH9tCWtcOH1
	VG3Wt/fwFOFOwlWWGTvGTVXD8oqE1o8I=
X-Received: by 2002:a05:6512:158e:b0:5bf:ec95:41c7 with SMTP id
 2adb3069b0e04-5bfec954566mr1655302e87.1.1793799854623; Wed, 04 Nov 2026
 05:44:14 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <6065833.DvuYhMxLoT@rafael.j.wysocki> <1995295.tdWV9SEqCh@rafael.j.wysocki>
 <f6e8c9b9-3bda-4001-a08e-8484b58575ea@arm.com>
In-Reply-To: <f6e8c9b9-3bda-4001-a08e-8484b58575ea@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 4 Nov 2026 14:44:02 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hQOjNP8tWfyKKV9UPUDSFWFsKVpcc_HZjpi8WHO6p_1Q@mail.gmail.com>
X-Gm-Features: AclHuK9FAqaO9MDkMbRL-tAIwDQUkMs4UEQdRpRXb2V0SBjLYuFw7ingN06NQIE
Message-ID: <CAJZ5v0hQOjNP8tWfyKKV9UPUDSFWFsKVpcc_HZjpi8WHO6p_1Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] cpufreq: Force passing target frequency to driver
 during resume
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Doug Smythies <dsmythies@telus.net>, 
	Zak <zakbrightonknight@gmail.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Mario Limonciello <superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 12:56=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/3/26 19:47, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > The policy->cur value preserved across a system suspend-resume cycle
> > may become stale in some cases and it may prevent the CPU performance
> > scaling logic from being updated due to the target_freq =3D=3D policy->=
cur
> > check in __cpufreq_driver_target() [1].
> >
> > To address this, adjust the existing mechanism to force the invocation
> > of the driver .target() callback in __cpufreq_driver_target() and make
> > cpufreq_resume_policy() use it.
> >
> > This involves renaming update_limits in struct cpufreq_policy to
> > force_target and moving the driver CPUFREQ_NEED_UPDATE_LIMITS flag chec=
k
> > from __cpufreq_driver_target() to cpufreq_set_policy(), where it is use=
d
> > as a condition for setting policy->force_target.
> >
> > In cpufreq_resume_policy(), policy->force_target is set for drivers tha=
t
> > implement the .target() callback, but don't implement the .get() one,
> > which is the case when the driver callback needs to run if policy->cur
> > becomes stale while suspended.
> >
> > Fixes: 2f0aea936360 ("cpufreq: suspend governors on system suspend/hibe=
rnate")
> > Link: https://lore.kernel.org/linux-pm/20261027143725.3763827-1-zakbrig=
htonknight@gmail.com/ [1]
> > Reported-by: Zak Brighton Knight <zakbrightonknight@gmail.com>
> > Reported-by: Doug Smythies <dsmythies@telus.net>
> > Cc: All applicable <stable@vger.kernel.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v1 -> v2:
> >    * Always clear policy->force_target if set in __cpufreq_driver_targe=
t()
> >      to avoid forcing the driver callback next time unnecessarily (Sash=
iko)
> >
> >    * Replace an outdated comment in __cpufreq_driver_target()
> >
> >    * Set policy->force_target only if .target() is present and .get() i=
s not
> >      present because that is the only case in which it may matter
> >
> >    * Update changelog
> >
> > ---
> >  drivers/cpufreq/cpufreq.c |   33 +++++++++++++++++++++------------
> >  include/linux/cpufreq.h   |    4 ++--
> >  2 files changed, 23 insertions(+), 14 deletions(-)
> >
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -2023,6 +2023,15 @@ static void cpufreq_resume_policy(struct
> >       if (!start)
> >               return;
> >
> > +     /*
> > +      * Force executing the driver .target() callback, if present, in =
the
> > +      * next invocation of __cpufreq_driver_target() in case policy->c=
ur has
> > +      * become stale while suspended, but do it only for drivers witho=
ut a
> > +      * .get() callback for which cpufreq_verify_current_freq() is a N=
OP.
> > +      */
> > +     if (cpufreq_driver->target && !cpufreq_driver->get)
> > +             policy->force_target =3D true;
> > +
> >       if (cpufreq_start_governor(policy))
> >               pr_err("%s: Failed to start governor for CPU%u's policy\n=
",
> >                      __func__, policy->cpu);
> > @@ -2400,17 +2409,14 @@ int __cpufreq_driver_target(struct cpufr
> >               policy->cpu, policy->cur, target_freq, old_target_freq, r=
elation);
> >
> >       /*
> > -      * This might look like a redundant call as we are checking it ag=
ain
> > -      * after finding index. But it is left intentionally for cases wh=
ere
> > -      * exactly same freq is called again and so we can save on few fu=
nction
> > -      * calls.
> > +      * Unless invoking the target callback is forced, skip the update=
 if the
> > +      * frequency is not really changing.
> >        */
> > -     if (target_freq =3D=3D policy->cur) {
> > -             if (!(cpufreq_driver->flags & CPUFREQ_NEED_UPDATE_LIMITS)=
 ||
> > -                 !policy->update_limits)
> > -                     return 0;
> > -
> > -             policy->update_limits =3D false;
> > +     if (policy->force_target) {
> > +             /* Avoid forcing the driver callback unnecessarily next t=
ime. */
> > +             policy->force_target =3D false;
> > +     } else if (target_freq =3D=3D policy->cur) {
> > +             return 0;
> >  [snip]
>
> This is too early though? Should be something like:

I don't think so.

If the driver has a problem, there is not much the core can do about it.

Do you have any specific drivers in mind here?

> ---->8-----
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 5f0ddb8823cb..66bc53f13eef 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2398,6 +2398,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *=
policy,
>                             unsigned int relation)
>  {
>         unsigned int old_target_freq =3D target_freq;
> +       int ret;
>
>         if (cpufreq_disabled())
>                 return -ENODEV;
> @@ -2412,12 +2413,8 @@ int __cpufreq_driver_target(struct cpufreq_policy =
*policy,
>          * Unless invoking the target callback is forced, skip the update=
 if the
>          * frequency is not really changing.
>          */
> -       if (policy->force_target) {
> -               /* Avoid forcing the driver callback unnecessarily next t=
ime. */
> -               policy->force_target =3D false;
> -       } else if (target_freq =3D=3D policy->cur) {
> +       if (!policy->force_target && target_freq =3D=3D policy->cur)
>                 return 0;
> -       }
>
>         if (cpufreq_driver->target) {
>                 /*
> @@ -2427,13 +2424,18 @@ int __cpufreq_driver_target(struct cpufreq_policy=
 *policy,
>                 if (!policy->efficiencies_available)
>                         relation &=3D ~CPUFREQ_RELATION_E;
>
> -               return cpufreq_driver->target(policy, target_freq, relati=
on);
> +               ret =3D cpufreq_driver->target(policy, target_freq, relat=
ion);
> +       } else if (cpufreq_driver->target_index) {
> +               ret =3D __target_index(policy, policy->cached_resolved_id=
x);
> +       } else {
> +               return -EINVAL;
>         }
>
> -       if (!cpufreq_driver->target_index)
> -               return -EINVAL;
> +       /* Failed updates still need to be passed to the driver next time=
. */
> +       if (!ret)
> +               policy->force_target =3D false;
>
> -       return __target_index(policy, policy->cached_resolved_idx);
> +       return ret;
>
>
