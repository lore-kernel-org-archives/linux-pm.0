Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A5642252D
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 13:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784207013; cv=none; b=IuuYMUGc+5qRVxsZaKeSt38JP9Nqbh789D7fnZk8cknuMV4AVw1B615dOvE+wl2jFGG+op91T4yzAfLG1gRIJAQr7oq8vJI/IXwyCZ1zO4jAFPHpZPrs79xyDsWnO1uUJErUtLOwhUVa5s9k/aDqTqioZ5WTMAgdH/wGDpNv+vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784207013; c=relaxed/simple;
	bh=YPjqidtkkpeQ9gNuBdGeFA9gTmj8itr4O3fScixI8xM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYdTGU/doxyoPVwjd1D0dfK1IsAaYCdv3y7uRYxHhD8lzYF3we03qAAcCg6k3cKQykJW5JZ6ZhO7ApSg74zfQRisZRbHhOM7rl+C19cjeAwo5F2WOMHSRdcXot9bQ3cfWneLN3EJU0bbNzhjv1dmz2w/EhPwmNKZt9qHJhpUi4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPrxgn2G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPrxgn2G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B541F000E9
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 13:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784207012;
	bh=N+CMXCJgK9VDtfpWZPtOzpZ5bvjpa0aUfqmfLq0j3dw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NPrxgn2GQdMkUWxKmi1296XlzfKShHGcsxoFO9u+8Pkkm3pfuWy0HUmOWCc9S3V1R
	 SlGzYJ4w03r22xw6pvlh6i0SmWtC9dmxk5ZzpUAmBXVMvzxaUiHu9UW2AAYfu0/8Kt
	 GImK7phIIWJ+zIsL/a3S7IszN2/ryJvpGKA+gICJqdpvH9l2dpxDj2eoDPbUT1Q3yO
	 L8hNOCAaWzX7VfYkIhZtFMeMgg1jY07RdxmNCBiSO/f8wT9XZcR9CySbhl+urX1T5e
	 FQuEa51LuTcs1Q4pRFyZVk4BzgU36la6PSTPg8Jjx7JPZppxmoKlBZ0NMJvBj5r9lC
	 rjWN4nEuBlQ5g==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b015532f7bso7039170e87.0
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 06:03:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpdA2Iha2UFCIQSE0t5I8qFSb4KVmLOtJclIsMROg5Oml0WZAsRw0seCyrFptptVey1tY25dmCXVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YywWUxNTXTdKo51vZC2/jN+89PvfWnYqVPILdW0JpAaztuG7ztX
	TRJircliQD8E5b5+jB+dnobNJ8XYWIsQRw1kjbSmfMZYLtVfbFzcZChjGucEMmBo7mAr4fhQuek
	TT+gPgMXYg/P4KK/i7hCsRoaAgz9lmBE=
X-Received: by 2002:a19:f515:0:b0:5b0:7766:54d1 with SMTP id
 2adb3069b0e04-5b15d78a414mr1122405e87.27.1784207010415; Thu, 16 Jul 2026
 06:03:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4746278.LvFx2qVVIh@rafael.j.wysocki> <3703077.iIbC2pHGDl@rafael.j.wysocki>
 <db010283-a568-4683-a880-53c0b27f8a8c@huawei.com>
