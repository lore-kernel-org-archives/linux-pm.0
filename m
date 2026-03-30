Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD3D3C1990
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 10:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774868361; cv=none; b=Z/r9iepLxcMJA3akiVH8l2ff0M9TfDjbM2B1o5Dl3+l63ogoKcFIp3VDHLQF9mPNXBjJAolXpiZLnX72RY9SGjQqzEtA7iILhiSYvk+8hCqywBc4YGvgPpIhp8E9O9lusmaOSVfTa9m9OK9cTVZzA9whQAOdskDGgNYiUTss0T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774868361; c=relaxed/simple;
	bh=/TXj5dE4mqvc1ssxoqFjKHWoirafJM76VbqarPKJr48=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gtwtC7rot56/YfsOA9w2y/zqedh10mJTQ554PJ5+h4hEC3IAObvK0aVAhe/k0XL0HBcmLdoCtBbHZ8yfPMQJeiP0pb/1jdY5bHyHuyEwIGNetJqSFQ8LVnM7P9IEVdIDsyX/tQvmmCAv6sCi4/6sg9Jx4/8RXG2bVUFkC1nlywY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OdnnhIHR; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OdnnhIHR"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43b41b545d9so4734425f8f.2
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 03:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774868355; x=1775473155; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/TXj5dE4mqvc1ssxoqFjKHWoirafJM76VbqarPKJr48=;
        b=OdnnhIHRLORDkLjeemJT4Vn/uQgn5CTW3+wmhtTg2QjoTSUTULguzpK3bxKFhJxKub
         iPjpL823UnseHyb7m4shyvII0SOAg4VwWpMDuFp5E+1IdwfaSwXdN21RXBsYQMGL08Iz
         7hRWR125+lZh6zPzgCiUUYjFIeJDqqQSXWB23HVcLG8teJvlVeddk/bRd48dBD2ea6HZ
         lOyEQv+Qds3xG5q73yOenjhZt1bu9d/jQn89YRfJxPeNWFOnzrD7lVp6f7LHHKvpke0k
         /FTtBWHvqUWYvgESr63wBxd5fTlZRtP2Ax4a2tI8TlscFphftcXxwQqptXMAeP4itr1i
         qo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774868355; x=1775473155;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/TXj5dE4mqvc1ssxoqFjKHWoirafJM76VbqarPKJr48=;
        b=h5/vM2LAeVmPXK53kiAa4r+H3DVDD7hXWrgm+653FWTZFoa92kGAEKNUXjJmTLVBH3
         mbHvqpNoeTBar4rPs8BAKQFYDDcJLkFOYsBvjp69pUOxpe4z+Cwp0reXHkZyGTj617y1
         1WO7iImaW4vlLRJC007z1sULt9p2L1VkJ9wY6C1YH8vQSARpYJaZeqsSvwc3vXgnTjre
         /ZOZYd+ntsV4A1w7TbQU+7+kOIvFELguofWGaix4iLHWS3zzpn67Pyv7GFfZcu3kmtgt
         4+MsjAwmANvHMOJnVcFntFG86vyt8SPYWaY3wpcCTLUmJhmGK82WgRHTC9jh68Gwpcp2
         Mdlw==
X-Forwarded-Encrypted: i=1; AJvYcCX1aDJ5W5IUl7Kz6nFwI3G1zDJq/cCUPdDtYBDsVMO5G7L3+DBGy65MRqN0TzQm6CikD/B3N1pxow==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRZQ+9zh2eJPsWF0bvPXEhjIA1M0GMqm2Xnfetjq148lt2CLkh
	ae8E7wekIfPFhN0KReV+nO9cuveJIGBSGjwN/8xS8KhuVx4V0X/hGbb044Zmdi0/tBU=
X-Gm-Gg: ATEYQzybIgSlUnTCkFIEWDNJNb+phAdM8L13k3tIhrfqIWQaw2Mr4OyX8zPeOxrdjgB
	ilL+x/THFxssP0bVgLI5WaeplocKQOulvoJf1ODzUmeajelnkBwXQWY4VtbpALZD1F6DBswSl8T
	vwsb0t6UTyTjUjQZZwJszZT1bqJul8abBwxn1V8VZMCPOrYBhfF/kXdMW35Zkvt3xcULwTqZq3B
	wHcg1K/Wle/Szg/Dy0nPpD/cGn4a2BL/y3QD9mW3/NQS4qhzlERqjxdfLsHj0gjvcraE4SdiqSq
	x+Zqo7cONfIDy7X9SmA774trm/gLpngo//cmsxEJwSg44Vba1NRWkvMLXKyNOK945pKuYc6bszg
	6LakUTmJkpe+eTQBk/+XV5Cm5x8GHhj1mGj2YqlHsAMiRpliRykuqpu6UnIN8EZljCA7+6mNAnp
	sxYhG28ToMPlM+iXR2ilSwfbNoIt0U
X-Received: by 2002:a05:6000:4010:b0:43c:fe7a:4917 with SMTP id ffacd0b85a97d-43cfe7a4bf8mr5625551f8f.2.1774868355539;
        Mon, 30 Mar 2026 03:59:15 -0700 (PDT)
Received: from draszik.lan ([212.129.78.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf24739easm18943009f8f.30.2026.03.30.03.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 03:59:15 -0700 (PDT)
Message-ID: <abeff7983dc08c3aeee8b504f34b71b1a2fcdb78.camel@linaro.org>
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
Date: Mon, 30 Mar 2026 11:59:14 +0100
In-Reply-To: <b66d7230-a495-40a4-ac75-378d0727afed@kernel.org>
References: <20260318-gs101-pd-v8-0-241523460b10@linaro.org>
	 <20260318-gs101-pd-v8-2-241523460b10@linaro.org>
	 <177409897339.266364.69715997034739052.b4-review@b4>
	 <6f0be0a71c74e7a7959e9ad02e93aff1cb8ef712.camel@linaro.org>
	 <b66d7230-a495-40a4-ac75-378d0727afed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8+build1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-03-30 at 12:55 +0200, Krzysztof Kozlowski wrote:
> On 30/03/2026 12:52, Andr=C3=A9 Draszik wrote:
> > > Your patchset is organized in odd way - first patch for me, then not =
for
> > > me, then again two patches for me. Please keep it consistent. Or bett=
er,
> > > decouple since there are no dependencies according to cover letter.
> >=20
> > I'll update the cover letter to describe the dependencies. 4 depends on=
 2,
>=20
>=20
> How 4 (soc) patch depends on 2 (pm domains)? What is exactly the dependen=
cy?

4 updates the soc-level pmu binding of gs101 to have gs101-power-domain
child-nodes, which are introduced in 2

A.
