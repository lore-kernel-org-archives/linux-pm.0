Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F76579CD
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 11:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773402163; cv=none; b=HwpTi/hyk70tjN8z+CNzJTqUfhnYEuZn2MG+UKXHqnQ6A/DJi4agKspu6vjVxRSamd6oy1ufWSz6J96zZLNd1YEbmJEg+3z2NHE5RrfjgL0ZGafC1A0bIrE9X4uvj7xLZPAcibMS1UAtn0AW6aDqcB+Q903R5u4LaEQfdAeQWEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773402163; c=relaxed/simple;
	bh=MpDy9kxJirWIecuc/r/fCES5V/lGLJUYErRHXyLbLAU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IrD1y0CyZa6ktnrziuJVn71BKAm7sGJdplWTx6vV0Ill43D0F7yJsak8cBIp2M9tx9Hx/ngnLnUNGzgy81pjpxNjvJhhAcToaUkuD6NkuN6pE0vpNFtSdnU5Dut+CQblfguP7P7M42Sxpd6K2sw6JtxiYRSyvRGNk448iO84R08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ng5SEgnW; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ng5SEgnW"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-661b08b04deso2317569a12.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 04:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773402161; x=1774006961; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o2dyCthQPSviIjLo6GGJyjNwIRguOwqd/MGhvd/maVE=;
        b=ng5SEgnWWmD2Ec2hDVmgqgWDcFz9SqSjnguXdY6fpr/0i8sxJIcjIWptwHhwF/pcYn
         TxU8EpRDSyeKNs3P3lmtbALG0I2l+eDplj9cYfRNwxuwhaAgoswaYqxc0z73Je7iKl9j
         Nej3pWA2+RzHo5KTQBS9EuSFzSQrE/p13w0OnNOjFXq+v5xVaMqqyZp0HsLlvzP1vpsL
         dEKahMtADN4oML2vBGvCaahw5LHwnDwuNjBBxxAeq+wamK9yOnRrs0DBNx2FXq/uIEQk
         7Bf0isAJgqjM1eKeA8JjzYz4KGslXoUAQP8+FcNCix4csVy7K23vep3cOE3J2BrcJxE5
         A6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773402161; x=1774006961;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o2dyCthQPSviIjLo6GGJyjNwIRguOwqd/MGhvd/maVE=;
        b=SUy8Tuh6QqGAvWekSGkT2aQNIdtMSWnP50c8bVXe5XfMd5D/NI08bSl7bzthvKyTIV
         FFvfhRH2vpZtWhU1+gFJTEevTmfXr/0WFW69OwQTxkIM6LKHo/x5AUwjtP1T4ogxSrnZ
         fw0ehU6s8o+TXbOmnGfLml13XdxOObaiidNRsm5tVsViSUok+qoLGWKaNdYPdzakEmgE
         /mmYmsWtRmkOwIRG7inIdaDZo4Wg2sct+AIT2GBr/IMr0RED4pu4LHSs9u/Wrpmv8ARz
         17H6aoOxB7TlO6tDMIawiuPgJKIEnxPFv4ytDPEoDq4w1SjE+fUb0tW5yjNMnGVYmIEm
         D1qA==
X-Forwarded-Encrypted: i=1; AJvYcCUXPOu0WxThliPXhEYSQSKQ15qN+JQpsHWT23afezbrQtWkVT3iJ2KdrU0GB+QfR/2VY4wMk0hN5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNHMbWmq8DhhZDby9+OeL4CF/wQo7RfFE8sT/rDDAjgPlTgUWn
	542Fx1RU6kCnDzULGkOhFF11xfbyzfD3tzOy+V0r6wf8ePjCm7HoHgtEr8IVagNmkRg=
