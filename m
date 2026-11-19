Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115548;
	b=Lnb5lK1bWQDVzkcCQgyrxpQjA01diOJQn4eFpVfB5DSgeoDAR+bJHKAXW7PC2exDdGS2
	 OLiaMqtFYaLx8rzl0tsFNoovIe4BN+OyR3XX/QNSWgVU5drSB5Y5w/HKfFs6PiHFKirrF
	 R+cwUEL8g/JflDeqKZTUXausqLWtl3sFIyb7SeC6k4GLvE2f8BSUWoLQbxad8ID8r0np6
	 BIK+Xf7sZQUOncWDc4/Ckb3BFE5EhjXEynZy4zvqjjkX+UvlKlYL5AHbvtm78OxGf9FEX
	 w/aw/clacOlzZOL23t62BLV43GxM8Hvez6zbgJ418DOfhHWaWcCiIkxrtvNhcNyDooQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115548;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=cPRlIWoU3nedg5UMks9BflBLw1pyZb+IzsqBpWtRPsw=;
	b=VeaEfGgegmJgnXWCy7aaZFR0a0U6tP1tWm1jUR9y3TEp62D2uVej+iAUDjTYwtv5Ob2s
	 G334YN1LaXLLex0rDkIJgFdfLaH9u4TefFbje5wjQdo85lNIqyJIxneYr9SjWLQXfwdHN
	 +8I2r+202u0V+P/H9yU3yz75Pz+3mWR8dXElbnApsCnj9gkPL7ZjZOq0pHfneYDdEPvNE
	 FX/zzVljewga7AysUe/PxRXpCywLVKKngSy9jHMHlbzwEv8cevnxgNOpAfh9+d32frOHa
	 oGXMtN+c0rJdrYkxAWsPnSh3MH8vhVzHrg9t0ghXj3O+4I279ldG9dpYbQ6r3GqvnEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lXIUtlOx;
	arc=none smtp.remote-ip=209.85.160.47
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D458606A32F
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 19:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D458606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lXIUtlOx
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4911df1e196so104015fac.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 11:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795115547; x=1795720347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cPRlIWoU3nedg5UMks9BflBLw1pyZb+IzsqBpWtRPsw=;
        b=lXIUtlOxNq2TkLnLAun0ua+pW2mfwPSBEN9OVeCfZXhlA5QXOftv09k+7+IG3v15EP
         m3eDMbbcaoGSZfuflOwQIYvyDBo06jO/PbzEoRGcfgGj/r5cy1C2neP8sEmnOtKIqtKX
         jy7r3t0KU/r+qnzYCj1xWqdBftURSZmQ2pR8cex0AOjGYPFWnxT0iNE9Da/mECkN3Pdz
         b1KtQF1A9fKuxk/+k/1ABXxoi4+y+hhvQ3b/y4zC6EPFQF+Ht0x0c3CQkX7y9etZmNx4
         QfAceFMYRODiMM7Exq2l+sq3WoalYD5QD5mwT6fJS4sjq9zWgDCQbnBERngmbInEmtco
         +YWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795115547; x=1795720347;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cPRlIWoU3nedg5UMks9BflBLw1pyZb+IzsqBpWtRPsw=;
        b=Vcm4GW48gC4xFCyxB2PXoL6J9eTTS0E0wwtDuYlLy6OA+PqrG/ztjR6WmBfmzLEjaX
         A7fN8qlHZXuRKoQO5GT/xmtI6puOCwVpKpdswuCE0N2L/B2N0zd40Qo1sRAh1VXE+T6Y
         f1R4kBg5rIPBh44u4IvbfTwWADZrM18rrCYaLjryp3aJwHWgW0m3emWGh9uBBMKe0bvY
         LiLShhMYdG9WfRRERXGD/omfonEAB9Qx4W5DarhKAeVaJ29qH6zcTqOVBHkJTkz3ekD8
         rOXnWLDCMkpCLdHfQO/9Q73z5BbitsO8dB2caejIR5IkUqbaEKH9RE9iC0iL+Whh7Ys0
         wc3Q==
X-Gm-Message-State: APuU4Z/8IJLbS/sGndEvkySUf/H5C4qbciElV56d3WY7sA+rAbWnohFy
	35W6ackYohqjVu+FZ3X+A9XfBJ9L5wkO/Xq+Df6WfHNuze6qR59w5w1uwj2/zw==
