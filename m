Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBCB43C7DF
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785248513; cv=none; b=Jipswwyc2yqIcYKMShG32FgXV+J3W4EQ/loaZAPBlDdqYl+QtHiZvsB45Fr6TMnpJ5OBkXpmVtR1yBLbit4WQ25DYDHfBT/f4xtV8JYnC2kWZC4WWUG+LCszgxXeuof8pBgCryFUdR0pFC7F9zdTBhmSZb4SgAUdUMpOEaQlNlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785248513; c=relaxed/simple;
	bh=Z+CxsvFYtPm9y+NWoU9vxPs3PEoqybAGsXTBCqbGpZE=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EqLYPQ+DYtMSFXEW7BTnA6TIjI6PHfPXkf9X3+JAM6eDxhhNz8q+ZLRAt+MKuktrKaZ6ErzZP73Wzi8zckpBGk3BOKHZ9uzYFJy9Hkw3rdzXtfhrhXnz4ANjICcHxQWct+jiGs99zmfL3+rf7cFVgtgIVyoudA5HnHKipLxmM2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQWpBK4Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQWpBK4Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86B21F000E9
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 14:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785248511;
	bh=qvUWYQmiK9GcCnPFwUXGX3seVpMxpCcE/3D13k6B0o4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=BQWpBK4QmQmSHXuH+kisHYv/oWR301DLf6T+utkY4r/SRhwe8yWxAKqYu/XBNFw5E
	 VAlZHo+KVftKPRqEVIQO2hMbQxuM/4WbBr+Q9KCVcysn9tCp7o74fyZlrX5qphOcnu
	 U8ziI/Mq+Nd+SGJx+Io8nZCwpcMv2Qy6Xy+JwZmx4/00sWmTXIsddm6tCGM9a9OJ1E
	 HtgpcsMRwEvJM1wI/QgyMJRgXcDj6/xUWrJUJtX2Uedr5doZs8voSvFiBWOhABYRHg
	 nr/0i5SWYykx95GiRHlI9qCDn38XKYFdrTqq7ApAmEoG91hk0pddAFBwxxu3XHn1ru
	 d6GiH/u6FW7gw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aec6360133so3567126e87.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 07:21:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrIQGH6a04Ru+01Wr8gUWX+AM+wJBwXm2Bho8Ux0kRiANmipdp/2g9cD4fbLEf91cXpdxqLiCqN9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXhDU2+a5yLmbgeU1j7uOfOrZz9B/5xYiMngRHjh/gNscv2Zqz
	GNNkvaNoluKynifS0tg5iY/kCAWhk3MrDfvt1HDXIF2pDtQA/9AdEqVgiUD18xMcbnXF1wD4ZTR
	vzJataunAWaYcY9LhlZnsnHtUMhKVNALGzK5Ie60Tmg==
X-Received: by 2002:a05:6512:a89:b0:5b0:113d:8ae5 with SMTP id
 2adb3069b0e04-5b2d0213879mr496837e87.10.1785248510630; Tue, 28 Jul 2026
 07:21:50 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Jul 2026 14:21:49 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Jul 2026 14:21:49 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <TY3PR01MB1134633BC06738344A740654786CB2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725123433.162348-1-biju.das.jz@bp.renesas.com>
 <20260725123433.162348-3-biju.das.jz@bp.renesas.com> <CAMRc=Mf_oNCQK3o5-s4u8zejkVWM4WN_R9YO+NA4od0qqtGjow@mail.gmail.com>
 <TYCPR01MB11332A50145F29D93157A58BC86CB2@TYCPR01MB11332.jpnprd01.prod.outlook.com>
 <CAMRc=MdU12B-+vQxCuFVuoJLLza_51-bv1o1T9VYEHbkiZF1EA@mail.gmail.com> <TY3PR01MB1134633BC06738344A740654786CB2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Date: Tue, 28 Jul 2026 14:21:49 +0000
