Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41703B6C13
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 20:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787258141; cv=none; b=mKTXR4xKf21t+8ZCspG8zTj20JVlbq3jCX1mQk997oJRxq/NYz2k3UT/hM1pJbprm6NMMsrFPEQwMvGkAZEMCMsdB8laqpwEq3P775mA1LXhzuMhta+JtEUTtpXVxH57t3yr+NpM8IQn6Q96NqCLWRoDTQy++ZRWdlH7BPSfwkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787258141; c=relaxed/simple;
	bh=i7Ql33ixi0sAp+Eyd6k0oHoZUzox/mt7rZrrQhw+QUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cvo6cW/UQjKCSgopEovqDz6sN617CUVBumHJ/vIYNOQb1pXKbi8dVOUkv94uYIjQhwG6O0YICWzD6hCsIJ/7y7Zt8e7kaTqylkkAFbNULB+D9sf0RPqlDDGxYpyK8efvgtBE/ME5Ex3UqfGMtS7B/R+ShcfF57FkpnVzizg1Krw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOg4onsl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOg4onsl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868871F00ADE
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 20:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787258137;
	bh=LVEvLIPEcNpWvW+7WYHdCYmT4bTuxYZ+a3551AYtS/Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hOg4onslcA38Hz1lx6d7G5Xr6jcrVkEEcFnoBs0zHrSlWtT5X5iddGpl09CaduWzo
	 PecB+yoWN/lPyN3F2hfFNxAS5JyU4onRiaKBNGmdN56nHSdPjjSc6UGl/gNhQeHgEW
	 QvI1FXqLJSl3wSwPJCd3jBLgliEx6yzqnEXgta8QhxMp9bezyA9acP4uB88mIp5A6i
	 /xBVDLen4o25gAGmhPTdGmZ66F0cGfTI2zVZRhNe+55Cgbxya6uSf9yeG4bd5CTgra
	 dbJBBxEhRBJSDTdf+xrPnCSvjXEQOzizXW8YCJtRteyJEkZXMOcbaCbwboXY+n08/e
	 Qsw9X5HhGW88w==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b0f19bea2fso268643e87.1
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 13:35:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrtQXRP5hqIOiTJTxgtO5UrkoTJ9mj25dE1EqoQLr5OIgo/v18vNRb+3YFBhEj6sFsTneIKDglVCg==@vger.kernel.org
X-Gm-Message-State: AFuF++nQKPnL3mOmjMDlJ2QeKZUka54HVuBoULKKLtAqZxMdW/Z4CcrM
	xGlV4HfPCLqlzFRz2MFPFpRgWmgB4ZMhFKQQWFKsRkPXw2JlTocFPl/VmpdQMUX/UzTE6fy1yIF
	wlP36alFeco26beQCmfLbkKbPrLRITzQ=
X-Received: by 2002:a05:6512:8346:b0:5ae:9c19:165c with SMTP id
 2adb3069b0e04-5b4841e27d3mr252495e87.7.1787258136265; Thu, 20 Aug 2026
 13:35:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-10-eb5e50b1a588@kernel.org>
 <CAPx+jO-ow2vo2wMxERLGse88wLoaR=HLdOWk6Qwv97ZdbE4R5Q@mail.gmail.com>
 <CAD++jLnzDmxW_SoJ9H1tS2_r+jd7A7FpLVp37nK=dOEPj=GExA@mail.gmail.com> <CAPx+jO-+hLsAdDC9Ep16cO52cA2c=xKeXvngkGqzoC0FyxXj+A@mail.gmail.com>
In-Reply-To: <CAPx+jO-+hLsAdDC9Ep16cO52cA2c=xKeXvngkGqzoC0FyxXj+A@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 20 Aug 2026 22:35:24 +0200
X-Gmail-Original-Message-ID: <CAD++jLnVsYhHjY5XB1kU8c-1bH4PGkR3quiEGVgkb_0_X-7hjw@mail.gmail.com>
X-Gm-Features: AcwNN1VO70LvbVfj0Q2UgJnPHtAU9I9kBvApsB1ktj4CqAz_-IVL1-eYcTJPSeg
Message-ID: <CAD++jLnVsYhHjY5XB1kU8c-1bH4PGkR3quiEGVgkb_0_X-7hjw@mail.gmail.com>
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

On Thu, Aug 20, 2026 at 12:24=E2=80=AFPM Ulf Hansson
<ulf.hansson@oss.qualcomm.com> wrote:
> On Wed, Aug 19, 2026 at 3:30=E2=80=AFPM Linus Walleij <linusw@kernel.org>=
 wrote:

> > > > @@ -673,6 +673,7 @@ db8500-prcmu-regulators {
> > > >                                 // DB8500_REGULATOR_VAPE
> > > >                                 db8500_vape_reg: db8500_vape {
> > > >                                         regulator-always-on;
> > > > +                                       power-domains =3D <&pm_doma=
ins DOMAIN_VAPE>;
> > >
> > > Hmm, isn't this the other way around? The power-domains node should
> > > have a regulator supply?
> >
> > They probably have that, but that is not what this is about,
> > it's the other way around.
> >
> > > We may even consider to skip to model the regulator altogether and
> > > make the power domain operate directly on the prcmu instead.
> >
> > That is what the series tries to do, as a whole. Sorry if that was uncl=
ear...
> >
> > What we do in this patch is to deal with the fact that two of the power
> > domains, when enabled, also turn on two external power rails outside
> > of the SoC.
> >
> > Since external components such as I2C devices cannot really be
> > claimed as "being inside a power domain" they take a regulator.
>
> So with I2C devices you are not referring to the I2C controllers, right?
>
> Are you saying that these external I2C devices consume the same
> regulator as the power-domain DOMAIN_VAPE uses?
>
> I thought these types of external devices in general use a different
> voltage range. Moreover, do note that DOMAIN_VAPE also has
> corresponding OPPs (performance states) that change the voltage level
> based on the requested OPP. I am not sure an external I2C would be
> able to cope with that.

I did the mistake to trust the device trees :(

It seems all the device trees are buggy, because components
that should be connected to VSMPS2 from the AB8500 PMIC
have been instead connected to the DB8500 VSMPS2 power
domain... The one instance of VARM being used outside of the
SoC was a bug as well.

OK I go and fix this, worst case I add a fixed regulator for it,
it's an "always on except during sleep" type of thing.

We should be able to drop this patch entirely!

Yours,
Linus Walleij