X-Gm-Gg: AYBFou3hebzzq/72J05ZK75jMOTcV3ugMmTHYwKXdnGdVLlh27OWmRUwy89NUcF4Pmq
	wbhlbTzzOFu1T+lVcuoqA1fOzwbnYryYfOyEiFp0tJEZqGitocr3NfawESW8tnEkLwLBg84D4yJ
	K0J3wVWBYY6c2yAZCZFp6wbM1V0S/4d7h8q7zYKNdCTfKRkFDaYUKVBuuuzC5s0tifXsGDAIJNc
	O12KJ9m6DVY+xx+XVs8KaGkIlWROLgd3SxlV7/AyO8KhW7EzzNafQNsjGFmjXN0/q7rbxHfSWpO
	XtFuhELqQdOt768ICiT+V5spzrDyU/ALH3qtGZUze2qa3CY2L8vwcJEI8Lkeex/sh2UI6RB8Cow
	dlmXrwJIiNqptDAFHEI8XLeyaMMZOSaCegLwjk2xnWyTDHxvr7LdlX5mz30TStZbwo0zzFbTq7d
	CWePq8bbPfC//mRCJA7dRXCwkv0C+cT13g/o2cr66g5ztYqoa6ROtj9CaP5NGpz12z1mP0jTK5f
	Mu+UauNwyckq+KMSb6L3GBgY0bbIEbiFUVaJyTqnThTg4QeFBFYCTFzo3kmxhOLBugDjFsN76zw
	F1pt4tVZThDvX8H4gIbLCMgdZ2Rj4JVpbUk+ChZrOhFJWg==
X-Received: by 2002:a05:6808:c3d2:b0:4e9:3412:14ac with SMTP id 5614622812f47-57a0af3421bmr1094077b6e.33.1795115546794;
        Thu, 19 Nov 2026 11:12:26 -0800 (PST)
Received: from neuromancer.localdomain ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a347636b9sm223450b6e.7.2026.11.19.11.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 11:12:26 -0800 (PST)
Date: Thu, 19 Nov 2026 13:12:24 -0600
From: Chris Morgan <macroalpha82@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org, heiko@sntech.de,
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	sre@kernel.org, t.schramm@manjaro.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: power: cw2015: add cw2215, cw2217, and
 cw2218
Message-ID: <av9KGG70s_UAkKJO@neuromancer.localdomain>
References: <20261027131751.1724448-1-macroalpha82@gmail.com>
 <20261027131751.1724448-2-macroalpha82@gmail.com>
 <83695285-207e-4d0f-ada0-2273953e2eb9@kernel.org>
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
In-Reply-To: <83695285-207e-4d0f-ada0-2273953e2eb9@kernel.org>

On Tue, Oct 27, 2026 at 04:57:12PM +0100, Krzysztof Kozlowski wrote:
> On 27/10/2026 14:17, Chris Morgan wrote:
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
> This needs min/maxItems constraints.

I'm removing the constraints here and pushing it down below where there is
logic based on the compatible string. For the new cellwise,cw2217 the
constraint is 80, while the constraint remains 64 for other implementations.

> 
> >  
> >    cellwise,monitor-interval-ms:
> >      description:
> > @@ -41,7 +40,14 @@ properties:
> >  
> >    power-supplies:
> >      minItems: 1
> > -    maxItems: 8 # Should be enough
> > +    maxItems: 8  # Should be enough
> 
> Why changing? yamllint complained?
> 

Yes, it did. Should I not fix it and ignore yamllint (since I'm not
actually modifying this line)?

> > +
> > +  shunt-resistor-micro-ohms:
> > +    description: |
> 
> Do not need '|' unless you need to preserve formatting.

Understood, thank you.

> 
> > +      The value, in micro-ohms, of the shunt resistor used for sampling
> > +      the battery current.
> > +    minimum: 1000000
> > +    maximum: 50000000
> >  
> >    monitored-battery: true
> >  
> > @@ -49,6 +55,28 @@ required:
> >    - compatible
> >    - reg
> >  
> > +allOf:
> > +  - $ref: power-supply.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - cellwise,cw2015
> > +    then:
> > +      properties:
> > +        shunt-resistor-micro-ohms: false
> > +
> > +        cellwise,battery-profile:
> > +          minItems: 64
> > +          maxItems: 64
> > +
> > +    else:
> > +      properties:
> > +        cellwise,battery-profile:
> > +          minItems: 80
> > +          maxItems: 80
> 
> default for shunt-resistor-micro-ohms? or is it required for new devices?

I'll add a default, since there is a default value in the driver.

> 
> 
> Best regards,
> Krzysztof
> 

Thank you,
Chris

> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
