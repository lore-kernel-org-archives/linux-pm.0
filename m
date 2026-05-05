Received: from mail-24426.protonmail.ch (mail-24426.protonmail.ch [109.224.244.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D79D48B388
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777998298; cv=none; b=MQ0yV6jHPvqdf0dzGWXnnZ17FkFXJ3L3iRZ3z3KsAcfnCDsv3asjqBh+r3+qpixJ5hp9+0jdLfgvZCeWk4ZToK0rZhoPbh4GWeY2lCnVrSDN5OMhNAbg7U6CLZnXjyLQakyrqFVQFmlN6dKgsmqTbzXEBz1PVtJmRjoh6bbnKoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777998298; c=relaxed/simple;
	bh=zNiWv6rRMr8VglHjj6vRucPyNjtedqguSDscHAx+XdI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=luEpCdg32rCvNyqLhfSDPbugRL4PjyeZVSW9XKrz3/5G9ufj+RmaOefdTpwOnH5i+4MUYMOO/UFZRvA37sAjcGahWCLJuRPkJwotFqCwsFTHmCgJZDty+VA+Jb4A/gfyFKiou/IgjZsXtLPuw/7U7W56pgmghLPMEH7jgOodn9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=M+F3yhx7; arc=none smtp.client-ip=109.224.244.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="M+F3yhx7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1777998287; x=1778257487;
	bh=ASWqzKjXrD7GPPPq7eqcATqg6A70mPRmdB4ZyDBwEK0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=M+F3yhx7dJ2rhFSJAZcFeXyevkNolOGRHAyGx9L5V9zEwV48mNW0/j1DxaK2EZV3A
	 sOI77K5RJdv6vOQ4iT0XOz7d7KLFmOkC+jHajqCLIfMwCKTNmoZk26ZlwEiaoyoM9j
	 b0Jm6p/Ff5EtNIHmXiEyFH/VfiVWcUCBVrOwkIFsGzbQoFISKrRmmTf1YBwE6BKG50
	 jEC/Wpla8r4KX6aKV8Ln+iyPz5DRcWZf6WmD+D+yqDdYEw+FuY37PxcYMtVcMYDeHg
	 ZFaIG7dN5yXP2FY+Ojke22qfg31drHoBz2zpt6/kca1w+FzeqPMI0bs85GKPo37cug
	 sJC/bk/aU+nQA==
Date: Tue, 05 May 2026 16:24:41 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>
From: Roman Vivchar <rva333@protonmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Srinivas Kandagatla <srini@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH 05/13] nvmem: add mt6323 PMIC EFUSE driver
Message-ID: <Bn1O24yJ2aBvKUTpiFUzxnqbuuybRirR73G7R38ghYtwhFvQqWJb3HPgcikEa1otDw6n07nX_g8khZUHXJ_QRA--LrV5yj5Mcg1QzrWt6vA=@protonmail.com>
In-Reply-To: <afmjfWtt7Vii6xfH@ashevche-desk.local>
References: <20260504-mt6323-v1-0-799b58b355ff@protonmail.com> <20260504-mt6323-v1-5-799b58b355ff@protonmail.com> <afmjfWtt7Vii6xfH@ashevche-desk.local>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: 70e68a78b3333f71307d661d5a8c93410d5d2dc7
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, May 5th, 2026 at 11:00 AM, Andy Shevchenko <andriy.shevchenko@i=
ntel.com> wrote:

> On Mon, May 04, 2026 at 09:24:57PM +0300, Roman Vivchar via B4 Relay wrot=
e:
>=20
> > Add support for the EFUSE controller found in the Mediatek MT6323 PMIC.
> > The MT6323 EFUSE stores 24 bytes of hardware-related data, such as
> > thermal sensor calibration values.
>=20
> Besides below comments, check for the similar issues that previous patche=
s in
> the series have.
>=20
> ...
>=20
> > +#include <linux/device.h>
>=20
> Not needed as platform_device.h implies this ("is this good or bad?" is a
> different story).
>=20
> > +#include <linux/io.h>
> > +#include <linux/mfd/mt6323/registers.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/nvmem-provider.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/property.h>
> > +#include <linux/regmap.h>
>=20
> Follow IWYU. At least missing types.h.
>=20
> ...
>=20
> > +struct mt6323_efuse {
> > +=09struct regmap *regmap;
> > +};
>=20
> Do you really need a custom wrapper data structure? Can't regmap be used
> directly?
>=20
> ...
>=20
> > +static int mt6323_efuse_read(void *context, unsigned int offset, void =
*val,
> > +=09=09=09     size_t bytes)
> > +{
> > +=09struct mt6323_efuse *efuse =3D context;
> > +=09u32 tmp;
>=20
> > +=09u16 *buf =3D val;
>=20
> Really? CPU order all the time?
>=20
> > +=09int i, ret;
>=20
> Why is 'i' signed?
>=20
> > +=09for (i =3D 0; i < bytes; i +=3D 2) {
>=20
> sizeof()?
>=20
> And since 'i' is used only inside the loop
>=20
> =09for (size_t i =3D 0; i < bytes; i +=3D sizeof(*buf)) {
>=20
> > +=09=09ret =3D regmap_read(efuse->regmap,
> > +=09=09=09=09  MT6323_EFUSE_DOUT_BASE + offset + i, &tmp);
> > +=09=09if (ret)
> > +=09=09=09return ret;
> > +=09=09buf[i / 2] =3D tmp;
> > +=09}
>=20
> + blank line.
>=20
> Isn't this reimplementation of bulk read? Why the latter may not be used?

Yes, but the PWRAP (the regmap which the driver uses) doesn't support read
callback, only reg_read is implemented in the driver.
It hits the map->cache_type =3D=3D REGCACHE_NONE in the regmap_read_raw, an=
d falls
for the !map->read check, so regmap_bulk_read neither the regmap_read_raw
can be used.

Technically the PMIC is not continuous address space, but rather non-MMIO F=
SM,
so it makes sense to not implement the read callback. I guess the custom
implementation is fine then?

All other suggestions will be applied for v2.

>=20
> > +=09return 0;
> > +}
>=20
> ...
>=20
> > +static const struct of_device_id mt6323_efuse_of_match[] =3D {
> > +=09{ .compatible =3D "mediatek,mt6323-efuse" },
> > +=09{ /* sentinel */ },
>=20
> Having trailing comma in the terminator is nonsense. Do we expect anythin=
g
> behind it?
>=20
> > +};
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20
>=20
>

Best regards,
Roman
