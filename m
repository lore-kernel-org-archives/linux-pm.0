Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A773407582
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777553412; cv=none; b=WXLexOqYrm78HiLuJj6ri0oOwSawlgUMDH2Fu3DKTINnc4lun6WdISc/JvSRfTTFqsSML8p+bPyBLJgi8LRW0/hYL2qNYxNqGgl7YGVbAiNsnSTc2MyLQIs0IVgJdOXjk/nHbZObkjRHIwdq7cpY74qONtq4ytECiBcaaBKm/TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777553412; c=relaxed/simple;
	bh=EUAeZZiWir+om8O/lfmhWKlIvgnl/Vp0lghxn/70ykI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ma6Noi89e8mPuhkUXxfmNT59ZtoOSRH+yj6TgiHXyIybiwRk6AbNZEEXPWuMwTTO1JQvfa95IxZf6FzPSyewOiYtc2seEfntlJcDDndNiIxZAfNPXgAdWszcJeh1DwFDuQFS/3j6i7A6OEyzy8c0GU6XtWIV4MAGBLnObqeMs1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38e12c67a6fso9370381fa.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 05:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777553402; x=1778158202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nuQFrVM35wc/XdWiWZfeFiOqf6xuZFSJEgb1hfqaX5M=;
        b=aHI/6ht1HJwYO1mnqS9gxg72Fu1vrAF/IKIpLDxL8ubz0uerfVNHc4ntZtH3J4XLTv
         b/FRUyOPjdf3p9uAvNKMpypCPRUCnC41CJ5bsY87q5yOfaH12X8fmGmVW9Kgd2nFNlLW
         WzIVu5dayhhhO+wIbA/3DsLhrjwozK1DeQ4Sm84IDa2iE+cH+oJ0luQeIouyRdlLad5l
         0sYV3INr07F//V+t/0cEbYGWShqete+xG+xg3IdWfiuvZknqBI5AuqEI6+DBSGYGZDzx
         23/s/dB48oIKq1QYpKY4C0YmyKfa5/KMApxDGiTXXH8L7eQnwlbUPTNQnRph188nPiHd
         ER+Q==
X-Forwarded-Encrypted: i=1; AFNElJ8PAHSt/4/DQd+8XyrFoe3kUV/aTaaK2qo1TPr4ng1wPWyUqS5pfkCUwQTka64fONbp7sNcjBssqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YziC3ERS8hKxgaEy/RbO26I9gKQK6/uO5yvxJ+1IAS4oNmzHVPv
	907L7Ehdv0sL58lOXSHjC9cvX4VwL8UwDqu00/s4Mr+XJEIRYNh4+Ww2xHlWcg1booU=
X-Gm-Gg: AeBDieuVkoWT5eG/NOvw/yO1biECsObL6cjCaKIVObYfDRW8QFGnKOWBHMeNHDLwHCX
	ecMurJIEHV+UdLOuX5LRrrd+K/kORmbt1lo5YhaLwCJSupIc9ZZ+XQG6F/F05LJ/tWynrVCWD6m
	OooMgPSD3WZmwogt6cov3aLgv5uR/bWrAXW6yXaiGZy/6C5qua2yWoIRxqlYLjuG7RJ6O7H2JyF
	cyAIawKJ5HtWGZrymhnrZ1fPJeO68SmJdeaCqkN6LE+hZ3yLaLEfbwXBZ4NTayEh6QnK6JbpxHF
	wVPyek/tKxKK6JD/epUSzvftZgVQ/nJqBkiwziKpY4KjPTnqM215YMHEXnr/8K9W4eXeP7U97Yz
	GkTXl3ZWIHqT39N7T5alQ++8qBy3CsxeBdLNmka80cEG1xfjO93SsyOL1e15K9In6hLccq9Wtrh
	8A7e7eAXgGr+XFtF3utYYP6xs+QBUO5UGHYEy1LGWLe7rECxPRBS2O2xxEA9UDNA==
