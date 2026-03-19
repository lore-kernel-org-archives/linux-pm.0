Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324A63B0AC2
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 11:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921475; cv=none; b=RXDIzdyhbHBW7ibBUbaKeg+mr7mMHCCrl2oqJJxtJWYwvkO0yf0YEOvgSRGdyPokmmg5QF+lKXjDJ6p4ROfYaKFP7+xnIVXSQ8JRf5cgBYGCptoogrPumwbbNwy1VFnA6jmfM7jEMsSQQMJOtpkF38x+5pQVHGmd70jhzYCyK7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921475; c=relaxed/simple;
	bh=yC6Ijh7vCR3XdkIrIV9yo00I9p5DCq5XZe85XCd2G6Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vf/ot2OxbpZj9ODJo/McOc8lMAafmqWL1QEsGos0EakVzzpX182qqe5qlSImNCNZn7uRkZAyuUfVmGaG1Q4x00Dw7InByyOexU8eVHC8FgYJAE2vNOIQ9PLeuhqN//wprBed2dN1g3q0fxIAwArJ93M69WlQfylcFn+0XU4NoxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N3+croW1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N3+croW1"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4856cd3f1ffso8866845e9.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 04:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773921470; x=1774526270; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yC6Ijh7vCR3XdkIrIV9yo00I9p5DCq5XZe85XCd2G6Q=;
        b=N3+croW1c7ST5J6EHCB6cZhFtMCt3CFujblmcv9rU+YpIk5XbBR7diwuQ9dh88r5Ea
         s3gpqHoWW/GSSXNBsouH2LvA8pngRkWNIs2r20VG9PggrPD0vNOSaFMq3rN/QVG+As5l
         wMaSiQStyFr0Jn7eIup6GYOlWjWol6h7EBW9ET0Kwn4QNrqch89DBtvndzZb68YUUejZ
         1TSRsHd2hNlmRIuTCrnOvIzO3cHXU5gUQmRdoTAnlYn2CXegZolOwJgphhcl4uU+mQR2
         /Vd7L58+mMQ7pFJl/q4fEDrjyMQnTdXH6MrY4FgYc5wDz5EzvW3AqRxoZEgbK49bya/N
         rZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773921470; x=1774526270;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yC6Ijh7vCR3XdkIrIV9yo00I9p5DCq5XZe85XCd2G6Q=;
        b=S4oXENlYcpaQQkRLarFttW642USGUQCZK+NPxiKqBAiZYqyqTH5hTGn7dJw0o/hmZW
         Apk3YhSnDu2IakKFdDd+AApUOiidhDLG86Nc6ql/0vP8NCzHHpAatolgIopXdxGQjmm9
         xFKPxc2eTDGTB6fdx+aEqvP/xzHVaeeMQukv98iRsapQmZSoHi9EmsuKIjwKMZj0uxYz
         bLQXOhsILuZZqAxAWUKm229HIeF/SjxOCDWO/YvIRjxmM8EEtsZvr1IwoAweYfDJDWvj
         +C5rcu6g7gWQwz+q36HwfRZkF3/Q871dWbre4sCKzZuMN3iEWH0ulzbOXyLBQZmxpnLY
         bmqg==
X-Forwarded-Encrypted: i=1; AJvYcCW27pbsOnqQbAuVXpxB2Ksar9cCg0goLKXFinGIyymTB4y2qvhyP6/g1AkzaAAqPHXiZU3XN+ijJg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz17vNWqevdiITDBIAXiopessC9eoJPX857NBvZhSVeEmkZQJ3i
	us95g6zMp9M6J8hX/f/s8LfxHuFVJLHhaq15sFkTDnSdAl/VWtvCf+L3Jj67Qvfr2y8=
X-Gm-Gg: ATEYQzxCQKE523zz7C7IIx/1TYkUgowJNXFmOBuayF1OH0iFRI8JmQPd/ueXdEHk+sh
	sAsqd1bflyLS9+McIpK2marfso0CZmqkjqkIe7B8anof3rkMWkH16liwcgAX1Xx8av3eDcymO+W
	2286CnphdmhYAkFT5y7lcaGibX2c8p7nPNbEwt9dYwfF0+nt+DHSHLo6PxjCsTmIYKjBfU+7Zo+
	vlpBr+e7Vs2lYWOlKqILzav7lIv+U0OGki5KSTHdQ2IJhiiDuDOZc/2KIASEo2cPC/GxlfXzqoH
	551EHJ/lFXIO53C880NJ1G2SZe0m7OapkhikcEYklpTBnTgMt7lNQbT6w+KjPykhLYOESXZ7/8t
	gvmTLBNzv6p8Ax0z5qyMrDUAMwkSFphFy0q/yjfOcialJLAJ7N4bGt9IPFnBI73i0LFcrcjaQTU
	hZenz/aquB3V+cGaOFAlbpb8GjWxM=
X-Received: by 2002:a05:600c:1992:b0:486:fad0:b166 with SMTP id 5b1f17b1804b1-486fad0b2c8mr30813105e9.17.1773921470276;
        Thu, 19 Mar 2026 04:57:50 -0700 (PDT)
Received: from draszik.lan ([212.129.73.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8bd5f7csm65030485e9.0.2026.03.19.04.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 04:57:49 -0700 (PDT)
Message-ID: <ae31c62c940e99077d44e1935465dce7db0e4c06.camel@linaro.org>
Subject: Re: [PATCH v8 05/10] pmdomain: samsung: convert to using regmap
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Ulf Hansson
	 <ulf.hansson@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>,  Rob Herring <robh@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Peter
 Griffin <peter.griffin@linaro.org>,  Tudor Ambarus
 <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, Will McVicker
	 <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Date: Thu, 19 Mar 2026 11:58:45 +0000
In-Reply-To: <c5ba58fb-50f1-4067-a099-97169ea81f68@samsung.com>
References: <20260318-gs101-pd-v8-0-241523460b10@linaro.org>
		<20260318-gs101-pd-v8-5-241523460b10@linaro.org>
		<CGME20260319101424eucas1p2d5dca06240e8760046fb40507ffb3bba@eucas1p2.samsung.com>
		<CAPDyKFrprMSLOBMB_BHbi=j6UXV4dXBn-H8M1BsqDWNSCJwvuA@mail.gmail.com>
	 <c5ba58fb-50f1-4067-a099-97169ea81f68@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8+build1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Marek,

On Thu, 2026-03-19 at 11:29 +0100, Marek Szyprowski wrote:
> On 19.03.2026 11:13, Ulf Hansson wrote:
> > As a follow-up patch on top, please consider converting the open-coded
> > polling loop above into a readx_poll_timeout_atomic().
>=20
> This has been tried and it doesn't work in all cases required for power=
=20
> domain driver:
>=20
> https://lore.kernel.org/all/5c19e4ef-c4fd-4bf5-88b3-46c86751b14e@samsung.=
com/
>=20
> Probably a comment about that could be added directly to this code to=20
> avoid such conversion and breakage in the future.

I am planning to revisit this in the future and am hoping that we can
figure out what goes wrong when using regmap_read_poll_timeout().

Hopefully such a comment would only be short-lived, so maybe not really
worth it? I can add it, though, if you prefer.

Cheers,
Andre'
