Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.82.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795187701;
	b=houMsNMf5IXCImcdDQfVQekFGCzrgwG9w5k5QUf9XglSosg0GgRWAh8sZve2bi1nm9It
	 gknli0kNPBfm9nAmW9S+WkfqyKW0d85wFnBvEom3r+zfK2COR/2rdHWXzfbXRGnbf+h/V
	 129X1uD3nx7vmb6PvD657YrzqNx3xEF/ol0Zjdtb3w0b18C5RKPXUIslbrFTyP3qF5CWi
	 HkQh4ifw/GsFs96FT1Hi2fpfF9mxEc175O6kgGWCBMt7qF2xsgZwZC/TphAi1Tzrx9nen
	 2C1ADILqE3nITZZTYex6IhZmrUZQa+IYxXg5liH78KH28pbjLjXdVx9mL2HYRpmDHjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187701;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BTVg64Op0q6C9ndfjZSeyDDbPDPodfwIL2/3SvvfmEM=;
	b=XCIxRwLX1bZisOmrv2SNlXtgvzifJQs5ESTSW6E6tYhWBjlgzUDKdC3mBymPovx/xqtw
	 C/tRiL927jAiae6YVY3dKwgMf3aLTc9kc93JGcKOcY2B/GXX0dXNXfbXCiGp7XecGmu7H
	 pruDsOcDcPGrCkl0fH5+GpkWfabCLilgoj/Dp5t7alphGeNIgTnYRlzNb8mpRXcELL6/p
	 Xy0eZ+SQPP/sWlcNcU8VGP6siTlQF+vVEG6XgZW32S91iQersNljWteRtYanQ52h6O2Wd
	 VjsjF2f2I27SaGCzLjX0eBp3unfcOfq9uYic9r4AUw78YuCVpnYx01naQN4DRmViUWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WuTp10tM;
	arc=fail smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1F3606A32A
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 15:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA1F3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WuTp10tM
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-372bdb942dbso1362857eec.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 07:15:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795187700; cv=none;
        d=google.com; s=arc-20260327;
        b=Y3z2ijNI+YdSO/dGOhzJusVyyjHeS5mgbxMuVo6hFDorbdkVwMizWjvm5clDkoWl5P
         h3ySiFjcouG6gIGEhFQP3tVmgyCelTPYxdv3gV3RR9XI2aDfpV1f0N3UOxbVWe4K4GZv
         uFMqDsTSQldTikVcNC7EGKHSY1KK+vn20u4hX6px+Xxje+GnpmlwyVJmCXdf/Rbt4Ymt
         b+nAekMmdYw9V5qDWz7wiCEAU9GZ8V/oxIyA/sfNmXgdkorF8LdmtD1az/47UsEuvEUt
         PumiLQbMGL0wtOG7+7iJCDsSb760JIwUEFaea3ES7MeWy7MynCrXeGn/rUOSYl/RpX6w
         KolA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BTVg64Op0q6C9ndfjZSeyDDbPDPodfwIL2/3SvvfmEM=;
        fh=60ZV5pYh2PCXx/FxQJYxqpK0rywlTubQVvAGg0K0SYA=;
        b=piuVv75zVo0jgbumawWgt919ThbGA+ZAKUb7bw0GcucKyfjyCSSvjVPhEjjV5dHpcF
         A2nV1Z+wISLh05IQk2xlgWYDDdbwax9+Yu8MvMpx3rebK0fAKZj1+pi9b6IVf2tn4V6b
         KFFddrEEwDqxJFQ4y2n+tk51gN7SiqupQFDxU19BbQVGxSoyFnva1jhxAg1Pb06N8vKW
         xO9ZSnmvv1mY6gjARV5zUg0RRr33xLC+W0S8P1GhVZer30mdXPI3Mb9UlQ7p3mKmgpw7
         MCDDfJd7YcmMLx/D27gz2P9/TIAHZEPOV5Vv8ZsMHKpd6sZ5lkPqDCFvXOYXH9RW8hJu
         7Szg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795187700; x=1795792500; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BTVg64Op0q6C9ndfjZSeyDDbPDPodfwIL2/3SvvfmEM=;
        b=WuTp10tMLt6quTLDUoIPlzwBypkOMQJNj+vf4TTfECZ/GqWqCsgs3AYI8wpAJ4SZx4
         MUuOzaDkO5uh5MZbFAOlrs8i8pZPQ6DS5JytlD7LMXxu+MjlhfSaM1gl+n6M3xhybkAz
         I6DVJtTZlrfQFu4Xj33bsQAhE3hVTCEvGP2suhCDp6l/8JKo8WXlhqEJCBun9SGSSXvC
         r0DI1bP62/E6NgoLI+h1+Hc3gmBR55Of/S0qPGWtxsE7gMYMn30DJ1Z4qnVOEeN4u9FM
         h2RpwA3/3BbD66QkA+HQkuuO0twdCZOWGVATOmbIEmdhKik1BikdQ6l8YXriWEXupjBK
         SKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795187700; x=1795792500;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BTVg64Op0q6C9ndfjZSeyDDbPDPodfwIL2/3SvvfmEM=;
        b=Wea95VNFI/nH1XiuiOFeTGoeVWbmpW24t6Fx2nbAAGuUYuI/aK4vBeGaVdwyXF3wUp
         cM95sJOSueLckMWH/Xtok8RaS3jpvZMzuLMu5JZCikcgTA9eCMobNa2SyYhaPXpz77Ne
         wbT/SVhgfe7AiIPN2VIgVvtHsBGOw/57lr9YMOZvPkHYprTFKjQ4ZbFY7fSqXvNt/GV1
         iimLYfcWe+k7baMChCBUuxp929c18oFQUQrq+wxV9QmdnBUbzzW9X9YrlFd/vIQwJigW
         ug9Arz8JFYjzK2zE/BNVAX5zEqVsyrYnWfVh96AgNQlUh8pv734KpIO2yDln0ofC8i8B
         4epg==