X-Received: by 2002:a05:6512:6c8:b0:5a7:4ac8:b332 with SMTP id 2adb3069b0e04-5a8522dc1ecmr937014e87.38.1777553402089;
        Thu, 30 Apr 2026 05:50:02 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a74a773599sm1411071e87.77.2026.04.30.05.49.59
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 05:50:01 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a2c3dfb4a1so818754e87.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 05:49:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+iNDxE2rUjAtnDSvNGX0qHg+YbtWWXASSGPLCZvM0ln5ozZfVKvlFk3OC0eHxrDQMn9nyF68Krfw==@vger.kernel.org
X-Received: by 2002:a05:6512:10c8:b0:5a4:175a:ce72 with SMTP id
 2adb3069b0e04-5a8522dd822mr1025501e87.39.1777553399625; Thu, 30 Apr 2026
 05:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025043129.160454-1-iuncuim@gmail.com> <20251025043129.160454-2-iuncuim@gmail.com>
 <20251026210905.GA2941518-robh@kernel.org> <1935223.tdWV9SEqCh@jernej-laptop>
In-Reply-To: <1935223.tdWV9SEqCh@jernej-laptop>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 30 Apr 2026 21:49:47 +0900
X-Gmail-Original-Message-ID: <CAGb2v64z9RMsGiy0skudn4cgo=RajxCho-vaXr5rUo5HPpqjPQ@mail.gmail.com>
X-Gm-Features: AVHnY4IT6nLdgfoMRlxWNV7nGADa-98ikdi3BEcPI2XpUYcTyVZLvYz4C1kzI-g
Message-ID: <CAGb2v64z9RMsGiy0skudn4cgo=RajxCho-vaXr5rUo5HPpqjPQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: thermal: sun8i: Add A523 THS0/1 controllers
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: iuncuim <iuncuim@gmail.com>, Rob Herring <robh@kernel.org>, 
	Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Samuel Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Andre Przywara <andre.przywara@arm.com>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 3:01=E2=80=AFAM Jernej =C5=A0krabec <jernej.skrabec=
@gmail.com> wrote:
>
> Hi,
>
> Dne nedelja, 26. oktober 2025 ob 22:09:05 Srednjeevropski standardni =C4=
=8Das je Rob Herring napisal(a):
> > On Sat, Oct 25, 2025 at 12:31:24PM +0800, iuncuim wrote:
> > > From: Mikhail Kalashnikov <iuncuim@gmail.com>
> > >
> > > Add a binding for D1/T113s thermal sensor controller. Add dt-bindings
> > > description of the thermal sensors in the A523 processor.
> > > The controllers require activation of the additional frequency of the
> > > associated gpadc controller, so a new clock property has been added.
> > >
> > > The calibration data is split into two cells that are in different ar=
eas
> > > of nvmem. Both controllers require access to both memory cell, so a n=
ew
> > > property nvmem-cells has been added. To maintain backward compatibili=
ty,
> > > the name of the old cell remains the same and the new nvmem-cell-name=
s is
> > > called calibration-second-part
> > >
> > > Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
> > > ---
> > >  .../thermal/allwinner,sun8i-a83t-ths.yaml     | 56 +++++++++++++++++=
+-
> > >  1 file changed, 53 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8=
i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i=
-a83t-ths.yaml
> > > index 3e61689f6..b2f750ef2 100644
> > > --- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-=
ths.yaml
> > > +++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-=
ths.yaml
> > > @@ -24,18 +24,23 @@ properties:
> > >        - allwinner,sun50i-h5-ths
> > >        - allwinner,sun50i-h6-ths
> > >        - allwinner,sun50i-h616-ths
> > > +      - allwinner,sun55i-a523-ths0
> > > +      - allwinner,sun55i-a523-ths1
> > >
> > >    clocks:
> > >      minItems: 1
> > >      items:
> > >        - description: Bus Clock
> > >        - description: Module Clock
> > > +      - description: GPADC Clock
> > >
> > >    clock-names:
> > >      minItems: 1
> > > +    maxItems: 2
> >
> > How can the max be both 2 and...
> >
> > >      items:
> > >        - const: bus
> > >        - const: mod
> > > +      - const: gpadc
> >
> > ...3 entries?
> >
>
> Because old variant uses "bus" and "mod" and new variant uses "bus" and
> "gpadc" and none of them uses all 3 entries.
>
> Although, I guess we can simplify and just use "mod" in both cases.

Yes. Please just keep using "mod".


ChenYu
