Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A832F6910
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 10:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773398893; cv=none; b=DNgNpiehTwO2OlkEECxqdTxZkkHVnPNtMjPatBn8195wblz7iPufwAtj5jnJqcvz3fw+k7GxU4+mt6/HOYr7gHyqniwO2ZW3YEDzmDC6octaOgy9u9zBrcPehhkbDhHQsW09vunmgshWPum5gEJ6t+tuZ3TM2nTJed9aokGP6WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773398893; c=relaxed/simple;
	bh=zzplZJ4Qyk51rYHGGTOx2eXlOHiYAraldVZ2IfKSWm0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B1zy8dmm+LER//XL9xKbB/mBFhY0YdX1JKJE2mdhspq8T7rDls+mqWRbaW1l/QXAu5DuhE/CIwADu/zNOem+rqdP45N91k3cjVUr6d5G0EKJk6yJpNm2BE5fE7M+Ue+HHBbuQIToN7aFBC9rG9anvNHUJmV4O6eueAn/dlTpq1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fQfqXbF3; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQfqXbF3"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43a03cb1df9so1642280f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 03:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773398891; x=1774003691; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zzplZJ4Qyk51rYHGGTOx2eXlOHiYAraldVZ2IfKSWm0=;
        b=fQfqXbF3hXT91xZVm4lwyVdXMB2ZYGv2r6RtxrqBmzJzZmL8zLLHGZlhOeY9RTFHXs
         YVi8VRkcWNiGQFfvO4lW2syuRnxBVQiE8Qm+xyBIyfnezP1K42bVBnNa6Fpbbr/aedM9
         wY9GvGNiinCYZlBKH1MeWicNKtkaN3j3sne2l3IAcfzKF5CQVzd//1847fbo8Dg2Y9ng
         fRtPAHlBPl/0+hRshaq+LhRhJrgIVKDj9IpSrwbjrfGhJXaUF11E+tXa6XZo4sVNZQp/
         o9oZlZPy5gd1t9tWymKlDpTtIdc3o9uFG7QZoOAHFFoNnx1KLNWAgUKftvVlA4i1Zgeo
         imKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773398891; x=1774003691;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zzplZJ4Qyk51rYHGGTOx2eXlOHiYAraldVZ2IfKSWm0=;
        b=mG6lsqUdaXh0rKzTI9ZOYQcL7w/Xr60b2h18EeHW7k5w4qDYx7DV+djn79Ta0i0H2a
         FCg42oYmE4Ccwm2R6cfuraNOKhVUp3uaEQbqX5p9cGD+BAG1k9AgzvhMQfbPk0e8TG9f
         qvH9uBerj4LXppm0NzbKLzCk7ngepof/wKwvc8yIEL75gUTfhnt4WcK+NYF+nlfkEE3A
         0bnep4uoZfhc2bWPWJ4g/YOLV6qeRF4+V4mn2R6edgWivdie+1W+I8ZF0ni1zTClSTKM
         YQQBZda20fH7ZmnGnwvjspxtU13zZhu+KR30rW42tD2EDew9Vn/WQNa45+RFrGFWgpAF
         cZYg==
X-Forwarded-Encrypted: i=1; AJvYcCVa+r5LLNNKlDNsxs1UQAGB85X/XCJVwDQLCjwrqnwPwX2JFSlDPhSw42RpIuD/4G6o/YwwGmopuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz29r7BLrMwkTLtgUe+QbGnSUBWWmIuyKvkTk3ftKMRO8hd3u7f
	FjKSE8zcizIRpI/NKtbEzcN+58KdfHefiLdX4PmuROmkfU/VBp2idg7t4utoan+mPfQ=
X-Gm-Gg: ATEYQzxokOsx3FYErkBp1X361P+ud28nWj1Eep4Wg/wolxS8CP8gHQpIiyW07KtinIR
	awozdBllWG1foEgr8a3ANJRsR1S/pY8hNPQZvy1+UK/A1pH99BVyQqSo6RjY3WhjfaKgamxBmns
	vKxdNp/UcxIvhK2lv5APSgg7IUTIKwDEV0B3fsL/mKEEOYLPj6c6qKV14ZUYQKxKr7+QY8ESyuV
	XLamaRgy7CN4Ng1fUlGrINBhac3sSkyKq/ruLwK2jkCVpfC3880zLiS2Lx9zCC5odFUA4BBLkTF
	0PLVu2ZDfXyfdQWG0k5mqcQrNYhuRz5P3FzGJ0g0CrUyRkDD5ZqY3AYRQvQgJqIWAfT4qJ4CN6/
	uB4pFMD6cpIeTfFRtUVTZ5u/Oo5ohZq9tRrMlvdXO6bReWxZtj85/M2Vi2U8uIGizBGvIlS+92i
	4UdmjpS3XjXS/TuIzWes7gNEytcFhKckprdZ9rCNqP
X-Received: by 2002:a5d:588b:0:b0:439:b114:60c2 with SMTP id ffacd0b85a97d-43a04db64b2mr5501570f8f.34.1773398890938;
        Fri, 13 Mar 2026 03:48:10 -0700 (PDT)
Received: from draszik.lan ([212.129.81.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19b936sm19109536f8f.5.2026.03.13.03.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 03:48:10 -0700 (PDT)
Message-ID: <da0726da3e59d83985650e8281ed945018a356e4.camel@linaro.org>
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
Date: Fri, 13 Mar 2026 10:48:55 +0000
In-Reply-To: <20260312151228.GA3136988-robh@kernel.org>
References: <20260306-gs101-pd-v7-0-03f7c7965ba5@linaro.org>
	 <20260306-gs101-pd-v7-4-03f7c7965ba5@linaro.org>
	 <20260312151228.GA3136988-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8+build1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-03-12 at 10:12 -0500, Rob Herring wrote:
> On Fri, Mar 06, 2026 at 10:29:55AM +0000, Andr=C3=A9 Draszik wrote:
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 system-controller@17460000 {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "google=
,gs101-pmu";
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x17460000 0x=
10000>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <1>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <1>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ranges;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 google,pmu-intr-gen-sy=
scon =3D <&pmu_intr_gen>;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pd_g3d: power-domain@1e00 {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 com=
patible =3D "google,gs101-pd";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg=
 =3D <0x1e00 0x80>;
>=20
> I'm assuming 0x1e00 is an offset from 0x17460000. That's not what ranges=
=20
> says though. It says both addresses are in the same address space=20
> (system-controller@17460000 parent's address space). You need:
>=20
> ranges =3D <0x0 0x17460000 0x10000>;

Thanks Rob! On gs101, the PD driver can not do direct mmio. Instead it
needs to use the regmap that the parent has created and apply the
offset from the PD's reg property (using struct resource::start)
(patch 7).

When using ranges as per your suggestion that doesn't work anymore,
as resource->start isn't the offset anymore but the final physical
address, and using that in combination with the parent's regmap
doesn't give us the right address anymore.

Is there an alternative other than using completely arbitrary indices
like e.g. rockchip is doing?


Cheers,
Andre'
