Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23FC361DCB
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 13:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802932; cv=pass; b=MPQ3ZEamkljKrsWSOuPlREytko/XagUWKTGKDQN1o3bFU3/sDl67piKIMhUHeOT3ukjoWkGu6BYJY4ZkrjsCX3zsNucVlAg4KtK54v3FRYNpjmGRKAWaB8qZUKOKT6Z5tcRWLwAUSjTGf/YZ7Odib7Ej6B54aRO3dh07O8o5b6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802932; c=relaxed/simple;
	bh=IR8h168jGiuhn6TmrhfuE1J/dfjJGqCoY/8QGtJOSTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o94qDhY7coWcEMOF2owrlGSUHZ+E4KyKYHNPcARGAxtYXMhXRalN6S5k/+VuaUPj/7g6LoAhfaG1cEbha5Paweic5rx90qWVpeDtueGhriD7FdgpHpdUvl6yo9uK5Vg8F0wIKuBv5bGJiAIRRPVDr/JLevjonoLUebdeuRR183Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pnCMSKJe; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnCMSKJe"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so34850059eec.0
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 06:42:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779802930; cv=none;
        d=google.com; s=arc-20240605;
        b=gY5geo3gitbEq3LFhv7BNs8yymC10WjOpfsp3w4QBk1a9Kf6FQAQHgqFLsy+uQKA2d
         iFhqtDeFB6NiqjwIAWp05lOlF7KQLlmpLqjXYqSsJ3pU7Pys99irG4OwQHXszPOqjVpm
         Z3XlUSJO0HPpnx23XrNTW9ocqFNofjGu0Kc6Iw9WiOFOqBZqraHOlMGoG95YWFDHE7yG
         xk5Id6nGQ+aPMWgz33Lr0Coz//UwoW6OKpJ/ZHDFmGF5Vdj8Mtsir+ltTj88mjrSC+Ma
         OfHv57MpHh9I/g2AZlSw/PQJQ3hhp85K3DI234Iq34xKKsc8EQG2Td1Yi62or18WJRv2
         9cfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IR8h168jGiuhn6TmrhfuE1J/dfjJGqCoY/8QGtJOSTs=;
        fh=OQzA5X1Hhk53ac8yn1cipMlYWwMNxMyGF1sX0T6aAGo=;
        b=GsQv3cMOFXSz40jWXHIwjz00QmNsErp7b85Z+Nk2L2J/2iaK820L48BzHoEBeNKAxc
         0LDP3LPYV6YgAth3xB5kksiEiWM7Ml9N2MmUPPw14T2jFlqnMXEMbbSa2CbBQdUI5pbR
         IhfRkYS02oF9l39FO2S+JEOYdAkwgFFFwxs8LfE8pbtQhcJCotqfs3DWsuvjdWBT2fMk
         yaYZpv2KXa/yWuRg/GHcYNdZCRVTIS1N7LEcwRZkWbD2ZuEFnJuppZjOP+YQlrYx7mRH
         aqygQADLgjN9YXDJL1uqesr21BLbnbuV3jgZt1l0cbwGU5nczy0aBbGW1H9d1cU8mMSv
         43Rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779802930; x=1780407730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IR8h168jGiuhn6TmrhfuE1J/dfjJGqCoY/8QGtJOSTs=;
        b=pnCMSKJevlCMdl1pgU4d53eM8k9WaDQsXgwcDVH4MsaEt4yNVIqjAuHSSzXUy9lZ0g
         Utm2Iq4IJLam2Fxf6dgfe6n0gLMlukyjs239MxxLvVhNCCf6iB/lCv61ZBF6r++O4OrN
         8jo2to0Z75coXPS8NyQ3sLyOdlik9gu2L8N+itmuZsKTWgZPaGH+GRXMEHFzSosF/0XV
         B+uIHc1Q+6sQYd/SCQ4ub3KEfYU2WlfXm9azOtfoiIV7T5nDQGpB8MVd66gR3/NnL12P
         dLTpIEbWbfBUd9M1YBwfxIQFEZ52+r2fEvdK35eeukJDFb5lkZFIhrMfR7pgIWQTzluJ
         7wPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779802930; x=1780407730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IR8h168jGiuhn6TmrhfuE1J/dfjJGqCoY/8QGtJOSTs=;
        b=ByVnErsu9oEkBlztVwuOnAotfR8NtuGtNm3GwxbFjaUDWjD+VCwlRvi1voG+mbTkDg
         tetzw3f0sL1bVbpxRDtO2xSYoPvyI3AA7z9PLIuEUna6ZsPtWLffYCKezvy2TdUPPPba
         dbUQOO1+dVazMX3aySERE3d9Xotyip4Dha6o+QG7Zph4DLeNE4WmXeBTulEHG3GYWwEJ
         4N2qUIs9I6qu/Q3LxaQWfVe5Bk7oaSvGHJnw6cEeQvowNX3U5IYtJk6/sGe+AD1HNb6w
         +Wt33mR7M5litzDX0CVz3LFZuczZjHUh7OgGigZCfJ/CLKFP/L3zsgwgyUeE2RL2ydw0
         nlMw==
X-Forwarded-Encrypted: i=1; AFNElJ8/RydJH9ZpRFBDOIyghybLPD+YN2iHmW/GclrVIToFElhFP8SE1qYnoJmvg0bmKj45jXkMK4OtiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc7Yjtz2jhuwDkG6zWglaBRxbc8sdtMkbkQJc5woWzbxsbBNDn
	/Yr1DNFiGiszZptHh3XBuJsoLQRpG2j9F2oCR2L+wi3AMjZi22Yyyc6RS2ZyOJChBFY2drXS58h
	9NNIpTCfxA9d5lyzxokGVdsay2vKi7tw=
