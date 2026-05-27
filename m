Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCE43E7BA7
	for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 09:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779873320; cv=none; b=kQkgq7geQbGgX2341exc4oM9j2tL0msQrObjesz9rhMmyKqd6LCxrIr4sRufzuoKVL0uVBAl7x5ScPdsQgmBUEL8lnU5u4SRDjKRl5uF1MM/+zv4l5V2lswRUia8ipa1phP5e3D+HNYNLzn86oXSIbBKI8hfHeMbovAL3HaP19A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779873320; c=relaxed/simple;
	bh=3Dd8Q6qWEhWP9wFNWciEruqR+v4ywenwT34Hvn8250A=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hAaQgvxpWYY1oy4angpxhHdjyuYNy4rhEQPy1JXy/qVKhM38GWAcblTho6xBW3YVhUmqybfMIVLWciGK84lEwJ05Hy25Wj1gGWmowIV3laJcx6DbMuFuIL5XXpQp7DiUYfV8P2+ZgtRoA3sGsdft1ESHPaYXek3WLyxlPIjEg2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwhGdfPl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwhGdfPl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239F21F000E9
	for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 09:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779873316;
	bh=3Dd8Q6qWEhWP9wFNWciEruqR+v4ywenwT34Hvn8250A=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=NwhGdfPlS2rVpiZc23mgic/3tOE2pnrlUoAbHDyq9O21RZ+Ov7LoQDzw2Sp1bDVYg
	 en3Wpl3jPt+6HfwnwAYJcvMkUlrU8XSkp5ux+YdyHdkvLpr2ccGnbXiSjQzebNT7AM
	 YkFmFxV3ytYzJiiaTKj3wwI0Gt/1TSB1iTpe4Ap/O8YoWghQTYJvT9EyKhTjBudVeV
	 gKSk5xd4hdk3+Cb9mSoniMi0fukY0dPB/WindCoxgS43ZdLLwZC8/B0OeTsV/8IqZI
	 +yF5ObEUfbiQchwy78DGjFrh6Mqp4UiJNV2DpqHlYU+Iy9uVBk1GSY/kse/FYXgLW4
	 3cmufO4oRAPyQ==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3938cc204a7so82683881fa.1
        for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 02:15:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9OsnlzWJpd3u4cVNy6qjVW/SNmKKz1g8EUoVgL3RN7Kf3RxtxUDSmRy8q2Gir/T7y2yWLcEVk4oA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx022nvfAnju+TotCeyLmudzvdiScOb1M1D+Vw2Aq9vAwfnuP7M
	4Q0TKRX+u8iOn6JnKdgUmbWun4mi4jFqgIcsS4rndmt49I3Rot+IJ5OtieDg8Um86tBiySSv2o9
	CbBEj/NriFYmPtc9BYLz3sDjEJuq5zih53B6Ya0mVNg==
X-Received: by 2002:a2e:838c:0:b0:393:5920:2c5d with SMTP id
 38308e7fff4ca-395d8d4f352mr53853401fa.28.1779873314842; Wed, 27 May 2026
 02:15:14 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 May 2026 05:15:12 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 May 2026 05:15:12 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <CAPVz0n3_wueX1yeZ=MDfSMy3UaQa80-nGg1b7ZQuCTneOaQDkQ@mail.gmail.com>
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
 <CAPVz0n2COsDL+fNBAuKr1ty_AVe9sK5yNJithkXex6GNa1T_Tw@mail.gmail.com>
 <CAMRc=Mc9g=yezRtAtRMzh7t-pSoyoKQEtxrb5U0oeFAbcjb6Ew@mail.gmail.com>
 <CAPVz0n3X8Gw2Yo9VgwhV0uAqvArGXbvmzw=cZVJw=4BEH_E7_w@mail.gmail.com>
 <CAMRc=Mf4W9hoP7FAbxQTNLaG3M9W+GmvQSMECbzzdQLU_+5D4A@mail.gmail.com>
 <80e102be-04c3-4591-8e75-ddf859d3a877@kernel.org> <CAPVz0n3_wueX1yeZ=MDfSMy3UaQa80-nGg1b7ZQuCTneOaQDkQ@mail.gmail.com>
Date: Wed, 27 May 2026 05:15:12 -0400
X-Gmail-Original-Message-ID: <CAMRc=Me+o6qo_r3TBUCrhPp1=r-fMq3jaQW1=H91H1mM5LYAnA@mail.gmail.com>
X-Gm-Features: AVHnY4LO9N7qH868qzbdIINqstqNuCinw4l5YNVHBZffK7h_X_9w3NYe5pqcE9A
Message-ID: <CAMRc=Me+o6qo_r3TBUCrhPp1=r-fMq3jaQW1=H91H1mM5LYAnA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: tegra: Document Nvidia Tegra
 modem pwrseq
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 27 May 2026 11:06:11 +0200, Svyatoslav Ryhel <clamor95@gmail.com> s=
aid:
> =D1=81=D1=80, 27 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 11=
:26 Krzysztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>>
>> On 27/05/2026 09:55, Bartosz Golaszewski wrote:
>> > On Tue, 26 May 2026 15:41:58 +0200, Svyatoslav Ryhel <clamor95@gmail.c=
om> said:
>> >> =D0=B2=D1=82, 26 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=
=BE 16:14 Bartosz Golaszewski <brgl@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>> >>>
>> >>> On Tue, May 26, 2026 at 2:55=E2=80=AFPM Svyatoslav Ryhel <clamor95@g=
mail.com> wrote:
>> >>>>
>> >>>>>>>
>> >>>>>>> The node attached to the pwrseq provider device should represent=
 a real
