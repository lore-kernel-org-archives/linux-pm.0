Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C04F38C2A6;
	Wed, 11 Mar 2026 07:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773212963; cv=pass; b=dt3DbzwRNT0OHFtzSTt4R46XVVR8OSI3P7/4+zmQ7sFvLIEYYmzL8ScNXbINtvhZqctXJyoo6EA9bM6WTDEsZ65guFw398Tg+DedJpSMb0mn3k7foT9ciPd1qliFGrq4L8xj1bZ2zlSDT4mFy9+9srIsm1p0Phr8CDoVq0xFnFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773212963; c=relaxed/simple;
	bh=RnXJAuUF4/LvGI6W1z8I2/JIwm3Vk1KfgHXHt8kH18c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSY4NPu668cVGuaJa6pL8t0LuqNb4YO/vsxA1EnXCpVXs2V0JEixPQiGvC1DkC3Zdl+mcCvcUkQ3FumNyD4X5cEWPFQxuyS0Bmk8zrocct9iOq+jTPbCdRbpobXVpsU/i1AFtCBP8rSPay+ZL+wEFj4jN4sfvGbF8b5YE3BLJxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=M0mgbB2f; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="M0mgbB2f"
ARC-Seal: i=1; a=rsa-sha256; t=1773212956; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=e5DbFlaVzsq9s0W3F4lyUF24XXOP2mHwkSgAGsNYVD1WSWgE8+IGzlg1rws3nHQMzCtbGcCkfcedcpRE9g2e7kcoXJZILuaDBj7YKFZmpXdZIwLdkaorpgJXheivajEeoOlD/ZnxZrGgvQjWNBmyYCNO7T0pwLu7q4Aw7i5wUw0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773212956; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+e0GijLckAotr2CGPd3QnmgrD+9ToWLfHOEU+XG8ekI=; 
	b=ajwgiJkAyYYE48AZuCvfmkU4DJn94R+/PwT0GFf8rGde+1RxqOVXH6pK16QUzV8lTVznFqZox/DV6zqCzliCdhQOHOVdkX/tln/nUs8zUNXxWvoSJPpHJFyxNl3PF8A4xfIWH1pPajJMcK4ryehNCxyQGTuhjFoIQ9Ixgc4APJE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773212956;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=+e0GijLckAotr2CGPd3QnmgrD+9ToWLfHOEU+XG8ekI=;
	b=M0mgbB2fxBeBqirMH064DgxaVUEDdtYBa538rO5oOODiHdKBXgpDjCFpbnd5z49k
	B43DXZyJzAhvCFAUvuARSXcGSLm3+jSsCmzVdvqzPEu5JOKVxeoAhPhYKHctftuowE1
	ZYx08N8RGl1wMCwzuF1+XP/huiNwFcY57a9Vv7Ac=
Received: by mx.zohomail.com with SMTPS id 1773212954718247.6150068024565;
	Wed, 11 Mar 2026 00:09:14 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 552CE180598; Wed, 11 Mar 2026 08:09:04 +0100 (CET)
Date: Wed, 11 Mar 2026 08:09:04 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 07/11] power: supply: bq257xx: Consistently use
 indirect get/set helpers
Message-ID: <abEVAER9eXX2EAL9@venus>
References: <20260310-bq25792-v3-0-02f8e232d63b@flipper.net>
 <20260310-bq25792-v3-7-02f8e232d63b@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ilrlyr22m6ij6ssn"
Content-Disposition: inline
In-Reply-To: <20260310-bq25792-v3-7-02f8e232d63b@flipper.net>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.1.1.4.3/273.195.15
X-ZohoMailClient: External


--ilrlyr22m6ij6ssn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 07/11] power: supply: bq257xx: Consistently use
 indirect get/set helpers
MIME-Version: 1.0

Hi,

