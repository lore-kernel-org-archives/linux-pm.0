Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43E03C3BE0
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774872031; cv=none; b=JVygDszEUaZiCP6OSUcf1LCPNOgAKGHWvcEuHNL5dBTsu/y7ni7Vndd3N4EFT1oo5cr0ZA9VipmQMds48w/QDZ+s+glfRdPEFI0Tij40/NECIYjnJhbgriUJ5j2w+bMma700TmPo7Y/jFBnn4yyRaW7t4K4wckpvgIR2H9Sx3VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774872031; c=relaxed/simple;
	bh=aE5fBq1X2SeEG/ena5ka2Z2L55xuyoJKeRtJR2hXII8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ewhhyvi+e7HlLFx2KIPZNmuFwiQ/zsdCPBHgYGhNciNxuJXENdaNgygWOS1xsWqU+GSsJWy3PRyBHZL2BEyoI1+B1sldRkTcdP4uVS8ort4Zik4GznmTdU2l6Zxk+PBNUA41zjL/7q5EN/DgIkDWlax5bT3c2rh7OPkMP8uLytE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w5GGPtpH; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w5GGPtpH"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so855661766b.2
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 05:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774872028; x=1775476828; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aE5fBq1X2SeEG/ena5ka2Z2L55xuyoJKeRtJR2hXII8=;
        b=w5GGPtpHSdwnxozu8+c4bsaFRBUHVnEx1FcrX/UR2OdBLU9KnBc440eD4o25gFtDNt
         ahd1LiFNZiQ7V6YxzWHixVRkuburAAAF4f+9QzmfoiNIheAdg8T+r6aghyYjwRF6XYOU
         a1QNQhed3hx7/LeZZHNcQyyyz1O6QVGdbr/jn6MCw7uKlrbowyha04jQSz6THiJ7es7h
         e/GOMJSxxXyDDy3uod8aKGjsE0tjBV5fRHswwnWHKchSmUoomkoTQiqZJkXL85u+qnkw
         GpztXd9x576SremoXYd2J4+xOUo656xJOevZ3FZybUaeOE+x5ljHUxEOMli1GNUHBE3A
         VwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774872028; x=1775476828;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aE5fBq1X2SeEG/ena5ka2Z2L55xuyoJKeRtJR2hXII8=;
        b=WY0i2iZJ5kPupu2JOr/bpGXh1cPu8vXROunub20Pe7qxqUZE5flQpFXrKZw/hBopMw
         mrndODIGHu7a6zpbwUJLf0h0UfKGfp/ruP2biF+h7q3g6KFNV0SWOJiBizgSDDsKvQdh
         gzItk9D/EuJSLAqnSjJxkHFbyaDMZr1Ah0+5nYwu/ePKbgTkLRAtvgJJswUsMFkvhObv
         YETMwsOvd6aq8eVUEu32ug6F/0cnF/cvNRbbNYRFnzRTUjnD1rFau68w8pJDtCKlInIX
         qhUvwHlCQ6ruFVMKJ6fBEYNE2otXcmpPUARQl/QBswQ0M88FBGrx4tPfubQJVWupK30B
         w46w==
X-Forwarded-Encrypted: i=1; AJvYcCVTzQEEHpOkfqFBrHkzKDSQbhagboEaDgypTdIHDAttVj8sApK7eB0sTemFI1DXP0spiY6PyYSjRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YynwE4azGFnr89z+ksvNuCjuI51kGHWYPp+B2lp1z87n0wqWkeO
	aeQ/yQPa8/RohaJXhb4agspJf8vvw++osQ9YjRC0ODUXea3H+Tyf7fQXqT8s6k9NY4E=
X-Gm-Gg: ATEYQzzACLmeazvhlBKNKGfLe7JCZzIZko+w+7gBh8N3naBz+m6m7GvbJgGpyXqYPZT
	uedRXNSiVajFeHUB6h72GLz71wUgNm/fRPlatVNzniY6lnmlY7pWB4Lna1l4RJABu3W52DLjs5L
	i6C1SrDYEsFWsfg7A9xYkRlIfGp5xBbH6Fk8ptJVrezdbHzKZzJb2+1uEqTkAZN3BWXGqxcBvDZ
	iqAqRhtEwXS4KhI4YQkKQmROhdiK/BAbsiftVCqZ+NBQSvskMWLxjcmgSvJ1CN5flfGHjYIYPnJ
	zf8qVy5dIehHY0GpBNOFxsZJFeQDFOGqK05UPpN8zU6cD2rF0YoIxViQvS96kZ8gCFJOhvaXa+r
	wWj7owLUg2VeXKyethLe6lSAZ6r3coZJq4+tk/g193O0oaaK/6rgnrN3/73iW8aKRKXDRwsU9Nu
	9IwstJwyqKWJAdpgH1d9Ii3dCQoeKAu3yFCilRNh0=
X-Received: by 2002:a17:906:209c:b0:b98:4156:878e with SMTP id a640c23a62f3a-b9b50946c27mr682254866b.47.1774872028096;
        Mon, 30 Mar 2026 05:00:28 -0700 (PDT)
Received: from draszik.lan ([212.129.78.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7b1e4395sm273916766b.44.2026.03.30.05.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 05:00:27 -0700 (PDT)
Message-ID: <dcf2c447d9bbe16e800a4dd7e74ecc26d3ade3db.camel@linaro.org>
Subject: Re: [PATCH v8 04/10] dt-bindings: soc: google: gs101-pmu: allow
 power domains as children
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>,  Rob Herring <robh@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Ulf
 Hansson <ulf.hansson@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus	
 <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, Will McVicker
	 <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Date: Mon, 30 Mar 2026 13:00:22 +0100
In-Reply-To: <355b2f8f-0a3e-4209-8b1e-10600c2b3df9@kernel.org>
References: <20260318-gs101-pd-v8-0-241523460b10@linaro.org>
	 <20260318-gs101-pd-v8-4-241523460b10@linaro.org>
	 <355b2f8f-0a3e-4209-8b1e-10600c2b3df9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8+build1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-03-21 at 20:14 +0100, Krzysztof Kozlowski wrote:
>=20
> This causes warnings, so I dropped the patches.

I assume warnings are because I didn't make it clear enough that patch
2 is actually required?

> I really do not
> understand how this is organized. This is not a dependency for pm
> domains driver but it is included here.

The binding is being updated, and the driver follows suit.=C2=A0
I particular, the driver needs to be aware that pd is (can be) a child
of pmu.

Yes, the driver does not depend on this binding update, but it shows what
the driver must support. I believe this is what we have done in the past:
binding and driver updates in same series.

I could move patches 3 and 4 from this series together with a DTS
update patch into a separate series, if that would be deemed a better
approach?

> It is a soft dependency for DTS,
> but that is nowhere to be found.

I was waiting for review of all binding changes before posting DTS.

Cheers,
Andre'
