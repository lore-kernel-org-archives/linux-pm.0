Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597635;
	b=zyDMqUtKMnB4UgrvV0+u+ASLijnMondN++B5gPInlT6zNb0TIRwpu9Wh9SM6uBUKMRzS
	 RILhR4wZJz1NegyAsCez/liEEsUF3BO4y/Ar5o1SjKcpN1p0A8jJ3reWa09w0OSDO/XHS
	 R7Onl5CnLv1KL4XMBSYly9sKoJDGmfgqXvr12MFL/n/JvvxzYQVeGmv9OPiE7brfEBXKI
	 FErrb+101mTBmSCa4jaengf2OIId0CrYYpDjjh8THLQsgQbvDbD46ynylTmAEo4Yzyq0r
	 bBg30wwjeTIqa9Bgdv68jvfbW4/IeAyAce4PHnS2VApsqXfWmzVrLHXAfB1pnkWSLqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597635;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=iZJjvOCw+Qz7RTPFaPuatB3TKmf+mxhm32nAlNzRBg4=;
	b=P9r6UKsAReVEgXDhrbWJThsvs0aVcKGNI8yrNjCkYDh355aJS9FpYWDRI/lJFTFIb7C8
	 UwpC75szsvoNYihgyMrfDqQzr5wvbMvgYV1uEeHwK9c2Yj3GxrcV3VK7Ug+Y5mU7h2b+i
	 y5qIg8oCLDo7VSrwCYdqlRh4kO6ULuKyNXPC6HCCceex2GJ0MkcJnAXQzPwn2ei+0bbaF
	 80GiCgBsZRm8D/g3TgKaLTI5nzo/TVy5QDCRMJjw/sZo5VlOgL+1m/rGuFJNB56UgxXQx
	 WhSwcLRWd4qTdOcZh9biRjUDa/X4Z1MgIuhCqY58dZWGJ+7Ny9py//hinoKp1IMhB0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b="xaqU/oDJ";
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09D3606A881;
	Fri, 13 Nov 2026 19:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F09D3606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=xaqU/oDJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=iZJjvOCw+Qz7RTPFaPuatB3TKmf+mxhm32nAlNzRBg4=; b=xaqU/oDJTujHMusxbk+DNWU3G4
	4p+uDpNECLpDeko4WUqLozh+GtW8IQ2X4+PtMGG4McdvDNPQfCqE2Fa/wgsjf3bnaRLcHTSBA4f57
	5B7FElsTObCdFy2f2ZLQe4bs2q0uB53b1d2c/Fwe68nExV3jffhRabIGqLSNve8CEGGFl65oqFBMc
	8IZR9s4T9EQVz+bvU1Pn7Z1n5J9rOZModPtsN9g6Ya0HBfrZwAUiN51F4N8b7jCxAOulSIxs1tYWG
	SDBEnH4CTxn+WZPhCu++OrxoGDCnAqNnUl/L2JDJHI5gKR1UkhScCZYX0jZkZtEy13JNTOw3bhnX+
	6vYNeZsQ==;
From: Heiko Stuebner <heiko@sntech.de>
To: Coia Prant <coiaprant@gmail.com>,
 Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] pmdomain: rockchip: mark PD_PIPE as active wakeup on RK3568
Date: Fri, 13 Nov 2026 20:20:17 +0100
Message-ID: <gZu9MXL8T6qhkNXh4okAaA@sntech.de>
In-Reply-To:
 <CAPx+jO-+uwxMN3-LZn4nH4HSXu6GCnvdrUb9ff79W5EeCU4SZA@mail.gmail.com>
References:
 <20260925041751.495818-1-coiaprant@gmail.com>
 <CALj3r0jMLFbz+oa_z6kySDg-3aLaFWtFoKv9VB_qHhQZDpemfw@mail.gmail.com>
 <CAPx+jO-+uwxMN3-LZn4nH4HSXu6GCnvdrUb9ff79W5EeCU4SZA@mail.gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Freitag, 13. November 2026, 18:48:00 Mitteleurop=C3=A4ische Normalzeit s=
chrieb Ulf Hansson:
> On Thu, Oct 22, 2026 at 5:04=E2=80=AFAM Coia Prant <coiaprant@gmail.com> =
wrote:
> >
> > Coia Prant <coiaprant@gmail.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=886=E6=
=97=A5=E5=91=A8=E4=BA=8C 07:27=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On September 25, 2026 12:17:51 PM GMT+08:00, Coia Prant <coiaprant@gm=
ail.com> wrote:
> > > >The PD_PIPE power domain on RK3568 hosts the XPCS, the PCIe
> > > >controllers and the SATA controllers.  All of them can act as
> > > >wakeup sources for the system:
> > > >
> > > >  - the XPCS for MAC WoL, through the SGMII link
> > > >  - the PCIe controllers for PME#
> > > >  - the SATA controllers for hotplug wake
> > > >
> > > >The domain is registered with active_wakeup =3D false, so genpd powe=
rs
> > > >it down during system suspend even when a consumer is on the wakeup
> > > >path.  That kills the XPCS and the SerDes, which breaks MAC WoL on
> > > >RK3568 SGMII boards, and it also powers down the PCIe and SATA
> > > >controllers while their drivers still expect the link to be alive.
> > > >
> > > >Mark PD_PIPE as active_wakeup so that genpd honours the wakeup path
> > > >of its consumers.  Consumers that call device_set_wakeup_path() keep
> > > >the domain powered; consumers that do not mark themselves as wakeup
> > > >sources are unaffected and the domain is still powered down when
> > > >nothing needs it.
> > > >
> > > >Several other Rockchip SoCs already mark their PCIe and USB power
> > > >domains as active wakeup, for example RK3588's pcie and usb domains
> > > >and RK3576's usb domain.  PD_PIPE hosts the same kind of
> > > >wakeup-capable controllers on RK3568, so this follows the same
> > > >pattern.
> > > >
> > > >Signed-off-by: Coia Prant <coiaprant@gmail.com>
> >
> > Hi Ulf,
> >
> > Gentle ping on this patch. It was sent on Sep 25 and Patchwork shows it
> > as "Handled Elsewhere", but I can't find it merged in linux-pm,
> > linux-rockchip, linux-next or mainline, and I haven't received any
> > review feedback.
> >
> > Since then, the XPCS driver and DTS that depend on PD_PIPE staying
> > powered across suspend have been merged and sent upstream:
> >
> > - XPCS driver in net-next: https://git.kernel.org/netdev/net-next/c/5e9=
1edfb0e45
> >
> > Could you let me know which tree this should go through, or whether it
> > was already picked somewhere? If it needs to be routed differently, I'm
> > happy to resend it.
> >
> > Thanks,
> > Coia
>=20
> Apologize for the huge delay. I was waiting for an ack from some of
> the rockchip maintainers.
>=20
> Anyway, this looks fine to me so, applied for next, thanks!

got lost in my inbox ... and for the record yep, looks correct


Heiko


