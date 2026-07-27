Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD3E3D6479
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 20:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785185416; cv=pass; b=YTAnK6KrNpvWcvQUlKYRbUVDw8HxaQgNgUlXTb5mVaLHbPJkFLWpsdg/utuELqAd9TlKBmA5e11K8Jw/6MC/cYODr2yaQYBlBVHs9UbeWO0hdjVPl/GVK0WOLvo1RDMTMyoAd3AjTGH51yMgnYayaoYlEbm7921jdCtCIWUOcTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785185416; c=relaxed/simple;
	bh=Nl1brM1XJYVZpsTVGem0WfMuC7sWOuAFyUsBz20pHUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5UsHIPRMGpbUPcoBxS8dOZ2dK8uniHpUkgSfHTa7ueTtG+tX9Gyd27sR7B/+k6YF9KTfWF6REI8fs/B2qtRFw+ACH5JfnTPtZk29OcI6HqD/4PSyEjIVjPtkkqM511y0kTkPUK6P/N/cgul2/gGPFIubEq8q7azWpA2BERduEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=A7CS0YbG; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="A7CS0YbG"
ARC-Seal: i=1; a=rsa-sha256; t=1785185400; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hfC0PRnki1MNgk5Qi6LOD05IXGuPeLT7sgEnnj6wI0u3iTfdRfuEmm/87+HPcNxZ1DMggh7Acfiq9ccmrG8v0kyJP0liFd4QmbJkbMlvKr8yh/q0KCkBJ207qjEzT3LPm61VdRCigKAP7C9PDjEtoWbXAoqzphdFnRrjKXx5sxw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1785185400; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sRBYMtiEbfSgJmYWtsfYSAOVB/aghCdNqybvywfcGdM=; 
	b=Tou6MVZYAmkZ9zmxUsG+ol8PYYvOrUNKOtpFW2h3EQGWdadEJCi7BusdKaOV8GKDubMDeo+4PR5fP2FEOXvlEofClY6gGmyfxxMEXm5zjMJ8L6yJ23iOHpq0ZhZ59KY8VXBtHIukBmEz6ldwL3pFJDdsRzVvHQwkMhyPTxXo7tQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785185400;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=sRBYMtiEbfSgJmYWtsfYSAOVB/aghCdNqybvywfcGdM=;
	b=A7CS0YbGDyzgw+pc6hjFEAVFNo6WnQLX1BgCmtV9AsglWpFxMgdyARwaeUESTzg7
	lAzzCYfBdbGksFDSkisbf7vNtrZuFXZEoBgEHqGmVMF8bZxyjaKZ8n7Aw+BnPzlR57P
	zdn3A9Oqq13FHn1392Nkb55hPGgNijh0TcPWlowE=
Received: by mx.zohomail.com with SMTPS id 17851853988061006.1905572064304;
	Mon, 27 Jul 2026 13:49:58 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 090B818090B; Mon, 27 Jul 2026 22:49:56 +0200 (CEST)
Date: Mon, 27 Jul 2026 22:49:56 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Linmao Li <lilinmao@kylinos.cn>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq25630: Release battery information
 after setup
Message-ID: <amfC7EN4d_72zLqH@venus>
References: <20260727093738.2611185-1-lilinmao@kylinos.cn>
 <pndjyqgob5y.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p52nonaenuoecvor"
Content-Disposition: inline
In-Reply-To: <pndjyqgob5y.a.out@axis.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/285.167.77
X-ZohoMailClient: External


--p52nonaenuoecvor
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] power: supply: bq25630: Release battery information
 after setup
MIME-Version: 1.0

Hi,

On Mon, Jul 27, 2026 at 02:43:37PM +0200, Waqar Hameed wrote:
> On Mon, Jul 27, 2026 at 17:37 +0800 Linmao Li <lilinmao@kylinos.cn> wrote:
>=20
> > data->batinfo is only used by bq25630_setup() to program the initial
> > charge limits, but power_supply_get_battery_info() allocates it on
> > psy->dev, so it stays around for the lifetime of the device. Nothing
> > else in the driver uses it. Release it right after setup, as bq256xx
> > and bq257xx do.
> >
> > Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> > ---
> >  drivers/power/supply/bq25630_charger.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/power/supply/bq25630_charger.c b/drivers/power/sup=
ply/bq25630_charger.c
> > index 165f8c67b4895..efcdb1f5bc351 100644
> > --- a/drivers/power/supply/bq25630_charger.c
> > +++ b/drivers/power/supply/bq25630_charger.c
> > @@ -1045,10 +1045,9 @@ static int bq25630_probe(struct i2c_client *clie=
nt)
> >  		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
> > =20
> >  	ret =3D bq25630_setup(data);
> > -	if (ret)
> > -		return ret;
> > +	power_supply_put_battery_info(data->psy, data->batinfo);
> > =20
> > -	return 0;
> > +	return ret;
> >  }
> > =20
> >  static const struct of_device_id bq25630_of_match[] =3D {
>=20
> The initial thought was that `batinfo` could/would be used elsewhere,
> but as you point out, it's currently not. A better design is then to
> move the `power_supply_get_battery_info()` into `bq25630_setup()`, in
> order to scope the `get/put()`. So let's get `batinfo` there, just
> before using it, and have an error/clean-up-path there as well.

Agreed. Keeping an invalid pointer makes no sense.

The setup routine is also a good candidate for the new
=2Einit callback now available in struct power_supply_desc,
so that the registers are initialized before the device
is exposed to the system.

Greetings,

-- Sebastian

--p52nonaenuoecvor
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmpnxHAACgkQ2O7X88g7
+prGVQ//eNA6uJh4EZCUhxWFMKXSnhKVR81uq1rDW4iJOonoruQ7zAG12hIjWDf+
qR7auzrypE5BDa2SVHhok0QWH6pC1Alk83Sc8Qd+o8xaiWkAh0Qi2GCl61CbNnxB
hYq0rVxZkqiw7cQ3xmuQTPrnKZo9s7964aT/GsbHpdTY2C9t9cVynF9fsIE5yqby
Ox6pWTpeI04HHp/2gN8NlYoFqpGnB671f8IYM0jzYU7LucB/NRYm4iA35mwaUiat
iENe/+wm4ukM04fAOiukUFcVAAtNIok8gLewBywEthwd4/G4jRV/bk6BFpfqkoNd
s7LPzgJSIKdjT3U8PLPUINRImxlUj98uVdbnfs7FAX/DkhY6dPP94z7UZUQh4XuX
Bii1cgyMN/mIiiGit2SxEad2v9Z3ROZB8Lq0KMuyAoQHMgziTUdfXl39PJRl76p5
TitSDS0viX3j0EssPSowJUpMGzuRNeePcotfZFXWlW8ha1BWAVNvfW7CWTVoCmUC
r1+ZGg4hmYpgC5BppuwMHrYPhFDQNHBEkOqN1M6+EkPOdLeao1sQLK5hiYdbrNuy
EoxHf4nr0/IFb6xdfJ7s6tYy6KPnuA83PvtDFDuT2+mtr1BzA7DLVyfqMGzVCzfz
svC6hdqeDHTYJKXRlmIMWAydCD67tynPGm5yML6FkifQb8j5+8k=
=PnnC
-----END PGP SIGNATURE-----

--p52nonaenuoecvor--
