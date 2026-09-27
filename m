Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108343B83F9;
	Sun, 27 Sep 2026 19:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790536819; cv=none; b=Rh2cq0FrMSVi6qbIECu+Qzd2IgzH3mLQ32p3ycHK45hS4sYe8GbScSCgjoJbmj2zQ45r8poxTHGXnmTGKb9La+s4d6Zt3qaD6/qq7VQQTPP7yy/d7DB5jXfXv6QQ1u/gA0i9QdcH8ZBKE5y1etSF4YZNAsKlPT7N3i1X+NJQF54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790536819; c=relaxed/simple;
	bh=Bi+G4xOm0CuAafK9NtXgYMH/kIkrDhJstHc8hRC/qdU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qd5tzdl++5MHjE48OP4GI0aCiAZpEuNyJYwESn6WQtpfrtcqrxGUuIqKnZwQftC6mOgwwu5wQwHjkSwKt0Exgmeix6BZzmvf9JbvUd0bshmbJrp938RW3sDUhFson9boprxx3ugL6Y13IlkYrV8qNMIP2wQ4FhMrjPdK081MpNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNLFf+dg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNLFf+dg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1DC1F000FF;
	Sun, 27 Sep 2026 19:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790536817;
	bh=eqRtTpcMaqlYPCPA8/lOkTh+UCeNEAv+LhDVEoTL/UQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KNLFf+dgiw/Xm0dZqQibNAiqjVZAcj7qBQBlt7IM1WbYs8NCHOXEw9KpeatVEdJUJ
	 VT+nU4AD/QfuAoSPXATq0jAfUzknRze8oyKf7cmlZB/V9A62cHRWMfBHM/mnOE8X3S
	 w98mhSnpu3mcxtaqwlo8A8LDdj2XZ1Z/wdpF+MyTs7wdAEvC0exvd0j7hM81ysY4vg
	 PNXueinVc2cl03UhSA72Jg8jkb2Qdics3Crd3x3zuxu/FaYuhFhOlT31TeCyZ2m2QH
	 Yrg58ABF1x+lwvbcjyYDEjXxyGMc03rtvO8rqEt43WCgIJblqcUzcT8M637pUE13Ge
	 NRrnehj1QpwMw==
Date: Sun, 27 Sep 2026 19:06:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel
 Lezcano <daniel.lezcano@kernel.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>,
 Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH v3 6/8] iio: adc: rzg2l_adc: Rename num_channels to
 max_channels
Message-ID: <20260927190615.30b3be49@jic23-hlaptop>
In-Reply-To: <CAMuHMdVbyktVBAwBh=LoARWHHmb_FrF+omeDvNdR76uxus3mPA@mail.gmail.com>
References: <20260922042707.116378-1-biju.das.jz@bp.renesas.com>
	<20260922042707.116378-7-biju.das.jz@bp.renesas.com>
	<CAMuHMdVbyktVBAwBh=LoARWHHmb_FrF+omeDvNdR76uxus3mPA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 16:33:51 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Biju,
> 
> Thanks for your patch!
> 
> On Tue, 22 Sept 2026 at 06:28, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > Rename the num_channels member of struct rzg2l_adc_hw_params to
> > max_channels, as it represents the maximum channel supported by  
> 
> ... maximum number of channels...
> 
> "the maximum channel" (aka singular "max_channel") would be equal to
> the maximum number of channels minus one.

Ah. I just looked at v4 and realised I'd not been paying attention.
The number isn't the maximum number of channels because it's a sparse
set for the new part being added.  It is the oddity of maximum channel
number and as such.  Ah well. I think at this stage this distinction
doesn't really matter.

Jonathan

> 
> > the ADC hardware rather than a count of channels currently in use.
> >
> > No functional change intended.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>  
> 
> > --- a/drivers/iio/adc/rzg2l_adc.c
> > +++ b/drivers/iio/adc/rzg2l_adc.c
> > @@ -62,7 +62,7 @@
> >   * @adsmp_mask: ADC sampling period mask (see ADM3 register)
> >   * @adint_inten_mask: conversion end interrupt mask (see ADINT register)
> >   * @default_adcmp: default ADC cmp (see ADM3 register)
> > - * @num_channels: number of supported channels
> > + * @max_channels: the maximum channel for the ADC  
> 
> "maximum number of channels", to avoid confusion.
> 
> >   * @adivc: specifies if ADVIC register is available
> >   */
> >  struct rzg2l_adc_hw_params {  
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

