Received: from mail-24427.protonmail.ch (mail-24427.protonmail.ch [109.224.244.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65633469E0;
	Wed,  6 May 2026 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778066552; cv=none; b=fyzsgoY9kudniWjKgHlXyeBX0hdHc5CpGD/jEsuynhchkG0TYNr4hKpg1vP4/q+ioxlITS2UMl7mQbvce/qRoiq/myKZUMhH45P5aVXvSqY1sb4mrj+qPUtipoiSrswbYLKt0Vo7YjdgJHEh2ACqRncAhiqjA8COqXzo9062cn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778066552; c=relaxed/simple;
	bh=QorpeboRxewf1UhnTNiYDcjq+TKrFB5HabAak7g3gQg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UGu9T4wBiH19HYOWP3XBZOKI1SAmIxS5OAdZjoJLaq+vm0I3Gs8CrkgcHUswpjDfnrC+uhcq/Ukl9/XgB1Pbq334YcJ/uHlkk7i7NIq1xentU/0g9S3It0xRrHuiP2Wv39oGfNCb3EfYnbRcP5WpkYCnbVKlBYismOtw4HWprFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=IzHhikTW; arc=none smtp.client-ip=109.224.244.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="IzHhikTW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1778066543; x=1778325743;
	bh=kZtsny8NCeAj/GASj1HlxIQBODAnth4j1tzCDBSh6zU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IzHhikTWfQDBTr23vgWJSTLdr5y+9NN/h3i887KjjWpZeA8mc76VXZO9vWyMfmZ7l
	 2FOHhTPlaj2aO7kjZzeawb9JjNYBxFDZuRcUBRs6K3QBAa3KxglgXHuebKrk6kUD8M
	 +b6wNyHjiKSymVqdw7bvKrYvhVBPL+LgY/dV70GM5V9iudGYIT4ZNZRiBl3xmPC8Na
	 hwRZFyTleFHpHYy/Dpe6r6LW6lUfuZOrOL9FWH2MmAbcw5rLOjiK7iku80jqGB2uI/
	 72Fg+8g97SEdOW7U8vN00SxmJsnrxc1IGhgH4xErpL7I/CR/2A+akispojEbDHR4I2
	 ZP9QdjW0dQo1w==
Date: Wed, 06 May 2026 11:22:15 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>
From: Roman Vivchar <rva333@protonmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Srinivas Kandagatla <srini@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH 06/13] thermal: mediatek: add pmic thermal support
Message-ID: <cgsML96DsJh_Ow9XsSnyrZ3NhlCnNj1rKegzYNR3eQzkWoF5xQB5-aU6Zi7pKcT8GfUnO3B-D71je60APUtorB7p_A3GtUCp2oer3KYLn6k=@protonmail.com>
In-Reply-To: <afmnUG8dG0N0HpV6@ashevche-desk.local>
References: <20260504-mt6323-v1-0-799b58b355ff@protonmail.com> <20260504-mt6323-v1-6-799b58b355ff@protonmail.com> <afmnUG8dG0N0HpV6@ashevche-desk.local>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: b57442d521fe1c3d5c9f5812d1b7a6c448998847
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, May 5th, 2026 at 11:16 AM, Andy Shevchenko <andriy.shevchenko@i=
ntel.com> wrote:

> On Mon, May 04, 2026 at 09:24:58PM +0300, Roman Vivchar via B4 Relay wrot=
e:

...

> > +struct mtk_pmic_sensor {
> > +=09struct mtk_pmic_thermal *mt;
> > +=09int id;
> > +=09struct iio_channel *adc_channel;
> > +=09struct thermal_zone_device *tzdev;
> > +};
>=20
> Can you confirm with `pahole` that this is the best layout (taking into a=
ccount
> the use in the below data structure)?
>=20
> > +struct mtk_pmic_thermal {
> > +=09struct device *dev;
> > +=09struct regmap *regmap;
> > +=09struct mtk_pmic_sensor sensors[MAX_SENSORS];
> > +
> > +=09s32 t_slope1;
> > +=09s32 t_slope2;
> > +=09s32 t_intercept;
> > +
> > +=09const struct mtk_thermal_data *data;
> > +};
>=20

On the ARMv7 it shouldn't be an issue, because pointer size equals to
the s32 or int. However, I've reordered the fields to group pointers
and integers together.

struct mtk_pmic_sensor {
=09struct mtk_pmic_thermal *  mt;                   /*     0     4 */
=09struct iio_channel *       adc_channel;          /*     4     4 */
=09struct thermal_zone_device * tzdev;              /*     8     4 */
=09int                        id;                   /*    12     4 */

=09/* size: 16, cachelines: 1, members: 4 */
=09/* last cacheline: 16 bytes */
};

struct mtk_pmic_thermal {
=09struct device *            dev;                  /*     0     4 */
=09struct regmap *            regmap;               /*     4     4 */
=09const struct mtk_thermal_data  * data;           /*     8     4 */
=09s32                        t_slope1;             /*    12     4 */
=09s32                        t_slope2;             /*    16     4 */
=09s32                        t_intercept;          /*    20     4 */
=09struct mtk_pmic_sensor     sensors[1];           /*    24    16 */

=09/* size: 40, cachelines: 1, members: 7 */
=09/* last cacheline: 40 bytes */
};

The compiler will still add some padding on the AArch64 though.

struct mtk_pmic_sensor {
=09struct mtk_pmic_thermal *  mt;                   /*     0     8 */
=09struct iio_channel *       adc_channel;          /*     8     8 */
=09struct thermal_zone_device * tzdev;              /*    16     8 */
=09int                        id;                   /*    24     4 */

=09/* size: 32, cachelines: 1, members: 4 */
=09/* padding: 4 */
=09/* last cacheline: 32 bytes */
};

struct mtk_pmic_thermal {
=09struct device *            dev;                  /*     0     8 */
=09struct regmap *            regmap;               /*     8     8 */
=09const struct mtk_thermal_data  * data;           /*    16     8 */
=09s32                        t_slope1;             /*    24     4 */
=09s32                        t_slope2;             /*    28     4 */
=09s32                        t_intercept;          /*    32     4 */

=09/* XXX 4 bytes hole, try to pack */

=09struct mtk_pmic_sensor     sensors[1];           /*    40    32 */

=09/* size: 72, cachelines: 2, members: 7 */
=09/* sum members: 68, holes: 1, sum holes: 4 */
=09/* last cacheline: 8 bytes */
};

Is this good enough?

Other comments will be fixed in the v2.

Best regards,
Roman
