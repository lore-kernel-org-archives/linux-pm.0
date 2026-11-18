Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018135;
	b=GNNhSr5yrd1sGFRRvTLroH2RrfU/CHDUw/g61k6RShStDrW1Ww5ad3M2wAaRGs02438Z
	 K0/VUvjpaG8NIY86PaYoTjZ9RxKYWq3RnSoNrfZePDYB2W4fS18zmh0UMi2A01HbbvdCX
	 AZSYGv2m5+Vk5sYj9r5+euVfi1tPc45DAAgWpM+3J+DDxQV2X7tw3k2o8ICZY5WYLziyS
	 DDUdISHtT3jg/ANg/m7gZqA1FVuWgmexXYJ0z/4QaN/5udNkhWIv71QFMKH0NsWciHHtO
	 IEylyMZKRyaDp7VpyWKAEkpzQ692G/LQProES1SFnJJ+NZ93WTqlvLglcUsU6+PnMCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018135;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Last-TLS-Session-Version;
	bh=NyruYRmBJ333KKsYOsJfBubBYnjFdFekZpcsS68Afoo=;
	b=kjHaUg5ZmhefzwqeIF+u0ekH1qiQCO21ypTZwPFaiCq+mS17Eai6IWFXh3mOG44j3Rxa
	 p16EFnzBmNUQH2xqmvxpo+sAjENR2+bbcx7+MvYTwUxHNjFBhcp61BuMvxVZe+osWvAiQ
	 rJZX+muU3MPWiRH80cpy4QIMswzB+QyA2JkNKsfLJGARXF0OcTFzYtmuHOY7YO7Qd3AxY
	 U44tx0zmby9mL0HEPV7glPikHNa/O7A6ziFAWmM9NCtcOAbg7su0aCKn5mEX6SqTJs0+p
	 uxFqy6bVIMKcGYZhXBST6ZUPwVPlG+/X0pRoK1UDVLHzMJJhpiz3bAhywdaCtWky+uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=X6cEgtil;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E066606A32F;
	Wed, 18 Nov 2026 16:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E066606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=X6cEgtil
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6702A1A16D4;
	Wed, 18 Nov 2026 16:08:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 299BD5FE9B;
	Wed, 18 Nov 2026 16:08:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BD37011BC244F;
	Wed, 18 Nov 2026 17:08:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795018130; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NyruYRmBJ333KKsYOsJfBubBYnjFdFekZpcsS68Afoo=;
	b=X6cEgtil8ijijO0rJLXA2fM6mfOKCqDSKEpQnIZl8O7QDvCmAFq44iTLtGiRg59T6tim+9
	BkfAmw+/K2LmZlkCdVN2sYKaDDdw/b0/mTAmoK6EDNyam9WvPm2KyqSsK6FFH80ZrBBRbl
	fOuG3P4fgquqDyFTbuhX5QPxzAzzTotAL3yURPLSCZ75iuwuF5fR7obk1dgbOVKjz5XyHU
	usLAW0L1/qdVNqF382CZu2aco6xcOyG4qofdf/C4tljy9+Ib67sXLpy0J5bWTKyaLMICZ9
	hf3TVLYsrb2HPg/gXOz12/t9aAj1TndcLvng+XJYM9BoHm2TlIq0tO3MLsgbzA==
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
To: Conor Dooley <conor@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jun Chang <jun.chang@metanoia-comm.com>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Philipp Zabel <p.zabel@pengutronix.de>,
 Sebastian Reichel <sre@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
 Samuel Holland <samuel.holland@sifive.com>,
 Ben Zong-You Xie <ben717@andestech.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Jisheng Zhang <jszhang@kernel.org>, CL Wang <cl634@andestech.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Adrian Hunter <adrian.hunter@intel.com>,
 Minas Harutyunyan <hminas@synopsys.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Randolph Sheng-Kai =?UTF-8?B?TGluKOael+iBluWHsSk=?= <randolph@andestech.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-phy@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject:
 Re: [PATCH 00/25] riscv: add support for the Metanoia MT2824 SoC and MT5824
 EVB
Date: Wed, 18 Nov 2026 17:08:33 +0100
Message-ID: <tSRWYJl8QRO6qpOrYOmeTA@bootlin.com>
In-Reply-To: <20261117-calamity-quiver-96d0d568b338@spud>
References:
 <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
 <_koitdIgQPmk89LDhlUlJQ@bootlin.com>
 <20261117-calamity-quiver-96d0d568b338@spud>
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
X-Last-TLS-Session-Version: TLSv1.3

On Tuesday, 17 November 2026 at 18:30:58 CET, Conor Dooley wrote:
> On Tue, Nov 17, 2026 at 11:41:52AM +0100, Beno=C3=AEt Monin wrote:
> > On Friday, 6 November 2026 at 12:15:09 CET, Mark Brown wrote:
> > > On Fri, Nov 06, 2026 at 10:29:57AM +0100, Beno=C3=AEt Monin wrote:
> > >=20
> > > > The series is organised as:
> > >=20
> > > > - patches 1-14 add the device tree bindings, the Metanoia vendor pr=
efix,
> > > >   the RISC-V board schema and the SoC block compatibles
> > > > - patch 15 adds ARCH_METANOIA and selects the AX45MP errata
> > > > - patches 16-23 add the reset, SPI, watchdog, MMC, PHY and USB chan=
ges
> > > >   needed to build and probe on this SoC
> > > > - patch 24 adds the MT2824 SoC and MT5824 EVB device trees
> > > > - patch 25 adds the MAINTAINERS entry
> > >=20
> > > This sort of thing tends to work better if you submit the patches for
> > > subsystems as separate serieses, it avoids enormous CC lists and keeps
> > > the individual serieses a managable size.
> > >=20
> > I agree, and I am reworking the series that way. Version 1 was intended
> > as an overview of the complete SoC support, but it ended up being too
> > big for a single series.
> >=20
> > So version 2 of this current series will be only the platform basics
> > (2 patches):
> >=20
> >   - dt-bindings: vendor-prefixes: add Metanoia Communications
>=20
> >   - riscv: add ARCH_METANOIA Kconfig entry
>=20
> Realistically, this does not need to be a prereq either, because you'll
> have "depends on ARCH_METANIOA || COMPILE_TEST".
>=20
True but checkkconfigsymbols.py will then complain about a referenced but
undefined Kconfig symbol in the following series.

> >=20
> > It will act as a prerequisite for the following new series, one per
> > subsystem:
> >=20
> >   - reset: binding + reset-simple support (the separate reboot binding
> >     is dropped; the RST block is described as a single node)
> >   - SPI: optional DMA/IRQ binding, MT2824 compatible, atcspi200 IRQ
> >     support + Kconfig
> >   - watchdog: compatible + Kconfig
> >   - MMC: compatible + MT2824 support (split between SD, eMMC and
> >     auto-detection) + tuning/HS400
> >   - PHY: USB2 PHY binding + driver/Kconfig
> >   - USB DWC2: binding + params
> >=20
> > Finally, once the subsystem bindings are accepted and the drivers
> > are queued, I'll post the SoC DTS in its own series: board schema +
> > cache/PLIC/PLICSW/PLMT compatibles + the MT2824/MT5824 DTS and the
> > MAINTAINERS entry
> >=20
> > Thanks everyone for the reviews, I will integrate the feedback in the
> > next iterations of each series.
> >=20
> > Best regards,
> > Beno=C3=AEt
> >=20
> >=20
> >=20
>=20


