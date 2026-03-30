Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3313BE627
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869200; cv=pass; b=Nd/QGt0vSqNUhON5+a+HU6E0HNoxQ/tR+f/O/2PcgK6ehqUBTEVunTnaaXyx2jfy9PFLJAklMgq4xEEiZE49pJDb8VQZEkjEFRW4mFhox6UIkRUIdRJaB1vKQ4/YKauBlyGJbs6MxCuiP9zOlXJzFScXXEa4AFEodjJs+66ActU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869200; c=relaxed/simple;
	bh=dlgA3vHp/tCZZP6x+MyvcYNS73Ufva6+EVngsEM6VdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=stjpl5TYr5vCvrFNSn5WVXGf93OuiwO5hKPge/1uGc6Se/nAo4wiHknAW1RDYvPR+mkPYUL4vK6DRX861KLZbzAeSBiyA2747MRtaqjJ+X55+scQ+6Xxx76yPUyPgycYZgXG4G6K/GS/WkE+aGTOibBu2BLw3viFFptKEElIB+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hCsadkBg; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hCsadkBg"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a126c8aab9so5179478e87.0
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 04:13:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774869195; cv=none;
        d=google.com; s=arc-20240605;
        b=exYrFzqXY0emqle2Ccx9nI+RcKIPcw/jlhsHTswGeYaCp5/yMWxg3Uq/pHc9Q4u7Ak
         WUk8VMjl9qbfYKsxPLUyg+7bzWxkkLdNj71lJ0mMksyvqNcE4/FEtw7am9n2H2B0ZkU+
         fs15RD+jqa/yscZLsuw9nCS541QvFPNfV2EamfQR1TJgj5Pqcmu8yQpd7KJYbyu3BKMI
         UZhb1hnZM5mJteRMFZIUQzjAlgdHz+DER8/BVd4TSyDFJZOiNa7Js1o605uiEeg/AdLT
         y0sCC5UbbfA0DdlV7wJwX38xzSIZtNsN8ILfhcpw+SNYNdd5uEtqjYOnpTs+ZUWScC+D
         fVNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JOM+v3hkRUPIxwZnJzq8Dzd0DMU9QR03z+xYMXNAkMc=;
        fh=j+C6XMFfzp+jHpGMQLX5MmfDgzjVdSxiQd7qwmnS2Zg=;
        b=Kg6OTGqRFK5iJjSjI1AhGcyiJLZ9oRILOXS+OZ/OvTDr46AFxiyaTLOzg8YeuO9AcN
         CiFFU7XhAm5V2MFkJ4GEBFIn6nBFGoS8JGbVMSIk4LBg34MimozH7eEroMeEkf2r1Fre
         Edyd44lnS7pV/w5HfWpe6UW2mdU3jCPesNPtfm4wHU2Zxgzp3fGqLR6QZPGIrT0pxo+T
         4pkoQY4TqAaOGlRcb9pE9XE72yUyuSIQSDGtKtWeqK1dAJKUbadtOop9kA+GGQRpj525
         u+cYhiYLGFkWnu8VCAq0tAgpXKtVz6A3bADO51KVmYlhlMhOfybqOgrjv0js4YSaNjn1
         dALA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774869195; x=1775473995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOM+v3hkRUPIxwZnJzq8Dzd0DMU9QR03z+xYMXNAkMc=;
        b=hCsadkBgAmi+9tAT9KksvfkxwpsYqeTRsfRyUxAUIcHE8RGB9HD0sWgd8sCmWvcB1r
         UI07jD81jbCf75euSTuXQDsISj4krH1/XvuehjtCH1w7u/HcagjkA2LEIo+zn6FDTOCI
         LitEGYYLljS0josW8buvHBitH3eTJqQRQkQeGCWGa8XQI6J/veFyDR23q22xR4EsExfi
         p6BnlQ9Y2qj69Q3I8b1CK13Yynx7zcGYkjwzL70QcmMnWCLxEk1/mfDj6C7mOUVEhab3
         kXmticgIFLgroGP3qEsSkOrE78Hh3XmEGwTCunQBQAx9vYBV1K5YON0Wc6BPxk+rYBhj
         XT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774869195; x=1775473995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JOM+v3hkRUPIxwZnJzq8Dzd0DMU9QR03z+xYMXNAkMc=;
        b=prad1roFqbQuRW/wHkfjH8WqYNPZDO8Nq6/3HQBqUYQbMRLtLA7lL+5eCCUpWxZdW5
         B7PJfUw6NowBcyQVxwrJ+sM1seYP0owMEWYAnvCWC9ybGYbfBNbGiQPacYakP68HalIe
         B3DZlLJrZqRQBUJoPyjLKp4BFl5UGPuHs2jVopkuWr2bxxgOIfVV15Jhay0wABEMryFp
         nkAkkCFvMWJ66dAq0Qvidw+R3SN0mqULpgq9ghbsmncgDReZZAfozb2VDCWyfnDwTOah
         yldyDyH6bNinNJ3SyObj9eaOU/N2fMOHHwlp2kjYaGXXv4TlMOq3BZV8AAYBhSSUsFNc
         u7Nw==
