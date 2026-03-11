Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DB83C1412;
	Wed, 11 Mar 2026 08:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773219191; cv=pass; b=lkOSLVvCbkgrnjWLrVj/OzXO1k/8X9zMmTJMvixr3jcW6R3k3do5iahpfIRgmvM0mpZBQfOLTvFcWQZYICzFhcUpfx5dixmPVOyVdcSdQQ/skm08fvZeyls1xDcEkD1pPmVlC+HfksLWrcdvFIsplLObp6MRHgONham3wWDaqcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773219191; c=relaxed/simple;
	bh=PDgo+D272zISHNjuyBYbcxfvB5jHMRggnQzNt4V8Mf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqp1un6dvS7GuXi5Ifljbk1YRup5/N0nQxstoBsLy5fZnDp7lYJSGTG7L5cqbGH3ONlVaylVeBahkm8IUyzYbCl0xXbiEmQJYOwNvXTAcIg4v0+o6Z5cG7myxr3CBJZFU9R4M93GSD/vA11WmQYP76I1rLmIDo4nhGjONmLDGCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=PNi3utUE; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="PNi3utUE"
ARC-Seal: i=1; a=rsa-sha256; t=1773219178; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=n8BhVQQSwXNyHLAgZPel+0zQ97F5zndubEciYQWZt4jULw2TGUUntRWr915xir4TRzrj4PbftL5nBksUGSJ3q/FLEc1u9HTIjA0C3fJMYHVsmqTGLAAP6QMJDcs50CrtRsdtL7XDYSGDLp2q+ZlLNdTozQkjWIA4nWjtMyPA7qA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773219178; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TISMxi5550xm/R43KixZOtkNQOnj1hmuaRGypHDqkU4=; 
	b=f2KkMmNkVM3BlMrkjn5cXE7mOLTInfiGWtTRxAON2ae/3uTI5FWwAHIZWGcVkx65clNhyttfLwGIE5CFzHH+eABYwVWrzl1WotIk8B3nzuGBQwKI2E5SUjaB+ta9dN3M+UxDWx+5CFrnOF4WIYs/3ygDVUjQSpBMEqGPUvyMxDM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773219178;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=TISMxi5550xm/R43KixZOtkNQOnj1hmuaRGypHDqkU4=;
	b=PNi3utUEJNfqgkTleSQ86+jI4h5HL37wiGQP8gch2ZAwJEq2dDpbGTWokYh9kKsO
	oAcIDBcaBLxsmWf9/4qpFFOATuLH84Y5PPyauLz1qbvCejqjBt5k1R9ncm7vOvtGiel
	Fw/nwvFoOe4/YTvqw85e/tYlW5PLU0DOMjcyYNPA=
Received: by mx.zohomail.com with SMTPS id 1773219175080121.91265362976719;
	Wed, 11 Mar 2026 01:52:55 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id B88AC180598; Wed, 11 Mar 2026 09:52:42 +0100 (CET)
Date: Wed, 11 Mar 2026 09:52:42 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 11/11] power: supply: bq257xx: Add support for BQ25792
Message-ID: <abEpAs5O1a3HqFTJ@venus>
References: <20260310-bq25792-v3-0-02f8e232d63b@flipper.net>
 <20260310-bq25792-v3-11-02f8e232d63b@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bypi6vmkhx5pxro7"
Content-Disposition: inline
In-Reply-To: <20260310-bq25792-v3-11-02f8e232d63b@flipper.net>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.1.1.4.3/273.195.15
X-ZohoMailClient: External


--bypi6vmkhx5pxro7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 11/11] power: supply: bq257xx: Add support for BQ25792
MIME-Version: 1.0

Hello Alexey,

