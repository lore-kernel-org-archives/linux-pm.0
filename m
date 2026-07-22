Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DB235C1AE
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710893; cv=pass; b=ZP5d/2/nDSxH+SOyr+qDruz5xA9poB/Li/Glqf6zNSLZlj/jB7R1FgDjG/sCXZimP92y+pDmEsimKRpVo4F6aUglX2PhCVHfE8+ar2SduYOUKUGdb/oBemGMHTpgMtuRIcYy41SKmNMdk8Co19E1yJYq9pIptmSbi8HyVA7ZQkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710893; c=relaxed/simple;
	bh=kjMhhSUJeM58LyEBWOqNhoBXbBuuVqDLE8DYLHYzEqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tinYKfpNvkb7fyXjl/ZamwICMAeABImunTCvJA+1FY3GePZGpe4kGlq/3YVWGEZO2NpcVmF+57TQKr+QJEhOWQlZeVlPNJvllaeu4J1ZT5oP4jksgLG6ql1+jwlMUl6HHUm4wB9gspJk40OwBtSi4ZD+Z28YGMygYvkLO0nHrAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mXJbWsPe; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mXJbWsPe"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81e86df8987so62354367b3.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 02:01:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784710891; cv=none;
        d=google.com; s=arc-20260327;
        b=i9iiU8x4j9zWGhWjfhydGlpr5CA5kEQmr3NvJ3dMVCGb85RkH+mw4lLOoUfe3Ew9UE
         Os86iOVWcXFNoUR3gDrx22sx4HV44Hxb8otVFk2UNMiHXtoWuRzVBxIrGKqHo0DTbQ+C
         H1FB0aOIkzAX3Ko9kw5l5dY7UdaSfY+v+VwkI678Bmpgde/l4A7Ip72NJhCSw8E05+0+
         nMQyHXe+5kovCiJb0tpHZQTsVr3G9+gEPqA2poKukK3swn8atFMv2+VcRDvvPkHJ8Sbj
         /vhcII7ezNmxg/hbZU1tgaWM7j90K9XSkvbrWdfeP0lWfrBK9Ldu6ccN7zIYKs6k3xJg
         3dhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BVQ32j56Dr60NJMwmM+X8AwJaAcbdmT9panK+KSnLpY=;
        fh=aFQtsaOLC0Hr3u6ILwgQEiuD7itiCsrPMcVMmGc9jh8=;
        b=moyW757/IR8TkZe4CuNinar24w8H7cdh8h5V4MkUD3GtQGHcYhaemwqj0pyRhDDG9z
         gAFUba2RDd54LVcGfWz2/QpyTz1hfXEaQe0pnI7N9Z4FxmEKTSY5fcMEHmSXfAQj5kuQ
         Y5WLa2n/HG6RGQpr42Fsv1ob0HdUN87ddUnIXvV6C1cBQ7ueQTMe36AfxOx6RI0tjs5E
         ULdsmPJdbFZnzCaREnpasvCBLY+K9PqZSX5LSoG8neqVCtsp24uEcdOXhlKSOToJIEuo
         KupE6Lwq9D9wxZFz2evJjn3mR5E0MwN142lnRWJqhevkbA0JaZO4zrNkgj8Avf7py29Z
         qwTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784710891; x=1785315691; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BVQ32j56Dr60NJMwmM+X8AwJaAcbdmT9panK+KSnLpY=;
        b=mXJbWsPeCO8FslQIu10GK72HjeWHi1GFyymj/tGTDhE5yi1vHwlRPV046PHgZ7VpF6
         NEAxPt8ne/efXzlFDPF3d0AZKJ1AtDazYWogGUm5jeMFvwz4KLohfxv1cU7ZnMbv00OG
         XoBwDO7yJNVGOswjqco0Vgsms2BhEWcHJ8IV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784710891; x=1785315691;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BVQ32j56Dr60NJMwmM+X8AwJaAcbdmT9panK+KSnLpY=;
        b=UdUYKbR/SFKm6DJax0PDz6JplnJz9cpvNRFOZDrjNaGANMgS4A3iwGsYd6rW9Fw2i0
         WJN2XJITWEA3EZjGac+1nFfPuFEWFttzEHetzJEqjzA+i69dEAIuxdjYMkUeRiM+PrhM
         t1vrjki0+e4YyoigKeumio91LQh9BomGMOvvyVabqno1SEHdJaFJ5NGBSVpJj9ugQfvp
         At510vy4T5GBnJeCQwjjfPnLdnbzajk2Oe479me5cePaQXTfV6lxgEwWgQp6HNoCuQo0
         biqXJa9PIGkcK+4rrKj8wpxgidYgefVX3djwYzcjxDPtc6Ck00a9w0LJb8Hzemlj5RhT
         M9Hg==
X-Forwarded-Encrypted: i=1; AHgh+RohNWfskp/gOEli1oSCN+7WvpR76huA9iQcHyWqc4iSL3n1/k4Szh38OUO10tC1myrLJiHBppC6hw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDdRFdlqeBIaeqoRb4q3M+S0nhEBIBIyWe7r/val+hXVlZtBcE
	euMmeaOHRnYp5qs3xtTK47IH8DztlVyYwAhx0OLDHzek7+qy22n299dxfV4YsgI9mijigOVrgSv
	OAo7cKL/mQclvjPJgGa4sOeinYlI6mZ5L3fZGABht
