Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795639241;
	b=a+wdAuOjbWNhu/sPfIcKFE/lty9NeHR9zUD9wNW2gBCu2Mmb9fpWeLPGn4u/erK1aoPR
	 UpcfKP36dfL2Ef2GCoiuzQaVNtOs+LzqrYle/6Z0U0QijJWzJVGUif84tOdDWaUpvfBHF
	 QzA2Uw6LJQ5lasmcZBFPt6mMQAWkcxFTZpa+3TOsB0d/c1dWIlHapW0Ak00vNlYvmPAfh
	 cx3ZaMjO3eiqxs/k6cFcxazvASpyNRlzTyoc4J1yv6FWguks19KcZwzySPb4VlFGBxi83
	 XnkBfsZRFlY9UsAW24DEtAaG7Dm0+wiOabjFjplZbe7a6gOT4LyUpylKtYwNYVQBYuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795639241;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=8hi1KZiya0UHcnzPSX4a+krak37ozdn0IOzf8OkNJyc=;
	b=Pp31kSIjMnSGm52UfXOxOQKSq/NygyttYX5kGS+5as2sfZPgUjh1C24s0kuGeg77gtq5
	 NHFHtvsw/L7J9RcJidphMEAajfPWn1quh9JC1ls3JUMebrY6hW9kD4nHSEs0v/N8YS+Bz
	 yLzTBWF6C0VGq+kOynRNo+P3ld5Ul4MuLyAOUJc7m9bj7Ici+6e7hoI92bJgovOczCHze
	 neDtDQafmxFBSZA5KKeZEhOpMTUwFiEBB/p8CeEJXbkJPo+WVgas3q48TfW7So72ffaeY
	 IMPn4u09xPAlaEpfT6OCCVvjMQ2bh6jC6aYJlUwaqzorBAduL8DY6MfOS+5RTscLz4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m0+vtZSB;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA294606A323
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 20:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA294606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m0+vtZSB
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-833e671ee9fso5564587a34.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 12:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795639240; x=1796244040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8hi1KZiya0UHcnzPSX4a+krak37ozdn0IOzf8OkNJyc=;
        b=m0+vtZSBjkmO0Cp6HPWsPVZ8DgZ/OdBhe5BQ+CSFmY04VIIJg8ehOpC9/tlhXKXE2u
         odQgnaktQjToeATIGYZ7iHTf/3GJi9AAAUSb2KzAr0g+t6x2bxMh/ckd1o7iz6RvF9A0
         ZLU3BkLdxpavvHb1SII1ZG8vKQ8XhNncxZRp0mClBM5iBu1DfK9OKMm2A95hc5y3eBk2
         hvkuhs5lGWD2zaW3ZPpsbJ+oGPWNCaCvzKatP09TMYh05GYTPVlYYjTRoqWpBu77JTv+
         1GmzGYVSWRoNajubCm3B/YI7qxthIXKxh1zGans0TmSyKGDQ+/1c63VhdIdwy4MzSMfJ
         odeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795639240; x=1796244040;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8hi1KZiya0UHcnzPSX4a+krak37ozdn0IOzf8OkNJyc=;
        b=IAloFEGe3LpiQBcCX/EFm7X2nmSw0vikIoIBQeYGCHoQcaJsZtuAtStmFmG4A86ruI
         nt/na7iVJBhVtAAD7POXvenTM+eo1nUBQyAJjDq8SkaB43apFB/sHMkgnAS4QnI7NsN6
         kTbrg5u5LW9JkXP8xNS7w5/pFA2WcK8OZRxAgbB8WUm6Yr517I7NE+gCJHE6dL+6C1Dq
         8RcI+rv2DRYsiKrTd8q1urzmGAmaUx5D3jgNG5smNLb3850jzF94HJKelCEMkZdq0DGb
         iprGr4hXffcbz9BeVZFFnAsf8zL/uc7gw2Hk72D7mPJ97HKIRbMJCgJ8BrZA3xr5W5n8
         esWQ==
X-Forwarded-Encrypted: i=1; AL+hErEdFrqrVjrXDQ/L6IEELh12AitSS2BCo5NdzubyaS667/vR7vEAzA91vzmo9PkougPESuXQ2NNf7Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z9/4Qy9simSzpC2sBk+Poz5B3hTrBEdpabWCtJNbEvCVhmTIxAq
	5Jd0N7BpTQu48jRNQxWMtr7XCRWPESeLm8chwLkTW/I/R89A6SMlHFC/8CoyCg==