X-Gmail-Original-Message-ID: <CAMRc=MfOk=+dQvdEAY1ah=G1JNM=p7J6=+Tz_uCYDQGBMxXHqA@mail.gmail.com>
X-Gm-Features: AUfX_mxAaYFnCt9ChrAQLfj7lYVuFlzkCiBF10AJpeAwSMvv7EsvjC_3_1nmEx0
Message-ID: <CAMRc=MfOk=+dQvdEAY1ah=G1JNM=p7J6=+Tz_uCYDQGBMxXHqA@mail.gmail.com>
Subject: Re: [PATCH 2/3] power: sequencing: Add Renesas RZ/G3L Power Ready driver
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"laurent.pinchart" <laurent.pinchart@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	"magnus.damm" <magnus.damm@gmail.com>, "biju.das.au" <biju.das.au@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Jul 2026 13:55:22 +0200, Biju Das <biju.das.jz@bp.renesas.com> said:
> Hi Bartosz Golaszewski,
>
>> -----Original Message-----
>> From: Bartosz Golaszewski <brgl@kernel.org>
>> Sent: 28 July 2026 12:35
>> Subject: Re: [PATCH 2/3] power: sequencing: Add Renesas RZ/G3L Power Ready driver
>>
>> On Tue, 28 Jul 2026 11:17:58 +0200, Biju Das <biju.das.jz@bp.renesas.com> said:
>> > Hi Bartosz Golaszewski,
>> >
>> > Thanks for the feedback.
>> >
>>
>> ...
>>
>> >> > +
>> >> > +static int pwrseq_rzg3l_pwrrdy_match(struct pwrseq_device *pwrseq,
>> >> > +				     struct device *dev)
>> >> > +{
>> >> > +	return PWRSEQ_MATCH_OK;
>> >>
>> >> When I see an always-tru match() callback, it always raises an alarm bell.
>> >> Typically, I'd expect there to be some validation of the consumer happening.
>> >>
>> >> Please at least provide an explanation of why it's ok.
>> >
>> > Without the match function the driver is not probing.
>> >
>>
>> Yes, that's expected.
>>
>> > sysc(driver) ->powerseq(driver) ->{DSI,CSI,USB}(driver) there is no
>> > property that I can match here as the resource is a register on the
>> > SYSC IP and powerseq driver is instantiated by the SYSC driver.
>> >
>> > Maybe I can provide a comment here saying that??
>> > "No DT property to match here, so it is OK always"
>> >
>>
>> So the sysc is the parent of the pwrseq provider and the CSI, DSI and USB drivers are the consumers of
>> the pwrseq descriptor? The latter are children of the platform bus, am I getting this right? Can you
>> point me to the device tree that describes it?
>
> Yes,
>
> Please see [1], [2], [3]
>
> [1] sysc node
>
> [2] phyrst node (I planned to remove renesas,sysc-pwrrdy in the next version as it is going to use pwrseq)
>
> [3] dsi node (I planned to remove renesas,sysc-pwrrdy in the next version as it is going to use pwrseq)
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/renesas/r9a08g046.dtsi?h=next-20260727#n609
>
> [2] https://lore.kernel.org/all/TY3PR01MB11346FA21EFADC8A3D53D81BE86CF2@TY3PR01MB11346.jpnprd01.prod.outlook.com/T/#mf24ae1363925a97c840b275c108a9b72942c40bc
>
> [3] https://lore.kernel.org/all/20260704093433.273672-1-biju.das.jz@bp.renesas.com/T/#m31c6711b5403c5a387b22467bb88371df73ae2b1
>
>
> Cheers,
> Biju
>

Then it seems you have a phandle from the DSI node to the sysc node:

renesas,sysc-pwrrdy = <&sysc 0xd70 0x2>;

In match() you can check if that phandle leads to the sysc device who's the
parent of the power sequencer device and return MATCH_OK if it is.

Bart
