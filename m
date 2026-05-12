Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD22739D3EB;
	Tue, 12 May 2026 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594142; cv=none; b=Np6Id7LZ84KEKAkbhmoKkdRzrn3HQyRVUDR3WD1eqJV6kVyM453W9aiQUmN4JTePNi8xj2+oxC54deIW78j/vuBQ0+kmtY1t8MfKpzGY1hi5ki65isMx/ptqGPXORsRplfknHiAJSsc8jghHj+u9ArjoY2sIVu9AinInHBo08yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594142; c=relaxed/simple;
	bh=jgRlifEBlOM8yFGWiEiX/OPeYroUTUbLgteOg6HKHWg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XxT7EU3PKVwx13wSEeQ+nEpNujpU5BlbQ0L0JwkpUIDyVTUwPgM7Y7ReW69CgUwjQ9/abq7RrLzaOUEv7RrkFnw0/CocbVC8VjI+tXgCefTN/ZAfl1oXAEiPrtmVXXhh00wMXBX4SrTR47++YXEoTbS70Z8EDjhWBh7UGbMHtvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Jd7WmbEU; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Jd7WmbEU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1778594132; x=1778853332;
	bh=LeXgjKzkNMDeBopPQNfwTQzIIVjtMI+vtYIQNjQTAik=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Jd7WmbEUFTq/LzB5l9+t3kyztP2gdvUHz51SIZGm3lcxKFmPL0hRk2J0HGyC1bXf0
	 tOPn51ILtDwmgvkazusbJ9t6HpF7P/FXF229xOA0ZU+Jcsc1LPp4ITaoNaR+X4Agoc
	 y5JmO3T7QM9gQZVm0+AIpEJlBYHHbPYLokJvnFcqIt1WaJJu18Jn3n3ltBpL04hRRC
	 BUUf9xSiQRU8xg4YQd6eCjhq/36k5u+J//5u14rS3zG2CFWweyKDsPkkKAAbmcsIRf
	 TkkV/oc05YWPQ6iWAbm+jOx2OOQ2F2Lp1hGL/mxMOqf+met+oLr541Fd+/CG/lprYb
	 r4K7x/DPYMASg==
Date: Tue, 12 May 2026 13:55:26 +0000
To: Jonathan Cameron <jic23@kernel.org>
From: Roman Vivchar <rva333@protonmail.com>
Cc: David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH v2 01/16] dt-bindings: iio: adc: mt6359: generalize description for mt63xx series
Message-ID: <wTd36596tJhd0sPk-1MSi79xz14IBgTKXpD25tnKuRXLfGywkoenZ-wIDtOvRxEZL8xpqijZ0nxMsCFTOJgJq__y26VzCpe_9f0JQGWrJVo=@protonmail.com>
In-Reply-To: <20260512141313.425535d9@jic23-huawei>
References: <20260512-mt6323-v2-0-3efcba579e88@protonmail.com> <20260512-mt6323-v2-1-3efcba579e88@protonmail.com> <20260512141313.425535d9@jic23-huawei>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: ff83f57ffc4d622d3c6e2bc332a83f392b3034e1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, May 12th, 2026 at 4:13 PM, Jonathan Cameron <jic23@kernel.org> =
wrote:

> On Tue, 12 May 2026 08:18:15 +0300
> Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org> wro=
te:
>=20
> > From: Roman Vivchar <rva333@protonmail.com>
> >
> > Update binding title to the MT63xx, since the list of compatibles alrea=
dy
> > includes mt6363 and mt6373 which don't belong to the mt6350 family.
> Hi Roman,
>=20
> Wild cards have a nasty habit of going wrong.  I'd prefer to see
> language like: MT6359 and similar PMIC AUXADC

Hi Jonathan,

I agree that it would be better to specify the exact PMIC models, however
'similar' wording might be a bit misleading here. As far as I know,
the mt6363 and mt6373 use SPMI, while mt635x (and older models, like
most of the mt63xx series) use PWRAP (a custom SPI-based protocol).
The mt6323 has an older AUXADC revision which is not compatible
with the mt635x driver.

Would you prefer more explicit list like 'MT6323, MT6350 series, MT6363
and MT6373 PMIC AUXADC'? It's a bit mess because some mt63xx
(like mt6333) are sub-PMICs and use I2C instead of PWRAP.

> It is less important here than in many other places because the
> file has an explicit list soon after this, but none the less
> we've been bitten by this too often to think manufacturers won't
> throw a completely non compatible part in the middle of a wild
> card covered range.
>=20

Best regards,
Roman
