Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35515414A16
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 19:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784749417; cv=none; b=aMTQgAKGjypRy+wairNbdjZyoz/LBCuvd8Q9nTZP5wTKmeZNCFfeCjqS7RYy7hnti+UxukUEtll/f9iX4O7MQZGzCGnr38RtP3Prdf0EB2b91HIAT1F5VEz3+WGYWz8lnLAC1sd0VtbnW9B2u0HS/XsePdrI7++FjSquqOv6xIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784749417; c=relaxed/simple;
	bh=FCiiZxZtsxJcPy3cXjMetXRRhY1ay6BeI7kHCG5i78A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oysexzFha8o0tE5ORT3pI6gBeLj0H/vP2/rG0ATvwn/knDLsjsqdPVIey7DPYHpJYEp2wDcYQ4jJ8KfBFik/zPUnXUjIfzdUDTiAf2SPjlkg/oKk2HPU0xnwj7ftTChCCHfj4mSKEGuADt9yQecr4RFyjlJ9ORbqzj123VHHltY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxrVnZVT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxrVnZVT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7DF1F00A3D
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 19:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784749416;
	bh=s3SKrXzi1JOGYNffyHvnqOO4r5F9XfIfUMWExef267Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CxrVnZVT2fTZ7xN1MPA8pzNP06LqclZGFjf/mdlbT6avL0f8xHv2hsiFP9KxGjnc5
	 sDZpw6Wi+2RL0x60VJEflwRDnswhVkH91ZTnOU2s0wNVGsWk9a7gns8b70E7SuuhPG
	 Ayjd+MMgbGcoPmSGcQwMzIeFrvnJypkASVyKJdcskl59LZD8hjTFiqa/jTYmPGcdv4
	 8KErwIClUDxvnhoM/LNrid7D7OtyYACzuoKfZ1Y59UR3FsBkM5N1P5uWmp/EMUguQ2
	 cT5pGZXrmkDvg9ytMkGgYLZKfMN0dTnGtUX6USgP4BaKIRkGq4BZeujPtv/UU/0cQ5
	 ZPZ1R/JupEAUw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39f00ce92d5so4891971fa.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 12:43:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoEeauyC7ywxqilGqgPrB5G/RKl/VRTWaeYZK3J2Kg8TTOJArA9JuOt60Iv3Y6DMv/paQxv9A2hvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPxRhLgw8gDr7rJOIIiEe+8yoM5QU5WzsCqeBLyPzlCXiZCcok
	VF8OItr1vTmaMgD7XGW1Qj3dPjstRtqBOAdm77XaR377ydC44WD+LyhRuHfjlVW8umTGlKKlXvO
	K9GGQWQYfosVrbK49FlPEIDt5gXJXgPE=
X-Received: by 2002:a05:651c:b1f:b0:39c:7130:f0db with SMTP id
 38308e7fff4ca-39f07c27a0cmr196021fa.6.1784749414352; Wed, 22 Jul 2026
 12:43:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710-critical_trip-v1-1-780d0b40bb96@oss.qualcomm.com>
In-Reply-To: <20260710-critical_trip-v1-1-780d0b40bb96@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 22 Jul 2026 21:43:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hD7OvQfOUja7mC+nXpH2cDfYjeGMgf7WKREXt3rSNOEw@mail.gmail.com>
X-Gm-Features: AUfX_mxgurxjeu56PlKd3cLVW9Cs1wOiMjSr9TI0_HPkRQj5oxszkNPwhDNqz0A
Message-ID: <CAJZ5v0hD7OvQfOUja7mC+nXpH2cDfYjeGMgf7WKREXt3rSNOEw@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: warn on non-critical trips at or above
 critical temp
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 11:12=E2=80=AFAM Gaurav Kohli
<gaurav.kohli@oss.qualcomm.com> wrote:
>
> Thermal zones can be registered or updated with non-critical trips at or
> above the critical trip temperature. Such trips cannot provide useful
> mitigation before critical trip handling runs, and a HOT trip at that
> temperature can coincide with shutdown.
>
> Warn at registration time and on trip temperature changes to surface
> misconfigured platform data and incorrect dynamic updates early. When
> multiple critical trips exist, warn against the lowest one.
>
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>

There are a couple of reasons why I don't like this, the most
important one being the overhead: two walks over all trips added to
every trip temperature update is a bit of a stretch.

Moreover, the messages produced by this code may not even be noticed
on systems in the field and users may not be able to do anything about
them, so the benefit is questionable.

> ---
>  drivers/thermal/thermal_core.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 28a20d4b475c..0e37e3787565 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -434,6 +434,38 @@ static void thermal_trip_crossed(struct thermal_zone=
_device *tz,
>         thermal_governor_trip_crossed(governor, tz, trip, upward);
>  }
>
> +static void thermal_zone_check_trip_ordering(struct thermal_zone_device =
*tz)
> +{
> +       const struct thermal_trip_desc *td;
> +       int crit_temp =3D INT_MAX;
> +
> +       for_each_trip_desc(tz, td) {
> +               const struct thermal_trip *trip =3D &td->trip;
> +
> +               if (trip->type =3D=3D THERMAL_TRIP_CRITICAL &&
> +                   trip->temperature !=3D THERMAL_TEMP_INVALID &&
> +                   trip->temperature < crit_temp)
> +                       crit_temp =3D trip->temperature;
> +       }
> +
> +       if (crit_temp =3D=3D INT_MAX)
> +               return;
> +
> +       for_each_trip_desc(tz, td) {
> +               const struct thermal_trip *trip =3D &td->trip;
> +
> +               if (trip->type =3D=3D THERMAL_TRIP_CRITICAL ||
> +                   trip->temperature =3D=3D THERMAL_TEMP_INVALID)
> +                       continue;
> +
> +               if (trip->temperature >=3D crit_temp)
> +                       dev_warn(&tz->device,
> +                                "%s trip temperature %d is not below cri=
tical trip temperature %d\n",
> +                                thermal_trip_type_name(trip->type),
> +                                trip->temperature, crit_temp);
> +       }
> +}
> +
>  void thermal_zone_set_trip_hyst(struct thermal_zone_device *tz,
>                                 struct thermal_trip *trip, int hyst)
>  {
> @@ -462,6 +494,7 @@ void thermal_zone_set_trip_temp(struct thermal_zone_d=
evice *tz,
>
>         WRITE_ONCE(trip->temperature, temp);
>         thermal_notify_tz_trip_change(tz, trip);
> +       thermal_zone_check_trip_ordering(tz);
>
>         if (old_temp =3D=3D THERMAL_TEMP_INVALID) {
>                 /*
> @@ -1509,6 +1542,8 @@ thermal_zone_device_register_with_trips(const char =
*type,
>         if (result)
>                 goto remove_id;
>
> +       thermal_zone_check_trip_ordering(tz);
> +
>         thermal_zone_device_init(tz);
>
>         result =3D thermal_zone_init_governor(tz);
>
> ---
> base-commit: 4f441960e691d37c880d2cc004de06bb5b6bd5e4
> change-id: 20260710-critical_trip-7b015d270e36
>
> Best regards,
> --
> Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>
