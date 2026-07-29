Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76DC4908DE
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 13:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330552; cv=none; b=gSkDWGOCfHXqen2RACBRi4T80onfhgZVHszFssaCfwQUGcokZGCtIVGt5pGGrQEPOUa+fXCSDYNf5QFZ7LpsKqDbMLGpfgroL3YlzLZYhZ7zVw/hrgeEwbel+8Vid2FBEB6veEkgY3Yolzm+7yqdxbNQGYQRgHaRrOgM3ib5O3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330552; c=relaxed/simple;
	bh=hPGVYBghCJkgcN3tZrevoVo9gaB35gByq1m7eKQMIiQ=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btiEc3/koq0RTS+iY4fO8YA9tIouvDlZQzyAAMC6JCZqYZBopAJJLfSc58ER5SXUeTpFt4NX+oVSxwJw9f6R0Q0UBtrQ7p6rAyXYseA0H7/zTckcpzGAgkKJt9IrosWSrz2/8ijluNMsAGAVXR3f1FQKqW+NYOaYV9kp9+q+ynY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItNABVh+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItNABVh+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B72E1F00AC4
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 13:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785330547;
	bh=ASFXsn4nXOD/mK641M4jZwzrrOlFUU+ziD5PtdpkWzw=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=ItNABVh+cfLWgv73RiFJkCwmQEUBhVv2sAXeVggmW8sKX6bWwx3atLLD3gdRMVCBb
	 QFDs6oOcSvv1c0VovBWzK2PWrSrOAvvwYGrqXGgfi98P0q77S9RniaRbuETreCTpI1
	 mfseWrDpO73hBEzU4rbdcCyEgSu4xHJzsWbj+IppAht687G75fpC4NbD0rk7eHp5CF
	 dYXEp6n03VMiqHPJVnSzlkiLuWWggtMC9+1W95te21hbAo1QIThxSG3u0kQmwFrMFe
	 r0ExQWTltCJTS8U0P0avlbpap5ZG2L/IIHxM01U0dzQ6SVP6hN5AybMm26Ee9tr+2M
	 DleiwQTarQ56Q==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b015532f7bso817819e87.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 06:09:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RojLBGJsJCMBqbBeQKhDzUDPQToUIWF6PGCm+ouj3dRKs35OwBjgdZ2PI/MeyqEciYtPEsveTxe+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YykSJfeyUa+1C7CIv7Wldj82kEieuMVOr3xhQ77ThL2kEdMThN1
	bPB9+GyyA4lv8dOqnZViiXbQFcMw/+VRluPR2gAeOoWxiefYZ+1SHp7gWz646hy/TLLCd2qxA4t
	6SRRoBcMQ2mVRoaDd11VLueUYLHgJKJUF08IHvEhbSQ==
X-Received: by 2002:a05:6512:6181:b0:5ae:a9eb:c5c6 with SMTP id
 2adb3069b0e04-5b2d0261512mr1133725e87.64.1785330546089; Wed, 29 Jul 2026
 06:09:06 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 29 Jul 2026 09:09:04 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 29 Jul 2026 09:09:04 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <TY3PR01MB113462C8DE3B70428F113ABF386CB2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725123433.162348-1-biju.das.jz@bp.renesas.com>
 <20260725123433.162348-3-biju.das.jz@bp.renesas.com> <CAMRc=Mf_oNCQK3o5-s4u8zejkVWM4WN_R9YO+NA4od0qqtGjow@mail.gmail.com>
 <TYCPR01MB11332A50145F29D93157A58BC86CB2@TYCPR01MB11332.jpnprd01.prod.outlook.com>
 <CAMRc=MdU12B-+vQxCuFVuoJLLza_51-bv1o1T9VYEHbkiZF1EA@mail.gmail.com>
 <TY3PR01MB1134633BC06738344A740654786CB2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMRc=MfOk=+dQvdEAY1ah=G1JNM=p7J6=+Tz_uCYDQGBMxXHqA@mail.gmail.com> <TY3PR01MB113462C8DE3B70428F113ABF386CB2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Date: Wed, 29 Jul 2026 09:09:04 -0400
