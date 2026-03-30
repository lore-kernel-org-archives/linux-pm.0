Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA3D3BAD9A
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 10:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774867935; cv=none; b=Nf9Jqi42FZN062/Mkjlape2aFlE6KjXx4iCdvTGRT9XhvKVJhuegwX+BTyDsS6/tydSn21FnNbUBLvgJ+lSlsC/jagjMYA9OjZE0oNModsS+pxhIGjg2ieNti35X7DuiwCE4CAinyKGuoQF9vX4sMWGvRvAIM7WF4Jr+ZYbIhuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774867935; c=relaxed/simple;
	bh=8tGCl9H2u0kxygEigoVcToA6cJ97rZF07Am4vKOJmbs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z1URjv/DvM4cRaAW7l6gXiP/2kQ4uY0yZN2s4Ekm0FiRnlRxV8UfOVAqQtgvQEhzuMAuWKkfIWVV8EdxczjYBayCf3No8X+RECYza708H6fC128NpvY0FV14HmqBQAp7f72AVOyZCDnoA1WAqNEgITtGbhy8G24dVMByJwlb5Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VCvcQwNg; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VCvcQwNg"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-487012ce896so26179135e9.0
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 03:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774867931; x=1775472731; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8tGCl9H2u0kxygEigoVcToA6cJ97rZF07Am4vKOJmbs=;
        b=VCvcQwNgAwvtg6k5HaKlSk/DWAF287dpGwC0Rn8Ss871lQXbEI2DnRHtdW2xQXmJGh
         1n0yxr/aQ7X9PEd4x3a4rdhGLkK8/yVBNvq/kuJYFQ/MqrzWYRoAMq0xX/DVTmC4Ef4G
         Ytn4u/JkAGZur15HRZCJ9Q9rd2wC1JarucW9f8TKbKsDHtZcFgFZ0ziNyBOcbbhK+8At
         QJ/v1XvY0HOiHEfB7VRo3ZltFUZatWUXSOcapmU7lLnuSArdccf/tC+4RBLE2i4MmZW9
         Zwrac2m2GafZGJRLTfO56KACyfl0NUTm6Wm28CV/gxR9yv4YqTGJ/1i/uWgHcUK5SVtI
         TWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774867931; x=1775472731;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tGCl9H2u0kxygEigoVcToA6cJ97rZF07Am4vKOJmbs=;
        b=rcYBjIIb0jJ3kq3PhvRc68W/+P9288hpaajDAFWcY0f+r88JZcPblnMSE9Zg79DnlN
         xH4K4Ywm+HHWYNS9DqzfHhDa4CCQujNFe4hzRffLXI1VVOuIFfs0hif1SJ+AcFwIqDRP
         B1MzyKnC4M0AplpwDISUPFspCOKts76RodvdSCe2TGGmwYKB+EP5OyFmVWo5mmBerzwO
         W7lG10nCqJf0BF2FCb/2XVjmeDy1vKZ9+3xN6CsoAygXp/XeWo9Xj3qB2p4d/ftLrOwC
         0IDEK0uPGm1PHXP0f6f4wmAYQK9fywljSUy8gFozupbBLHcs3liZvZ6RAs907GcNRSJv
         17Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUFFqJbd+As2GELgGGOWo7PaQ786MkyPjexvqBwWRYTWX7TH+Okd2zYr39dpDMbu8ag8I3Jp5N/Qg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIblWXpPd0yVIEtOxGczK0f9NtzAh9SqfW07/b15kWCjl0jkOg
	miFUpeMOtvwJLaXy/goHo5+A5WuKkeBb2MIj54QMaJbI/5B0LPS6kis1+5spqaHdUUU=
