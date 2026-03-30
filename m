Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC78F3C3BE5
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774868138; cv=none; b=TwfIEugEy+uYwJCpEghoSfaiB+om85NR14duWyxK4JFZxpQAghI0E8ylMTWGui6SG7KFv4VFL59L9QgPSgFNnMeH9F74FOTt7IMKW1bpApaCZhAd6vrucXGWwa7inZ6udQqRKtHYiZnxV7FJGGye1fP3EO6Z4nZsrazqUmSIoU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774868138; c=relaxed/simple;
	bh=IxVCxS3KsrL7X9+TLUafohMnmgl8E7kaA4sFH55EiJk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZEPLW87ZjGZfUsYJM4zy6hiWab+vzZgvKXwgVrDSFFAk2z0tzegWgmxbq62f2DfuH6S8VFlWHjvDK9Yqdz9MfvQhZZmr2I7iMw3KMMnMdUluPlyVTsrr8r7W5+O1JYz2HutXbGGOoUMtWDI57WTBaozMI1QyQmttymd68eQ6xYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lX4PfEcQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lX4PfEcQ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso36978125e9.1
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 03:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774868135; x=1775472935; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IxVCxS3KsrL7X9+TLUafohMnmgl8E7kaA4sFH55EiJk=;
        b=lX4PfEcQ+SUBKWkBRDMsTlfA0M0wFgK9o7iMLad0kQhaXlWLKmgwBsYQM3+Dx5uflq
         YQpGZySYF1mi7WA2CcDp/3ZRmCgjPFIBS6/7rVKadePQszyr53vRjQ0s3wv9gMrv6jMl
         //vMbEZk+WlGwgaXQxxICdaJgIXjIzQLL1n57WxXy+oHfqZemnlcRqSG2xLWf0BOyzbB
         vPVKD48oI0Zq/9pkQiV/ewez48+7R4YidV28uQNTfHfmMWAbfWeHefChfCRUSftgSBR8
         D+g94L9JCCxshU96wSqeguMLA4ipw/rBgS1pZROCNSycbgN+sJZZAiEFv5YKD7UGHOa4
         GvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774868135; x=1775472935;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IxVCxS3KsrL7X9+TLUafohMnmgl8E7kaA4sFH55EiJk=;
        b=IUCBonX+LcyFrPjBHmL3/4j8cK3t0TxZfyPUCm6Y42geDp6+uWX7dSkdW3i9Ibo3v9
         QAMYaU+VaZoU7gh/JzgYJSyuGc9Pkp1wJIeLn9L2MvYpH7UcSCpGTTYpUge5JsAiJn50
         LrHbEWYkq/VbMwGfC9VT8h3Y+HRxCTCoGuaSf0TZTcS6F6b8gFozuXrsoP6+/H7qw9bM
         M31bybs4qm8iK7Ka6K/ojPyHa7ETn0FN+jOg4bbmNwQYDdqI419bX+LXS0UZ7POu3jfP
         FoBd83eO1OlJIPq2xe9hNCgeJU70cOSUxiwc6riUG1kXEBMjbVybxCxLbBgy+2/iecUp
         NM4w==
X-Forwarded-Encrypted: i=1; AJvYcCXSNtvlI/sbfx1ac10/IZBP1FSfYs7NQA/24VO5WbdmGITS32dyU3EZzFIECIH1T2ZOc7h4DawWGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgXuxdO/TulCZw93siBdoocTVoNi0cuPDNDQOLiRLLalCS44Jj
	FsMacw1VaaAFIYowcCdVLWlmHtoT2Snc5TAinQuV/jA/e163wXX/rAcfuG+FbfUkz6Q=
X-Gm-Gg: ATEYQzxozns4bIqtq6WQO96qCI1uRdmKpJQMedarbnAE2t7mIhbPeMUj7Mq0j+HC9kf
	f4nOTYmVEnvq9DKiu9c29xqL/WzG4oPhKNkNMdxLhyjxvrxOa8kcsVNgJ0I14zq4icBAYtKotNI
	qeXqI8YgF8T5snSDvleGLRaJ0V59hxwftKmiQBxGjPEGMneqXCllQet70WaLG2Llyr4mVswlXY0
	O/NSH+MgQGeF6k1H/FogB26rVvKjVPf9AipBNqBTT3Le4ivpmv3y9sBjl/WMHZSpCS1/sIwOpus
	Qu+BjRN+vV/2+csonIw3JjoXLTMWnyiUTlh58Pm3PxdKlkLMUIqKjW3MVxzSomxEVcnZV2f/e7e
	G0RYi49XLvvv6uOtW0CnxiTiQGhQ7uHVLfqisv62jSdtDvY46iUP4AK97wp5AEW4FTa9x83uBkF
	rNr1cZpnXe+0v1f21FXdJY/GXT3hh6
X-Received: by 2002:a05:600c:4e08:b0:487:1fb4:7b3 with SMTP id 5b1f17b1804b1-48727ef0cc2mr216860995e9.23.1774868135275;
        Mon, 30 Mar 2026 03:55:35 -0700 (PDT)
Received: from draszik.lan ([212.129.78.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48730629033sm164969365e9.6.2026.03.30.03.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 03:55:34 -0700 (PDT)
Message-ID: <9f9d400b84512be41d47099d916338be5662061e.camel@linaro.org>
Subject: Re: [PATCH v8 07/10] pmdomain: samsung: add support for
 google,gs101-pd
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
Date: Mon, 30 Mar 2026 11:55:30 +0100
In-Reply-To: <177409897341.266364.10743294916208405425.b4-review@b4>
References: <20260318-gs101-pd-v8-0-241523460b10@linaro.org>
	 <20260318-gs101-pd-v8-7-241523460b10@linaro.org>
	 <177409897341.266364.10743294916208405425.b4-review@b4>
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
> On Wed, 18 Mar 2026 15:27:52 +0000, Andr=C3=A9 Draszik <andre.draszik@lin=
aro.org> wrote:
> > On Google gs101, direct mmio register access to the PMU registers
> > doesn't work and access must happen via a regmap created by the PMU
> > driver instead.
> >=20
> > Add a flag to the device match data to denote this case, and obtain
> > the regmap using the parent node in DT if true, while keeping to use
> > the traditional direct mmio regmap otherwise.
> >=20
> > Additionally, the status is just one bit on gs101.
> >=20
> > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>=20
> There are few reviews from Sashiko which seem legitimate. Please check
> them. If they are false positives, just reply that you carefully went
> through them.

Thanks for pointing out Sashiko, seems like a useful tool! I'll go
through it.

A.
