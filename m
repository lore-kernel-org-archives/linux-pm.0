Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE0D412276
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144946; cv=none; b=aPfaGGEVWwWgX7aDX6w1WQrVd4+SC9osLKHKvCXAc2Jnr1ivJneC06NxOxLaf2Mf4/o3KIzXfybKFgHyPsCGrvCBPurBLCDKVVJyMOPI3/5Okl/pSiggbcJZQmjvKK5Q0bkpjAcyCXRGDHeAvG86K0xChgYA8DGPAQJ2Km5C3to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144946; c=relaxed/simple;
	bh=k3Jxgs83Hig7QlE9LvZO3586kM0dwwLP9F7/r2P6Frs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nnm8rDDI42zjCl5JGCqNcJInL9VFyNt8BHzjy5uBmSAlotwYslnm/hsCCrVyOdt0MYIHT0Pia95etWw6MmbZzCwZvdJszFvZo7HQUyxgjCQHQ42XXzx7fCTmJVnQoQv9zvUAqQ2AbSAkAC8IpOcvdqaj/X908V4qO8Qs+V6LvLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCATDe6h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCATDe6h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8479C1F0089E
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 16:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789144942;
	bh=qCw+Wc6VaeePIHUiOF/W/RmHHZ1/xvW5DOzr9HdXJqw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GCATDe6hhPwbg8OG6qb0sKFHmHhdz2YMc6txTEV9c1ufFFK2XtJ2YeW4s4v9b1yC9
	 bUYzk/Jxer96YhzTb5mAhyx/EiLQiwdoiaj/FlGtKvIiy8m3p4T/LOy9E+d+Av1N0n
	 ZxUAUIXuc9oytTgc6dWGu7jtfM+GGWubw12fMq2zqpze8r8lGtklprSrw65aQudRVk
	 iM/esHEEWTX4eu8W/KGAfmB3EG4dkxFy6oJAtQwhguNV/bKWet3aKrv4sEmpGoboJv
	 R42N2xRNCB+iSZ9/Gx9J423uPsUKJ+VzmjTtNgF2KNVWB2u95xYQT49CnZgpgQIQ2f
	 vdBdx/YmWNjAg==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f16f13so170699e87.2
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 09:42:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzPye1/bO6GldGsKvtz5xztQ7qf4iPuAKULEHBLd5GgfDoh0XdYJyqIy7pg5tT984NWYrhG+5Q4DA==@vger.kernel.org
X-Gm-Message-State: AFuF++nFKUybbUTKRjnDEhYiEwDISUlFjqvWUFsUVEp1MuNo8ZDFOBZE
	SE9CU7nxMvsml4HhVQxos7zDcteaCdTPhbQagvSR7MIOGsE5QB6BEh1WBPASRqppoAUkRdIxYWf
	peAbaUtMl0GQ0NfuxtbmsY9yYX21WgOc=
X-Received: by 2002:a05:6512:3a84:b0:5b8:998c:ea9 with SMTP id
 2adb3069b0e04-5b8a032edbemr2203604e87.24.1789144940839; Fri, 11 Sep 2026
 09:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1965933.tdWV9SEqCh@rafael.j.wysocki> <9672996.CDJkKcVGEf@rafael.j.wysocki>
 <aqQt8-MlG3fiFw2-@ashevche-desk.local>
In-Reply-To: <aqQt8-MlG3fiFw2-@ashevche-desk.local>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 11 Sep 2026 18:41:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jCLq7J2X8eR_bAVmnm+4zxDnwk511F9eajZ4oyaUs-tA@mail.gmail.com>
X-Gm-Features: AcwNN1VLIHUe7MsCAMIdQGwp_Prmmrh-ZVz-tGh7o47y0E0NLP2EJoHQOAx5cUQ
Message-ID: <CAJZ5v0jCLq7J2X8eR_bAVmnm+4zxDnwk511F9eajZ4oyaUs-tA@mail.gmail.com>
Subject: Re: [PATCH v1 07/10] ACPI: thermal: Use cooling device parent for
 thermal zone binding
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <w_armin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 6:36=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 11, 2026 at 03:05:07PM +0200, Rafael J. Wysocki wrote:
>
> > The ACPI thermal zone .should_bind() callback function,
> > acpi_thermal_should_bind_cdev(), expects the given cooling device's
> > devdata to point to an ACPI device object whose ACPI handle should be
> > compared with ACPI handles in a list associated with the given trip
> > point.  That is not particularly straightforward and it effectively
> > requires the drivers of ACPI cooling devices to populate the devdata
> > with addresses of the ACPI companions of the devices they bind to.
> > Consequently, the devdata cannot be used by the driver for its own
> > needs which is its intended purpose.
> >
> > That can be overcome with the help of the observation that the
> > ACPI device objects to be matched against the lists of ACPI handles
> > associated with trip points are in fact the ACPI companions of the
> > parents of cooling devices.  Thus instead of using the given cooling
> > device's devdata, it is sufficient to obtain the ACPI handle of its
> > parent and compare that ACPI handle with the ones in the list
> > associated with the given trip point.
>
> ...
>
> > +     parent_handle =3D ACPI_HANDLE(parent);
> >
> > -             if (acpi_fetch_acpi_dev(handle) =3D=3D cdev_adev)
> > +     for (i =3D 0; i < acpi_trip->devices.count; i++) {
> > +             if (acpi_trip->devices.handles[i] =3D=3D parent_handle)
>
> device_match_acpi_handle() ?

That would cause ACPI_HANDLE() to be evaluated
acpi_trip->devices.count times for the parent whereas only one
evaluation is necessary, so not really.

>                 if (device_match_acpi_handle(parent, acpi_trip->devices.h=
andles[i]))
>
> >                       return true;
> >       }
