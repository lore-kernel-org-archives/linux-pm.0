Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85719190462
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 11:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238487; cv=none; b=DeTvCLItLsN+DTMQwdj2rKUPoiC0mvmgrbo0d/ZFwfkDDnImtWSZzgPaxrt0tGYRQEFkQO8HXltyhMzKgzvENClL7S3Bke6Afr/l1I4ldWtCXzwsoK3yVb4nFZaB3SpcicWGjUa48ZMzMGdFD8y9FwkcErhQzv9rhYCBYkFKK6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238487; c=relaxed/simple;
	bh=UYw827yIYRrj8YVTD92kyqZyozycfEsTinyf3KHZ6KU=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IidcLVclItZ/I8xjYhy7r9jCcA+3KL6JmQjVGQ7FFfOn3mh5XV+AhWEk0bNDA1/NMAMA6BgFnN1LROeTEHy6yPUYDwJP1nFe9JNq3WAsNkLft9Y3kvRQo84mIuJtIxLKPZDWEBW1QmZwzNJzoLsRG/ogwSPU0SxAMWryR1YsJfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVXyNmAD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVXyNmAD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C621F000E9
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 11:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785238486;
	bh=01Ihi3305oysJ/MtNvOVfA3mMmtzFfao+1ofsfUbngU=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=PVXyNmADDlIrhgjTL1TlPbvsdKVX1Wi+vgkZLJPpKBMEGWtujq+k2RZdMLFLhwFD6
	 CEG7lZVmavlayoMLv1AEY2medGCUCawtKGII3OzQdpSnVcjl6n7/6Oh7U8ysQ3G79U
	 hV2rHE3/GZqav8+ZTeVpeKoFkHtO7uPrP4mHpenl6zacyX91yGzEjuGTq3DJGUEdx1
	 5Q3zEzLmoNQxA92TiQiShvY26V352h3I4NhgKnIvcCGWeYiu3SMQw+fI2X6RH4Qpr1
	 wzOTq1Tl+KQBuPusP12yxKWul4MYL4QRcp8U0bmV+uvN4sKAkxbXmhnC67Y67EWf7i
	 rNmgXWmrmVcHg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39f00ce92d5so23327681fa.2
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 04:34:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpyfjI5oPYsz4r+thcO1wPFMxMZjq+ZoNpe6bd24OtuAlqoR4Ny4kWdTYaG/t9e1Nls3rUlzUgnhg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9EgTEhs4hdWpSZq3JavscZbQF4P8fVNlwxePNBbmG+hF0UVPK
	ALPmHPqU4phsZx9e2nj+m8UsEEjkwAnR9kcsbwd3xL+7Hu82mRIwSRbqdF3B/btdGMJCVUA4Fly
	DSVxbJ4ogCnCZB6Ndh4pgiBqe+U5uU/8UdTCi3h5lOA==
X-Received: by 2002:a2e:a803:0:b0:39c:6d58:a6e3 with SMTP id
 38308e7fff4ca-39f51d0eb41mr4092081fa.21.1785238484908; Tue, 28 Jul 2026
 04:34:44 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Jul 2026 04:34:43 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Jul 2026 04:34:43 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <TYCPR01MB11332A50145F29D93157A58BC86CB2@TYCPR01MB11332.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725123433.162348-1-biju.das.jz@bp.renesas.com>
 <20260725123433.162348-3-biju.das.jz@bp.renesas.com> <CAMRc=Mf_oNCQK3o5-s4u8zejkVWM4WN_R9YO+NA4od0qqtGjow@mail.gmail.com>
 <TYCPR01MB11332A50145F29D93157A58BC86CB2@TYCPR01MB11332.jpnprd01.prod.outlook.com>
Date: Tue, 28 Jul 2026 04:34:43 -0700
X-Gmail-Original-Message-ID: <CAMRc=MdU12B-+vQxCuFVuoJLLza_51-bv1o1T9VYEHbkiZF1EA@mail.gmail.com>
X-Gm-Features: AUfX_mxJCIRjsW_9Xtb4PyCGY0h9DXj72jiAoCqaRJdgo5M-pPtrUtXbvTNYmIE
Message-ID: <CAMRc=MdU12B-+vQxCuFVuoJLLza_51-bv1o1T9VYEHbkiZF1EA@mail.gmail.com>
Subject: Re: [PATCH 2/3] power: sequencing: Add Renesas RZ/G3L Power Ready driver
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"laurent.pinchart" <laurent.pinchart@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	"magnus.damm" <magnus.damm@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	"biju.das.au" <biju.das.au@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Jul 2026 11:17:58 +0200, Biju Das <biju.das.jz@bp.renesas.com> said:
> Hi Bartosz Golaszewski,
>
> Thanks for the feedback.
>

...

>> > +
>> > +static int pwrseq_rzg3l_pwrrdy_match(struct pwrseq_device *pwrseq,
>> > +				     struct device *dev)
>> > +{
>> > +	return PWRSEQ_MATCH_OK;
>>
>> When I see an always-tru match() callback, it always raises an alarm bell.
>> Typically, I'd expect there to be some validation of the consumer happening.
>>
>> Please at least provide an explanation of why it's ok.
>
> Without the match function the driver is not probing.
>

Yes, that's expected.

> sysc(driver) ->powerseq(driver) ->{DSI,CSI,USB}(driver)
> there is no property that I can match here as the resource is a register on
> the SYSC IP and powerseq driver is instantiated by the SYSC driver.
>
> Maybe I can provide a comment here saying that??
> "No DT property to match here, so it is OK always"
>

So the sysc is the parent of the pwrseq provider and the CSI, DSI and USB
drivers are the consumers of the pwrseq descriptor? The latter are children
of the platform bus, am I getting this right? Can you point me to the device
tree that describes it?

Bart
