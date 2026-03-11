Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885E838656E;
	Wed, 11 Mar 2026 07:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773212990; cv=pass; b=c9hp5cy/VI2m985NIx/XopwllIuYRK86SpuvcUsEXejl0BVmABZT6bnAUCQ55XgUgxBm3xAYJ/MeFklUCdeVrthr8Ov0IkbhnWX80m0vdWcdKhS6R+RNnoI37qjCkKx5sqUYY9qZY+4g9VD0k8sqMhvhx2BzbS2oTXAddjS2vc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773212990; c=relaxed/simple;
	bh=6KMu4+G/zOmHX6rKfiUqgpE/it+tPMrcWmMb/Nq+5Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dz3NS666l2FwMI6BKaEYsIxVkKHbnycFQqxRZTK+71aknp/d1yn/d62qu68OpHhuuvpIIh4El0jFasuWdk1fRgsWuGygqLpN+XPDQXWIxivRFfJNBYrJXPmukKufxlTknxSb+VJ0Hp0zzHUug2oKbvRr6YJ0yTt8t8MVDFSY/Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=NWTbDsZ4; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="NWTbDsZ4"
ARC-Seal: i=1; a=rsa-sha256; t=1773212984; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mBGtwSqfzwz7CnkXPL58zuK7LnGqTv3przzSw7fzzIvhIbqdR7QNp4i/lgwbW8aBGfjzFxcRrJetjhz1vgnN7zxFkiduiirsRBmWZindUi2B+ORW+++gUDp1zKcavtH6152uwOaF7CQeFSz9IFlYWd94/Fymd8CbIvpNCTOJPZY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773212984; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bX3KqtJRFdnpydJQW6XcNj29YdWQOIU3lYhG3QT6r/g=; 
	b=OpdguC2cVhphQe6lM12wYUe1LzPXE28gqed1kyTjSz/a15eCy7RviNaazjjnn9ecgbr7ZWWPDyZhRR3Dm01ydYkF88NoPDp9tdX7tFqb6OhrpabQA+blm+3GUzVZ+Kzwk82DLHxoLP47KCXTtfb5+6sA+KzcAcsKZbcJ5zi5yqI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773212984;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=bX3KqtJRFdnpydJQW6XcNj29YdWQOIU3lYhG3QT6r/g=;
	b=NWTbDsZ4t+T4COjT7NQwq4+WRxRjHkPA6GXEKWZiDoZaqUPOn4auzTynPe2271RE
	l/pGtNVYUiAcTqrpRAEzNsqxa7O40V18ig72ATgyBs9sFOsrycoqELDqzXqGd36+1/R
	JJYdbtI2jrROtaI+BNhqYdzCbFm9/ovUX2qVXNb4=
Received: by mx.zohomail.com with SMTPS id 177321298263555.491937079018385;
	Wed, 11 Mar 2026 00:09:42 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 2E7E1180598; Wed, 11 Mar 2026 08:09:26 +0100 (CET)
Date: Wed, 11 Mar 2026 08:09:26 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 08/11] power: supply: bq257xx: Add fields for
 'charging' and 'overvoltage' states
Message-ID: <abEVEkdrRbBVJ02w@venus>
References: <20260310-bq25792-v3-0-02f8e232d63b@flipper.net>
 <20260310-bq25792-v3-8-02f8e232d63b@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="noyw5ylnvg7qvqo4"
Content-Disposition: inline
In-Reply-To: <20260310-bq25792-v3-8-02f8e232d63b@flipper.net>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.1.1.4.3/273.195.15
X-ZohoMailClient: External


--noyw5ylnvg7qvqo4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 08/11] power: supply: bq257xx: Add fields for
 'charging' and 'overvoltage' states
MIME-Version: 1.0

Hi,