X-Forwarded-Encrypted: i=1; AJvYcCXFVQnTYtCpX/OE5Eg3Ycp2/E39MAwSk4kYUUxIP5zH1pQxQB+RHrrWOsJR/PwRqbLu5pdRu9cGMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBikyc+dLTbXZGx56HgM6Dks97xGAm6Hp0kFnhNAw/G/toqrdn
	/i4UnXFe0f/NeIKhLDF1yJJ5k/iqg1xQxq76EN9eeHIzV75OSRoUuoJOssm7vOIg6l2LuYsVsl0
	bGMNYBbcBdjqbRcd6Udf2ItDAQhm5YKJrkZBujE/dwQ==
X-Gm-Gg: ATEYQzwTYNZwHztlw3e9KJNO9cL3BGWz6PPmv6H2LMbs2V+B0EcRqySOkuFKQPgutUZ
	aBRQGTc2kWQx7BXHNR+Jcq1+jZw7H7hFnOdr0UGNarNAiGEANMlqOo8195K/VQzqJ5AKLoAyeZb
	5cxMkk5Z9kUoNMLqr4QjqPxefkcS7eG48ctp+LCJByAa52hPdHuuMmsaYWv7Wdejo2JBmHCcmD/
	V2osRWBgRqeDy37m47LaQPg8pg4jUWUrLtd7jmIo0FsdA87gXcYVpacCzNwuLKNA85/8GDJ++fv
	IWv805tPixfTeuoo3+o=
X-Received: by 2002:a05:6512:685:b0:5a2:9d61:f710 with SMTP id
 2adb3069b0e04-5a2ab92634bmr3995988e87.28.1774869195094; Mon, 30 Mar 2026
 04:13:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318-gs101-pd-v8-0-241523460b10@linaro.org>
 <177409907930.268981.5882592990447577348.b4-ty@b4> <CAPDyKFoz-sm0pfvn5iSYFY0mrW38vaGRZsFvrVPqsv7BsYxeWQ@mail.gmail.com>
 <1fbf5c54-8793-4585-be33-ded77019adb2@kernel.org> <CAPDyKFrK3NLwaii-9FEmyaTzUAuVkMkLL3rWBQwQvT-M+PzEHA@mail.gmail.com>
 <3bb6b71e-947b-4248-95ba-79852f743c1d@kernel.org>
In-Reply-To: <3bb6b71e-947b-4248-95ba-79852f743c1d@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 30 Mar 2026 13:12:39 +0200
X-Gm-Features: AQROBzCzpsR16OKFH2Q1YSJwCONrrQEcDC_w0lPdIFqdSp0pO1DGRu9LhJ5vXKQ
Message-ID: <CAPDyKFpOPC2stAJ262jdap-=ByY09AeQ0kj6p_9FTGJBx+Tu-Q@mail.gmail.com>
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

