Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543994;
	b=BOxluwVPlUWJTGbM7GJPyZTBcZMH7o3JmmI2Ctv45TCYBSTXbdLNT8QTgtCQpGLVL7Fl
	 8fFdIgmK3DtRGUVCyzT9NNCsmPOzjT/uoTnGMpam7pzDQKJg5UNk/zkofO+pCrriQHWC+
	 ypBsgTBp3TerNX87ZvTW0SnOT0GvbKVIxuOuOs2LWOAQIs4+xQEM8RLU9eMrdaSpIDiNP
	 WfPiLnronbKxS2ZlDBDvYh1V5a3xdi9UsKQ0kssm1lC/NI8CseW+z6JOdDzM6g147R2B/
	 dH7EztJNxRylGAsNOw1AKdLeJliWUKMjbdFuWnIts928U0+nC/1A0rUBwNLXEXn0R6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543994;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gosVtrukTW/5/NEwvnr2FcIZlFj6gPLu6QFpdN7L/Gs=;
	b=X6eljtAjZUNzAzm5B2OX+93VdecY28Y7gDWvwgVpES8wM9imG8Hy/FKevMO+Ep4O1C/r
	 g2lg7dqxhwAITVHy1z35Y7jGTfLVmIhoL3DOtHarc6Py69kxtltYEmn1/tUd8ZIFKoDDe
	 8foslOOOjPz7KuzxnSqgzUKUn8uoxdxCcc3XwC9lDX+7RygHgOCoHOTnqLkzC12z53x+Q
	 WBBtS1yjlAA7IERpBsEIQeRIsFzT/5XvBIAK9s2gcw5D35W+haAZwq+szwGM8lagHHP5i
	 AMqC9AatFaxjK5Di0Bx43pwdZnmPox4gDIF7JcxQoSJOwCd5sG4SnIOzVdl62bM0pFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czgyOFVX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00340606A338
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czgyOFVX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6749B1F000F0
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 18:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795543993;
	bh=gosVtrukTW/5/NEwvnr2FcIZlFj6gPLu6QFpdN7L/Gs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=czgyOFVXclfyXfriwv3XxvHNWIroC8qMsR35/jKD+ahI52/ujZFB86IGAAjeoGvKg
	 MTXBAI1pua4EA2V4ykmZJW8fAoZTgP1FuiApGAIdAUW5L4j3C7v4POs1/iv6H9j2Cz
	 UM6XvkVa+XhsKZpyY1dN7eSt6Z/j1rIMn1Fecs9LS2bJ1BJSqcfDvG8jPhBoQzbDQp
	 gRLAY1h4jaDNjHS+35zGpCgzMRhK96F/Ucs/9bNE7iQKWfJvSa3AoN5CDMMFVHd30t
	 ASdgEQNacvhbSLwlKrn0OA0+rsoHaSrmOD9opwNJaD9dd2zJGGi410PdWIqEjuy/e0
	 uk1/FxyEuZU8Q==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3ab30b3212aso37965251fa.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 10:13:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErETUEUyQjVydn7AGrWiC+pzG8FaBAxV3+5zoNW3hUUnK1LtrSs3cv4koO7W+fs5ibcKiT8oR2l5jg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8xLCSPKUmIZyDW0cmsN4qufaxINnXxfgpmO04u8jpbocg0HHA+
	6r2/atqChRQ5i5jyzAJS+ovm28lFjdo4e+dX1Dzm+4HVYkO7rsrX44wtHgfnROpfb/wnmlG7l2N
	4ml0Q+82hoZzjmgTNn4ierwNj013UmFY=
X-Received: by 2002:a05:6512:23a0:b0:5c1:5c55:2d2d with SMTP id
 2adb3069b0e04-5c1bc7e68d2mr4651609e87.26.1795543991861; Tue, 24 Nov 2026
 10:13:11 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <3985766.kQq0lBPeGt@rafael.j.wysocki> <6217460.MhkbZ0Pkbq@rafael.j.wysocki>
 <awXGWwlZo0QIFvxA@ashevche-desk.local>
In-Reply-To: <awXGWwlZo0QIFvxA@ashevche-desk.local>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 24 Nov 2026 19:12:59 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h=FeDNkUaa_25mUeXDLaVgg4YqD_JSwZPUBm9kT8qd1w@mail.gmail.com>
X-Gm-Features: Aa3M54pKSNT-PvjuyC9UUyumgmnt6VFrhDVgupy6P4mQgFud7kbtJ99gVXNmMkk
Message-ID: <CAJZ5v0h=FeDNkUaa_25mUeXDLaVgg4YqD_JSwZPUBm9kT8qd1w@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] ACPI: fan: Stop using driver_data pointer from
 struct acpi_device
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Armin Wolf <w_armin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 6:21=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Nov 24, 2026 at 04:47:12PM +0100, Rafael J. Wysocki wrote:
> >
> > Instead of using the driver_data pointer under struct acpi_device,
> > make the ACPI fan driver use the driver data under the dev member of
> > struct acpi_device and clean it up properly on driver removal and on
> > probe failures.
> >
> > While at it, unify the code ordering of acpi_fan_delete_attributes()
> > with the rollback path in acpi_fan_create_attributes().
>
> ...
>
> >  static ssize_t show_fine_grain_control(struct device *dev, struct devi=
ce_attribute *attr, char *buf)
> >  {
> >       struct acpi_device *acpi_dev =3D container_of(dev, struct acpi_de=
vice, dev);
> > -     struct acpi_fan *fan =3D acpi_driver_data(acpi_dev);
> > +     struct acpi_fan *fan =3D dev_get_drvdata(&acpi_dev->dev);
>
> I'm a bit lost. Is 'dev' parameter embedded into struct acpi_device
> ('acpi_dev') and later we again come to it via dereferencing 'acpi_dev'?
>
> If so, why not use 'dev' directly?

Yeah, good point, it can be done.

> >       return sysfs_emit(buf, "%d\n", fan->fif.fine_grain_ctrl);
> >  }
>
> ...
>
> >  void acpi_fan_delete_attributes(struct acpi_fan *fan)
> >  {
> >       struct acpi_device *device =3D fan->adev;
> > -     int i;
> >
> > -     sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
> > +     if (fan->acpi4) {
>
> > +             int i;
> >
>
> While at it, ...
>
> > -     if (!fan->acpi4)
> > -             return;
> > +             for (i =3D 0; i < fan->fps_count; ++i)
>
> ...seems the local form can be used
>
>                 for (int i =3D 0; i < fan->fps_count; ++i)

Yes, it can.

> > +                     sysfs_remove_file(&device->dev.kobj, &fan->fps[i]=
.dev_attr.attr);
> >
> > -     for (i =3D 0; i < fan->fps_count; ++i)
> > -             sysfs_remove_file(&device->dev.kobj, &fan->fps[i].dev_att=
r.attr);
> > +             sysfs_remove_file(&device->dev.kobj, &fan->fine_grain_con=
trol.attr);
> > +             dev_set_drvdata(&device->dev, NULL);
> > +     }
> >
> > -     sysfs_remove_file(&device->dev.kobj, &fan->fine_grain_control.att=
r);
> > +     sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
> >  }
>
> --