On Tue, Mar 10, 2026 at 01:28:31PM +0400, Alexey Charkov wrote:
> Move the remaining get/set helper functions to indirect calls via the
> per-chip bq257xx_chip_info struct.
>=20
> This improves the consistency of the code and prepares the driver to
> support multiple chip variants with different register layouts and bit
> definitions.
>=20
> Tested-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/bq257xx_charger.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/suppl=
y/bq257xx_charger.c
> index e14dd16f9d08..deb60a9bd222 100644
> --- a/drivers/power/supply/bq257xx_charger.c
> +++ b/drivers/power/supply/bq257xx_charger.c
> @@ -30,9 +30,15 @@ struct bq257xx_chip_info {
>  	int (*bq257xx_hw_init)(struct bq257xx_chg *pdata);
>  	void (*bq257xx_hw_shutdown)(struct bq257xx_chg *pdata);
>  	int (*bq257xx_get_state)(struct bq257xx_chg *pdata);
> +	int (*bq257xx_get_ichg)(struct bq257xx_chg *pdata, int *intval);
>  	int (*bq257xx_set_ichg)(struct bq257xx_chg *pdata, int ichg);
> +	int (*bq257xx_get_vbatreg)(struct bq257xx_chg *pdata, int *intval);
>  	int (*bq257xx_set_vbatreg)(struct bq257xx_chg *pdata, int vbatreg);
> +	int (*bq257xx_get_iindpm)(struct bq257xx_chg *pdata, int *intval);
>  	int (*bq257xx_set_iindpm)(struct bq257xx_chg *pdata, int iindpm);
> +	int (*bq257xx_get_cur)(struct bq257xx_chg *pdata, int *intval);
> +	int (*bq257xx_get_vbat)(struct bq257xx_chg *pdata, int *intval);
> +	int (*bq257xx_get_min_vsys)(struct bq257xx_chg *pdata, int *intval);
>  };
> =20
>  /**
> @@ -489,22 +495,22 @@ static int bq257xx_get_charger_property(struct powe=
r_supply *psy,
>  		break;
> =20
>  	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> -		return bq25703_get_iindpm(pdata, &val->intval);
> +		return pdata->chip->bq257xx_get_iindpm(pdata, &val->intval);
> =20
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> -		return bq25703_get_chrg_volt(pdata, &val->intval);
> +		return pdata->chip->bq257xx_get_vbatreg(pdata, &val->intval);
> =20
>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
> -		return bq25703_get_cur(pdata, &val->intval);
> +		return pdata->chip->bq257xx_get_cur(pdata, &val->intval);
> =20
>  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> -		return bq25703_get_vbat(pdata, &val->intval);
> +		return pdata->chip->bq257xx_get_vbat(pdata, &val->intval);
> =20
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> -		return bq25703_get_ichg_cur(pdata, &val->intval);
> +		return pdata->chip->bq257xx_get_ichg(pdata, &val->intval);
> =20
>  	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> -		return bq25703_get_min_vsys(pdata, &val->intval);
> +		return pdata->chip->bq257xx_get_min_vsys(pdata, &val->intval);
> =20
>  	case POWER_SUPPLY_PROP_USB_TYPE:
>  		val->intval =3D pdata->usb_type;
> @@ -632,9 +638,15 @@ static const struct bq257xx_chip_info bq25703_chip_i=
nfo =3D {
>  		.bq257xx_hw_init =3D &bq25703_hw_init,
>  		.bq257xx_hw_shutdown =3D &bq25703_hw_shutdown,
>  		.bq257xx_get_state =3D &bq25703_get_state,
> +		.bq257xx_get_ichg =3D &bq25703_get_ichg_cur,
>  		.bq257xx_set_ichg =3D &bq25703_set_ichg_cur,
> +		.bq257xx_get_vbatreg =3D &bq25703_get_chrg_volt,
>  		.bq257xx_set_vbatreg =3D &bq25703_set_chrg_volt,
> +		.bq257xx_get_iindpm =3D &bq25703_get_iindpm,
>  		.bq257xx_set_iindpm =3D &bq25703_set_iindpm,
> +		.bq257xx_get_cur =3D &bq25703_get_cur,
> +		.bq257xx_get_vbat =3D &bq25703_get_vbat,
> +		.bq257xx_get_min_vsys =3D &bq25703_get_min_vsys,
>  };
> =20
>  /**
>=20
> --=20
> 2.52.0
>=20

--ilrlyr22m6ij6ssn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmmxFQ8ACgkQ2O7X88g7
+prahA//YXUP1FjZ+rLHcBl4I1f2jem/19PJz9Pr9BC+SUoSVZWMZWEcJDuWUN3q
oDACwy2QMlwjNTkVcmH19cqBtMmW1SjAMHSRKJyAXIguLtRN1yyZBg8sfZY9jePu
Zslz/rw5VzBxacT74ONBh5Gnl4WbM5iGQg+Xv/W+Hi6AvVaVPAnuuX0UdFZrxiM5
m+n0G2YSR1VVa9r81A2Wd4YbHVsHNHoNfyomLBx7C5IqzRAfJkn9j9Yqb6E9lhyX
IfKYh5KlGKfqqV8CFX/+Mw/pwHO1olvm/WhLmA7thDw5rZn3VzjqCeyx5qkGyxpS
QWyThMlOsJ3D5P2Mv2P5r1r75mEJa457ciT3kXw2lZLXKqJdU7aCMrtsqPRqBd6M
dywyk7lri8WknXnr4TlFAzmawXRhFazijNQPMo6wFl5zXylIVxeYeQMkphTU0jEZ
2YB4rmYu5y564tbOInz3Obm+aieRut1709vHuxkMcO6P/Lw6jcvyvnle/e08K/u5
HvJg65DkX16GvZkdrR4dqy8fBzX1Skx1smk2bacmlgeW/6dQnUjM9zVO+BE+EGqq
8TM23eyZI+FXV91m1RfNboYTXIHCninotWlxJjzqyGgjde38w5W6feMg5xtua2ri
alGTduvgbb2zXWesKinFfBcftiVbnv+j0FAU87i/YYKeShnPnEY=
=HNbP
-----END PGP SIGNATURE-----

--ilrlyr22m6ij6ssn--