On Mon, 30 Mar 2026 at 12:17, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 30/03/2026 12:13, Ulf Hansson wrote:
> > On Mon, 30 Mar 2026 at 11:54, Krzysztof Kozlowski <krzk@kernel.org> wro=
te:
> >>
> >> On 23/03/2026 12:13, Ulf Hansson wrote:
> >>> Hi Krzysztof,
> >>>
> >>> On Sat, 21 Mar 2026 at 14:18, Krzysztof Kozlowski <krzk@kernel.org> w=
rote:
> >>>>
> >>>>
> >>>> On Wed, 18 Mar 2026 15:27:45 +0000, Andr=C3=A9 Draszik wrote:
> >>>>> This series adds support for the power domains on Google GS101.
> >>>>>
> >>>>> There are a few differences compared to SoCs already supported by t=
his
> >>>>> driver:
> >>>>> * register access does not work via plain ioremap() / readl() /
> >>>>>   writel().
> >>>>>   Instead, the regmap created by the PMU driver must be used (which
> >>>>>   uses Arm SMCC calls under the hood).
> >>>>> * DTZPC: a call needs to be made before and after power domain off/=
on,
> >>>>>   to inform the EL3 firmware of the request.
> >>>>> * power domains can and are fed by a regulator rail and therefore
> >>>>>   regulator control needed be implemented.
> >>>>>
> >>>>> [...]
> >>>>
> >>>> Applied, thanks!
> >>>>
> >>>> [01/10] dt-bindings: soc: google: add google,gs101-dtzpc
> >>>>         https://git.kernel.org/krzk/linux/c/10084aeadadfab72648f6ed1=
cc78f7cd87b861ba
> >>>> [03/10] dt-bindings: soc: samsung: exynos-pmu: move gs101-pmu into s=
eparate binding
> >>>>         https://git.kernel.org/krzk/linux/c/3ec3c42b426fe5e2b48ff19c=
551dec50bc78788c
> >>>> [04/10] dt-bindings: soc: google: gs101-pmu: allow power domains as =
children
> >>>>         https://git.kernel.org/krzk/linux/c/c8229a5160eea145b796f543=
17d6e659cec9b080
> >>>>
> >>>> Best regards,
> >>>
> >>> Usually I pick up the power-domain related changes for the DT binding=
s
> >>> and host them via an immutable branch called "dt". If needed, SOC
> >>> maintainers can pull it to apply/test the corresponding DTS changes.
> >>>
> >>> That said, I am open to whatever you think is best here. Perhaps it's
> >>> easier if you can drop the DT patches and provide your acks instead o=
r
> >>> if you can share them via an immutable branch for me to pull?
> >>
> >>
> >> I did not pick up any pmdomain binding patches. I picked up only soc a=
nd
> >> according to cover letter there are no dependencies between anything h=
ere.
> >
> > As I understand it, they are all related and some even depend on each
>
> I raised exactly that questions but no answers.
>
> > other. I think keeping all four DT patches together makes sense.
>
> Why? What is the dependency?

I defer to Andr=C3=A9 to clarify this for us.

>
> >
> > Although, as I said, if you think it's best to funnel them through
> > your tree, please do and then share them via an immutable branch, so I
> > can apply the pmdomain driver changes.
>
> soc must go via my tree, but there is no reason to take the pmdomain
> binding patch. So I did not take.

Yes, they belong to soc/platform, which is common for most
power-domain providers.

To allow us to merge/maintain power-domain provider *driver* changes
separately, we needed a way to manage the corresponding DT bindings.
That's why I am hosting the immutable "dt" branch for these, which
soc/platform maintainers can pull-in when they need it.

Of course, doing it the other way around is also possible. Just let me
know what you prefer.

>
> But anyway, I just noticed that I dropped everything: this introduces
> new warnings which were nowhere addressed or explained. So regardless
> how this should go, please do not apply anything - it's broken and
> author is silent.

Right, I will await your confirmation!

Kind regards
Uffe