X-Gm-Gg: Acq92OEvJgZfjRvuWkR5EqwMXk8DMpApMSUYcukolH7mSyz0Ii+nW1/VSfgnz+GjJ+F
	xlfGPsTkSp70hRqQ6q8wvUJqjE2ftHIFPAl1AtvEkv/Em8RxcMn65/+pLIBg+nTddlYbjs30Hko
	R9VBAFv2ShJd0GcHu+GL1yuEv3eMpQxVYaWyb0j5058HC7jyeC4cMajtPULTYh4hrMI8l8t1MX6
	B0KmlL53oqgxbxR/gBbaph8AdKnHmUnJ9qFTzUe/0VpwBbGh4YNB9QQVFo4rooqhfdEql7mSc5z
	/TFRHk8GSFEL8B8iUak=
X-Received: by 2002:a05:7301:9f08:b0:2d3:f43c:d684 with SMTP id
 5a478bee46e88-30448fbf1aemr7687031eec.2.1779802929836; Tue, 26 May 2026
 06:42:09 -0700 (PDT)
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
 <CAMRc=MfAAE4UtnW4S1=pY+2yvS6Hsd-U9+uveUFtPGoJPrv6aA@mail.gmail.com>
 <CAPVz0n2COsDL+fNBAuKr1ty_AVe9sK5yNJithkXex6GNa1T_Tw@mail.gmail.com> <CAMRc=Mc9g=yezRtAtRMzh7t-pSoyoKQEtxrb5U0oeFAbcjb6Ew@mail.gmail.com>
In-Reply-To: <CAMRc=Mc9g=yezRtAtRMzh7t-pSoyoKQEtxrb5U0oeFAbcjb6Ew@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 26 May 2026 16:41:58 +0300
X-Gm-Features: AVHnY4KFEJMIqmJFkVXi2wsVW9jw7UK66gK7opVRcY6tQsdWbwfvh4xNHY4PcSY
Message-ID: <CAPVz0n3X8Gw2Yo9VgwhV0uAqvArGXbvmzw=cZVJw=4BEH_E7_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: tegra: Document Nvidia Tegra
 modem pwrseq
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 26 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 16:1=
4 Bartosz Golaszewski <brgl@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, May 26, 2026 at 2:55=E2=80=AFPM Svyatoslav Ryhel <clamor95@gmail.=
com> wrote:
> >
> > > > >
> > > > > The node attached to the pwrseq provider device should represent =
a real
> > > > > hardware component. Are the enable-gpios and power-supply lines c=
onnected
> > > > > to the modem package?
> > > >
> > > > Yes, enable-gpio is connected to the modem and signals that USB is =
set
> > > > and ready to work with the modem, while power-supply is an optional
> > > > supply connected to the modem's vbus input.
> > > >
> > >
> > > The modem is a hard-wired USB device? Do you implement it as a
> > > platform driver or a USB driver?
> > >
> >
> > It is not a traditional USB device. XMM6260 is an embedded modem used
> > in the Tegra phones, it is linked with the AP using USB line in HSIC
> > mode. The driver is implemented as a platform device since it does not
> > interacts with the exposed USB device directly, it just ensures that
> > USB device is properly configured and is ready for IPC.
> >
> > > Is there a connector of any kind that could be used as the HW
> > > component represented by the pwrseq device?
> >
> > I assume control over USB line is the HW base, but as I have said, I
> > can integrate binding in the modem node itself, and pwrseq can get all
> > it needs from the match. Pwrseq framework states "This framework is
> > designed to abstract complex power-up sequences that are shared
> > between multiple logical devices in the Linux kernel." it does not say
> > that it must represent some specific hardware.
> >
>
> No, not at all. We just can't make up any imaginary, logical "pwrseq"
> devices and describe them in DT bindings.
>

Ye, ye, sure, pwrseq framework is quite flexible and I am not stating
this bindings is mandatory.

> > Using pwrseq allows modem driver to be SoC independent since USB line
> > handling is moved into SoC specific power sequence, and this modem is
> > used in Exynos and OMAP too with similar setup but they all have
> > different USB controllers. Maybe you can point me where SoC specific
> > USB controller handling can be implemented?
> >
>
> I'm not sure I'm following. Can you rephrase or point me where OMAP
> and Samsung implement it?
>

They did not.

The XMM6260 modem is used not only in the Tegra phones but in the OMAP
and Exynos based too. Replicant tried to implement support locally
with midas devices and they had some progress. From what I have seen
generic implementation I am proposing will work with any of those 3
SoCs maybe with some slight tweaks, only part that is totally
different and SoC specific is how USB controller used by the modem is
handled (well and IPC but that is out of scope of this patchset
anyway).

Obviously, non of the 3 vendors have submitted any mainline patches,
everything is in the downstream forks. I have investigated a bit how
this modem works on my Tegra phone and re-implemented it to work with
mainline kernel (I don't have Exynos and OMAP devices to play with). I
have come up with generic platform driver which handles modem
configuration and a SoC specific part which performs USB controller
bind/probe when modem is ready to handle the USB. ATM this SoC
specific part is available and tested only for Tegra devices.

> Bart