X-Gm-Gg: AZFdTZc9gXuD1XPkp5OrsGz6G8h8LZAY36JjyVUU8PDaThNIByQUhqhBuNTORwl3C5z
	gViNjHXTPNe8ZID4qb3Xuv2y21dtPPtPJeI1N9/TQM/a7GVAeRLaAkIF2mVS3x9kESOsvzyi7mT
	RkZdJyXJKRP5jkt6tzg4IAtxLqFTUKrm1XEEHzud8QIzyD+8t/dbzmBu/AtsUBFgdcwFcS1IlEj
	7lHvX3TYSIbtseA3uGEjU2R8XuVN8P2C2LF2jKUrlmSuXMudbTMRWD0CYzKbLEbTvsLjZie9xb0
	kyZZIgjVvXlEHqFj1tYPA41zMgZ+tkzlr5vQQJiWoFSW8l4HUSsiHsGHEolSMxLtjoXY284yRp6
	Rx0+AikZj4zS7GCLjiSyqu0mCrx5MmIsxARQecubryGpkYc1FjlLqNy0fSglUfg2/wyFpowIPHq
	AzmWVM6a/21VL5B+s/+KQRhMyXwUL41esDLmL5VlhsgqU7sLdiDt4u9L4UQmUBkxzhmlHbHohDj
	pUHtz2OCabs0zCim4Womh1EPRE15h21sYgobBpf2hm56H3cYblYtzsZolnteyOeyw39mRCH2mrc
	rx0HfSSA6FqQRUM3JL+Eaqdek+2m/8wbngjtABsLeGmJYQ==
X-Received: by 2002:a05:6830:4411:b0:862:bc33:da9d with SMTP id 46e09a7af769-86315939b41mr19156987a34.23.1795639239726;
        Wed, 25 Nov 2026 12:40:39 -0800 (PST)
Received: from neuromancer.localdomain ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168dd6d8sm13477219a34.10.2026.11.25.12.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 12:40:39 -0800 (PST)
Date: Wed, 25 Nov 2026 14:40:36 -0600
From: Chris Morgan <macroalpha82@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	shawn.lin@rock-chips.com, linux-pm@vger.kernel.org, heiko@sntech.de,
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	sre@kernel.org, t.schramm@manjaro.org, xsf@rock-chips.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V4 1/3] dt-bindings: power: cw2015: add cw2215, cw2217,
 and cw2218
Message-ID: <awdHxIQ7AMNUtiq_@neuromancer.localdomain>
References: <20261124191346.434143-1-macroalpha82@gmail.com>
 <20261124191346.434143-2-macroalpha82@gmail.com>
 <179560806608.84329.5895350466243051992.b4-reply@b4>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179560806608.84329.5895350466243051992.b4-reply@b4>

On Wed, Nov 25, 2026 at 01:01:06PM +0100, Krzysztof Kozlowski wrote:
> On 2026-11-24 13:13 -0600, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add bindings for the Cellwise cw2215/cw2217/cw2218 i2C interface
> > battery gauge. It is similar in function to the existing cw2015 but
> > with a different register layout. Each of the cw2215, cw2217 and cw2218
> > only really differ in the minor specs and the hardware ID they display
> > when queried. shunt-resistor-micro-ohms is a property in use for
> > multiple devices so not appending a vendor prefix to it.
> > 
> > Move the minItems and maxItems for the battery profile to a conditional
> > based on the compatible string, as the new monitors require 80 bytes of
> > firmware instead of 64 bytes.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >  .../bindings/power/supply/cw2015_battery.yaml | 41 ++++++++++++++++---
> >  1 file changed, 35 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
> > index f7bde324153d..992cd5f6a216 100644
> > --- a/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
> > +++ b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
> > @@ -14,12 +14,13 @@ description: |
> >    phandle in monitored-battery. If specified the driver uses the
> >    charge-full-design-microamp-hours property of the battery.
> >  
> > -allOf:
> > -  - $ref: power-supply.yaml#
> > -
> >  properties:
> >    compatible:
> > -    const: cellwise,cw2015
> > +    enum:
> > +      - cellwise,cw2015
> > +      - cellwise,cw2215
> > +      - cellwise,cw2217
> > +      - cellwise,cw2218
> >  
> >    reg:
> >      maxItems: 1
> > @@ -31,8 +32,6 @@ properties:
> >        it is to mail two batteries to a test facility of CellWise and receive
> >        back a test report with the binary blob.
> >      $ref: /schemas/types.yaml#/definitions/uint8-array
> > -    minItems: 64
> > -    maxItems: 64
> 
> Nothing improved. Broadest constraints always stay here (explained also
> in writing bindings).
> 
> Best regards,
> Krzysztof
> 
> -- 
> Krzysztof Kozlowski <krzk@kernel.org>

I think I get it, sorry for being thick. So this would have 64 as the
minimum and 80 as the maximum, then further down for the cw2015 we'd
have 64 as both the min and max, and for the others we'd have 80 as the
min and max.

Thank you,
Chris

> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
