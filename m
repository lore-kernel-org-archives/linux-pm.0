Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E60241695
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773411288; cv=none; b=tIlv59OJUVOtxPPuDDg8MMTT0jPSqRayMxTYjv0QAWM92joPIgui/mr/LlETRKIdaGPEKAmnkTRurWOp9HF80y5u9kNO23jeGIzzbnBIc4vQtTnRTC9Nq6rqpSAO5x0YqigBr7DMfa9fqLSg2v31DUwYcoaMwaxMPE8EZTqtGlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773411288; c=relaxed/simple;
	bh=yxLMf+p2GuGBniwtiAZ7R8MSn2ihPWUg3zgiw3eOsUw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i2tSbRg7cuV09j80E2dPYArHz2PyABzY+aOtJ37ZRqytALPT82J3gCcN28C6IDcrvEfEAT7p6fkRv9e9W1L5eyOuA9B0jobeQcR4dawSdw64zqYUvvf/0HNsZAsM2/o6REhW0w8bBs1Igs/rvoL+rXAP4g/efd4HjDPrf69uhf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kciLrQqA; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kciLrQqA"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6615c461d3fso2169036a12.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 07:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773411286; x=1774016086; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yxLMf+p2GuGBniwtiAZ7R8MSn2ihPWUg3zgiw3eOsUw=;
        b=kciLrQqAi4EKYCA2AxVgKL4yEu6as0tpMa11p2mqIegQglDtql0VHepjsij6F2hTI+
         lwjJEBtOkmmH/K09zAxbnmUd80rPndsgdFGPxLxjEoRMa1NCk4mMt5KfPjMseeEjKcBk
         +4Fl+peOANpOSi0FXnhTsRB+Pymp4mAsTn6+ady4RP+MyFSH+Yvo9B4p8mjUThXvKkuQ
         LCEENHm8yDRUNtWfKbOZfgc8keWcqUR/SnUYwFTuYr27MVWSXrqbUtLX608G/NGG9NW2
         9t6O+zi9Y+b3+qUX5Fe73i+OpW0WOJUYRRdaK0qJyg4c9Tylo7vwz4ZUoTEioZyIepHV
         zwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773411286; x=1774016086;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxLMf+p2GuGBniwtiAZ7R8MSn2ihPWUg3zgiw3eOsUw=;
        b=ZS2FzkxCXLu9iVGaRQmWTd4oU+YcAxlfcziMuEfdZrbCezdUm7wPCMYkaWVNJPAPoB
         bpn0O9WXd4TnsgrEMHcaGSeS/eawgEcnQh12uPf+mcwcH4uZjVt/kDSn6ldq6PiyW/j0
         iRBdBH9ldcL8ng7iZxgOnD+lAimk+6e45F9GQQH4/TKgZUhygl3vI+xzbGsv+djA5CJq
         TgtcyyumH71vUtlMkI4DlTeQjoc/lz/aKDpo0HEe3AI0rGDml2mSpWBhBGDsD2SJoCoY
         kN3tUpwY6BnZ5Kwl8sVRPpfhFQB8C8OiHlqA/a1tASnQQBKZovUw1ApOU+HJktgb0dz/
         9FDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSZ+/8hxRzgTm0R/g5/fxGo0lXiIZreSw3JC1dNJK5uzxqjEiFqPkRFwdcx54N+Bn4o8a8OX6AVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YywYviPRvBJ1SvIE3V4BA8rIH4jmJ7NS5ot8PzBfPP+w72XpT6/
	tPKFcBEsdtNcQ1UFBnmHbsvF5u44f6vtEGGCrIr/ZEOTccqWDrb9iujVIlPnM/KKgzU=
