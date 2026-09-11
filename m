Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0F5489875
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134277; cv=none; b=i7rKszRsYzPsjEhJJMzjCTdTuczShAgAD6vW6apgz9BWu18IzSzeKFRamNlTl6YLWR2HP1BjgvpssA4MA8XKB0HGOO2K+EH8WWAjPyWNKnTwMxS8ekzYG43rTFUTc4cM+KIgSst5u7RZBPNxU24eFkyJQAhGOhonILEYpdv1na4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134277; c=relaxed/simple;
	bh=3BVualpps+oIITm7i2WMlfGh/e2l+lFc/2FBvui2N5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Met+fbcBPwZmsMs+mfh9ZMr9+v3sA+bi8o3xHk8V/koHOS3pwDPGTZIqP0c8Yf3Kprr6xNrhMl8kSagnWJBxqtvS6FmMtj7Nc3tGOwm9iZQa8zP33H6CWNq3RpYOwm55rKmI2rWtAjjqM2WKt7HInK202nZvmtMOx12dLmRmTUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hog+6Al+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hog+6Al+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB7D1F0089E
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 13:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789134274;
	bh=sedARVedgr2SQmPDtAqiMO2lPnvh5+Bf7fKQKIpyce8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Hog+6Al+m2ynPcygfNNvzNEFZjpIGD6YLW6G1ycbkz6aKDS8PqYJ+/wt8DMDJmZDI
	 BXeheHB14o0owH0ik6FcQeW5hlxB+XZHofQRbCc1RVZcTVDmkwtixw/Sy2b4GVnDKQ
	 Uyg/GIaQTklT7P9vdtRZmlurE0dsBqvbHU63O1bvh+u9j3yEjXSKodehK4PBy41deD
	 YDnfkbJi+5wib4HW8hT4vjhdtVWkzKPvVkCk5zE7zOy3OdKalVM/A+zU9/b0V4fPgT
	 roeS5wHxaEJZHsdaV11XJg3Qd49yC0k4jQpOgpqh+tUpF300P5Osyxsd9ZwTdd69EP
	 p+0cpd1fk+3Fw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b4ae0b3308so745277e87.3
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 06:44:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwv5K87YQMrNMPNiYEbQCkGa4o+ZKV2OpEZDssUBYtnhDujOhHF5Hp4RAzNfXX38bP159SlpBZqOA==@vger.kernel.org
X-Gm-Message-State: AFuF++nR2Y2SU6PchhHm0Epd8gg/KxdjoWxeIz6yF29Sh/PL3Mj3UoyT
	lUKJ8LDVuFAbstQVvfZSbzncrcEAzegLXWPdOv1MMzmLuouuSHNSInU3eT6XVGoz17YkL24BlNy
	vm9vkXOZmPQ4HThdvub9KRvxmww31v/Y=
X-Received: by 2002:a05:6512:128f:b0:5b6:4b2:c799 with SMTP id
 2adb3069b0e04-5b8a030bc40mr954978e87.33.1789134272444; Fri, 11 Sep 2026
 06:44:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822114236.15998-1-sumeet4linux@gmail.com> <3284bfcb-2dd9-4ca2-be08-c7ecc7571695@arm.com>
In-Reply-To: <3284bfcb-2dd9-4ca2-be08-c7ecc7571695@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 11 Sep 2026 15:43:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hTuf4KUtvk-0Y=v9VRxmzXUSrWoHaVkUJ5vdH3Ky7mfg@mail.gmail.com>
X-Gm-Features: AcwNN1W0GlW5XPUi4nY8aveNtvYi2rIsY6zXw9RfCAj1t2_Bbcldgarak0FIVJ8
Message-ID: <CAJZ5v0hTuf4KUtvk-0Y=v9VRxmzXUSrWoHaVkUJ5vdH3Ky7mfg@mail.gmail.com>
Subject: Re: [PATCH] thermal: gov_power_allocator: Fix NULL pointer
 dereference in update_tz()
To: Lukasz Luba <lukasz.luba@arm.com>, Sumeet Pawnikar <sumeet4linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rui.zhang@intel.com, daniel.lezcano@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 9:51=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> wr=
ote:
>
>
>
> On 8/22/26 12:42, Sumeet Pawnikar wrote:
> > power_allocator_update_tz() unconditionally derives the trip descriptor=
 of
> > params->trip_max as below,
> >    const struct thermal_trip_desc *td =3D trip_to_trip_desc(params->tri=
p_max);
> > and then walks td->thermal_instances. However, params->trip_max is allo=
wed
> > to be NULL and in that case the list walk dereferences a bogus pointer
> > derived from NULL which oops the kernel.
> >
> > get_governor_trips() picks trip_switch_on and trip_max out of the trip
> > table of the zone. When the zone has neither a passive nor an active tr=
ip
> > point, last_active is NULL and params->trip_max is left NULL. This is a=
n
> > explicitly supported configuration, as documented in the function
> > get_governor_trips() as below,
> >    If there are no passive or active trip points, then the governor won=
't
> >    do anything. In fact, its throttle function won't be called at all.
> >
> > Return early from power_allocator_update_tz() when params->trip_max is =
NULL
> > and only compute the trip descriptor after that check. There is nothing=
 to
> > update in that case anyway, with no trip_max and there are no thermal
> > instances for the governor to account for, num_actors stays zero and
> > total_weight is irrelevant.
> >
> > Fixes: 912e97c67cc3 ("thermal: gov_power_allocator: Move memory allocat=
ion out of throttle()")
> >
> > Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
> > ---
> >   drivers/thermal/gov_power_allocator.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/go=
v_power_allocator.c
> > index 37f2e22a999e..b5c254187628 100644
> > --- a/drivers/thermal/gov_power_allocator.c
> > +++ b/drivers/thermal/gov_power_allocator.c
> > @@ -660,10 +660,15 @@ static void power_allocator_update_tz(struct ther=
mal_zone_device *tz,
> >                                     enum thermal_notify_event reason)
> >   {
> >       struct power_allocator_params *params =3D tz->governor_data;
> > -     const struct thermal_trip_desc *td =3D trip_to_trip_desc(params->=
trip_max);
> > +     const struct thermal_trip_desc *td;
> >       struct thermal_instance *instance;
> >       int num_actors =3D 0;
> >
> > +     if (!params->trip_max)
> > +             return;
> > +
> > +     td =3D trip_to_trip_desc(params->trip_max);
> > +
> >       switch (reason) {
> >       case THERMAL_TZ_BIND_CDEV:
> >       case THERMAL_TZ_UNBIND_CDEV:
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Applied as 7.4 material, thanks!
