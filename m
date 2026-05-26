Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5508F3D649F
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 13:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801291; cv=none; b=axOCMD90qtaxpkD3/t7RsmiyX5IHYACyokDL0/TcWOD5QqIvL++tJBKmD/Jv2Q3jcjASaS5loKaioZ684IP3LCbuFgftm+TgW1EAfHgOneX/2QtHBfwLV7i+zPhC4kLXeK6lzBNpt1IyUyAFTCRavzWE72b2HaiTDOguSKCkFAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801291; c=relaxed/simple;
	bh=25B7o9pqO4qPKR/hwAESUhwchmLmSGyid3ssN5O0t8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxhVMs6E2pDVJgNE6bJMuaBl1DyODOz3impF7gs/w7ZrNr9a1+xrINsjT9kfPbQw5tPtBYgd3RueBDBg6btNLhnud8jrkzbkc6AzNMBpC4058rRIPQtK9CS97DaPQFc9v88pI2jHseaMwUvdPXO4LoP8CYOamZUrfnLSLML1vX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUaGJfNM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUaGJfNM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF8D1F00ACF
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 13:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779801290;
	bh=25B7o9pqO4qPKR/hwAESUhwchmLmSGyid3ssN5O0t8Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HUaGJfNMYAcSBHx4tGo1970JuC3O77aZoR27BX5XP/yzbSQBmCRg9iAKsHafFuNmE
	 Js0Fl3OwUpRMOnNQO8+dhZEjbZTInGdMlcxcb7x29obM9xzQwJBk9RueLQOss6g3Kr
	 pfy3qy1J1WtKUC2TTAj6nlOv93g5BSS8o+huQtumlucgUOu36vgwZp85j9LzKhF4pe
	 prwVU+wk7t4A1PyTC8W/Ql66TYfpRNFIETQS8wA3fz6GC4TkwdDZsmuarAiP4rpRBO
	 tGh/OLWMRXsk9A5DJ+9ozeK9k3zy5na06h9eUjwNMjlwEP8uGmIfkZub7Oyu+tWCyX
	 d6TIMsY8rNjXQ==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-393d6025f99so104626001fa.0
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 06:14:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9UyqoxcYCWjHBR+JZjvItPdv6FaelSEY57KsNhGyKPFGtOENd5kzfEIxA7zcnaKKdOiNGL+f2Ebg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwrlF4vbmmLOpdvk4GU4H7Gw0jU8O3bleONYE05tHT9pEWihto
	wVO5a9C2R0oUeyVaQeotc8l4NaRG8Tymdnun9Zxil1bjLFHt6PiIeUYxlMwKw4FUS3kghhi68En
	p2IaZ8vgORZ+TmrgzzDM+IQGU7F10yrnmaKpSXsSnEg==
X-Received: by 2002:a2e:be0e:0:b0:394:4e89:712b with SMTP id
 38308e7fff4ca-395d8e31375mr62628301fa.8.1779801288687; Tue, 26 May 2026
 06:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523085102.51000-1-clamor95@gmail.com> <20260523085102.51000-2-clamor95@gmail.com>
 <CAMRc=MfXVwD2u0e115RapnyLzf5JRjWMs=2PSNzMnm0GDd7aaQ@mail.gmail.com>
 <CAPVz0n1G5Yu2X5f+=q90RAbnsWi9psMq-L5tWDMM4JRC4R_mPg@mail.gmail.com>
 <CAMRc=Me4G-YqKoFan3epofXk2OWzxY1iPE1mP=uwEjs9wgA6Cw@mail.gmail.com>
 <CAPVz0n2P-zB1_uetZN9pVcQChK+FkdQowbF4Z0YZOBQBsB76WQ@mail.gmail.com>
 <CAMRc=MfAAE4UtnW4S1=pY+2yvS6Hsd-U9+uveUFtPGoJPrv6aA@mail.gmail.com> <CAPVz0n2COsDL+fNBAuKr1ty_AVe9sK5yNJithkXex6GNa1T_Tw@mail.gmail.com>
In-Reply-To: <CAPVz0n2COsDL+fNBAuKr1ty_AVe9sK5yNJithkXex6GNa1T_Tw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 26 May 2026 15:14:36 +0200
X-Gmail-Original-Message-ID: <CAMRc=Mc9g=yezRtAtRMzh7t-pSoyoKQEtxrb5U0oeFAbcjb6Ew@mail.gmail.com>
X-Gm-Features: AVHnY4Lz1bsnLzkXJ8_2leuXmpIdQqxdMVpE8NVuV3RukGdrDmQV4ZXqVxNZWLs
Message-ID: <CAMRc=Mc9g=yezRtAtRMzh7t-pSoyoKQEtxrb5U0oeFAbcjb6Ew@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: tegra: Document Nvidia Tegra
 modem pwrseq
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 2:55=E2=80=AFPM Svyatoslav Ryhel <clamor95@gmail.co=
m> wrote:
>
> > > >
> > > > The node attached to the pwrseq provider device should represent a =
real
> > > > hardware component. Are the enable-gpios and power-supply lines con=
nected
> > > > to the modem package?
> > >
> > > Yes, enable-gpio is connected to the modem and signals that USB is se=
t
> > > and ready to work with the modem, while power-supply is an optional
> > > supply connected to the modem's vbus input.
> > >
> >
> > The modem is a hard-wired USB device? Do you implement it as a
> > platform driver or a USB driver?
> >
>
> It is not a traditional USB device. XMM6260 is an embedded modem used
> in the Tegra phones, it is linked with the AP using USB line in HSIC
> mode. The driver is implemented as a platform device since it does not
> interacts with the exposed USB device directly, it just ensures that
> USB device is properly configured and is ready for IPC.
>
> > Is there a connector of any kind that could be used as the HW
> > component represented by the pwrseq device?
>
> I assume control over USB line is the HW base, but as I have said, I
> can integrate binding in the modem node itself, and pwrseq can get all
> it needs from the match. Pwrseq framework states "This framework is
> designed to abstract complex power-up sequences that are shared
> between multiple logical devices in the Linux kernel." it does not say
> that it must represent some specific hardware.
>

No, not at all. We just can't make up any imaginary, logical "pwrseq"
devices and describe them in DT bindings.

> Using pwrseq allows modem driver to be SoC independent since USB line
> handling is moved into SoC specific power sequence, and this modem is
> used in Exynos and OMAP too with similar setup but they all have
> different USB controllers. Maybe you can point me where SoC specific
> USB controller handling can be implemented?
>

I'm not sure I'm following. Can you rephrase or point me where OMAP
and Samsung implement it?

Bart
