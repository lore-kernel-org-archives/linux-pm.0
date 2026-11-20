Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795188815;
	b=Dvfrax5kQFlHZpG0PGdexnC8myJW3JhepFO3IjcW5D85T2CGLsvHWN1eJnWbhoOlpWqq
	 4I8e4D4YIyqmHSKTFakkJq7RfLBvrZg6HHeOuMKopIb1Ey/zUVpTUSeLcQYV5TTfyfDiE
	 I1S+Ak7JeNAV7m7LrKO2+Q40btg1mkhyweKPQMGl3B8Af74Mo4dvXejDmxcCG3d2mhmBy
	 F/4KzF3ouasdBWJX1kZGdIeXZ2WxnTaZ3Q2vrqNiTuK1vxwoWh8OBJ0TeJ+qieOh8LCId
	 HlO3t4huGxZvb9blhRXFBZ9sMEUe0eJ+W2wubCvyKzyN1uE4BOXHaRFSsqiiUPFi3rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795188815;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cn3lpGNrKpPmr2WW+2DRITn4KazHE8yVcfU/4bT7oXM=;
	b=j3F4IJ1sX4vidTYdOC4qpwzpY5oY1qZy/GuslW1Zbi/oT+0vlWQGfVY9aPu/GkN+woBp
	 nqVTM0415c28qIcOcGcOjkj3JqQQ4nTudYwv5tSZ80tmaQmREsGh0KxnMlQFWAIaq8WYY
	 z+Q/HqVP619s8rW+uV078di644g1Qq2GYEM4LThoJ3mGjK1Vpeb2tvTqXDusbdosAxfia
	 ETJzzDWyR1TFUk+V6Lj2ULHCe35rKgmUIrAIDnHiOTSJ1UcZwgS5S10/2xklR6IqtzDQo
	 ehKZJ2GtFvSfU+wlv3f2BwNrNWhbM5+A++XNnQFkfWsE4gZxKchjLkFsVKHLFYLW88A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F96B606A325
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 15:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F96B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-67c0bd676eeso790087d50.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 07:33:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795188814; x=1795793614;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cn3lpGNrKpPmr2WW+2DRITn4KazHE8yVcfU/4bT7oXM=;
        b=Ufskliasumcj0iU09NEapQYAKhNUA6M6GhIKIBwVbpCz4y022tYaewoYpkr5uu5kaI
         eUdE/kzv1/zFBHKRA8VKlWEaSQv/FSZ8KsgBPKKrW2Hjrrbf45sLbX10adrVJSSXM4iE
         vNCXYXKalzE44Lkbv0KmNKe1rEQWFD00fE/F/8SgSI3Jp+nLs6aqxhaxFW3LZeiRWiRD
         V49BSV01/iqybnUZqPLbipO6n2ovsFJg+2a28boyxALcjKul/5BH+gMhDfpXzZtV/Tsp
         hD0SHIP2p4icfKGFiMryVIYuRiRdzbPe8SkE6xn706tzIWRhPoFVf9XeU0d36JlUeo7M
         6Vrw==
X-Forwarded-Encrypted: i=1; AL+hErHlpcb+ZNu9BXyl+lYIZfEkV4iRGe9kT+tTBKL2yRWEf/pcU8RRSurmr1rst+TtaJma8nASFTTYYg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+C03b8bojKNsvs+KauXhIGmoptXM4Dd1oQgnNHJsmkNR2cBx8j
	VolPl7l7KBfMzExQ3JQmFrCrWKpgmiyRai2fVnYOY7o5V7KzAsiQ0NY933Bm3ZYy
X-Gm-Gg: AZFdTZc7G25LuMpFox/ymqhfc28tl2aQO4rPrGeOOTwjcG41DVJhJ4VpnerKU8UKxfx
	AIr1Kez5+mxkMotaaykDjzuelfGwYFsE4EuU6lnxTQ1l+guNbdUOIEZk16z4m/FOsAVOFmh+XhY
	GKFIRZSAVdhcxs8VAW2zBGKgDt1isVag6SVmrhSjwryukPrL6metmb1TSwQk3OEC9HgiQr/5dDh
	gobAljWn3ONEsbnjE8volWlbMkQW6ONtBRpPeq/FhUqQeqJE+mTrGBrUHhfyMrDbzjditBQ76ek
	IwIC8h5pZqxypS6QgdxA7EvRJVHbp5VHNBwfjId+6UG5XfVEKB/7XUSDPKnf6RWEePwe6fu7zcx
	l0aeZEgUVt8gyC8axlnHti5TsNmckj4z+Ymu495J8wHTV0ULd4rj5VsMos/RtVAuxQj/yNtYAfr
	h3KJrT/bbUzyrByjlZRHlo8SaxWRciA3dkaI0si6cPUdJjqI8RIxwi5P7HJAL2RsKxC2UrXRTiM
	ls0aHiY02lBRm1NmWBYyah5O2JOV1/udS/7qHM22lcUbaj/hrQS06txULveh9kTkM4lquxGrk/o
	wAp4O2otvauBUntW0gU9Z3fFqJlbSJt8RuGzLLfRxLz/uGzwVp9gX2tG5PXqxBO03OHlbOsNimg
	jlM9eEMpeMU6j