On Tue, Mar 10, 2026 at 01:28:35PM +0400, Alexey Charkov wrote:
> Add support for TI BQ25792 integrated battery charger and buck-boost
> converter.
>=20
> It shares high-level logic of operation with the already supported
> BQ25703A, but has a different register map, bit definitions and some of
> the lower-level hardware states.
>=20
> Tested-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>  drivers/power/supply/bq257xx_charger.c | 492 +++++++++++++++++++++++++++=
+++++-
>  include/linux/mfd/bq257xx.h            |   6 +-
>  2 files changed, 493 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/suppl=
y/bq257xx_charger.c
> index 951abd035fc5..0bbb0a8b5f55 100644
> --- a/drivers/power/supply/bq257xx_charger.c
> +++ b/drivers/power/supply/bq257xx_charger.c
> @@ -5,6 +5,7 @@
>   */
> =20
>  #include <linux/bitfield.h>
> +#include <linux/byteorder/generic.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/mfd/bq257xx.h>
> @@ -18,12 +19,19 @@ struct bq257xx_chg;
> =20
>  /**
>   * struct bq257xx_chip_info - chip specific routines
> + * @default_iindpm_uA: default input current limit in microamps
>   * @bq257xx_hw_init: init function for hw
>   * @bq257xx_hw_shutdown: shutdown function for hw
>   * @bq257xx_get_state: get and update state of hardware
> + * @bq257xx_get_ichg: get maximum charge current (in uA)
>   * @bq257xx_set_ichg: set maximum charge current (in uA)
> + * @bq257xx_get_vbatreg: get maximum charge voltage (in uV)
>   * @bq257xx_set_vbatreg: set maximum charge voltage (in uV)
> + * @bq257xx_get_iindpm: get maximum input current (in uA)
>   * @bq257xx_set_iindpm: set maximum input current (in uA)
> + * @bq257xx_get_cur: get battery current from ADC (in uA)
> + * @bq257xx_get_vbat: get battery voltage from ADC (in uV)
> + * @bq257xx_get_min_vsys: get minimum system voltage (in uV)
>   */
>  struct bq257xx_chip_info {
>  	int default_iindpm_uA;
> @@ -47,8 +55,10 @@ struct bq257xx_chip_info {
>   * @bq: parent MFD device
>   * @charger: power supply device
>   * @online: charger input is present
> + * @charging: charger is actively charging the battery
>   * @fast_charge: charger is in fast charge mode
>   * @pre_charge: charger is in pre-charge mode
> + * @overvoltage: overvoltage fault detected
>   * @ov_fault: charger reports over voltage fault
>   * @batoc_fault: charger reports battery over current fault
>   * @oc_fault: charger reports over current fault
> @@ -79,6 +89,53 @@ struct bq257xx_chg {
>  	u32 vsys_min;
>  };

The above belong into the previous patches that actually added the
fields to the structs :)

> +/**
> + * bq25792_read16() - Read a 16-bit value from device register
> + * @pdata: driver platform data
> + * @reg: register address to read from
> + * @val: pointer to store the register value
> + *
> + * Read a 16-bit big-endian value from the BQ25792 device via regmap
> + * and convert to CPU byte order.
> + *
> + * Return: Returns 0 on success or error on failure to read.
> + */
> +static int bq25792_read16(struct bq257xx_chg *pdata, unsigned int reg, u=
16 *val)
> +{
> +	__be16 regval;
> +	int ret;
> +
> +	ret =3D regmap_raw_read(pdata->bq->regmap, reg, &regval, sizeof(regval)=
);
> +	if (ret)
> +		return ret;
> +
> +	*val =3D be16_to_cpu(regval);
> +	return 0;
> +}
> +
> +/**
> + * bq25792_write16() - Write a 16-bit value to device register
> + * @pdata: driver platform data
> + * @reg: register address to write to
> + * @val: 16-bit value to write in CPU byte order
> + *
> + * Convert the value to big-endian and write a 16-bit value to the
> + * BQ25792 device via regmap.
> + *
> + * Return: Returns 0 on success or error on failure to write.
> + */
> +static int bq25792_write16(struct bq257xx_chg *pdata, unsigned int reg, =
u16 val)
> +{
> +	__be16 regval =3D cpu_to_be16(val);
> +	int ret;
> +
> +	ret =3D regmap_raw_write(pdata->bq->regmap, reg, &regval, sizeof(regval=
));
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

Are there big _and_ little endian registers on the bq25792? Otherwise I
would expect this to be done by properly configuring regmap.

> [...]

The remaining part looks fine.

Greetings,

-- Sebastian

--bypi6vmkhx5pxro7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmmxLVYACgkQ2O7X88g7
+poLoBAAqeSDKtvgAr4fXoOWhkiLXT3b+x3VL0buVVUaxkY0YLQHXW0WMMO3hrvZ
qN0hOlVGNIZ44iVmVl7OVFUxkybDkSXVfnvqWulKP7FzWAl9WYZki2uQjgYxr4Cw
bO1hPolJEEavIsriqqLSyuuyK7namT3VZ0eli64xopwVpGZxaKJCqKuDSoiH4uAJ
4JMt+nt+jOzdfTxUYGQ4GV7r2JoJYyHGfpy91b4YJIkOz5ijpcxWarv/R+Skuwiw
dmJ0I1cbUJQKbtrBZqcz5fAWdva9aQXM+3f5lHVhc8kYvc3UYMTD207By0ipDsBw
B8XUOx2IW+iJq+jJPoRox3ShutXbNeE4SZq54iEbFMDK6+VY55z+HgnwiYowT1bs
YdSsWzU0j09w9hZASrVCzluoLN9ts0tsH9jMJYKN3QnqxnGwy44hZrGtrXPm5pVE
ovq7y3WbLfkHmTIChorI59e1BsXTgAg4y3JuDVOznzWRJ/Nmx6y+zuZeYsvIPzy2
kJeto7lsQXr8yHWNUCArn0vvd/L7YOiFIacPZB1qilnF2oIEnux7R4q28zvOCIwj
+F3p0N/k8Dbsz1BquJTXTBmMg583Bb9oxZ0KmtKGMYHS4RvqGwZvcT+nW58kgNrO
HfSQBbgHsUH5gogR1iTka5DDO1zEAcG/HBQy9/CrP8kNeWcoWV4=
=/YrQ
-----END PGP SIGNATURE-----

--bypi6vmkhx5pxro7--
