Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F7F38B150;
	Wed, 11 Mar 2026 07:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773212955; cv=pass; b=jy5QjoUSBiECK5YrLtmH0YDNDWUszP4pShkjQytOpG9uwT8joz5O0K3lFgBzyN8KRtAdLjzMH3uvve1u1adkxmaKnZBtQBhTI247swDvWUirvMGyRy4/zXiRHJIY1NhwoDrNl/sM+gwMd2I0s6M/Oljn5FeLg3mG1aOXv7zwRBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773212955; c=relaxed/simple;
	bh=hEuAy+6uPnEv6CenFLePXlMngUsWbU6iSfZGwptrqhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hncnZKTAfvYa+Io9nkHIx84uDKvQS83oof9zqm3B7cKahLEV3ICXc7DU16rjfdOAf2Q1GSsyhdSHCKGidZl9+Upbl+bysv54I8ENUlPqvVWYw/ofxaS3dvfcHPNOAxJOXIb4TDMaqe5rtMJrQoOXLj+iGQ4nw/a8Qc7l8ACTRM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=CLteU38F; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="CLteU38F"
ARC-Seal: i=1; a=rsa-sha256; t=1773212937; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EKkQ63WcZdFoc4cSm1mo5FOUrx5FEA0/7XP5lGP9MrZfsbVEBI4+mhXtTTaLEhYVyvnnxfwVrMkRYS7nWtvu/PHE/kIrp2QewalG1j6GRQvA5aF6c7PqTStAPht+x9gfaMvIjxykogFDlHOdl9QrsKKKRqNO8OsxXIenN/AVXbs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773212937; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cmlOI7djcSL6lb3xz9b+q0jqYhA5pGPPF6F0qUM1pnc=; 
	b=flh4YIZ64tfaGzRSoiBvfx+ycyNZcmwdBzWQHX16mSurFe9SmCU4WCEo7Hg88GbwCreovM27DgF1qw8DbuPqB/BHL3M7ictV1xCXK7jvzCNIdOhcxYAyBTiiCD/f4qAfGKeJi+/7wOmi/4zW3GyU4esMTANX7LWjnIPSHl0Etl4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773212937;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=cmlOI7djcSL6lb3xz9b+q0jqYhA5pGPPF6F0qUM1pnc=;
	b=CLteU38FOZiReffIm50QudreSQpk5qsb0wC9xpp2fI9jkuDUGExcCbL1AuWvdRKi
	yifytjV6QCrAM314wVDkS5fYMdpCaOgisWXEmsuff3YDKGYBC6s4H6VjfO3qIo9ZLOj
	zebZAB3Rofsncm0lJulXu8wAagmPPZ74iIPZaoNk=
Received: by mx.zohomail.com with SMTPS id 1773212935077604.5115313097302;
	Wed, 11 Mar 2026 00:08:55 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id F16D0180598; Wed, 11 Mar 2026 08:08:46 +0100 (CET)
Date: Wed, 11 Mar 2026 08:08:46 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 06/11] power: supply: bq257xx: Make the default
 current limit a per-chip attribute
Message-ID: <abEU4z8pdttLkyVe@venus>
References: <20260310-bq25792-v3-0-02f8e232d63b@flipper.net>
 <20260310-bq25792-v3-6-02f8e232d63b@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="reifdht5cktlc2j3"
Content-Disposition: inline
In-Reply-To: <20260310-bq25792-v3-6-02f8e232d63b@flipper.net>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.1.1.4.3/273.195.15
X-ZohoMailClient: External


--reifdht5cktlc2j3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 06/11] power: supply: bq257xx: Make the default
 current limit a per-chip attribute
MIME-Version: 1.0

Hi,

On Tue, Mar 10, 2026 at 01:28:30PM +0400, Alexey Charkov wrote:
> Add a field for the default current limit to the bq257xx_info structure a=
nd
> use it instead of the hardcoded value in the probe function.
>=20
> This prepares the driver for allowing different electrical constraints for
> different chip variants.
>=20
> Tested-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/bq257xx_charger.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/suppl=
y/bq257xx_charger.c
> index 7ca4ae610902..e14dd16f9d08 100644
> --- a/drivers/power/supply/bq257xx_charger.c
> +++ b/drivers/power/supply/bq257xx_charger.c
> @@ -26,6 +26,7 @@ struct bq257xx_chg;
>   * @bq257xx_set_iindpm: set maximum input current (in uA)
>   */
>  struct bq257xx_chip_info {
> +	int default_iindpm_uA;
>  	int (*bq257xx_hw_init)(struct bq257xx_chg *pdata);
>  	void (*bq257xx_hw_shutdown)(struct bq257xx_chg *pdata);
>  	int (*bq257xx_get_state)(struct bq257xx_chg *pdata);
> @@ -627,6 +628,7 @@ static const struct power_supply_desc bq257xx_power_s=
upply_desc =3D {
>  };
> =20
>  static const struct bq257xx_chip_info bq25703_chip_info =3D {
> +		.default_iindpm_uA =3D BQ25703_IINDPM_DEFAULT_UA,
>  		.bq257xx_hw_init =3D &bq25703_hw_init,
>  		.bq257xx_hw_shutdown =3D &bq25703_hw_shutdown,
>  		.bq257xx_get_state =3D &bq25703_get_state,
> @@ -675,7 +677,7 @@ static int bq257xx_parse_dt(struct bq257xx_chg *pdata,
>  				       "input-current-limit-microamp",
>  				       &pdata->iindpm_max);
>  	if (ret)
> -		pdata->iindpm_max =3D BQ25703_IINDPM_DEFAULT_UA;
> +		pdata->iindpm_max =3D pdata->chip->default_iindpm_uA;
> =20
>  	return 0;
>  }
>=20
> --=20
> 2.52.0
>=20
>=20

--reifdht5cktlc2j3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmmxFP4ACgkQ2O7X88g7
+poVshAAnXzYI6V9uZTnGhackdsLYcIzYBzV4S2UblpvgsjBEDRbg8hS/8Y5Uk/G
rx6QjiEW1/pmj8VKkoHbU3X/oD1WxT2M1Safnlev6s1mvKor7Ccop15nuLZzMwvs
xc47h900ZWCQyLc7Q2w7Xb7kRrcIitpBhLgYNSb98657rjGXYYBtx92xuuSvnxgl
u4Xsz6EQfwbsh6UOZV0+9EzDiWbLPA466TXv39R9rOMFQJQEAqZZi4zum6IVyWoT
6vsbmODK1GkX6Bf4Fx9tGVIYS8KHrMym3N/P+APYXZavZwe/n6zoUqmVuQYyNDNE
RVWYjRjrMfqHuLayxVv0zHGZh16JMoJkSVUpxXQIWQ2npWxWZ2ZJStVuIL9kZPzj
Uii6iAOSHBd8LzDqQjBj0N1lnPq785/F4TahKWZRLoMci+2EQFA49R7Y1YPJePby
QnJPfo3DuA6H6O72f4L7pH/fSP+Qi94MqyreIr8yFtf0+7qNQrt9SgoeSReIE01E
RSjk4RnNS2Bo0483Em39OQjforCHn7V6DAzHPOAmJcAuqjCCqIQd+QiTgFmJhPyC
Js7gYmMLcVBhEUADhpZtTOz0X4C/zxc6BGv1aBiplohxyupiNpIos5E2+zacLTvY
FZ7GN6XlFtvIgSlCZ93UX3jMv51EFqcDtR6bdVAq3+GLaFLw8Cc=
=lQvk
-----END PGP SIGNATURE-----

--reifdht5cktlc2j3--