X-Gmail-Original-Message-ID: <CAMRc=MeybezmErzs9+jYaBgXr+ufsTv5_V5sZjhP6ynuQk+W2Q@mail.gmail.com>
X-Gm-Features: AUfX_mwmatqgN8qkrJFJEW5yCcx-5JS7pmFqF_UHjRuELIIi5AWfSahrMeY1x0Y
Message-ID: <CAMRc=MeybezmErzs9+jYaBgXr+ufsTv5_V5sZjhP6ynuQk+W2Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] power: sequencing: Add Renesas RZ/G3L Power Ready driver
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"laurent.pinchart" <laurent.pinchart@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	"magnus.damm" <magnus.damm@gmail.com>, "biju.das.au" <biju.das.au@gmail.com>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Jul 2026 16:38:00 +0200, Biju Das <biju.das.jz@bp.renesas.com> said:
> Hi Bartosz Golaszewski,
>
> Thanks for the feedback.
>
>> -----Original Message-----
>> From: Bartosz Golaszewski <brgl@kernel.org>
>> Sent: 28 July 2026 15:22
>> Subject: Re: [PATCH 2/3] power: sequencing: Add Renesas RZ/G3L Power Ready driver
>>
>> On Tue, 28 Jul 2026 13:55:22 +0200, Biju Das <biju.das.jz@bp.renesas.com> said:
>> > Hi Bartosz Golaszewski,
>> >
>> >> -----Original Message-----
>> >> From: Bartosz Golaszewski <brgl@kernel.org>
>> >> Sent: 28 July 2026 12:35
>> >> Subject: Re: [PATCH 2/3] power: sequencing: Add Renesas RZ/G3L Power
>> >> Ready driver
>> >>
>> >> On Tue, 28 Jul 2026 11:17:58 +0200, Biju Das <biju.das.jz@bp.renesas.com> said:
>> >> > Hi Bartosz Golaszewski,
>> >> >
>> >> > Thanks for the feedback.
>> >> >
>> >>
>> >> ...
>> >>
>> >> >> > +
>> >> >> > +static int pwrseq_rzg3l_pwrrdy_match(struct pwrseq_device *pwrseq,
>> >> >> > +				     struct device *dev)
>> >> >> > +{
>> >> >> > +	return PWRSEQ_MATCH_OK;
>> >> >>
>> >> >> When I see an always-tru match() callback, it always raises an alarm bell.
>> >> >> Typically, I'd expect there to be some validation of the consumer happening.
>> >> >>
>> >> >> Please at least provide an explanation of why it's ok.
>> >> >
>> >> > Without the match function the driver is not probing.
>> >> >
>> >>
>> >> Yes, that's expected.
>> >>
>> >> > sysc(driver) ->powerseq(driver) ->{DSI,CSI,USB}(driver) there is no
>> >> > property that I can match here as the resource is a register on the
>> >> > SYSC IP and powerseq driver is instantiated by the SYSC driver.
>> >> >
>> >> > Maybe I can provide a comment here saying that??
>> >> > "No DT property to match here, so it is OK always"
>> >> >
>> >>
>> >> So the sysc is the parent of the pwrseq provider and the CSI, DSI and
>> >> USB drivers are the consumers of the pwrseq descriptor? The latter
>> >> are children of the platform bus, am I getting this right? Can you point me to the device tree that
>> describes it?
>> >
>> > Yes,
>> >
>> > Please see [1], [2], [3]
>> >
>> > [1] sysc node
>> >
>> > [2] phyrst node (I planned to remove renesas,sysc-pwrrdy in the next
>> > version as it is going to use pwrseq)
>> >
>> > [3] dsi node (I planned to remove renesas,sysc-pwrrdy in the next
>> > version as it is going to use pwrseq)
>> >
>> > [1]
>> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tr
>> > ee/arch/arm64/boot/dts/renesas/r9a08g046.dtsi?h=next-20260727#n609
>> >
>> > [2]
>> > https://lore.kernel.org/all/TY3PR01MB11346FA21EFADC8A3D53D81BE86CF2@TY
>> > 3PR01MB11346.jpnprd01.prod.outlook.com/T/#mf24ae1363925a97c840b275c108
>> > a9b72942c40bc
>> >
>> > [3]
>> > https://lore.kernel.org/all/20260704093433.273672-1-biju.das.jz@bp.ren
>> > esas.com/T/#m31c6711b5403c5a387b22467bb88371df73ae2b1
>> >
>> >
>> > Cheers,
>> > Biju
>> >
>>

Please wrap your emails at 80 characters as per the mailing list etiquette.

>> Then it seems you have a phandle from the DSI node to the sysc node:
>>
>> renesas,sysc-pwrrdy = <&sysc 0xd70 0x2>;
>
> But this is no more required after modelling the pwrrdy signal as powerseq driver.
>

So can you show me what the actual DT nodes and connections look like?

>>
>> In match() you can check if that phandle leads to the sysc device who's the parent of the power sequencer
>> device and return MATCH_OK if it is.
>
> As per the DT maintainer Krzysztof Kozlowski, we should not use random phandles for pwrrdy signal.
>
> Also, I confirm that this property is unnecessary if we model it as Power sequencer.
>
> From ABI, point now only matters is the pwrseq_target_data.name in the power sequence driver and
> consumers.
>
> dsi->pwrseq = devm_pwrseq_get(dsi->dev, "dsi-pwrrdy");
> priv->pwrseq = devm_pwrseq_get(dev, "usb-pwrrdy");
>
> From the experience, I don't think, DT maintainers will allow
> to define a vendor property just for the driver match.
>

You pointed me to the node so I assumed this is what it will look like. I don't
have the full context in my head.

I still prefer there to be some connection and validation of the pwrseq
consumer so I'm inquiring about the architecture.

Please respond with the relevant DT nodes' final form.

Bart
