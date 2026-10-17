Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF489274FE3;
	Sat, 17 Oct 2026 21:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792274057; cv=pass; b=fCjhpTTgv1ohWaUbDYatU+46wEvClCVAoExbvJ/PHnDXcIjS4fCxyax2vkPiaEjBOccayPdrR/ROD7kadvbpMDsgoN9yDuzqKDRtHNlG951zWw4Ky8hpS/Mry+IQViIFmJTxQHw5kCPwCp3PU+A19fSqdYdFHML1r2CZfpl39/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792274057; c=relaxed/simple;
	bh=5X5ujoXodvyuNMTS4/HlVxT2ovcty5row7mD6HHKRuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlt3j/fRRz3/PjrIDyGlJeQOAd0Fe/C3qXbqzNCJIXKSvVhE7wREnm6Zx41xiKbpeety+FyetCNYR5ibzz8Zn+csqj2n0D3Vs/I/MPc9DhlR0hdhBx7zFEGP3NOgtUr5STgiT+eV0Q8IFc9mjGGaGRVhY+NwwmBza4aRvutIqB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=PeJJa4xV; arc=pass smtp.client-ip=165.173.180.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="PeJJa4xV"
ARC-Seal: i=1; a=rsa-sha256; t=1792274053; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EKd8RQe5E7oCe0NhypwwW/YGY4rh3ztxTFkz1d1edW1440N/MGb5ZUWGqnFcqDisijOoxH/e5kYkP3BRi1JjVvEU5hsnNEzzhDhx3+cqVvZQckBwrPAxrOOwf92K/sKf/u3MDgscLxmz6uCG+UVSc+Yl6v/tC+PGrx2Cx0UeBZw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792274053; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZJcGslv0czVBTIydD0K8O/jWcHTbFnPCUePPgTSTYIk=; 
	b=jflp62JtrFYvJkm3Ro1gVP+jvBGO4bSuPXg91jbLiGFkshwmXXtUwIE3aKeo3Yf7H7O9PntRsRXckLnBxGn4B4lbsL9VIAyoCznoy6jYdwNPscAMEeEXmnwLXFeEUiOc250JF53StHWB7WkyW5prEIjXP2GPqwGWDnwhqgKiiec=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792274053;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=ZJcGslv0czVBTIydD0K8O/jWcHTbFnPCUePPgTSTYIk=;
	b=PeJJa4xVcSNAJCoYlJPafRma0ZsDH1wGCZL14aPL+K/MuMhvE8Od+jleaTgPJhdB
	gVkzvIfqYwxGTtg0+S8StndoVCPKbhQhhAIwTco3VCF66As4YHYazFuDypt1FAaMXpy
	7jdtQ5KeCHM7KeHAGI2GUJ4RVcPwKdRVNxXgZ7Cc=
Received: by smtp.zohomail.com with SMTPS id 1792274050794145.90045020595323;
	Sat, 17 Oct 2026 14:54:10 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 4368B182317; Sat, 17 Oct 2026 23:54:08 +0200 (CEST)
Date: Sat, 17 Oct 2026 23:54:08 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] power: supply: act8945a: Disable status work on removal
Message-ID: <atPtc_jKLo8RhAMU@venus>
References: <179211805459.3650807.8742309660995961596.G171@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zykbhpmbszvp5mez"
Content-Disposition: inline
In-Reply-To: <179211805459.3650807.8742309660995961596.G171@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/292.264.81
X-ZohoMailClient: External


--zykbhpmbszvp5mez
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] power: supply: act8945a: Disable status work on removal
MIME-Version: 1.0

Hi,

On Thu, Oct 15, 2026 at 10:34:33PM -0400, Myeonghun Pak wrote:
> Clearing init_done does not synchronize with either status interrupt. A
> handler can observe init_done set, be delayed, and schedule the status
> work after cancel_work_sync() has returned. The work can then access the
> power supply after its managed cleanup.
>=20
> Use disable_work_sync() to reject subsequent queueing and drain any
> existing execution. The charger allocation remains valid until both
> managed IRQs have been released, so a late handler can safely attempt to
> queue the disabled work.
>=20
> This issue was identified as part of our ongoing research while
> reviewing kernel code.
>=20
> Fixes: a09209acd6a8 ("power: supply: act8945a_charger: Add status change =
update support")
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---

You should also drop the useless init_done.

Greetings,

-- Sebastian

> Compile-tested with GCC, W=3D1 (x86_64). No runtime testing.
>=20
>  drivers/power/supply/act8945a_charger.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/act8945a_charger.c b/drivers/power/supp=
ly/act8945a_charger.c
> index 7e4b087..61381d2 100644
> --- a/drivers/power/supply/act8945a_charger.c
> +++ b/drivers/power/supply/act8945a_charger.c
> @@ -14,6 +14,7 @@
>  #include <linux/power_supply.h>
>  #include <linux/regmap.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/workqueue.h>
> =20
>  static const char *act8945a_charger_model =3D "ACT8945A";
>  static const char *act8945a_charger_manufacturer =3D "Active-semi";
> @@ -641,7 +642,7 @@ static void act8945a_charger_remove(struct platform_d=
evice *pdev)
>  	struct act8945a_charger *charger =3D platform_get_drvdata(pdev);
> =20
>  	charger->init_done =3D false;
> -	cancel_work_sync(&charger->work);
> +	disable_work_sync(&charger->work);
>  }
> =20
>  static struct platform_driver act8945a_charger_driver =3D {

--zykbhpmbszvp5mez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmrT7nwACgkQ2O7X88g7
+pqD5A/9GBhk0AhalwbJsGsMmaiqzRIqx7VAbuIW0qhs/lIQzUI3z29AIbcucfWn
3DPx56Sbj2TBWwym7GWV3iPQxKEl6NxDaUu8m4dooJKjkXUPH78oOo3e13i1iZuA
BmGtgKtm+lxDiF9IXlP3tO3lq9IFQ+Kly5u0nzROYbS6JcsmE+r5SZBPltlpZXq3
GLfy+FF61mCBW5I+Nh3wPDRC4nZzvVVbltsVw4nOa475fCBiCzrN6KteZtAXkqPc
3pe9cr5++/zqUdIduv8E6t6Tne0RZRzNhPa8n60UnrOfQZ1g8UnhLvImF/kYgj1c
IXvH5zBZVBHf0aQTVd1ZfFWysKno8zQR9iGo/zBTdyh+Py1HJB7GGyFTzA9O8avf
KHUvOfeJvCfkvfxQSVihK+EFXCitwyBU5+WOGLp9bzb3OYEZT2kQBajRw5Z7E3xh
HUve7vehBYzDJaGddrnaAPWe06YbjYAtEtfa/9BN2I93QQ0wGChlgiQRTILxGcWt
uciIqTHEABFWkVUXAppaSpq7KBGsg3zzj/dzSdXAKhYcWVlPiI08K05thOah1Vg3
oGwij+R5IGerudMLo2BqDla7FSyttGsJwFh6FT0UphWk1EQMS+SxiSRHUAOvL1Yd
J4+8dcYMzaxW+ckEFDzc9yNgqq8gBwmR1hypf/GIxUj7Y3XU8d8=
=bkTZ
-----END PGP SIGNATURE-----

--zykbhpmbszvp5mez--
