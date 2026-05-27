Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EAD276049
	for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 07:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779868506; cv=none; b=cqeK2DwIPT1RgwE3thRuKAYeFAJzY73q1Z9TLVRTpsPjdT5J9mR7eo/Mn7yW8YCYIcdhS3EVi6s8kwPJK7Tp+N6Q/6t/AIIWSeTcOcl7dNdMlZptLeewAGXrS356Tq9VdMOgUcLIE0C6hsHV1GZeb9UKyPF4OpyvzJbkIKkJroQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779868506; c=relaxed/simple;
	bh=TinoBZ5FTOzSVqA4vf8A548fMG5R5EFZFN4mybwiaj8=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Msg7Bd84GoNLpK4jZBxDlOMslR2g+E/e+JMQWAV6ILiVMUhJqpvfYGW6QP6pyj6UlhvqczEoeP45xRP5UroYGWNteaP2h96FB6ypZLdvpPZIJQc9YN9GTydgpHD4EFN6m4Yd90RtpbRjL1OpufyJuPxpqU4vaKVINtzRf6Gc5rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBpZwvnt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBpZwvnt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30ED01F00ADB
	for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 07:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779868505;
	bh=TinoBZ5FTOzSVqA4vf8A548fMG5R5EFZFN4mybwiaj8=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=IBpZwvntlzDZda5S4ksMbHKk2oECsb3PmTK1002SfoskyX2IaGDrlwyNicf7twiy/
	 TK+M3L+mk9MRFC/Cuom5GYjinqb9hF7vzwHDWDPXU4HhqxF3FBy5d+t3tgxL4Ws+Bl
	 NXbDjk7BhkBXWWpJkMUU1d4tj6GG6jDrnh5Bdr9W97j7izkMSc/gPRA5Hgu4aNAK4/
	 eC9AoIQjuCs+or2mtlGky4+0qkUpch6bFzIO81ugnf/cnLShR5ioHlxF7kC/OqE7V/
	 4xEG31dRTE1jsqZKoJXanDzEnGM9wjvoXL9chy/WD5h5ZeWVIC5bCZjONx5DNo6TK3
	 q0VS622CGc7BA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa4a628ab0so557540e87.2
        for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 00:55:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+RnIksVmpBYHpHVcTfD94wfRKixAJ3e/SPcN6KoHvDKdnt+NFE3sJmOzZyonLwCEdbvp1yA1E8jg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyK3u4Oq9m/vjUvttpTfqrcSxVbt0n5LJ0XetTUn0vNEeKYp4ff
	7munTA33sTYMkYggxUrDjakrojfg5h09RtquaFU24UyDmEymvuIUeM19xHk9hXCEf8KVQ/1UuOf
	3cGNz97hwjzdzcrE7MFYcIe5ZXTBUd2Ad55QyMg5CaA==
X-Received: by 2002:a05:6512:1595:b0:5aa:116d:ae0b with SMTP id
 2adb3069b0e04-5aa3232a168mr6419026e87.16.1779868503859; Wed, 27 May 2026
 00:55:03 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 May 2026 03:55:02 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 May 2026 03:55:01 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <CAPVz0n3X8Gw2Yo9VgwhV0uAqvArGXbvmzw=cZVJw=4BEH_E7_w@mail.gmail.com>
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
 <CAMRc=Mc9g=yezRtAtRMzh7t-pSoyoKQEtxrb5U0oeFAbcjb6Ew@mail.gmail.com> <CAPVz0n3X8Gw2Yo9VgwhV0uAqvArGXbvmzw=cZVJw=4BEH_E7_w@mail.gmail.com>
