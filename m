Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6863B37DADE;
	Tue, 12 May 2026 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592820; cv=none; b=W8E2p+LdiSdnNwgPlIGJfRPxt+4GidGh3/CTUKXmq9zAV83W3JkRe7Yo+55xPI9/7yIeYIzMGJtjFDrl81S4QQLseXJuwArx6FSLX5+d4r8UWvPztMa49iK3N6YDTaEyhYRpKLMc4kpJ/DBkPoU/3WARWxQwh+MbOJ2zKCaJoo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592820; c=relaxed/simple;
	bh=tCoTCTQ9QeY5v2rxtk4mFU/0h6WzNAdCNvFNNbGqxyU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j31Bs9zf9a0hc6M9bLlRctA4Y9R2+YFVM9kmz9j7Znko+iPxZ+CkaQLXoNvOoP+OpIyrw+57wOlwkzNY2WPucUMjW8XWHGN2hPxPGwXNjaf5l3xO2g0Wzw+Tw+rjXPcNZP5O25AcakZrtDeE6tFGGn6lV+zoKrvUgkg4OhRXQ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4+lqBpE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4+lqBpE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2CAC2BCB0;
	Tue, 12 May 2026 13:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778592820;
	bh=tCoTCTQ9QeY5v2rxtk4mFU/0h6WzNAdCNvFNNbGqxyU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A4+lqBpE04t1qca+VdtmT3sCUPPAsltMG2GlPngcd3brhJvA31inKG15xDUX48nwr
	 YECrTaYY8Soa0fxK7VLLJmMFWqb2r0eW/LGDKyuPLqLPF7IWPGVxh1RLb4Vhaku9IQ
	 L8+zPjWZGQXSbMn9mLaZVrwoLuWdmtRdRYoVkED4IeMwQ6N2W/koIvTs0lzOuT5Xw7
	 4TBPh6j6E+zDk1S6kVDMzouf9PoRBBMTpqlwItGk/wGi4rhBlk329exqLHlfxI9EIH
	 Mdqf4sAbLNMx3AAcpu1hMx/mHuMTy8MGJkIx/xno8IXGEPf00pBamGV05o2NqYQyxK
	 dpOWLojURsZbw==
Date: Tue, 12 May 2026 14:33:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Roman Vivchar <rva333@protonmail.com>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
 <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org, Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH v2 07/16] thermal: mediatek: add PMIC thermal support
Message-ID: <20260512143325.026b6341@jic23-huawei>
In-Reply-To: <agMI2phk0AQF6QP9@ashevche-desk.local>
References: <20260512-mt6323-v2-0-3efcba579e88@protonmail.com>
	<20260512-mt6323-v2-7-3efcba579e88@protonmail.com>
	<CAHp75VfgrbEDLavMKFp2maFCH08RBUxF2wYhh56GG1HCq4ogmA@mail.gmail.com>
	<j2uhavC9edilBoD6VJnlz8cCmMPhE9rQavh1epqLk61zrlZ3k1rqlyj8fVYWnkddIY1fEfPk1DfcW09i39hd-Q7I9Y8Vxd0w8C2eCjVGLc4=@protonmail.com>
	<agMI2phk0AQF6QP9@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 12 May 2026 14:02:50 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, May 12, 2026 at 08:55:44AM +0000, Roman Vivchar wrote:
> > On Tuesday, May 12th, 2026 at 10:05 AM, Andy Shevchenko <andy.shevchenk=
o@gmail.com> wrote: =20
> > > On Tue, May 12, 2026 at 8:21=E2=80=AFAM Roman Vivchar via B4 Relay
> > > <devnull+rva333.protonmail.com@kernel.org> wrote: =20
>=20
> ...
>=20
> > > > +#include <linux/kernel.h> =20
> > >
> > > No way the driver(s) nowadays use this header. Please, drop it and add
> > > the ones that are really in use (there are missing ones). =20
> >=20
> > Is there a tool or script that can check for IWYU? =20
>=20
> The `iwyu` tool with customised configuration is the closest what we have
> (but quite far from ideal), you can read this thread [2].

For what it is worth the various AI tools don't do badly if you ask
them and Sasiko often comments on this now (running on all of linux-iio)
This series is pending though - might be done tomorrow:
https://sashiko.dev/#/patchset/20260512-mt6323-v2-0-3efcba579e88%40protonma=
il.com

>=20
> > For example,
> > the u32 and s32 types are defined in the asm-generic/int-ll64.h, which
> > is not used by any device driver. Instead, types.h should be used.
> > It's difficult to guess which header to use for a given type/function. =
=20
>=20
> I know. I got this knowledge because:
> - I do a lot of reviews and patches and gathered it from the experience
> - I am the one who reshuffled *some* of the headers
>=20
> > I've tried include-what-you-use [1], but it gives bad results like
> > "add #include <asm-generic/int-ll64.h> // for u32". =20
>=20
> See above.
>=20
> > > > +#include <linux/module.h>
> > > > +#include <linux/nvmem-consumer.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/property.h>
> > > > +#include <linux/regmap.h> =20
> > > =20
> > > > +#include <linux/slab.h> =20
> > >
> > > Is it used? =20
> >=20
> > Yes, without slab.h the __free would complain about missing __free_kfre=
e,
> > which is DEFINE_FREE(kfree, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T))=
. =20
>=20
> Ah, indeed. I forgot that this is not the part of cleanup.h.
>=20
> ...
>=20
> > 1: https://github.com/include-what-you-use/include-what-you-use =20
> [2]: https://lore.kernel.org/all/20260512073505.1310-1-joshua.crofts1@gma=
il.com/
>=20