X-Gm-Gg: ATEYQzy13p2zzLZXxWysTWqVSbRNjxV4NUqOu7Cqa3tydqqQpY5kingQTXq8YaoCZJ5
	xqBHuZHV+IjEk6HMODg7GRuzIW3biTQn0PAcXeRwHAZfPgYqhFVfx2nmcyCw4E9c/3eWspdzJz3
	UywUFETZeSbufWnGJCEjkv5DvcDTXtbHGSQwNSX3rIiKwPpIEYFBR+z2XBeNaCkcSQ6VNHI6KlE
	K1vR5hHJldVm2X8mQNQ0nb/GPnW+t0IOQKZwLNiOQoGLKGeqReKiuZA4BzQQcVNSECLIFA7x0z3
	8Uas/LSKqxBrMwOlRBPVHYtOVF9gQo8xpAgeNinIxaHg8OlH90+nghC1Q8yv2jxqAHrlqcczvcS
	oRLfoX9M2Rp/bAuMJJ6+cInd+7Tf4sJ3rTbcnlcn5/K2du7u4PeM/5S/Y3sP3X0HcaP6T9kkGMu
	1HtuJSd+By/NGsbeYqy1tC0Wx0H3S4eEA4HGBn15Ec
X-Received: by 2002:a17:907:e98b:b0:b96:f6f1:e7d6 with SMTP id a640c23a62f3a-b97650e6e1emr210223966b.18.1773411285513;
        Fri, 13 Mar 2026 07:14:45 -0700 (PDT)
Received: from draszik.lan ([212.129.81.187])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b976cbf4879sm49502766b.17.2026.03.13.07.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 07:14:45 -0700 (PDT)
Message-ID: <82d2d515a38eabd78951effff1dbc459db864130.camel@linaro.org>
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
Date: Fri, 13 Mar 2026 14:15:31 +0000
In-Reply-To: <CAL_JsqKeSimB6OYFzOk2tWy-nbFez3qRwWrc=yD8uKDALYP8pA@mail.gmail.com>
References: <20260306-gs101-pd-v7-0-03f7c7965ba5@linaro.org>
	 <20260306-gs101-pd-v7-4-03f7c7965ba5@linaro.org>
	 <20260312151228.GA3136988-robh@kernel.org>
	 <da0726da3e59d83985650e8281ed945018a356e4.camel@linaro.org>
	 <CAL_JsqKeSimB6OYFzOk2tWy-nbFez3qRwWrc=yD8uKDALYP8pA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8+build1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-13 at 08:26 -0500, Rob Herring wrote:
> On Fri, Mar 13, 2026 at 5:48=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik=
@linaro.org> wrote:
> >=20
> > On Thu, 2026-03-12 at 10:12 -0500, Rob Herring wrote:
> > > On Fri, Mar 06, 2026 at 10:29:55AM +0000, Andr=C3=A9 Draszik wrote:
> > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 system-controller@17460000 {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "go=
ogle,gs101-pmu";
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x1746000=
0 0x10000>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <1>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <1>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ranges;
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 google,pmu-intr-ge=
n-syscon =3D <&pmu_intr_gen>;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pd_g3d: power-domain@1e=
00 {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 compatible =3D "google,gs101-pd";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 reg =3D <0x1e00 0x80>;
> > >=20
> > > I'm assuming 0x1e00 is an offset from 0x17460000. That's not what ran=
ges
> > > says though. It says both addresses are in the same address space
> > > (system-controller@17460000 parent's address space). You need:
> > >=20
> > > ranges =3D <0x0 0x17460000 0x10000>;
> >=20
> > Thanks Rob! On gs101, the PD driver can not do direct mmio. Instead it
> > needs to use the regmap that the parent has created and apply the
> > offset from the PD's reg property (using struct resource::start)
> > (patch 7).
> >=20
> > When using ranges as per your suggestion that doesn't work anymore,
> > as resource->start isn't the offset anymore but the final physical
> > address, and using that in combination with the parent's regmap
> > doesn't give us the right address anymore.
>=20
> You are mixing kernel implementation details and h/w.

Just trying to get to the best solution, considering both.

> Are the
> registers in the child nodes MMIO or not? If not, then drop ranges. If
> they are, then what I suggested for ranges is correct.

While they are MMIO in theory and offsets into the parent's address
space, in practice access from the OS is not possible via mmio APIs,
only via the custom regmap created by the parent (which defers to the
EL3 firmware) - hence the driver's need for the offset from the
parent's base address.

> For MMIO, your kernel implementation options are what you suggested,
> do a regmap for each child, or use of_property_read_reg().

OK, I'll go with the first option then, thanks for your patience Rob!

Cheers,
Andre'
