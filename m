Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FCD394796
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774264467; cv=pass; b=JlAixsrs0mFXeuiVQf5sMYq3A/oDH3wmss//VyWHjm5l549OKsx4X7ek6xqi+mtiYcmTka/VVE/VoQLeR4PN9XGRFEKBbOBL9qC007TGA2ph+U32JZRJSBROOvroC+KbYc6L/2ml+p4X3y5V3w+Pvtfgm/yACmKyDbs0ZGWTrZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774264467; c=relaxed/simple;
	bh=YsJoLrLCtXBI6DtmBAjdk5zdQPkh2dEYsn5jbiErAYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NduE0CBY9XcOrmgTN5MmTPBh4Kf1qDFzNhA9/fQAYbruciLLala2j/o4QlMAbogah5mhq7YFMrJKAiXwGdIjuoAcfgs6FAAvgvqK0zOqtflbRVUc7Snxjn2VqLqFDf1DrFqVVtbrv9AFGEm/FjOv+2k2av6qZK8PyiwJZscqxz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bn82Ql8b; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bn82Ql8b"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a283c44478so2713636e87.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 04:14:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774264462; cv=none;
        d=google.com; s=arc-20240605;
        b=CWQKQYt6GrJy3rA2L9+/9HQ3izsc4FigsgSEWEut8WwtaCgInY4qBK+U8kui7iWT9Z
         WKm+JCGJKMgsiA/JTKdNvtZ1Azbvb2NP+ai8IkylvRIncMxggPbKzl9r7Y6lUSXC3UPG
         yf7jUp4/aHsYsIVgRQXF6/8KwzkVYyw/mv5lPQQpFQuPiu5rRFVPOLdjTvFb2JxqBoUF
         5hPgtswRjEVDMBXaxz8Ew9l44D2pnLwct3FOJm9yJf1ARUHXpQ03aUMOHOeDBvfZk5oS
         PzLSqYPPGa4e7nvorNt4tqxwpkPzu1batnndjtbdsZQCOQzqKBvnjfFTxBnAX1a47mzI
         /AuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+IJUWFVuRtnRrcxOAe+qH0nHesEXlr9bnFCdCu3nBCU=;
        fh=rSqnwSiy4XWnXY3bcKQAM7dEOYPLLaykizyCVaT3fIo=;
        b=dH0Xs0R41/Eepb7SGp4PUf5Fsc74oIcswM5hb+v5wv2jECUer4/Wn3J6xN4+FMKPXV
         wjcV65YT17WC/JRsRxpwWgdxLoLS5EynpzoiaDK9zKV+CYsuT+Pw31eeIHOVOqqLmz7X
         VnA7lCWEb8LtUxjgqbG95qNoGrrisI0g4KlNhAhsp9hlgFd1jUAY+RtXpVKOna0pEIj5
         Z4p/DOStCdq3AVMPFzVDPjQ4NDNJkpXpdcSEq31rmoRNiDUE3DpoMiEUg2L6cemt+0Iy
         p03ArqUCth/tMUa9v/3MSY9g9sCHF62aRB0s2VERxWJdL1C7Jhfh3tMqAhp2sBaPaQJz
         vdzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774264462; x=1774869262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IJUWFVuRtnRrcxOAe+qH0nHesEXlr9bnFCdCu3nBCU=;
        b=Bn82Ql8bEbzB7ovYrS2cyKJ7rqnYq5cuNEGH8ulsVoNTcEZ3cTXKEoNT2IH9h6RTF0
         7jZGxZSi1sN30QazDNR5Y9JpYA01kKZhXFxN26S2LOJv4xR4z6oTxQVs4qFTqgizm71O
         UBoj7hDw2QnR2iKLbKF7xec1NC/Olc2cCY4m+dLf+7cPHr7KLwU3zGdRL06RydJmTYUW
         CVTXAMMna7cDto7DWo0QrTV6Qki/b0DvMVVlTmFbVBAspDh+b0CmzQMy1O8DDxRn8Iao
         GL54wek7J00SOpMExdOYoAz1/jm0/R2EpodH3WLal9z9sECTSFWbAC1+ppymJuyIdz99
         6yaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774264462; x=1774869262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+IJUWFVuRtnRrcxOAe+qH0nHesEXlr9bnFCdCu3nBCU=;
        b=TzUiVeDywsib0K703yLhk+EYgDVXhT79JWuvs2TrcEPmFitTc3/ZLjVEkFIq0X+C6b
         WIxZHqwTqp6bbc4L576MmiF4YchWv8XTa4ndqLn+b5IuR7NOyBjxiAktsUwOpHbFmHiv
         eU+i0Hu0RM4q+PKi86dkF2n7VGJ+lMCi3fB28bfLhigiKw0tMbvC/oxIe0jf/rCTOJEZ
         KVXqrsery5/QurYjcPeSeOmhJ0YHZDnD+Zev7oC0LK4UiF+3D9EfMOu8aeV8FbAs78Qd
         xFAKQ4e7wyb0lBUaSQdRkf5IIliWlWpkB8dlRQ2IGM2D6ujB4m4O6NtXOl6J4JaJW9p6
         e6Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXBU3+yQ6pcLMBJyhWPD29/mIboEcUbPXKz7ggDO4RC2jt0WRrTTpIzmmQsoj6K5RevWXRokzD+sA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTIMcaNKis3nfP1n4kcNTRVeqvb9gQgkAbFWPZmrTLIniPxg2p
	ehziIF779b/J7IcbKhc6hElS1hCaRzRYNQQ4ecFLzVxwDURGR9zra9Jjyfo853hg2p5cqUBfOYV
	RjiNacH3THnY/FmBfo3THpLXmPjgYH3Yx4Aj/72RYHw==
