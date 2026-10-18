Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1172D0C8F;
	Sun, 18 Oct 2026 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792318791; cv=pass; b=p6sEwDLGYh15TvX2ixZ0P8Zj9uT2w8PT9oE4dF4+0PIIDXrj8/7N9PMKhBWdKW18+IMkDmXPycsuVsdZl3MCWR5qTs1lySksJv0bhrXbP9C08ePlKVhW4Rp3VhRbRhQtZGEZyEYdLCHUfxxvilDSL1hLA2N80smxvDQef7+rWjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792318791; c=relaxed/simple;
	bh=v+ywTi8+59OlpvWWnXjhz0LVaofyKglkoov1piRqIpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mdk7f+eNoRnMWWUq1T4ZPKaKu4ZSAfeGrGhriGrdtCpkKSpbE2YBxa1aH8swfbs+lVq/R73A3uI3Kj56NzS2djirge4ooqCBs/tMWui4J/RnNuGkHuTkNwbsWB+vRtQJboASKl/7/7vqcfYV9l4qpiMpVc6qSmiWmIhBYyHQTtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=GTbCTdVY; arc=pass smtp.client-ip=165.173.180.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="GTbCTdVY"
ARC-Seal: i=1; a=rsa-sha256; t=1792318787; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=a3QNF5ESUz5G5dt97L+lutm7ANzfOM8XT35f6WaTzWeEKAk3c1GW3vtgj25W7imOBnK3HAlIf3weLO57Cdh+/mMpFrTLupA6BKCywQ1MLKX7dHNRJNPFlCZJOrRk12lTfaBRiQY9pkwu5Ai5U3yMtiMBzbAZst/4NEUGdJRnHDs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792318787; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VBJvKmB+ztjPP6MHZCt4WWZ0Vw3J6gEDSdIBKXDhVac=; 
	b=Zlb/rtOmFyiipyxIXDZ3MDuEuwS68Fr4E5/S/8Z+aUvwiLiASW8zFw48PYijGwuxbGz7cVR/NOXbKXbrvO6sJU//JanVbE1YPfdvaHBkWHQrsUWq76bFiOV5kGNPtC9g4vB8MCfTNgGfiYQ8/lZnRMnCUgtBkNlrmPbJ9wSHFfI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792318787;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=VBJvKmB+ztjPP6MHZCt4WWZ0Vw3J6gEDSdIBKXDhVac=;
	b=GTbCTdVY3RhkJBuEdnK0VjahQRdQ7tCUEMGNW/9Wznrj60dSgu6Zy5tlqeoBuGoe
	HaYCFB7VvW4Sz0/y/FBFqadp72WRRUzbo9KyWUWVrbvQ7F76ZEMZ/Y3hILkF9jhAQBN
	t4fU91dpc+BVda3hzrWrf383QqT1JggElWdkT57M=
Received: by smtp.zohomail.com with SMTPS id 1792318784821792.2592897543716;
	Sun, 18 Oct 2026 03:19:44 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 704431800D8; Sun, 18 Oct 2026 12:19:41 +0200 (CEST)
Date: Sun, 18 Oct 2026 12:19:41 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH v2] power: supply: act8945a: Disable status work on
 removal
Message-ID: <atSacKtZ3e4YtVBy@venus>
References: <20261018020357.3845586-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vdbkogyuqrd7jrg7"
Content-Disposition: inline
In-Reply-To: <20261018020357.3845586-1-mhun512@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/292.311.61
X-ZohoMailClient: External


--vdbkogyuqrd7jrg7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] power: supply: act8945a: Disable status work on
 removal
MIME-Version: 1.0

Hi,

On Sat, Oct 17, 2026 at 10:03:57PM -0400, Myeonghun Pak wrote:
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
> Replace init_done with the work item's disable state. Initialize and
> disable the work before act8945a_charger_config(), which registers the
> LBO interrupt, and enable it only after probe initialization succeeds.
> This keeps both status IRQs from queueing work before the power supply
> is ready, including on probe failure.
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

Having a closer look at how the work is being used: Instead of doing
all this complex stuff this should just use a threaded interrupt and
completley get rid of the worker. I.e.:

1. get rid of init_done (done in your version)
2. switch from devm_request_irq to devm_request_threaded_irq
3. move the act8945a_lbo_detect IRQ request after power-supply
   registration to avoid problems with spurious interrupts
4. move act8945a_set_supply_type + power_supply_changed calls from
   act8945a_work into act8945a_status_changed
5. completley remove charger->work
6. drop empty act8945a_charger_remove()

It results in less and simpler code.

Greetings,

-- Sebastian

