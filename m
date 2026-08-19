Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67263A05F2
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787146246; cv=none; b=UcCdi6UUdz5xkkw8AHbebsZVZnwF/ilIiKLOjw9W0ZcdZ9AEXFETyKiNnLj2tXbgzwkcJ2YQMRxEJtAAHCBNKaQ3+t+jMu37tPuhY0xhPNEkFW3zLpJ9F6amp09BNDKHy2KmCEXdfs2a8S9HxeXxnzja0+yJQc9+FG4gqpmwTEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787146246; c=relaxed/simple;
	bh=4gSwkan2L6CEisBgarTBd82x+gm9pt9Nh/78UILyg5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSp3sBEqSFOorBXMZkzMyQuldBkox3z+dBUEDfrVCbKzw2B2gxX02raqLKU/4YFi6N3BP+5hSAxWBwqWryx+LSYmu6EnId4MjUIkIK4ej/WY8RPnNkaQBWCBsRFODMHtp7NvhPBi1lzSM2gLFp8FvMmy5k/3X9yyuGo45CwCTA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPUasIj9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPUasIj9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A65C1F00A3E
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 13:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787146243;
	bh=Wy+D+ESTTq/dSV8mhmm+rhMC+Crd5u0rz0n4yla+hGs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aPUasIj9J9ETAKkXY+xz3TK125/aXZYjKzFmuOkfbiiU6/19xiRkGoYKKBAsT8WxR
	 QBKYCqbs49DV3cgMcXgHT6zGootPM+lszjhmfFD9fcpQYefWkk1lRr56QoIqqH6iEN
	 rC6xB0mB9mkb1GOgRBaXc5IY5EMSRj8qW60VDICji5wM+RBJQog6XmfZXcVUfrNZVL
	 tI0TyZHQ+3I+wgbDVL/bPi+wsJQha090rSdqoQfAnpwtw64dUr2Wd12xOYZ93ECvLT
	 4oLbcbZ+qzeRb0Yb/VtQi4oH7EvFBO6jE2r5JxA6u49vhaerF/9ndVpaKe6aShnILS
	 GQJEhWHiA5uGg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b0231a3e86so1077632e87.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 06:30:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RorhvQ8FiTSbrSFgGD2T/NeIpzjCQW9MVq/bFMpG1cz21PqKYDZmT4CmmgY9yXNq0WKvxsaJ77jrg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdvLMx1M+u0jml8SvBITVXDbM+m/jU8Mh1ik4sCA8u4M5vNSY+
	s4HrldTbbOlWfCphKQ0nHH9/rg68OSpUFgc77scA3YPQIR1ExtyyOD9e1H/KoUCLdmQtDupRJFX
	yIcuNBojHYJhHQ38O88NtrQJF9XWAK6o=
X-Received: by 2002:a05:6512:6d1:b0:5aa:5ef9:a33 with SMTP id
 2adb3069b0e04-5b478bdb85fmr1801632e87.25.1787146241774; Wed, 19 Aug 2026
 06:30:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-10-eb5e50b1a588@kernel.org> <CAPx+jO-ow2vo2wMxERLGse88wLoaR=HLdOWk6Qwv97ZdbE4R5Q@mail.gmail.com>
In-Reply-To: <CAPx+jO-ow2vo2wMxERLGse88wLoaR=HLdOWk6Qwv97ZdbE4R5Q@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 19 Aug 2026 15:30:29 +0200
X-Gmail-Original-Message-ID: <CAD++jLnzDmxW_SoJ9H1tS2_r+jd7A7FpLVp37nK=dOEPj=GExA@mail.gmail.com>
X-Gm-Features: AcwNN1VzmKR08mtjCfHfPMShMvTxNHeVOcLQxu2aSZ4UbCwVZegKiNNfpCmjf24
Message-ID: <CAD++jLnzDmxW_SoJ9H1tS2_r+jd7A7FpLVp37nK=dOEPj=GExA@mail.gmail.com>
Subject: Re: [PATCH 10/11] regulator: db8500: Add power domain regulators
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Lee Jones <lee@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 5:53=E2=80=AFPM Ulf Hansson <ulf.hansson@oss.qualcom=
m.com> wrote:

> On Thu, Jun 18, 2026 at 7:01=E2=80=AFAM Linus Walleij <linusw@kernel.org>=
 wrote:
> >
> > Add a DB8500 regulator driver for the VAPE and VSMPS2 compatibility nod=
es.
> >
> > Back the regulator enable state with the corresponding power domains.
> >
> > This is done for off-chip consumers: the corresponding voltage rails ar=
e
> > routed out so they are used for powering different peripherals using
> > these voltages as supplies.
> >
> > Assisted-by: Codex:gpt-5-5
> > Signed-off-by: Linus Walleij <linusw@kernel.org>
(...)
> > @@ -673,6 +673,7 @@ db8500-prcmu-regulators {
> >                                 // DB8500_REGULATOR_VAPE
> >                                 db8500_vape_reg: db8500_vape {
> >                                         regulator-always-on;
> > +                                       power-domains =3D <&pm_domains =
DOMAIN_VAPE>;
>
> Hmm, isn't this the other way around? The power-domains node should
> have a regulator supply?

They probably have that, but that is not what this is about,
it's the other way around.

> We may even consider to skip to model the regulator altogether and
> make the power domain operate directly on the prcmu instead.

That is what the series tries to do, as a whole. Sorry if that was unclear.=
..

What we do in this patch is to deal with the fact that two of the power
domains, when enabled, also turn on two external power rails outside
of the SoC.

Since external components such as I2C devices cannot really be
claimed as "being inside a power domain" they take a regulator.

This is based on my understanding that power domains is an
SoC-internal concept only, so there is a clear boundary if something
outside of the SoC starts to use such an externalized power rail.

All this regulator does is to make sure the corresponding power domain
is enabled when the regulator is enabled.

I will repost all the patches once v7.3-rc1 is out.

Yours,
Linus Walleij