>> >>>>>>> hardware component. Are the enable-gpios and power-supply lines =
connected
>> >>>>>>> to the modem package?
>> >>>>>>
>> >>>>>> Yes, enable-gpio is connected to the modem and signals that USB i=
s set
>> >>>>>> and ready to work with the modem, while power-supply is an option=
al
>> >>>>>> supply connected to the modem's vbus input.
>> >>>>>>
>> >>>>>
>> >>>>> The modem is a hard-wired USB device? Do you implement it as a
>> >>>>> platform driver or a USB driver?
>> >>>>>
>> >>>>
>> >>>> It is not a traditional USB device. XMM6260 is an embedded modem us=
ed
>> >>>> in the Tegra phones, it is linked with the AP using USB line in HSI=
C
>> >>>> mode. The driver is implemented as a platform device since it does =
not
>> >>>> interacts with the exposed USB device directly, it just ensures tha=
t
>> >>>> USB device is properly configured and is ready for IPC.
>> >>>>
>> >>>>> Is there a connector of any kind that could be used as the HW
>> >>>>> component represented by the pwrseq device?
>> >>>>
>> >>>> I assume control over USB line is the HW base, but as I have said, =
I
>> >>>> can integrate binding in the modem node itself, and pwrseq can get =
all
>> >>>> it needs from the match. Pwrseq framework states "This framework is
>> >>>> designed to abstract complex power-up sequences that are shared
>> >>>> between multiple logical devices in the Linux kernel." it does not =
say
>> >>>> that it must represent some specific hardware.
>> >>>>
>> >>>
>> >>> No, not at all. We just can't make up any imaginary, logical "pwrseq=
"
>> >>> devices and describe them in DT bindings.
>> >>>
>> >>
>> >> Ye, ye, sure, pwrseq framework is quite flexible and I am not stating
>> >> this bindings is mandatory.
>> >>
>> >>>> Using pwrseq allows modem driver to be SoC independent since USB li=
ne
>> >>>> handling is moved into SoC specific power sequence, and this modem =
is
>> >>>> used in Exynos and OMAP too with similar setup but they all have
>> >>>> different USB controllers. Maybe you can point me where SoC specifi=
c
>> >>>> USB controller handling can be implemented?
>> >>>>
>> >>>
>> >>> I'm not sure I'm following. Can you atrephrase or point me where OMA=
P
>> >>> and Samsung implement it?
>> >>>
>> >>
>> >> They did not.
>> >>
>> >> The XMM6260 modem is used not only in the Tegra phones but in the OMA=
P
>> >> and Exynos based too. Replicant tried to implement support locally
>> >> with midas devices and they had some progress. From what I have seen
>> >> generic implementation I am proposing will work with any of those 3
>> >> SoCs maybe with some slight tweaks, only part that is totally
>> >> different and SoC specific is how USB controller used by the modem is
>> >> handled (well and IPC but that is out of scope of this patchset
>> >> anyway).
>> >>
>> >> Obviously, non of the 3 vendors have submitted any mainline patches,
>> >> everything is in the downstream forks. I have investigated a bit how
>> >> this modem works on my Tegra phone and re-implemented it to work with
>> >> mainline kernel (I don't have Exynos and OMAP devices to play with). =
I
>> >> have come up with generic platform driver which handles modem
>> >> configuration and a SoC specific part which performs USB controller
>> >> bind/probe when modem is ready to handle the USB. ATM this SoC
>> >> specific part is available and tested only for Tegra devices.
>> >>
>> >
>> > Are you familiar with the PCI pwrctrl code that lives under
>> > drivers/pci/pwrctrl/? It seems to be solving a somewhat similar issue =
for
>> > PCI devices that are hardwired and powered externally. Maybe you could=
 use
>> > some of that code for your USB use-case?
>>
>>
>> I pointed to PCI already:
>> https://lore.kernel.org/lkml/20260518-mustard-rabbit-of-ecstasy-eed3b6@q=
uoll/
>>
>> And emphasized to describe hardware, not drivers. This binding AGAIN
>> describes drivers, so we did not move forward at all.
>>
>>
>> Best regards,
>> Krzysztof
>
> Krzysztof, why are you so mean? Yes, I misunderstood you and sent this
> schema. However, I am not stating or arguing that it must be applied
> or whatever. I am just looking for a proper solution to issue I am
> currently facing.
>

Krzysztof reviews hundreds of patches so his fuse is quite short, don't tak=
e
it personally, he's a nice guy in real life. :)

> Anyway. That does not matter, what matters is how to organize
> everything I have regarding this modem into a logic set. This is why I
> am looking for maintainer suggestions.
>
> How I see it ATM:
> - I will remove this schema entirely and add usb-gpio (trigger for
> modem that USB is ready), vbus supply (yes, modem has this line too
> you can check in the P895 schematic) and infineon,usb-bus which
> represents HSIC connection to the modem to the modem schema itself.
> Obviously, I will add detailed descriptions of each component.
> - I will resent patch 2 of this pwrseq with the modem patchset to have
> a bigger picture. Pwrseq will obtain needed data from the modem node
> itself (Bartosz Golaszewski are you fine with this?)

As in: the modem driver will be the pwrseq provider? Sure, sounds good.

> - I will try to get control over Tegra USB controller in the pwrseq
> without need in externally-controlled flag I have proposed for
> chipidea driver. I hope my idea will work.
>
> Will this be acceptable for both of you?
>

Bart