X-Received: by 2002:a05:690e:bcc:b0:675:3f33:b183 with SMTP id 956f58d0204a3-67df43ce1bamr1643874d50.24.1795188814414;
        Fri, 20 Nov 2026 07:33:34 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df33a1cddsm1730387d50.18.2026.11.20.07.33.33
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 07:33:34 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7cc81984fceso416769137.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 07:33:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHLlL8emdZt6Y9an+UUhChTtmkgNzDemtaxD/l469eEjWd18ueQmoAz3R3/mGubUWSiA1Cbi7rW9Q==@vger.kernel.org
X-Received: by 2002:a05:6102:3f16:b0:7c0:1d48:b2a2 with SMTP id
 ada2fe7eead31-7d73968c860mr1362556137.31.1795188813290; Fri, 20 Nov 2026
 07:33:33 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795095742.git.geert+renesas@glider.be> <CAPVz0n1+qXrO5P+rOBKOSOE86+WcmjNF0taWDZoWqerKrjVgJQ@mail.gmail.com>
 <CAMuHMdWPvKop0KAg_nff29ZeAELKprfmDtp8hDU2KPvJH5VVMQ@mail.gmail.com> <CAPVz0n3zsUixggHgKNzWsxtxDZ20GecHGa7qQf2RmzkoJ792KA@mail.gmail.com>
In-Reply-To: <CAPVz0n3zsUixggHgKNzWsxtxDZ20GecHGa7qQf2RmzkoJ792KA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Nov 2026 16:33:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUOtO6XNw1MKW5CBi9MSK+5TxVJhf_4nOt=Zr=qordTJQ@mail.gmail.com>
X-Gm-Features: Aa3M54ph5eK70EiMju3R-mcxt-wZED0VO-z7mXKruy6-8v4cTNmqw-8EZNTAXM8
Message-ID: <CAMuHMdUOtO6XNw1MKW5CBi9MSK+5TxVJhf_4nOt=Zr=qordTJQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Improve MFD_ASUS_TRANSFORMER_EC dependencies
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Ion Agorria <ion@agorria.com>, Lee Jones <lee@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, mfd@lists.linux.dev, 
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Svyatoslav,

On Fri, 20 Nov 2026 at 16:15, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> =D0=BF=D1=82, 20 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 10=
:45 Geert Uytterhoeven <geert@linux-m68k.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > On Thu, 19 Nov 2026 at 15:51, Svyatoslav Ryhel <clamor95@gmail.com> wro=
te:
> > > =D1=87=D1=82, 19 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=
=BE 15:52 Geert Uytterhoeven <geert+renesas@glider.be> =D0=BF=D0=B8=D1=88=
=D0=B5:
> > > > This patch series improves dependencies for the MFD_ASUS_TRANSFORME=
R_EC
> > > > MFD driver and its various subdrivers:
> > > >   - The first patch adds a missing dependency for the MFD driver,
> > > >   - The other patches enable compile-testing for the input, serio, =
and
> > > >     battery subdrivers.
> > > >
> > > > Note that compile-testing cannot be enabled for the LED and charger
> > > > subdrivers, as they have a hard dependency on the MFD driver.
> > > >
> > > > Thanks for your comments!
> > > >
> > > > Geert Uytterhoeven (4):
> > > >   mfd: MFD_ASUS_TRANSFORMER_EC should depend on ARCH_TEGRA
> > >
> > > Though this EC is designed for Tegra based devices, it does not have
> > > any Tegra specific parts. It can be used by any other SoC.
> >
> > Sure, the dependency can be extended once the hardware appears in
> > devices with other SoCs.  The question to ask is: does it make sense to
> > ask about this driver when configuring a kernel for e.g PA-RISC or S390=
?
>
> Restricting this device to Tegra, even though it is not part of the
> Tegra SoC or Tegra-specific, seems plain wrong. If you want to

The help text explicitly mentions Tegra-based tablets.

> restrict it by architecture, restrict it to arm/arm64 instead. Your
> logic is strange.

Sorry for my bad wording, PA-RISC or S390 were just examples.
Does it make sense to ask this question when configuring a kernel for
an Apple ARM machine? Linus Torvalds does't like irrelevant questions
popping up, so let's wait until he starts complaining?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
