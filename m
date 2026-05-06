Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F4532C8B;
	Wed,  6 May 2026 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778065182; cv=none; b=dWV6W7d1fR4uYiZkLFvVbsR+JWPPAzc/r2AN9W8mW5nPcPBkhBYsl73PpWFGAZneBbncvYGsAguvuwBIrIU0s0YHKBjccWHvAOt20lmlDrcil61VWyTXTZ0ytf0lL2wJ1VDbvjlE3YW/riveojGRqZ+4o/6s8v1z75ZCVLapG6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778065182; c=relaxed/simple;
	bh=XXcj7T3DFPNc7g+RbOa+lN53rr7KNdcj2NlBPpaVIQY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J0YnjIqFbK3/7b69uC+Jwei8ptaVLq2QUUe4BaFuJYGmckrXiP2Xn+aaQJ1YP9bhZwQRtY4ZyJSWGK4JU9QTzf3KoIdIUppuHwdYAZPg/H1E8LWRSfH3aE2imZe9T63pRJyrJY9CqjFZuLajXOtXDqXQN0IXZ0aAxz4IPAVMPhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=EGvbsrKR; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="EGvbsrKR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1778065173; x=1778324373;
	bh=Vp0YaEHA+Vz07FZCGn4HZFYiAua40SZzSJgjDcDx34I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=EGvbsrKRp1zTJyOrjN5rl3dTlWGFVpAz7bq3iUMc856yy0WajiUiNmBoE98uFZwHb
	 ykdM8CowM5+bdvhIWDGn/bOquMNDH3qQbBNbUNYYcIHks6ZiSyKRAeUST60HSRvX5R
	 IlMYZxq5ha+Wqiwhpy7e9xNrZ3jSD0BIdSKDvFzoG3PvI39J4aXFoIF3zq/WXKsvBH
	 gPaae4kOBbCZUEaxc5fCn+oX6Y2+g+8dn73HAu5zkr5dedRensLsNleyTMlI9B0L+/
	 Y1N1N1tC6rchd1GSkbGloTh1k10xUJGSBmwk1HK1A9n/iqg4Pezkz87lRXumhtE1HT
	 H5LqCYAtGqxlQ==
Date: Wed, 06 May 2026 10:59:29 +0000
To: Krzysztof Kozlowski <krzk@kernel.org>
From: Roman Vivchar <rva333@protonmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Srinivas Kandagatla <srini@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH 01/13] dt-bindings: iio: adc: add mt6323 PMIC AUXADC
Message-ID: <evJBbJD1B9GjUyj5xyiJVUw-Ufib330tbUxxamM8-e4kJeNlwcENufbYZHdDWb0ZItz1fsEAbDaSFk0ObL4y0zenRr4vA4KOn6IHxuBP4VQ=@protonmail.com>
In-Reply-To: <389917bb-c64c-4ac2-ab8f-b28ab0a89ecb@kernel.org>
References: <20260504-mt6323-v1-0-799b58b355ff@protonmail.com> <20260504-mt6323-v1-1-799b58b355ff@protonmail.com> <389917bb-c64c-4ac2-ab8f-b28ab0a89ecb@kernel.org>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: c2fe990d4bbda504abf775e2c63ea9d8db350fca
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, May 6th, 2026 at 10:56 AM, Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:

> On 04/05/2026 20:24, Roman Vivchar via B4 Relay wrote:
> > From: Roman Vivchar <rva333@protonmail.com>
> >
> > The MediaTek mt6323 PMIC includes an AUXADC used for battery voltage,
> > temperature, and other internal measurements.
> >

...

> > +
> > +properties:
> > +  compatible:
> > +    const: mediatek,mt6323-auxadc
> > +
> > +  "#io-channel-cells":
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - "#io-channel-cells"
>=20
>=20
> This is heavily incomplete node... or unnecessarily split. Why it cannot
> be part of parent binding? Or even parent node?
>

The MediaTek mt6359 AUXADC also has a very similar binding. The mt6323
cannot be merged there because it has a different hardware.

Should this go as a child for the mt6397 mfd like mediatek,mt6323-led?
It currently references only mediatek,mt6359-auxadc.yaml, so perhaps
the mt6359 should be merged to the mfd, and then use oneOf for the
compatible property?

Best regards,
Roman