X-Forwarded-Encrypted: i=1; AL+hErGT5jnHrYaFr7YH9xXRdIs8drGqo5dQnB9kAb24+jFyV2MMrIgmbw1GpYh0EDbYZ0cTMwUFGKl66A==@vger.kernel.org
X-Gm-Message-State: APuU4Z88teiT7NJTk2+dIdpquZJhylClJuXrpU6g4UIx0evHMND2iB3Y
	S6aaA4ml4scg8rV2GwShNts4bvyIHUcya4RL64V+75UhDxQWp3Tag8FN8Sh1zjdv+1Odfz7Sv4h
	shckiRNnbtlACh8EWXzuSv6BDGIYLVOyLIPRu
X-Gm-Gg: AZFdTZcRYz/9ukIcAb0a5PQEC8mBgzs3TyPhnTnbdM+1SIx984JIzXo9Ux2nfpTSejA
	GTtZen/D7p2MmShBWL2NXbbq2SpCJt/CNTBE/WYhBDGNOp0MUk8EnJBCWcTYvUAwKO1g5hYqBly
	+c++Oat4BKShWo4exNhiONzAqjpPt5XV6oBr2TpUfBwBdm18qX/m7GlJOfK6eTNgQMMcHU1ASCD
	xIRTZqv8urKneOB5WzbIGjLhl3LGP90vGb0njYFyC7FrnE4TsnDR46LE9sTIRr0VNzaoUvcxdju
	CKjSaScOd0r9WpVIxq+hZj7dcM51rJQ8WIbw5OsartmIP6No4aieleCtvsXxo4EL838sgnxndBp
	L1un/JUWffOddrbpqyI2e071J2i6mICmqOa94F4hpBVcP7uTj/5a68q4uLHBDc7ypVCRLyA/6/e
	aqWRhULkL6xFDljf0RH8I1y7KPayDynYtYvgEJgucxVKGSe/6DQro=
X-Received: by 2002:a05:693c:4091:b0:384:483f:2ea0 with SMTP id
 5a478bee46e88-3856f65af07mr3934775eec.17.1795187699638; Fri, 20 Nov 2026
 07:14:59 -0800 (PST)
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
 <CAMuHMdWPvKop0KAg_nff29ZeAELKprfmDtp8hDU2KPvJH5VVMQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWPvKop0KAg_nff29ZeAELKprfmDtp8hDU2KPvJH5VVMQ@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 20 Nov 2026 17:14:48 +0200
X-Gm-Features: Aa3M54q53xAAi2-NE6j4-zP1TXb277cEgD_-5pZDZArGHR0nuFBgm3EHI75NcY8
Message-ID: <CAPVz0n3zsUixggHgKNzWsxtxDZ20GecHGa7qQf2RmzkoJ792KA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Improve MFD_ASUS_TRANSFORMER_EC dependencies
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Ion Agorria <ion@agorria.com>, Lee Jones <lee@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, mfd@lists.linux.dev, 
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 20 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 10:4=
5 Geert Uytterhoeven <geert@linux-m68k.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyastoslav,
>
> On Thu, 19 Nov 2026 at 15:51, Svyatoslav Ryhel <clamor95@gmail.com> wrote=
:
> > =D1=87=D1=82, 19 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE =
15:52 Geert Uytterhoeven <geert+renesas@glider.be> =D0=BF=D0=B8=D1=88=D0=B5=
:
> > > This patch series improves dependencies for the MFD_ASUS_TRANSFORMER_=
EC
> > > MFD driver and its various subdrivers:
> > >   - The first patch adds a missing dependency for the MFD driver,
> > >   - The other patches enable compile-testing for the input, serio, an=
d
> > >     battery subdrivers.
> > >
> > > Note that compile-testing cannot be enabled for the LED and charger
> > > subdrivers, as they have a hard dependency on the MFD driver.
> > >
> > > Thanks for your comments!
> > >
> > > Geert Uytterhoeven (4):
> > >   mfd: MFD_ASUS_TRANSFORMER_EC should depend on ARCH_TEGRA
> >
> > Though this EC is designed for Tegra based devices, it does not have
> > any Tegra specific parts. It can be used by any other SoC.
>
> Sure, the dependency can be extended once the hardware appears in
> devices with other SoCs.  The question to ask is: does it make sense to
> ask about this driver when configuring a kernel for e.g PA-RISC or S390?
>

Restricting this device to Tegra, even though it is not part of the
Tegra SoC or Tegra-specific, seems plain wrong. If you want to
restrict it by architecture, restrict it to arm/arm64 instead. Your
logic is strange.

> > >   input: keyboard: Enable compile-testing for
> > >     KEYBOARD_ASUS_TRANSFORMER_EC
> > >   input: serio: Enable compile-testing for SERIO_ASUS_TRANSFORMER_EC
> > >   power: supply: Enable compile-testing for BATTERY_ASUS_TRANSFORMER_=
EC
>
> As pointed out by Sashiko, I forgot to take into account the transitive
> dependency on I2C, so there will be a v2.
>
> Thanks!
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