On Tue, Mar 10, 2026 at 01:28:32PM +0400, Alexey Charkov wrote:
> The driver currently reports the 'charging' and 'overvoltage' states based
> on a logical expression in the get_charger_property() wrapper function.
> This doesn't scale well to other chip variants, which may have a different
> number and type of hardware reported conditions which fall into these
> broad power supply states.
>=20
> Move the logic for determining 'charging' and 'overvoltage' states into
> chip-specific accessors, which can be overridden by each variant as
> needed.
>=20
> This helps keep the get_charger_property() wrapper function chip-agnostic
> while allowing for new chip variants to be added bringing their own logic.
>=20
> Tested-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/bq257xx_charger.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/suppl=
y/bq257xx_charger.c
> index deb60a9bd222..951abd035fc5 100644
> --- a/drivers/power/supply/bq257xx_charger.c
> +++ b/drivers/power/supply/bq257xx_charger.c
> @@ -64,8 +64,10 @@ struct bq257xx_chg {
>  	struct bq257xx_device *bq;
>  	struct power_supply *charger;
>  	bool online;
> +	bool charging;
>  	bool fast_charge;
>  	bool pre_charge;
> +	bool overvoltage;
>  	bool ov_fault;
>  	bool batoc_fault;
>  	bool oc_fault;
> @@ -99,8 +101,10 @@ static int bq25703_get_state(struct bq257xx_chg *pdat=
a)
>  	pdata->online =3D reg & BQ25703_STS_AC_STAT;
>  	pdata->fast_charge =3D reg & BQ25703_STS_IN_FCHRG;
>  	pdata->pre_charge =3D reg & BQ25703_STS_IN_PCHRG;
> +	pdata->charging =3D pdata->fast_charge || pdata->pre_charge;
>  	pdata->ov_fault =3D reg & BQ25703_STS_FAULT_ACOV;
>  	pdata->batoc_fault =3D reg & BQ25703_STS_FAULT_BATOC;
> +	pdata->overvoltage =3D pdata->ov_fault || pdata->batoc_fault;
>  	pdata->oc_fault =3D reg & BQ25703_STS_FAULT_ACOC;
> =20
>  	return 0;
> @@ -471,14 +475,14 @@ static int bq257xx_get_charger_property(struct powe=
r_supply *psy,
>  	case POWER_SUPPLY_PROP_STATUS:
>  		if (!pdata->online)
>  			val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
> -		else if (pdata->fast_charge || pdata->pre_charge)
> +		else if (pdata->charging)
>  			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
>  		else
>  			val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
>  		break;
> =20
>  	case POWER_SUPPLY_PROP_HEALTH:
> -		if (pdata->ov_fault || pdata->batoc_fault)
> +		if (pdata->overvoltage)
>  			val->intval =3D POWER_SUPPLY_HEALTH_OVERVOLTAGE;
>  		else if (pdata->oc_fault)
>  			val->intval =3D POWER_SUPPLY_HEALTH_OVERCURRENT;
>=20
> --=20
> 2.52.0
>=20

--noyw5ylnvg7qvqo4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmmxFSUACgkQ2O7X88g7
+proshAAkWr4cE63rJNICSYF6YQNjXLHDKXcZYZgtA4uXIY8Bsu8o6b5TzoSKuoK
cOib/viW7x7sq7z/QFyflWIoM2/PifwCWtyqif+tXFsDJ493e3+urgYt88rYCTSY
/OZboFg9z1ot7cyzHx266Z4p+C7p6CwIChQo6HXDsmuO8d8wcQhRXfH7B7LQdt6c
bhPBvaYiIYR8zCFVRQTW60Q62qtlBRNWAP8FOVI0CxbiH2ZOtCAXAmBry4/C4wcQ
CRYTRIdIl7WLS11kFYgUwpquRZMztF7FEK1e+53Nzjkpfr+d1u8RqRAmCAohsrjY
w6kPG/hCE6U0ITNBIV4M5AD73vn8a9p3r24lBwWyAOWtTMfK19mQRK1X7otRN1S0
2+bCKYDk46uC5Q0AKMa32FwPq+Nua1RzjM09SsvcsWsZFTO8fP6WUmDmfTORg/z1
mHBOjCUk7DKhLg69mOITaHdF5GZn2JKey+wx0Pk7J/SrDo/2vZxyhMjxKztkQUr/
FgqrX0enA7IBNWC0PZ6ZOHNJoIq0ssSKHZIlr08gK47Ss+1s+uGcBbAv9Ze1OGg3
VMs3rFv5YE/Kc0QAFuGamz6InOkrP09zsOjcaGcygblEdx10QFMkhrrEgnoheyJ8
xDiCLrn/+dWmYxNyrFXIJJ8KdIMcyCoPnWD8z47udHOgJgBiZDk=
=Ea9Z
-----END PGP SIGNATURE-----

--noyw5ylnvg7qvqo4--