In-Reply-To: <db010283-a568-4683-a880-53c0b27f8a8c@huawei.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 16 Jul 2026 15:03:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i3W-+DQeo9Of71_keS-gH=DvUEANYPh7mLh8+OzjgDrw@mail.gmail.com>
X-Gm-Features: AUfX_mwyigjgc7Upayrh5gDq7t6WwEbwxS2VT8AN76pACrRJbyaqDhmoLLXTTCQ
Message-ID: <CAJZ5v0i3W-+DQeo9Of71_keS-gH=DvUEANYPh7mLh8+OzjgDrw@mail.gmail.com>
Subject: Re: [PATCH v1 08/17] ACPI: processor: idle: Rework first-level _LPI
 states processing
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 2:44=E2=80=AFPM lihuisong (C) <lihuisong@huawei.com=
> wrote:
>
>
> On 7/9/2026 8:37 PM, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > The first-level _LPI states need not be combined with the previous
> > level and the entry method for them cannot be ACPI_CSTATE_INTEGER, so
> > process them directly in acpi_processor_get_lpi_info() instead of doing
> > a special case for them in flatten_lpi_states().
> >
> > Also bail out if there are no _LPI states at the first level because
> > that means that there are no _LPI states at all.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/acpi/processor_idle.c | 47 +++++++++++++++++++++++++++-------=
-
> >   1 file changed, 37 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idl=
e.c
> > index e990a43514e6..efd3e76377fa 100644
> > --- a/drivers/acpi/processor_idle.c
> > +++ b/drivers/acpi/processor_idle.c
> > @@ -1068,13 +1068,6 @@ static unsigned int flatten_lpi_states(struct ac=
pi_processor *pr,
> >
> >               flpi =3D &pr->power.lpi_states[flat_state_cnt];
> >
> > -             if (!prev_level) { /* leaf/processor node */
> > -                     memcpy(flpi, t, sizeof(*t));
> > -                     stash_composite_state(curr_level, flpi);
> > -                     flat_state_cnt++;
> > -                     continue;
> > -             }
> > -
> >               for (i =3D 0; i < prev_level->composite_states_size; i++)=
 {
> >                       p =3D prev_level->composite_states[i];
> >                       if (t->index <=3D p->enable_parent_state &&
> > @@ -1101,9 +1094,10 @@ static int acpi_processor_get_lpi_info(struct ac=
pi_processor *pr)
> >   {
> >       struct acpi_lpi_states_array info[2], *prev, *curr;
> >       acpi_handle handle =3D pr->handle;
> > -     unsigned int state_count;
> > +     unsigned int state_count =3D 0;
> >       acpi_status status;
> > -     int ret, i;
> > +     unsigned int i;
> > +     int ret;
> >
> >       /* make sure our architecture has support */
> >       ret =3D acpi_processor_ffh_lpi_probe(pr->id);
> > @@ -1117,12 +1111,45 @@ static int acpi_processor_get_lpi_info(struct a=
cpi_processor *pr)
> >               return -EINVAL;
> >
> >       curr =3D &info[0];
> > +     curr->composite_states_size =3D 0;
> >
> >       ret =3D acpi_processor_evaluate_lpi(handle, curr);
> >       if (ret)
> >               return ret;
> >
> > -     state_count =3D flatten_lpi_states(pr, 0, curr, NULL);
> > +     /* Copy all of the usable first-level states to power.lpi_states[=
]. */
> > +     for (i =3D 0; i < curr->size; i++) {
> > +             struct acpi_lpi_state *lpi =3D &curr->entries[i];
> > +             struct acpi_lpi_state *flpi;
> > +
> > +             /*
> > +              * Skip states that are not enabled or have an inadequate=
 entry
> > +              * method for this level.
> > +              */
> > +             if (!(lpi->flags & ACPI_LPI_STATE_FLAGS_ENABLED) ||
> > +                 lpi->entry_method =3D=3D ACPI_CSTATE_INTEGER)
> > +                     continue;
> > +
> > +             if (state_count >=3D ACPI_PROCESSOR_MAX_POWER) {
> > +                     acpi_handle_info(handle,
> > +                                      "No space for more _LPI states t=
han %d\n",
> > +                                      ACPI_PROCESSOR_MAX_POWER);
> > +                     break;
> > +             }
> > +
> > +             flpi =3D &pr->power.lpi_states[state_count++];
> > +             memcpy(flpi, lpi, sizeof(*lpi));
> > +             stash_composite_state(curr, flpi);
> > +     }
> > +
> > +     kfree(curr->entries);
> > +
> > +     /*
> > +      * If there are no _LPI states at the first level, there are no _=
LPI
> > +      * states at all.
> > +      */
> > +     if (!state_count)
> > +             return -ENODATA;
> >
> The code is easier to understand after this rework.
> But the "first level" is not good to me.
> IIUC, the first level is processor, right?

It is, so I can replace "first" with "CPU" easily enough here when
applying the patch.

> In addition, how about extract a function, like,
> flatten_processor_lpi_states, for these codes?

That can be done on top of this series and the CPU-level states are
not really flattened, so the name would need to be different.

Thanks!