X-Gm-Gg: ATEYQzxndJK4fNn/hwFuwyhHAxUyOvn06gCCmdJ6ACShn4Dtf+t03akZN4L6t+mkh37
	EI+9R5Bpw1caLQM/ARTamQVdPG6JII3LbpdNIvdJpgMthG3sMNN8FFPOgeJJTUBGulKdf6qeOs4
	iAAXne5JFZO8OlI88+DKFl29N3ghsyeF/hObNIskvUBCR/tqgRB+k9o8f1TfY/RgzvM5r/RsSNB
	jfVoznefbC67e58E3WT7aDnF2JFTldq3Eb27aw22B+OmCvDeOPwyXoyqa+H7uh1T1OMTcXw9k8W
	Dlro2rWj7zAR9ELQwB0VPNlTr9gglO830wRbDstxbAv/klYT+iOoNA7tqeBQ/k+hvDdEL8bExcr
	1r+IiCxliy3ZyXXTDh6daM4jiekywPCjo+gLlF2Ad4fCT0xdbmgrbzTNng3bO0f0r3ONcO/6IHc
	Pn18rGWqEnSTcFlNx4v28S68d4JLqY
X-Received: by 2002:a05:600c:a108:b0:485:3a27:a961 with SMTP id 5b1f17b1804b1-48727c82082mr167788605e9.0.1774867930830;
        Mon, 30 Mar 2026 03:52:10 -0700 (PDT)
Received: from draszik.lan ([212.129.78.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4873ab203e9sm78932785e9.0.2026.03.30.03.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 03:52:10 -0700 (PDT)
Message-ID: <6f0be0a71c74e7a7959e9ad02e93aff1cb8ef712.camel@linaro.org>
Subject: Re: [PATCH v8 02/10] dt-bindings: power: samsung: add
 google,gs101-pd
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Ulf Hansson	 <ulf.hansson@linaro.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown	 <broonie@kernel.org>, Peter Griffin
 <peter.griffin@linaro.org>, Tudor Ambarus	 <tudor.ambarus@linaro.org>, Juan
 Yescas <jyescas@google.com>, Will McVicker	 <willmcvicker@google.com>,
 kernel-team@android.com, 	linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-pm@vger.kernel.org
Date: Mon, 30 Mar 2026 11:52:08 +0100
In-Reply-To: <177409897339.266364.69715997034739052.b4-review@b4>
References: <20260318-gs101-pd-v8-0-241523460b10@linaro.org>
	 <20260318-gs101-pd-v8-2-241523460b10@linaro.org>
	 <177409897339.266364.69715997034739052.b4-review@b4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8+build1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Krzysztof,


On Sat, 2026-03-21 at 14:16 +0100, Krzysztof Kozlowski wrote:
> On Wed, 18 Mar 2026 15:27:47 +0000, Andr=C3=A9 Draszik <andre.draszik@lin=
aro.org> wrote:
> > diff --git a/Documentation/devicetree/bindings/power/pd-samsung.yaml b/=
Documentation/devicetree/bindings/power/pd-samsung.yaml
> > index 9c2c51133457..3f1a2dc17862 100644
> > --- a/Documentation/devicetree/bindings/power/pd-samsung.yaml
> > +++ b/Documentation/devicetree/bindings/power/pd-samsung.yaml
> > @@ -44,11 +45,28 @@ properties:
> > =C2=A0=C2=A0 power-domains:
> > =C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > =C2=A0
> > +=C2=A0 samsung,dtzpc:
> > +=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/definitions/phandle
> > +=C2=A0=C2=A0=C2=A0 description:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Distributed TrustZone Protection Contro=
l (DTZPC) node.
>=20
> For what purpose?

It is part of the domain.

Furthermore, TZ configuration is lost as part of power-domain power
cycle, so this allows a driver to take necessary actions (inform the
EL3 firmware). I believe this handle to be similar to e.g. the existing
samsung,sysreg

> Your patchset is organized in odd way - first patch for me, then not for
> me, then again two patches for me. Please keep it consistent. Or better,
> decouple since there are no dependencies according to cover letter.

I'll update the cover letter to describe the dependencies. 4 depends on 2,
and 2 depends on 1, hence the ordering.


Cheers,
Andre