X-Gm-Gg: AR+sD12QZ0EyHktxyJpZSJTBK8w7O9XEt36zevNdIzJwFrEXxm74AjWBMh2iD/hGVQ2
	Oe1RMw6TkxvqCnt4QS/PHAQvngpkc4mxPfTc5Dt1a3r1W2XrDqLh7MeUdu5NW2tpqyEP5+ucH5F
	1Nue6/hHpQVR9z/im+4sqOO6RDdWHp7w98GeXMMMR24KBH64BlmmfxKd12u/dE319vRbsCSvwOA
	oYUx/pxMUrTVKtSVwQfyZL0rqHD687OCs30uOcV9jFCxQyKpK2qezi04LWyPYXI+24oJFQai4zz
	7OtcyhFAtQZE8eiO
X-Received: by 2002:a05:690c:e0c:b0:81e:6a1c:e30b with SMTP id
 00721157ae682-81ef28da7b0mr69266347b3.67.1784710891191; Wed, 22 Jul 2026
 02:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721065413.2306137-1-wenst@chromium.org> <20260721065413.2306137-4-wenst@chromium.org>
 <CAMRc=McsCRBxXMj0xC8H0cgdZZ=Z9_4u_DS9b2z0pLE0=gZr+g@mail.gmail.com>
In-Reply-To: <CAMRc=McsCRBxXMj0xC8H0cgdZZ=Z9_4u_DS9b2z0pLE0=gZr+g@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 22 Jul 2026 17:01:20 +0800
X-Gm-Features: AUfX_mzymMOrnzz3ZSisQQjvbDECVUbqfaXF7TwtpwvIT3XYymwiPHVmpWvFgt8
Message-ID: <CAGXv+5H_V+J0cvrYjMFdKAQVrPKxPdtimXMc+hwHenwxhb9mDQ@mail.gmail.com>
Subject: Re: [PATCH v6 03/16] power: sequencing: Add pwrseq_power_is_on()
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 5:08=E2=80=AFPM Bartosz Golaszewski <brgl@kernel.or=
g> wrote:
>
> On Tue, 21 Jul 2026 08:53:58 +0200, Chen-Yu Tsai <wenst@chromium.org> sai=
d:
> > The power sequencing consumer API already does power on state tracking
> > internally. Expose the state to consumers through pwrseq_power_is_on()
> > so that they don't have to reimplement it locally.
> >
> > Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > Changes since v5:
> > - Reverted back to returning -EINVAL if descriptor is NULL
> >
> > Changes since v4:
> > - Make pwrseq_power_is_on() return 1 if descriptor is NULL, i.e. if
> >   the descriptor is optional, matching the other pwrseq consumer APIs
> >
> > Changes since v3:
> > - Added missing stub function for !POWER_SEQUENCING
> >
> > Changes since v2:
> > - New patch
> >
> > Needs to go in with "usb: hub: Power on connected M.2 E-key connectors"
> > as it is a build time dependency. Bartosz wants the change on an
> > immutable branch to pull into the pwrseq tree.
> > ---
> >  drivers/power/sequencing/core.c | 18 ++++++++++++++++++
> >  include/linux/pwrseq/consumer.h |  6 ++++++
> >  2 files changed, 24 insertions(+)
> >
> > diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing=
/core.c
> > index 02f42da91598..72b96d36920e 100644
> > --- a/drivers/power/sequencing/core.c
> > +++ b/drivers/power/sequencing/core.c
> > @@ -968,6 +968,24 @@ int pwrseq_power_off(struct pwrseq_desc *desc)
> >  }
> >  EXPORT_SYMBOL_GPL(pwrseq_power_off);
> >
> > +/**
> > + * pwrseq_power_is_on() - Queries the last requested state of the powe=
r sequencer.
> > + * @desc: Descriptor referencing the power sequencer.
> > + *
> > + * This returns the last requested state of the power sequencer.
> > + *
> > + * Returns:
> > + * On success, 1 for on and 0 for off; negative error number on failur=
e.
> > + */
> > +int pwrseq_power_is_on(struct pwrseq_desc *desc)
> > +{
> > +     if (!desc)
> > +             return -EINVAL;
> > +
> > +     return desc->powered_on;
> > +}
> > +EXPORT_SYMBOL_GPL(pwrseq_power_is_on);
> > +
>
> Didn't we agree on introducing an enum to make it future-proof for when w=
e
> also pull in pwrseq_is_controllable() from Loic?

My bad. I misunderstood and thought it wasn't needed yet.

> I think this should work like so:
>
> enum {
>         PWRSEQ_STATE_UNKNOWN,
>         PWRSEQ_STATE_ON,
>         PWRSEQ_STATE_OFF,
> };
>
> int pwrseq_get_state(struct pwrseq_desc *desc)
> {

I think you still want this here?

          if (!desc)
                    return -EINVAL;


>         /* Only once this is upstream. */
>         if (!pwrseq_is_controllable(desc))
>                 return PWRSEQ_STATE_UNKNOWN;
>
>         return desc->powred_on ? PWRSEQ_STATE_ON : PWRSEQ_STATE_OFF;
> }
>
> Bart


Thanks
ChenYu
