Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F75833FE15
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035582; cv=none; b=OREg+gR9P0lKCEblNGEOeFFmMl2Qlwpss3GAV5mEpWKXm6hO5enWrPNtLznkt9TC7HkMhir+DC1r/on1DJqc5N1YUAtnpOgMs3RUqnxF61tEWuo+eQSfKIN0B+mp3r4rHHVyUPIAsgQcSEZ9HSTNUMXmkssNhtYNQ7XNVDLsIjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035582; c=relaxed/simple;
	bh=IbxqA5kI8UVWYKqQ6XdJ2Za06O/jAjIjAj1D4EYFRFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTl0Q3B90PoJ4r9CFcoZTt5vuFSi26I+4ssSLfzzCykMEjz3S5kEFV5oBzOpPgeah5H4ATiPMCgwrmQsqzYP0WHTEEiCQBp6BiH/UW298cy4nEIEfuCygcGIkc1viuNYFHOQKXEjbts9hHjqft1+JGoF4WSvbaAdXv7J7sOp96E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLCXNwpJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLCXNwpJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128381F00A3E
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 13:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784035578;
	bh=lBHocEz/NlJmbo2Tn1hjIcEfq+hyYKUksKMIHrzslk0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BLCXNwpJlJt8I8UMqgfA5zm04seOGZkvGyZnIF/oW6VjkUROgv7DA8OS02wo9K3oi
	 jZbLh/PQ14vTEcXIlOftHwt6G6mSw+Wz7p6paWBFZg0maY/0xahnhrO2T4RifUmCYO
	 7ab8bxezASevRxVs1zksILy7+AFQTkCeSY90NNDI7/P5BnqiA7ncNAgIs0JLDm1AYd
	 6UazhOS6/4IUJr4MLKk9rSBSGkA0NhSJOnHKyNIwNSRFseSzH9p1U6LLOZ6mT1hC3h
	 T9Wtg+7DjpdcTMmEnaOboeagwBB8Noje2jRA/TAlXJGa+jApSTTy6iq8c2ixrw5T26
	 rshF0fGPF1m3Q==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aebd52488cso4627436e87.2
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 06:26:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqdO9EUqyLl5NYmUNzH7oQGFMayC+73FBzZDwFjT/6pdHKeqP6VSY2ICJBk8qI3T3dsdXpWWTyY3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnoC5KZwZlIadsf07o24J3XiMF3rKp7WJzG1x7/PSrspOlC67o
	7Z7IhoPhWlm6wF8ijsO+PvcyFU/BTiJDdt0SiQDTlQLH8V1B5JiztgL+BuaAAkZZcVcNPgUloz7
	WOnkSBuN5fHA5mytwUVtVHBZv315d4YQ=
X-Received: by 2002:a05:6512:ace:b0:5ae:b584:561c with SMTP id
 2adb3069b0e04-5b0236c689dmr3112183e87.62.1784035576434; Tue, 14 Jul 2026
 06:26:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4746278.LvFx2qVVIh@rafael.j.wysocki> <2280567.Icojqenx9y@rafael.j.wysocki>
 <20260713-aquatic-okapi-of-wind-9e657c@sudeepholla>
In-Reply-To: <20260713-aquatic-okapi-of-wind-9e657c@sudeepholla>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 14 Jul 2026 15:25:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0heUWyDy7jpt2M3s+b_ir7q5KgUjrf_Ga817GfWoC6DsQ@mail.gmail.com>
X-Gm-Features: AUfX_mzhIi96WL4hqFJy-bZzkY_623RqUQzDt0htGgnd_HR86krRSfcWZJJAnt0
Message-ID: <CAJZ5v0heUWyDy7jpt2M3s+b_ir7q5KgUjrf_Ga817GfWoC6DsQ@mail.gmail.com>
Subject: Re: [PATCH v1 17/17] intel_idle: Add ACPI _LPI support
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 4:56=E2=80=AFPM Sudeep Holla <sudeep.holla@kernel.o=
rg> wrote:
>
> On Thu, Jul 09, 2026 at 02:44:23PM +0200, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > Allow intel_idle to use idle states information coming from ACPI _LPI
> > objects by making it call acpi_processor_extract_lpi_info() and, if
> > that is successful, using the list of idle states produced by that
> > function instead of the one coming from acpi_processor_evaluate_cst().
> >
>
> May be it is lack of my knowledge. I always assumed intel_idle is fine
> tuned with for specific intel cores. But now if the information is being
> fetched from _LPI, what is the difference between intel_idle driver
> and ACPI processor idle if the FFH backend can be MWAIT.

The usage of _LPI in intel_idle is based on the same principle as the
usage of _CST in it:

 - There are processor models for which intel_idle doesn't include