> Changes in v2:
> - Remove init_done and all accesses to it, as requested by Sebastian
>   Reichel.
> - Initialize the work before either IRQ is requested and keep it disabled
>   until probe initialization succeeds, preserving the probe-time gate.
>=20
> Compile-tested with GCC 15, W=3D1 (x86_64), with OF, OF_IRQ and
> GPIOLIB enabled. No runtime testing.
>=20
> v1: https://lore.kernel.org/r/179211805459.3650807.8742309660995961596.G1=
71@gmail.com/
> Review: https://lore.kernel.org/r/atPtc_jKLo8RhAMU@venus/
>=20
>  drivers/power/supply/act8945a_charger.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/power/supply/act8945a_charger.c b/drivers/power/supp=
ly/act8945a_charger.c
> index 7e4b087..7d47052 100644
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
> @@ -78,7 +79,6 @@ struct act8945a_charger {
>  	struct regmap *regmap;
>  	struct work_struct work;
> =20
> -	bool init_done;
>  	struct gpio_desc *lbo_gpio;
>  	struct gpio_desc *chglev_gpio;
>  };
> @@ -444,8 +444,7 @@ static irqreturn_t act8945a_status_changed(int irq, v=
oid *dev_id)
>  {
>  	struct act8945a_charger *charger =3D dev_id;
> =20
> -	if (charger->init_done)
> -		schedule_work(&charger->work);
> +	schedule_work(&charger->work);
> =20
>  	return IRQ_HANDLED;
>  }
> @@ -587,6 +586,10 @@ static int act8945a_charger_probe(struct platform_de=
vice *pdev)
>  		return -EINVAL;
>  	}
> =20
> +	/* Keep status IRQs from queueing work until probe has completed. */
> +	INIT_WORK(&charger->work, act8945a_work);
> +	disable_work(&charger->work);
> +
>  	ret =3D act8945a_charger_config(&pdev->dev, charger);
>  	if (ret)
>  		return ret;
> @@ -625,13 +628,11 @@ static int act8945a_charger_probe(struct platform_d=
evice *pdev)
> =20
>  	platform_set_drvdata(pdev, charger);
> =20
> -	INIT_WORK(&charger->work, act8945a_work);
> -
>  	ret =3D act8945a_enable_interrupt(charger);
>  	if (ret)
>  		return -EIO;
> =20
> -	charger->init_done =3D true;
> +	enable_work(&charger->work);
> =20
>  	return 0;
>  }
> @@ -640,8 +641,7 @@ static void act8945a_charger_remove(struct platform_d=
evice *pdev)
>  {
>  	struct act8945a_charger *charger =3D platform_get_drvdata(pdev);
> =20
> -	charger->init_done =3D false;
> -	cancel_work_sync(&charger->work);
> +	disable_work_sync(&charger->work);
>  }
> =20
>  static struct platform_driver act8945a_charger_driver =3D {
>=20
> base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
> --=20
> 2.53.0

--vdbkogyuqrd7jrg7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmrUnTUACgkQ2O7X88g7
+ppUSQ/7BeXj7VAfv76OqCz/1Relb5Y+CP1hcM4UWXsnofxLFj4u84EXca2bZriu
CloxTDvUib1Pm5IWFRgQXTpL5SHY9ruvMepmDUex2dTGwoM+c2ChaedZB8OyfA/d
8zinglt6kniRgUJlRHUwnYuVpJQSS0E13q0HYCYHcOdLQxZsfkjoi16NeEUv74ZH
GU2dmJ6Z1I43hwUWFtR7Xz0yHn9QDogCT3zGfQ4oRAgvUogoJx8/FKwrOx1inPYi
ksSbqGR9wh3iI8u3h4ijdqY/NvdzfQkOkAswKez5cU19ikvIejgGbzialrUcUtxM
yNIoxJkf0boTDaBVhGAwS/JdOelz/VjiBjhZRa4goHEGdllQ7TeJ1vpjq1D08l4P
/QDzDYJ2U3MFQ3+NJlJ7RUdDGgrf++QKJwtMNdI6xIOEytXlPCVDcFljbXyGsshM
ec4rg9akJJdg45PUH+3frqIkPacZRFul4wud4uLylwIrU9WL9bPikOAIdtG8svQo
TbnHJ5ZkqYDTS40tsyuW53Czyx67Kg7khiIE5LXH/R7XLW9uPF+67UDTaHJMVCva
HjCxhKl24qzDLXyDGdLxb0wlfpTGsqpv7YLGFbWQjaoSuuuBA0yINPXXPK4V4YIv
HJ7azxMkwdzAfN79U/iZlLZZEjQzT+GJTOtcLxSsX+g+kNBcWCo=
=xjGk
-----END PGP SIGNATURE-----

--vdbkogyuqrd7jrg7--
