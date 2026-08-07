Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3EC37CD3A
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786120880; cv=pass; b=bSf9R6hdogNH1x++8Sd5sodkPDsPtD9TtqI6pKXnm822hSOe6dt07qKc21Ji50Ri8notUz+iT3hxGIoo8CGogXbeMLBy4fEL8U7mf5GubhQLmyp3fvlq29gGi4ULXGgBfGqC5HLfyPaYKxwL76s9nGYoSaVMX/ssDBx/73DSY2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786120880; c=relaxed/simple;
	bh=H4YOFrL1KfBu3NDle8YUdni3Mk4BFwaMFq6LZ90tQgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ObUu2ltHh3UZN32lWeinwFJIF9JnAXy3uWVGxHZ1uUPWwzxm25zUqx/oCeppI3BKiEOmj6j5q5YaxkTwhPIYEJAmb5pjolNjJ7x5KEYpCJg79We6HKmRLqfJLDmdXmPwuEUmJNt/ZXtOndFmayD7tdG4ECfusbqv5dmGYdWMT2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQWRLutR; arc=pass smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQWRLutR"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-969524c1a63so2517566241.0
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 09:41:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786120878; cv=none;
        d=google.com; s=arc-20260327;
        b=S0PzNg/+mwklAqnIhjpWJjYteEQ0NzHsX5PwxatTHVDX1DyBQmGeM9BO9rF4XOI8HY
         bVVJRDpGtmwobcHnsGp68nEmqJ2o1yH1FE+sR+o0lHAQECwPQlIrf7C/PznCeWBU2DY+
         dyNoIRCDSs4EZilL2qiNkRRKSM0cpV+sr3LxCK2q+/6dKSogqCICQa2wJzv2oMBc6y6A
         iJ7glPkrnzFK86/ytg3SYAbnDg8wXoc2EpawfainuYpd1WZ0cldxf45mnJHfzsxctQd4
         EqiIq3M0zI2bWHMhGCnYuknlARF7FMElofgE1aHQ3AYkf7fhvYC8QFspvJutV07xV6Db
         NaRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VbYKBFSni/MXYcTbspULgZDCuPfk5qG+Byfv7cl+Zzg=;
        fh=R3iJzAzL0VfpZHckCCD9g123M753TU5p/SYJ8teLgkI=;
        b=FPLEkRsETAx6CJgSWTApoodZMvg3iDrcAayPNW8TwKNDosjkPMlB2Xoq8OWu41Vc6M
         pI186BOSqLEN1hzmQ7eVAdl0pAohQzYi5EmUE5LeTCYVeH/1XRgWhTIDBam1hKz9bu6U
         krWFVaJFsdfcidAtl4ciCBDF46emb7dtucpIfR01znBZEjHrVi2A7hYd774HDc4gV2/N
         1Ok7CBRoDV67hXl1deXDf258/9869Y99YWBjy9l104j9fHiXDRrhkvATNjg0BkshllRL
         gmimjA5c8hqKA7duF/wWckJjLiqMcqB9RuNo8Y6/rvr6SHaa7sPYejp9AzatmaYCmExW
         eTJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786120878; x=1786725678; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VbYKBFSni/MXYcTbspULgZDCuPfk5qG+Byfv7cl+Zzg=;
        b=bQWRLutRFUKY/OF/6kmInYCWZcLyGaNyhItdMuuSNqAsCkK5solo5inhvi1d1BllN4
         f2FoUM7mxHcL13xsdSR/PjkSNpSbqJj/E0MbKsRafc9xqsmfzHCyWRDEBQgN4b+JLK08
         UYTx5SRS4fJuAJpBFSxSuNzed4SPx8gdwyYj9WsGBB6ueJggMvg9FWBWELo6wWhOn3rA
         y1wE/RT0j5aT2IJEjyV1D4zko8RrVkwsyjdXrAGkhLFYzeBU+1Gc6EYCzu+62B5DJ6Gy
         HfDT1izxLFumQm48VEMQWq8NdYgygHFzGxLO+uJr732wFlpsz0FiOW8K3ymk2DOyCMxc
         APhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786120878; x=1786725678;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VbYKBFSni/MXYcTbspULgZDCuPfk5qG+Byfv7cl+Zzg=;
        b=lP9ZbLhhz+vPyaTwcjA+4PoumDsIJ6f5Y3rnl+Kw3y94DmmrWuwQu8nlxnJVWXINo+
         BT7oT9AOkI4s3fxrx1kIlBOMzFHedTKN1CE8SegYAQlCIuGd3ifTA1Mzp/7fISwdkAsJ
         5JD+ZC7HPJwX5XeWNefhYkJpgtJaCCvv1svLL8CCrmRAx43r8mqcmF7Lhfr/7br8KhkC
         agH58w5QvMXk7kixjS0XqMfXNUB0AlFFrb3P57JhkISTHYpRZG7WaaOTP5V+dqTonlsn
         +q+toFMIjY/vseIs+bmgYjF1dgcSavb8OtiNyqcz5Rf/AWoZRCgil3T27dibAO5Phvff
         4saA==