Date: Wed, 27 May 2026 03:55:01 -0400
X-Gmail-Original-Message-ID: <CAMRc=Mf4W9hoP7FAbxQTNLaG3M9W+GmvQSMECbzzdQLU_+5D4A@mail.gmail.com>
X-Gm-Features: AVHnY4Lt6npNCIf-HQwre2EThWE1lIb8ewUMXlF5zYGKxytOXdvRZmQqD1cgohY
Message-ID: <CAMRc=Mf4W9hoP7FAbxQTNLaG3M9W+GmvQSMECbzzdQLU_+5D4A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: tegra: Document Nvidia Tegra
 modem pwrseq
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 26 May 2026 15:41:58 +0200, Svyatoslav Ryhel <clamor95@gmail.com> s=
aid:
> =D0=B2=D1=82, 26 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 16=
:14 Bartosz Golaszewski <brgl@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>>
>> On Tue, May 26, 2026 at 2:55=E2=80=AFPM Svyatoslav Ryhel <clamor95@gmail=
.com> wrote:
>> >
>> > > > >
>> > > > > The node attached to the pwrseq provider device should represent=
 a real
>> > > > > hardware component. Are the enable-gpios and power-supply lines =
connected
>> > > > > to the modem package?
>> > > >
>> > > > Yes, enable-gpio is connected to the modem and signals that USB is=
 set
>> > > > and ready to work with the modem, while power-supply is an optiona=
l
>> > > > supply connected to the modem's vbus input.
>> > > >
>> > >
>> > > The modem is a hard-wired USB device? Do you implement it as a
>> > > platform driver or a USB driver?
>> > >
>> >
>> > It is not a traditional USB device. XMM6260 is an embedded modem used
>> > in the Tegra phones, it is linked with the AP using USB line in HSIC
>> > mode. The driver is implemented as a platform device since it does not
>> > interacts with the exposed USB device directly, it just ensures that
>> > USB device is properly configured and is ready for IPC.
>> >
>> > > Is there a connector of any kind that could be used as the HW
>> > > component represented by the pwrseq device?
>> >
>> > I assume control over USB line is the HW base, but as I have said, I
>> > can integrate binding in the modem node itself, and pwrseq can get all
>> > it needs from the match. Pwrseq framework states "This framework is
>> > designed to abstract complex power-up sequences that are shared
>> > between multiple logical devices in the Linux kernel." it does not say
>> > that it must represent some specific hardware.
>> >
>>
>> No, not at all. We just can't make up any imaginary, logical "pwrseq"
>> devices and describe them in DT bindings.
>>
>
> Ye, ye, sure, pwrseq framework is quite flexible and I am not stating
> this bindings is mandatory.
>
>> > Using pwrseq allows modem driver to be SoC independent since USB line
>> > handling is moved into SoC specific power sequence, and this modem is
>> > used in Exynos and OMAP too with similar setup but they all have
>> > different USB controllers. Maybe you can point me where SoC specific
>> > USB controller handling can be implemented?
>> >
>>
>> I'm not sure I'm following. Can you rephrase or point me where OMAP
>> and Samsung implement it?
>>
>
> They did not.
>
> The XMM6260 modem is used not only in the Tegra phones but in the OMAP
> and Exynos based too. Replicant tried to implement support locally
> with midas devices and they had some progress. From what I have seen
> generic implementation I am proposing will work with any of those 3
> SoCs maybe with some slight tweaks, only part that is totally
> different and SoC specific is how USB controller used by the modem is
> handled (well and IPC but that is out of scope of this patchset
> anyway).
>
> Obviously, non of the 3 vendors have submitted any mainline patches,
> everything is in the downstream forks. I have investigated a bit how
> this modem works on my Tegra phone and re-implemented it to work with
> mainline kernel (I don't have Exynos and OMAP devices to play with). I
> have come up with generic platform driver which handles modem
> configuration and a SoC specific part which performs USB controller
> bind/probe when modem is ready to handle the USB. ATM this SoC
> specific part is available and tested only for Tegra devices.
>

Are you familiar with the PCI pwrctrl code that lives under
drivers/pci/pwrctrl/? It seems to be solving a somewhat similar issue for
PCI devices that are hardwired and powered externally. Maybe you could use
some of that code for your USB use-case?

Bartosz
