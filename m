Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5493BFE24
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774867987; cv=none; b=JpoiqY2I+TXG3ND0qihusD6YKVrIu2sG25stZ0pWY8/hmLHn0KXe4t5/bBUT24h2dF9QDCz3Ip6QAcCiRUHhKk/y6Kxcj/tMh69mMnm9kk6UF6p2rDmCvOpYYOZngPyKBNLs0BdI+/yvs9MqnER7Q8p9cvaZEmH13m70ChiVZiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774867987; c=relaxed/simple;
	bh=BNYWE4ZNfeLRGblM3h9jfVP9WIaSB0fZFyHZKbb2/BY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PeIijloVliaAIXtlT1ZappzHunBTgjt3iQid2Wndz6doVwBQFnzDJpb3VPs3eiRMWvWulLAB2o5D89j3NJCcPF5B5UsRqYh0XCRTGQ4+GkQZBH2S9wnQabKHnmHplZNePAKz50c/uKZT06BnyO35lYpFLlZOAGh97mk2EY0RpYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TATXPP8o; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TATXPP8o"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d04fc3bf2so225004f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 03:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774867983; x=1775472783; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nzbPas/zVRhWvMIP9KSmda2kkwwqeTULljeMJhCNvcc=;
        b=TATXPP8oQZLLpCL5KsAbv7XDn7cKmg9nSldOrFdSaePhsGrjiYktxRxakmzU3qRWsw
         diGnL0KCwMdRNb7Y1dbl0Jbzg56l/L40ZsBuiXIg4bIJsq+BJQPmpxeRrpZWzaWP0DmC
         XMB05gv3bTPzZKNxjqS01cAcNiOzBzIVKVDvWsWqgy0GIRRD8pI9rCvIK228Bc4+e0Hp
         u12CZLOVWdxGJOnAEeccPFC9mhaEDyNIoY6hJIpOOp4WA0Cpgby51JjrA0gYuQnTq8bO
         SOpvtVO8U9wEycMtYHDp0Plko4SZ0hbUAHWeWg4iChXZ+t+kH0cPUEvov2yD0c4kP/ia
         q5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774867983; x=1775472783;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzbPas/zVRhWvMIP9KSmda2kkwwqeTULljeMJhCNvcc=;
        b=jwB2KE8FtgDDYLwp9ZHBbIjr1uYGrtPqZRssY0ijiOud4zkW42SEiRfTv0anct+WId
         H/lGe+fgq+yUP7RtjKHuSq9XZjG9DOW05N2UVLlYlb2xOouOfov+15YxFo6opUMT830k
         66E5s/AF5vmN1yOg7pOdD3K1O8vf9zzLJ1+WLWepbAhKb6zrnT4ANGCVXWAKa+itR1Wo
         55KczoemD2Q5IN7NH9ZVPepuerVS/PnKnO/PJoqJpgOBMkOLAEkrN9VjK3QrIF9Ze0yJ
         Mkcu/MsMS8rgB3iP0hodZsJMuPi+41dcFuo0WCkBvGcWnnN0tSklAosMzrEwnSSTmsKn
         e/yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBXQZE6ab3fqeguvVp0rSfpfyf40POMelzL+rseL+GvNaC39vBnWPylhkrt0fkMXOxBD8mUWaoWg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrudo+8gHZT8nPzuehBEkWjI1RH0PtizJpBS44p8Z3ptf+SoMD
	cMVJ1R5FH5G8Q3phWYecPhaNAjRHOQz2wAE3dxL5HYTJdkcaQ+OOO6jh7h1DCkceNV8=
X-Gm-Gg: ATEYQzy85fM1K1BLjChj4QL35L09h2o782ZggI4hBUdfs+eRqpjneQBNKzRMhp7yBLp
	k9hPBrdhObSr3Cej/qWLMgJjn3G+A6FxcH6ebISjRPz3Z3JQLwBxU8u9Zxa9GZhwu242cwv1BLi
	b+uqeQeB6WgG7lW0l4GDIP7UYxvscHLDtXvVhaXdqZhsPzcWKZmLx2FSfONVCW2hNEREs0XtyXd
	9eqx1ubJ1jmnJcvQaJmHfN4vQackrrSrBzvayi5m2hpPbXiHt0bT0gE81u5ASB4CfsiVCygjYdI
	GNuMsxDXdeLeO0Dmw2aAT8u/9qFqfkUZqd0ee0fj+fPOud4FXDQcgdNdT4e5solyU+vNdObgmif
	I+9pHvxKuqlIBwO61ZiWagHUfwb7y/ZOe3Z2RuvGyKXQIC7ZZ3+C2GlgFO3CVFtmT9m/SWMGqgP
	sZzHyrHGlANkWZ2MmzzVUx1Z6fV59/
X-Received: by 2002:a5d:64e6:0:b0:43b:8fa4:1937 with SMTP id ffacd0b85a97d-43b9e9d5ea1mr20787372f8f.5.1774867983379;
        Mon, 30 Mar 2026 03:53:03 -0700 (PDT)
Received: from draszik.lan ([212.129.78.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf330872asm16354366f8f.17.2026.03.30.03.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 03:53:02 -0700 (PDT)
Message-ID: <61f4ba09a77a255008078a8655e8f4791e4c87ff.camel@linaro.org>
Subject: Re: [PATCH v8 05/10] pmdomain: samsung: convert to using regmap
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Ulf Hansson	 <ulf.hansson@linaro.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown	 <broonie@kernel.org>, Peter Griffin
 <peter.griffin@linaro.org>, Tudor Ambarus	 <tudor.ambarus@linaro.org>, Juan
 Yescas <jyescas@google.com>, Will McVicker	 <willmcvicker@google.com>,
 kernel-team@android.com, 	linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-pm@vger.kernel.org, Marek Szyprowski
 <m.szyprowski@samsung.com>
Date: Mon, 30 Mar 2026 11:53:03 +0100
In-Reply-To: <177409897341.266364.2957933304869869135.b4-review@b4>
References: <20260318-gs101-pd-v8-0-241523460b10@linaro.org>
	 <20260318-gs101-pd-v8-5-241523460b10@linaro.org>
	 <177409897341.266364.2957933304869869135.b4-review@b4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8+build1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-03-21 at 14:16 +0100, Krzysztof Kozlowski wrote:
> On Wed, 18 Mar 2026 15:27:50 +0000, Andr=C3=A9 Draszik <andre.draszik@lin=
aro.org> wrote:
> > diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmd=
omain/samsung/exynos-pm-domains.c
> > index 5c3aa8983087..68b1e7ba8729 100644
> > --- a/drivers/pmdomain/samsung/exynos-pm-domains.c
> > +++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
> > @@ -120,9 +140,26 @@ static int exynos_pd_probe(struct platform_device =
*pdev)
> > [ ... skip 20 lines ... ]
> > +
> > +	reg_config.max_register =3D resource_size(res) - reg_config.reg_strid=
e;
> > +	pd->regmap =3D devm_regmap_init_mmio(dev, base, &reg_config);
> > +	if (IS_ERR(pd->regmap))
> > +		return dev_err_probe(dev, PTR_ERR(base),
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to init regmap\n");
>=20
> PTR_ERR(pd->regmap)

Thanks!

A.