X-Forwarded-Encrypted: i=1; AHgh+RqQM5iynF5fIK6HzC6+nkXdbsoFHCdiVaqzQ4hd/jAnBMP6aWvZPuBzmyR/Tmo/drEdePTGNgXtNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSihZPm4GKuVGPqTDjxse3wr+WtUExbjJvotDmollv2Tv6eUxf
	AqMJ2I4p4A41qPpuY+Jl0IHEKKMiJWpcH+bskFTF/RqiHaSC/WBTeiP51eoAGYizF/4CUq16vVH
	qQf/2pfovidd5tg+F6dbOf36Om+cSjeo=
X-Gm-Gg: AR+sD1280rBc+7Oqyj4PMaSSlgdsyqLzNwutkB+R1k+1EaCp677xKlupzvNXg5clBfQ
	OQ4raxoweL7l8OJKyYBxc8puk3jY7m54FMzYS/VS2/csVJn1TMCvfrA3rOUVqPFXdfyPk8Y352a
	hl+wSGl+tC7nwIZ+1jpXPfClJN+Yln6Jf3/0vAFToLfCpJ7BoOkK8h1OxXTPYdtcdzF8gVgNsj/
	arh2p7wcj+CQxZm3tRoPrX5/5fnRiYms5aK69dECILrXXwkXSTNItPKzPAO3+VUuj+C8gSqyktO
	P18FbqkRphkUVFfcnFPHmo6wBpHzhLRvBPTXBjL/5XSU6X7113hc8M2AbunoRXrU8NX0rNY7Few
	Q2uV1etDvzDjTdYBWgl8f5FRoV1Ies24llmizXgN3Qos5Lgv7cvmA84MtgFDIjkuez23oyHIEEs
	0JImVxSq/fkHKWOrrDgjOJ7X19q8RT/D3snYQe
X-Received: by 2002:a05:6102:578b:b0:737:5c42:858b with SMTP id
 ada2fe7eead31-764e72c3a27mr698784137.11.1786120877713; Fri, 07 Aug 2026
 09:41:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-submit-mdio-of-dynamic-v2-v4-0-4beb0c50d5ba@gmail.com>
 <b2e83ba0-2e9c-4105-b806-8a155e8b9aa5@lunn.ch> <CADvTj4rame1n8eQL2GUOaJHnOcR_cqNxzNYO+QeCLYDczEFeUA@mail.gmail.com>
 <ddce5cfa-8cf9-4f9e-ab0a-0b415706876a@lunn.ch>
In-Reply-To: <ddce5cfa-8cf9-4f9e-ab0a-0b415706876a@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 7 Aug 2026 10:41:06 -0600
X-Gm-Features: AUfX_mwLDixIRmddCRIK4ioEeGf1D4LRV-vMQxIFETRbvqYEEeJik4zuAKwk_IU
Message-ID: <CADvTj4qxGVw+PW2LeF-a3h1XfmirQZGfJA9-6Czt72XASbVLBQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/4] net: mdio: support dynamic OF device changes
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Richard Cochran <richardcochran@gmail.com>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Jonas Gorski <jonas.gorski@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Ciprian Regus <ciprian.regus@analog.com>, 
	Andreas Larsson <andreas@gaisler.com>, Mark Einon <mark.einon@gmail.com>, 
	Iyappan Subramanian <iyappan@os.amperecomputing.com>, 
	Keyur Chudgar <keyur@os.amperecomputing.com>, Michael Chan <michael.chan@broadcom.com>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Doug Berger <opendmb@gmail.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Wei Fang <wei.fang@nxp.com>, 
	Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Jijie Shao <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>, 
	Bryan Whitehead <bryan.whitehead@microchip.com>, UNGLinuxDriver@microchip.com, 
	Vladimir Zapolskiy <vz@mleia.com>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, Timur Tabi <timur@kernel.org>, 
	nic_swsd@realtek.com, Byungho An <bh74.an@samsung.com>, 
	Steve Glendinning <steve.glendinning@shawell.net>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Thangaraj Samynathan <Thangaraj.S@microchip.com>, Sebastian Reichel <sre@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 9:10=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Aug 07, 2026 at 08:59:47AM -0600, James Hilliard wrote:
> > On Fri, Aug 7, 2026 at 7:16=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wro=
te:
> > >
> > > On Thu, Aug 06, 2026 at 09:54:19PM -0600, James Hilliard wrote:
> > > > MDIO buses enumerate firmware children only when the bus is registe=
red. A
> > > > later devicetree overlay or status transition is ignored, unlike on=
 I2C and
> > > > SPI buses. Supporting live reconfiguration also means that populati=
on and
> > > > removal can race address scanning, PHY attachment and bus teardown.
> > >
> > > Please make the bootloader work around the issues, and drop this
> > > patchset.
> >
> > This is just fixing OF_DYNAMIC for mdio now, it's no longer used
> > by the AC200/AC300 PHY patches anymore.
>
> Meaning it has no users?

I think OF_OVERLAY depends on OF_DYNAMIC?

I guess it can also be used like this for live dt modification:
https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/t=
ree/Documentation/devicetree/configfs-overlays.txt?h=3Dtopic/overlays

> We don't add code unless it has a user. To do so pointlessly adds
> Maintenance burden.

AFAIU the patches other than the last one are still relevant regardless
since they are fixing a bunch of generic mdio safety issues in code that
has users since MDIO maps already change at runtime through non-OF
paths(i.e. SFP insertion/removal).

>
>    Andrew