X-Gm-Gg: ATEYQzx4K0NVsaU3/8wS2JVlqtjDTSH5ji3xKCmecqFmFzwEdozM/0X5l9NbGWOBfr5
	yp8x0TEPJw4YHLVYRaNqiwagLcrx6JLy5fGoM/9pus46caNplUikgSSkSdga7jIjFJi86rKVU+B
	WsqVkquKabggsiKRRjztRQKdUjlO+B96RLvQt16p9CpZyPuMLoD07ElB3fVO5rUprQ6Kd5Fc8m9
	qhAKCZw6h3lDEkJiRi3sJNKRrET+dAadRXJXAb8kHbg8DnmlOy7vbwjDueZPDAu3rJ9d9W6/bxm
	+Eq2kI4W
X-Received: by 2002:a05:6512:10cf:b0:5a1:2b2b:479d with SMTP id
 2adb3069b0e04-5a285b6125fmr4577456e87.31.1774264462090; Mon, 23 Mar 2026
 04:14:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318-gs101-pd-v8-0-241523460b10@linaro.org> <177409907930.268981.5882592990447577348.b4-ty@b4>
In-Reply-To: <177409907930.268981.5882592990447577348.b4-ty@b4>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 23 Mar 2026 12:13:46 +0100
X-Gm-Features: AQROBzDb0FyhDsEJ4InmRtciuv9Wo1DbFap7YBMqRE1Hh3qfHVm60c1Z9Vi7vPA
Message-ID: <CAPDyKFoz-sm0pfvn5iSYFY0mrW38vaGRZsFvrVPqsv7BsYxeWQ@mail.gmail.com>
Subject: Re: (subset) [PATCH v8 00/10] pmdomain: samsung: add support for
 Google GS101
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Juan Yescas <jyescas@google.com>, Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Sat, 21 Mar 2026 at 14:18, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
>
> On Wed, 18 Mar 2026 15:27:45 +0000, Andr=C3=A9 Draszik wrote:
> > This series adds support for the power domains on Google GS101.
> >
> > There are a few differences compared to SoCs already supported by this
> > driver:
> > * register access does not work via plain ioremap() / readl() /
> >   writel().
> >   Instead, the regmap created by the PMU driver must be used (which
> >   uses Arm SMCC calls under the hood).
> > * DTZPC: a call needs to be made before and after power domain off/on,
> >   to inform the EL3 firmware of the request.
> > * power domains can and are fed by a regulator rail and therefore
> >   regulator control needed be implemented.
> >
> > [...]
>
> Applied, thanks!
>
> [01/10] dt-bindings: soc: google: add google,gs101-dtzpc
>         https://git.kernel.org/krzk/linux/c/10084aeadadfab72648f6ed1cc78f=
7cd87b861ba
> [03/10] dt-bindings: soc: samsung: exynos-pmu: move gs101-pmu into separa=
te binding
>         https://git.kernel.org/krzk/linux/c/3ec3c42b426fe5e2b48ff19c551de=
c50bc78788c
> [04/10] dt-bindings: soc: google: gs101-pmu: allow power domains as child=
ren
>         https://git.kernel.org/krzk/linux/c/c8229a5160eea145b796f54317d6e=
659cec9b080
>
> Best regards,

Usually I pick up the power-domain related changes for the DT bindings
and host them via an immutable branch called "dt". If needed, SOC
maintainers can pull it to apply/test the corresponding DTS changes.

That said, I am open to whatever you think is best here. Perhaps it's
easier if you can drop the DT patches and provide your acks instead or
if you can share them via an immutable branch for me to pull?

Kind regards
Uffe






> --
> Krzysztof Kozlowski <krzk@kernel.org>
>