built-in tables of idle states and it is still desirable to use
intel_idle as the cpuidle driver on them (mostly so that users don't
need to deal with two different drivers for platforms based on Intel
hardware).

 - Even if there is a built-in table of idle states for the given
processor model in intel_idle, an OEM may want to prevent certain idle
states from being utilized by avoiding exposing them via ACPI.  In
those cases, intel_idle can validate its built-in table against the
one coming from ACPI (either _CST or _LPI).

Generally speaking, intel_idle is regarded as a one-stop-shop for
Intel processors as far as cpuidle is concerned.

> Couple of more questions below, all just for my understanding and it
> doesn't add as a review comment.

Sure.

> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/idle/intel_idle.c | 160 ++++++++++++++++++++++++++++++++------
> >  1 file changed, 138 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> > index fedaa8142121..bcc2725769c5 100644
> > --- a/drivers/idle/intel_idle.c
> > +++ b/drivers/idle/intel_idle.c
> > @@ -1779,6 +1779,7 @@ module_param_named(no_native, no_native, bool, 04=
44);
> >  MODULE_PARM_DESC(no_native, "Ignore cpu specific (native) idle states =
in lieu of ACPI idle states");
> >
> >  static struct acpi_processor_power acpi_state_table __initdata;
> > +static bool acpi_lpi_available __initdata;
> >
> >  /**
> >   * intel_idle_cst_usable - Check if the _CST information can be used.
> > @@ -1803,18 +1804,37 @@ static bool __init intel_idle_cst_usable(void)
> >       return true;
> >  }
> >
> > -static bool __init intel_idle_acpi_cst_extract(void)
> > +static bool __init intel_idle_acpi_extract_lpi_cstates(void)
> >  {
> >       unsigned int cpu;
> >
> > -     if (no_acpi) {
> > -             pr_debug("Not allowed to use ACPI _CST\n");
> > -             return false;
> > +     for_each_possible_cpu(cpu) {
> > +             struct acpi_processor *pr;
> > +
> > +             pr =3D per_cpu(processors, cpu);
> > +             if (!pr)
> > +                     continue;
> > +
> > +             if (acpi_processor_extract_lpi_info(pr->handle,
> > +                                                 &acpi_state_table, tr=
ue))
> > +                     continue;
> > +
> > +             acpi_lpi_available =3D true;
> > +             return true;
>
> On the first CPU for which acpi_processor_extract_lpi_info() returns 0,
> it sets acpi_lpi_available and immediately returns true.
>
> Consequently, one CPU=E2=80=99s _LPI data populates the global acpi_state=
_table,
> which initializes the single intel_idle_driver. Remaining CPUs are neithe=
r
> queried nor compared which is fine IIUC on x86. But then the questions is
> why does this needs to be in a loop as you? Can't it be just the boot CPU
> for instance.

It could, but what if _LPI is not present for the boot CPU?

This basically follows the _CST usage pattern.

> >       }
> >
> > +     pr_debug("No ACPI _LPI idle states\n");
> > +     return false;
> > +}
> > +
> > +static bool __init intel_idle_acpi_extract_cst_cstates(void)
> > +{
> > +     unsigned int cpu;
> > +
> >       for_each_possible_cpu(cpu) {
> > -             struct acpi_processor *pr =3D per_cpu(processors, cpu);
> > +             struct acpi_processor *pr;
> >
> > +             pr =3D per_cpu(processors, cpu);
> >               if (!pr)
> >                       continue;
> >
> > @@ -1826,14 +1846,36 @@ static bool __init intel_idle_acpi_cst_extract(=
void)
> >               if (!intel_idle_cst_usable())
> >                       continue;
> >
> > -             if (!acpi_processor_claim_cst_control())
> > -                     break;
> > +             return true;
> > +     }
> > +
> > +     pr_debug("ACPI _CST not found or not usable\n");
> > +     return false;
> > +}
> >
> > +static bool __init intel_idle_acpi_extract_cstates(void)
> > +{
> > +     if (intel_idle_acpi_extract_lpi_cstates())
> > +             return true;
> > +
> > +     if (intel_idle_acpi_extract_cst_cstates())
> >               return true;
> > +
> > +     return false;
> > +}
> > +
> > +static bool __init intel_idle_acpi_probe(void)
> > +{
> > +     if (no_acpi) {
> > +             pr_debug("Not allowed to use ACPI for C-states extraction=
\n");
> > +             return false;
> >       }
> >
>
> The intel_idle documentation and module parameter descriptions should be
> updated to reflect _LPI support IMO.
>
> Documentation/admin-guide/pm/intel_idle.rst should no longer imply that
> intel_idle only looks for _CST or only uses _CST-derived state
> names/construction rules.

Definitely a good point, but I'm planning to do a documentation update
when the code changes have been queued up to avoid updating the
documentation multiple times.

So there will be a separate patch for a documentation update.

Thanks so much for all of the reviews!
