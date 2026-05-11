Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2828C223DFF
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 17:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521369; cv=none; b=lcv8mLP5/9WQhyQkZ947nX9YgyIP6MYiX58Wv7cZIWDuwKi9K6Rq4QVE1FR/I7BjU1010ZvPI8duUjPeT0ruZ8334+2vhyg1Q2Bs8ulUon/rWzvzrAMLVjj8fMiquG9Jq+56cBnMbzXPiu4WZFwaSZkyjgk3lMlvuwYsIOHP/Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521369; c=relaxed/simple;
	bh=4X/QVUjKUtQcwje/UzwSBopWafmJVduPiwKIdJoHHcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/AVrpBck8AU3rr5jA4xB5ZCi6o1AdzrCMRKT3IRoaolkuPzX3OdDEfuqAiGRUJuUHbqfE4hNdq0rUeAt4njAqK3b/2dkVu8fx7T8QwuFqyLVoYL19fMWKz8SeOVEwB3Y2GdlLhZIAi2dD0g2r89SifwD4DQDgHncIaEPH07HzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDSw+BQo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDSw+BQo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D06C4AF0B
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 17:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778521369;
	bh=4X/QVUjKUtQcwje/UzwSBopWafmJVduPiwKIdJoHHcY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HDSw+BQo9+mKuzXiEctWMpOUYP0/KffAP1aJIKQEC8Ns5ABwyU3n35WCh41OHIxnI
	 ApGT/pITu0evyMev9iKkAGZDbmUtQQYN/lowrqRKBTtiYwyNQaeOLhqM/s6mk2+bzW
	 wp1K7Qz96oXMxGoinsixnXYSf+QlxSsYnyyzcFJ0NDHKUY1GVmU0IR9faGtiWyCD+h
	 9WdmiH1FDe3wjEkrxAgjs2ntfj/Z6zCsM+9v5aq+uckEVzcmSPwz+A451DIg30imhK
	 fa8jTUiY6clvSh26CIgQFPODycWMvpVFo3AmJqZHwOrxHurnDZxH4ej0vvDJL1JRCa
	 ShlIE9amp9UYg==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a8891febd2so5402349e87.1
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 10:42:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8MYY4WfzRJ49YyczYGD/8qoPZKEpk3ldAWSx7o6ZGHTaMwHfnbtKKYdMcuJMNMoo2uQOtdeM6kzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxslumszrhcSXYBPZPJjyDGVXN+0Y2BzSm1xQ+0ma4QJLD39dSR
	Bnp/ALoO8J092FUFtTJ7bDHTtLh5Oq18ZK7DcOFvD6eiaAhDYzB6IPvHSIljszRbBGZQaXuaHhV
	yZH1rVN0TkZ7JxJ1nKxeN/AuLf74jXxI=
X-Received: by 2002:a05:6512:33c9:b0:5a3:fdf4:4899 with SMTP id
 2adb3069b0e04-5a887ae368fmr8237155e87.16.1778521367417; Mon, 11 May 2026
 10:42:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511163718.198335-1-kmayur809@gmail.com>
In-Reply-To: <20260511163718.198335-1-kmayur809@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 May 2026 19:42:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jskPFOQELt+XE6DhcTxVomqzuVJF322n3n3xffbG9Uog@mail.gmail.com>
X-Gm-Features: AVHnY4IZ1l8kOlg8qbtxD3DrpxN0No0gFFNKhd38z7wTaq2LDo9ACspXOhdr9XU
Message-ID: <CAJZ5v0jskPFOQELt+XE6DhcTxVomqzuVJF322n3n3xffbG9Uog@mail.gmail.com>
Subject: Re: [PATCH] thermal: sysfs: fix whitespace and use octal permissions
To: Mayur Kumar <kmayur809@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 6:37=E2=80=AFPM Mayur Kumar <kmayur809@gmail.com> w=
rote:
>
> Clean up thermal_sysfs.c by removing a space before a tab

So please do the white space cleanup separately if you care enough.

The permissions are correct as they are AFAICS.

> and replacing symbolic permissions (S_IRUGO, S_IWUSR) with their
> preferred octal equivalents (0444, 0200) to improve readability.
>
> Signed-off-by: Mayur Kumar <kmayur809@gmail.com>
> ---
>  drivers/thermal/thermal_sysfs.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sy=
sfs.c
> index 5eecae13f07..7cf6b0b060a 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -82,7 +82,7 @@ mode_store(struct device *dev, struct device_attribute =
*attr,
>  }
>
>  #define thermal_trip_of_attr(_ptr_, _attr_)                            \
> -       ({                                                              \
> +       ({\
>                 struct thermal_trip_desc *td;                           \
>                                                                         \
>                 td =3D container_of(_ptr_, struct thermal_trip_desc,     =
 \
> @@ -405,7 +405,7 @@ static int create_trip_attrs(struct thermal_zone_devi=
ce *tz)
>
>                 sysfs_attr_init(&trip_attrs->type.attr.attr);
>                 trip_attrs->type.attr.attr.name =3D trip_attrs->type.name=
;
> -               trip_attrs->type.attr.attr.mode =3D S_IRUGO;
> +               trip_attrs->type.attr.attr.mode =3D 0444;
>                 trip_attrs->type.attr.show =3D trip_point_type_show;
>                 attrs[i] =3D &trip_attrs->type.attr.attr;
>
> @@ -415,10 +415,10 @@ static int create_trip_attrs(struct thermal_zone_de=
vice *tz)
>
>                 sysfs_attr_init(&trip_attrs->temp.attr.attr);
>                 trip_attrs->temp.attr.attr.name =3D trip_attrs->temp.name=
;
> -               trip_attrs->temp.attr.attr.mode =3D S_IRUGO;
> +               trip_attrs->temp.attr.attr.mode =3D 0444;
>                 trip_attrs->temp.attr.show =3D trip_point_temp_show;
>                 if (td->trip.flags & THERMAL_TRIP_FLAG_RW_TEMP) {
> -                       trip_attrs->temp.attr.attr.mode |=3D S_IWUSR;
> +                       trip_attrs->temp.attr.attr.mode |=3D 0200;
>                         trip_attrs->temp.attr.store =3D trip_point_temp_s=
tore;
>                 }
>                 attrs[i + tz->num_trips] =3D &trip_attrs->temp.attr.attr;
> @@ -428,10 +428,10 @@ static int create_trip_attrs(struct thermal_zone_de=
vice *tz)
>
>                 sysfs_attr_init(&trip_attrs->hyst.attr.attr);
>                 trip_attrs->hyst.attr.attr.name =3D trip_attrs->hyst.name=
;
> -               trip_attrs->hyst.attr.attr.mode =3D S_IRUGO;
> +               trip_attrs->hyst.attr.attr.mode =3D 0444;
>                 trip_attrs->hyst.attr.show =3D trip_point_hyst_show;
>                 if (td->trip.flags & THERMAL_TRIP_FLAG_RW_HYST) {
> -                       trip_attrs->hyst.attr.attr.mode |=3D S_IWUSR;
> +                       trip_attrs->hyst.attr.attr.mode |=3D 0200;
>                         trip_attrs->hyst.attr.store =3D trip_point_hyst_s=
tore;
>                 }
>                 attrs[i + 2 * tz->num_trips] =3D &trip_attrs->hyst.attr.a=
ttr;
> --
