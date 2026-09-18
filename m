Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E665251DB01
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 19:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789761133; cv=none; b=SvSJ+5gIvLhflvmN0dxtoenHlYoTPuqPuEf3d/YtndiEuJrVpc12nl5heBkw5OKXjdEPdZ5OHtj+mBs+4VJsH6Jz1sYY2dY5uuT8pPmHyTR1RpbKxMElf/6VLFIHwGMZTdSg9PhFF3Du3qKBEr+7Q1YcqWlVVsL0/nK83uM6840=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789761133; c=relaxed/simple;
	bh=GvLNCDNFJca2SZB7bGwmDI8D0tBR6aZy0yCPA3XIn+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixQz7aSQQ9Za+KPD2KcDK/0YtQBYMcXPKyGV6+Da/fca9OCU0WgdYRpDiL6il9T/9LwFtvOC3p/Nw4GwwZNtHWhLnbuObm9Kx5oCo9xYI1Lt2yWmchLIByUmcCJGyQOu8GBFm9nzwMCA+Vohimnvqamu5rFZopjhe6IYQJGIn7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gm6qzNfW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gm6qzNfW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159F41F008A1
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 19:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789761129;
	bh=2aZ2SRdSwMAy6l7corBl6TSn3cdYhbUcwCmUTuq+Lz0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Gm6qzNfWy5SaEaZiWboTlhe73I5Y3sKUdV6dA1lzHfVwoETVwe+9hP7CmVBl37W43
	 X8HruD8sWl9SRDFkfNmCHKrzypv+Oh0peVFrVCV026JEEP8+eguYm8Yy+gakSLDM+e
	 h+m+fv9lnjTbvJ0rf5+NYRXRuQ5NW4+Vjc2dCMAq2MKfiznZQPeqnMlra/QJxE3iaC
	 KzUnoA71jnKCeftkRbab5KjOcfPHnTV4eVW8WJUJwQFgArkQpF4yQyg/dR7XURkReL
	 1QIjIi01Po7Ajp4zITvll8Yj5PdiraLijx4XpY+89UhP1uEzsw2oSatYZ9aWf2cc/X
	 F/+VsHDt6R/cQ==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b899413537so1620586e87.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 12:52:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxju+yknTKMJ8wybV3N140c2UU/w1HDmgjmvN1rY76JX+o4gnEazP3csoGdGY3j5ssdalNdHcRhNw==@vger.kernel.org
X-Gm-Message-State: AFuF++nLASCIFak42YnYnI7ALeGfeDUW3DiQZbffuxCVviND7ojKkjWv
	2HkF6BmRKehG51ABB7O7m7Ve5psZKzL1Z5OQDrSoeiIAs6NRMHMA4660LhBoDzTOzXT/sDbeNpS
	cEShIIR3FDP9qI+ZtUDSoY7twoLYEKBc=
X-Received: by 2002:a05:6512:a94:b0:5b6:183b:d1fb with SMTP id
 2adb3069b0e04-5b8c184918cmr1248231e87.34.1789761127739; Fri, 18 Sep 2026
 12:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
 <20260914-ux500-power-domains-v7-1-v2-17-9d0c17e1f816@kernel.org> <aqhg8fCuVBqDvRrh@lizhi-Precision-Tower-5810>
In-Reply-To: <aqhg8fCuVBqDvRrh@lizhi-Precision-Tower-5810>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 18 Sep 2026 21:51:54 +0200
X-Gmail-Original-Message-ID: <CAD++jLm-_-a1ROYBYPo96Tp+qdUr2Ka=F1H0O=ngoqJ9wrqyqg@mail.gmail.com>
X-Gm-Features: AcwNN1VfgwBXDgi6e_-s2oKD27ppfBOu9eGlZ28XYdT8IngR0jAuGkn-SUSGs0s
Message-ID: <CAD++jLm-_-a1ROYBYPo96Tp+qdUr2Ka=F1H0O=ngoqJ9wrqyqg@mail.gmail.com>
Subject: Re: [PATCH v2 17/20] dmaengine: ste_dma40: Use power domain for LCLA SRAM
To: Frank Li <Frank.li@oss.nxp.com>, Saravana Kannan <saravanak@kernel.org>
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

On Mon, Sep 14, 2026 at 11:02=E2=80=AFPM Frank Li <Frank.li@oss.nxp.com> wr=
ote:
> On Mon, Sep 14, 2026 at 01:54:45PM +0200, Linus Walleij wrote:

> >       if (base->plat_data->use_esram_lcla) {
> > +             np_lcla =3D of_parse_phandle(np, "sram", 1);
> > +             if (!np_lcla) {
> > +                     dev_err(dev, "no LCLA SRAM node\n");
> > +                     ret =3D -EINVAL;
> > +                     goto destroy_cache;
> > +             }
>
> sram is used at many place, is it good to put into
> drivers/of/property.c DEFINE_SIMPLE_PROP to avoid set up device link by
> each driver?

I have absolutely no idea if that is a good idea or how to
even use that macro.

But Saravana will know, so let's ask him!

Yours,
Linus Walleij