X-Gm-Gg: ATEYQzymzQC9dfvmFT8f+c6w4WOi/Gh4/TBI6IWB52YO8NwDamzCrkWqFF8vYdRrD7x
	jvVrHAenXKNMDqjJaPoV76i+H1/SWvD9+ZoAM6mRUCueBXIN48Tj+FtB9YdTi3Td9CNErtZ58mt
	QsBS4FdzvUxgWuNYhEhlNQEsSX6DEPWVBoTKmIZaIpxkgO8udAj5YKAs7TuNzqOrI/X0ra9rPrd
	ynirtWrwsrJFRN2NDyvmH3V+PEWIi5yJQx8BQZN0/j3uKuK3sRuNIflgJQiF5NOC0p1tDNGizgK
	IKx/QWoz8YK55WRsWjJmtKdQu+ZNo8pmtlZLIJFaIRWOt+gvDapBHghx/scmvFiAaikhruUJeAw
	hhU9q3rLVYDcjSlNxUIlHGNUocRkrtZnjPFiY2WiED5aEQkNvMjsg1Ou9Mst4Af8wkkNTIoPQ/G
	0tbcT5jBnoA8c66TUkLjLCLntROSR42Q==
X-Received: by 2002:a17:906:a291:b0:b97:c19:2972 with SMTP id a640c23a62f3a-b976500f96fmr117661566b.5.1773402160491;
        Fri, 13 Mar 2026 04:42:40 -0700 (PDT)
Received: from draszik.lan ([212.129.81.187])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b976cf02b14sm40474666b.51.2026.03.13.04.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 04:42:40 -0700 (PDT)
Message-ID: <451f74528021a67b40a4d08fdd0e5c80f6a90025.camel@linaro.org>
Subject: Re: [PATCH v7 04/10] dt-bindings: soc: google: gs101-pmu: allow
 power domains as children
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>,  Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Ulf Hansson	 <ulf.hansson@linaro.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown	 <broonie@kernel.org>, Peter
 Griffin <peter.griffin@linaro.org>, Tudor Ambarus	
 <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, Will McVicker
	 <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Date: Fri, 13 Mar 2026 11:43:24 +0000
In-Reply-To: <da0726da3e59d83985650e8281ed945018a356e4.camel@linaro.org>
References: <20260306-gs101-pd-v7-0-03f7c7965ba5@linaro.org>
		 <20260306-gs101-pd-v7-4-03f7c7965ba5@linaro.org>
		 <20260312151228.GA3136988-robh@kernel.org>
	 <da0726da3e59d83985650e8281ed945018a356e4.camel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8+build1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-13 at 10:48 +0000, Andr=C3=A9 Draszik wrote:
> On Thu, 2026-03-12 at 10:12 -0500, Rob Herring wrote:
> > On Fri, Mar 06, 2026 at 10:29:55AM +0000, Andr=C3=A9 Draszik wrote:
> >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 system-controller@17460000 {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "goog=
le,gs101-pmu";
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x17460000 =
0x10000>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <1>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <1>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ranges;
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 google,pmu-intr-gen-=
syscon =3D <&pmu_intr_gen>;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pd_g3d: power-domain@1e00=
 {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
ompatible =3D "google,gs101-pd";
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eg =3D <0x1e00 0x80>;
> >=20
> > I'm assuming 0x1e00 is an offset from 0x17460000. That's not what range=
s=20
> > says though. It says both addresses are in the same address space=20
> > (system-controller@17460000 parent's address space). You need:
> >=20
> > ranges =3D <0x0 0x17460000 0x10000>;
>=20
> Thanks Rob! On gs101, the PD driver can not do direct mmio. Instead it
> needs to use the regmap that the parent has created and apply the
> offset from the PD's reg property (using struct resource::start)
> (patch 7).
>=20
> When using ranges as per your suggestion that doesn't work anymore,
> as resource->start isn't the offset anymore but the final physical
> address, and using that in combination with the parent's regmap
> doesn't give us the right address anymore.
>=20
> Is there an alternative other than using completely arbitrary indices
> like e.g. rockchip is doing?

My driver could of course peek into the parent and get the parent's
IORESOURCE_MEM and subtract that start address to get the offset
back.

Is that considered clean (enough)?

	ppdev =3D to_platform_device(dev->parent);
	pres =3D platform_get_resource(ppdev, IORESOURCE_MEM, 0);

	pd->regmap =3D syscon_node_to_regmap(dev->parent->of_node);

	pd->configuration_reg =3D res->start - pres->start;
	pd->status_reg =3D res->start - pres->start;


Cheers,
Andre'
