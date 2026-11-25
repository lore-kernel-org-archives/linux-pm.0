Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795638912;
	b=zcKhl2evg5PoZJeSEUCvbPvlgshDPNLcu3TETGC4OyMqfHYmRyil9/wZY+N/fNcq9mUw
	 TPk9fWPPHQpdHeITE+NjCkL59a5yuKVi/Pupb9Ly9dRaBb4ejgLM+ts4EzrRTG01iZWYv
	 A1KVj8mx7ORftSg/2wd0Y7maINPJA2GIy4dag7Ak1sN1wxQ9oXYxawuZO8Eexi2ArO0X1
	 DxcDTWndxnCrBIIMBkkcZpwiHTFFagL5MHD23q5mX+8L9uBMhki/Kz8BkqaFuLexMXPAE
	 j4VDOXZF9nr59y8eDNLaULZmIq/egjzHWQqYBQl4qKVUJWLyrCEWmX4ZnkCa7a9WsOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638912;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=p5acCxDxlSUFFS4vMmVVTs7/iECoKuFpu+gwcLgjPm4=;
	b=U9WUaBEwB/je/iuA+59fphqt7nVXhb2hqDVEG+0VSpgyxCBUf9+2I5txCvU0JLmW/3ut
	 qbhrSlkW8nNvj/tb8/ANYNeUo60Cm9O4n4LPvcoI8ZRgMiUcing0zQvpuokb2D12gUZH5
	 qyE7zFrjzckNrnrhJdOQvsueaEzsaQJkn0FlWIvXrdhINrDtXLraDqKNSvDe12hCbeDnO
	 mAAFnXXDeWUxwZPd5Ck8scrF/8XUIUh6O+8qNhbfIXDGNZ0Pt/ZXXU3Kp0AnpATGUCVzX
	 vk2TcW/Jw5rj2twO5py2r+GOkZqoyGFPJ/YXyRwUhET1e/JCd/RqblAmP5OrgcGIjQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wrbk76mx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88087606A323
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wrbk76mx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E511F000CF
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 20:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795638912;
	bh=p5acCxDxlSUFFS4vMmVVTs7/iECoKuFpu+gwcLgjPm4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Wrbk76mxflc0K88uE6XtEmrlv9oHc3/FmkPnBCfYQgt+M6iwsL2Soa9oekQqabSfr
	 gowHhgEOIhS+zq36Q1/Jin4DQOpetWn0J2Svv7fPsq3LjkL1dGPaC0UfRy+hdgM6If
	 o1F5KdZ6B14bHDevVoAiBPRIYm77gVcGK/ii3SNNHr+zGzxkTUVDdS2beoUdLMdu9d
	 Z8KlUbyLFbZSb/I1f1zqoOexLmgZl97/r26rV/ZzBVwDENZwgE9MpWS1USC4hQWYwH
	 Uj54MMSKbJaf/qDIlMgqdh8UIuEFKC4ELqLdom9WCW/0XwYv+3ENKfNWx6J3JZfWaT
	 5yT7De4ZeKTUQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3ace304021eso60366431fa.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 12:35:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEEkVmHwhAvS09FcogpuQKMCQ7y9rnyCoUwt/+Y9Sdyx93RGTkig0rFSz+tlCAVllSWyCHQKvGz0w==@vger.kernel.org
X-Gm-Message-State: APuU4Z91jCmXKSFqF0G8pJl5hBn3xKIqfz1tyZ/Rxkmr8GUjqOsZBkN+
	y4spBhz59P/0aOb4X2D37wjZutpghIG444ApxdDat8pgQ7B8KvZH/ez+RYo243Ob6l/8woSYgAF
	nhCTqVNQnXD5p58oX+Cny35yqrhorg6M=
X-Received: by 2002:a05:6512:3a81:b0:5bf:b27e:3fac with SMTP id
 2adb3069b0e04-5c1bc822487mr6615065e87.57.1795638910594; Wed, 25 Nov 2026
 12:35:10 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <2859850.mvXUDI8C0e@rafael.j.wysocki> <1976174.tdWV9SEqCh@rafael.j.wysocki>
 <awcYhE0hvgBQMT6_@ashevche-desk.local>
In-Reply-To: <awcYhE0hvgBQMT6_@ashevche-desk.local>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 25 Nov 2026 21:34:58 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g1S2EppsW+Co_VD1Rbmv1bAsVDNmQ3a58H_exUFjuyXg@mail.gmail.com>
X-Gm-Features: Aa3M54pRFlc3O3GoOZgNptt89xZDZbUNFHK_jAQXyN3VbCzeL3td5jRczMyeN8g
Message-ID: <CAJZ5v0g1S2EppsW+Co_VD1Rbmv1bAsVDNmQ3a58H_exUFjuyXg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] ACPI: fan: Pass struct acpi_fan pointers to functions
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Armin Wolf <w_armin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 8:29=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Nov 25, 2026 at 03:07:24PM +0100, Rafael J. Wysocki wrote:
> >
> > Pass a struct acpi_fan pointer as an argument to several functions in
> > the ACPI fan driver either instead of or in addition to a struct
> > acpi_device or a struct device pointer.
> >
> > This allows acpi_driver_data() usage to be reduced and some other
> > simplifications to be made.
> >
> > No intentional functional impact.
>
> ...
>
> > -static int acpi_fan_get_fps(struct device *dev, struct acpi_device *de=
vice)
> > +static int acpi_fan_get_fps(struct acpi_fan *fan, struct device *dev,
> > +                         struct acpi_device *device)
>
> Hmm... Can't we derive 'device' from 'fan' as you done elsewhere?

It can be done, but it's rather cosmetic IMV.

It's just a matter of whether or not dereferencing "fan" is better
than passing one more arg.  Anyway, this change can be made
separately.

> ...
>
> > -static int acpi_fan_dsm_init(struct device *dev)
> > +static int acpi_fan_dsm_init(struct acpi_fan *fan, struct device *dev)
> >  {
>
> Now 'dev' is used solely for dev_info() call AFAICS. Hence when you move =
to
> acpi_handle_info() this parameter can be killed I assume.

However, I'm not sure if using acpi_handle_info() would be better.
After all, the platform device is the one using MSFT extensions.

> >       union acpi_object dummy =3D {
> >               .package =3D {
>
> >                       .elements =3D NULL,
> >               },
> >       };
> > -     struct acpi_fan *fan =3D dev_get_drvdata(dev);
> >       acpi_handle fan_handle =3D fan->adev->handle;
>
> --
