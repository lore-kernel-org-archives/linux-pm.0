Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795788349;
	b=EI2bNzgdE4/cpd5nQUfmM9GZ0kHyo5hdzUyToAJqR8yp2su3bmFdO+ODkGYBTbVtQTa7
	 k/TJAF4leTO2Xy4FhDS9o1lIvWpGl/7wqERkg2JmvR2Yv13tZb/TRmFiobvO7ItB5612r
	 a6LLDWZXMEQddgcRDO8MdjYk0KU2khr4Pc9SKJmQkSIk+iajf9BW2Fackul6O1Rypahz0
	 rWEoGegeYgENIzq0Dv06THBhiqGNnRzmwfm2I99GhN20L6uO779VYb44aWsbsU5nIlNJ2
	 JK/9Rtt0bmLzsnRirSjQfFkYfOdoF3vc46YavOHxHRQhCdomsQAQ6BpVID11OGAI+1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788349;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZChi/V/cBkPXD1LTeyDR+JElxQO43oGSZK3MDyeqdcM=;
	b=VlZolcOKH0i0uBXT5jb4oq/z8RyZSzS1zyDdgHXLOi1tO0X/d9iR1mSgyqSvM8dj2gOE
	 55jQLsLafxO+SqI0+gggPCblJwNo2uIXm/FPfKh68bvpn4FA0eowBtJ5o4sZ2rq7pOPvS
	 jakwkTnqnUCDoJ+makitopPve3e5mr8w2GBqy1w7DSenJPw+ufHmRqf+nRhWltQnBAjbA
	 QbsVKDOYwS5E+v5JFe1zYti2cGEgeYVvT3uP7FCLvZrVNtbLdeDsQzjvqpnwERWAt/pG/
	 8sLJcW8kCriek5awo+3Cy2O4GUF6aqwWEyk8NivCMXJun7pf8MsJSmLOqL8RZKkpfxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cwGcmAnw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DAB606A68D
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cwGcmAnw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5EE1F0089C
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795788348;
	bh=ZChi/V/cBkPXD1LTeyDR+JElxQO43oGSZK3MDyeqdcM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cwGcmAnwFDYuXkp0yV57lAwaoVjNBIf/38pYwOJtioVvn43I1w1G95EYJDblVsaQJ
	 Ghv3OCZ9BOs87yWZ+lTotMpfKg+IaR9qgn/Zv+9CaSZVCzkltxwnBqFGknSE23P3gp
	 J5B5FicZP7Z732ZlJ6ibkHgD0Da2qTv12SKU93Szh8eWsPnw/0Ytra/vgIBNfdKcyH
	 Sl39lOF+mUWGsZyOsDa/Bbe3ZOs0tEtvfSqbUYcDRfCzRAAzNKeUfsrHCzlwl8o/Ym
	 DH1wRbR134+YaM+UD0Sh/dNlNOlIJJsVhijyz7kmlrFTVlrU6YWy0FEJLAUH34CaiT
	 ZiV9qU5ta+7IA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3ae6f2b193fso41629261fa.0
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 06:05:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHKVh7kKt6AgdXcoYUENkEalXosBRhYOPun9U1s6YaY7HVco1B+UV4PTAzlx6HIT0QxhFr7LNPFkw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8HiWidmOnX4rkYThCeVhC2GHcDAIc/RUQ/v8xt3AQOe+JwPQRU
	f0Qq0mTPm2GX/ftom9MNnF1XZ6q9vcIrLxUZkWDdwEgl6nRDl64L1WINum6k7BvWGYqTP2/HA86
	srLXa1Kkgt4VPX0FhS8YQnv2wAdJdoPQ=
X-Received: by 2002:a05:6512:3a94:b0:5bf:b5a1:3c09 with SMTP id
 2adb3069b0e04-5c1bc7d222cmr7698254e87.31.1795788346777; Fri, 27 Nov 2026
 06:05:46 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <3986546.kQq0lBPeGt@rafael.j.wysocki> <2080993.usQuhbGJ8B@rafael.j.wysocki>
 <3659d5f94d83b71df4040f8516000e9be9a9c1b5.camel@linux.intel.com>
In-Reply-To: <3659d5f94d83b71df4040f8516000e9be9a9c1b5.camel@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 27 Nov 2026 15:05:33 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hCxSQHok3t8JHVmb7nUcNzO059BHnm6-Ogu2pWyh6WOw@mail.gmail.com>
X-Gm-Features: Aa3M54p-JnvCjuJdrIlWFlDk59C2fD3iAe3siOzUrYiYTbS-7Fm722hwEh6Mlqk
Message-ID: <CAJZ5v0hCxSQHok3t8JHVmb7nUcNzO059BHnm6-Ogu2pWyh6WOw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] intel_idle: Allow ACPI _CST to be preferred to
 ACPI _LPI
To: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 10:17=E2=80=AFPM Artem Bityutskiy
<artem.bityutskiy@linux.intel.com> wrote:
>
> All patches look good to me, there is only doc nitpicks below.
>
> Reviewed-by: Artem Bityutskiy <artem.bityutskiy@intel.com>

Thanks!

> So my nitpick is to make it crystal clear this option is not about
> never trying _LPI, it is about trying _CST first (reversing the
> default).

That's what "prefer" means.

> On Wed, 2026-11-25 at 15:20 +0100, Rafael J. Wysocki wrote:
> > +``prefer_cst`` - When using ACPI, prefer idle states coming from ``_CS=
T`` to
> > +idle states coming from ``_LPI`` (which is preferred by default).
>
> ``prefer_cst`` - When using ACPI, try ``_CST`` first and fall back to
> ``_LPI`` only if ``_CST`` does not provide usable idle states (by
> default, ``_LPI`` is tried first and ``_CST`` is the fallback).

This is more precise, so I'll use it, but honestly it doesn't make a
lot of a difference to me.

> > +
> >  The value of the ``states_off`` module parameter (0 by default) repres=
ents a
> >  list of idle states to be disabled by default in the form of a bitmask=
.
> >
> > diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> > index fc0aea26db50..3c07469586f7 100644
> > --- a/drivers/idle/intel_idle.c
> > +++ b/drivers/idle/intel_idle.c
> > @@ -1779,6 +1779,10 @@ static bool no_native __read_mostly; /* No effec=
t if no_acpi is set. */
> >  module_param_named(no_native, no_native, bool, 0444);
> >  MODULE_PARM_DESC(no_native, "Ignore cpu specific (native) idle states =
in lieu of ACPI idle states");
> >
> > +static bool prefer_cst __read_mostly; /* No effect if no_acpi is set. =
*/
> > +module_param(prefer_cst, bool, 0444);
> > +MODULE_PARM_DESC(prefer_cst, "Prefer ACPI _CST idle states to ACPI _LP=
I idle states");
>
> May be even something like this
>
> MODULE_PARM_DESC(prefer_cst, "Try ACPI _CST before ACPI _LPI (default: "
>                              "_LPI first)");
>
> But this is very minor, your call.

I'm going to use mine.
