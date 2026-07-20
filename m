Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E22266B46;
	Mon, 20 Jul 2026 22:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784586215; cv=none; b=kfZhPOiadC08KbOUhCPf2RyWcWj3H3FeF7Nswon8o1oY+elvve401kJSrfLuwyOquzwrwlrlBHWW/5deUuWS8D/GTtUZ5Od7ZRM6XLEmpKTQ9BgLOm0nZcqVPLSsGYLLBrd9Qzxfr2RT9X8gNnbu+as48j4blE5x/The2cT2c8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784586215; c=relaxed/simple;
	bh=Lhd74HwTjByf3TW/mc2egQc9HOEnReCG3VDixMdk2Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTmbYGbZWcH4MFPWet/6JYw2NFYPU0e0AjtqcEaZBWWWuqU8m3/YodzgdyllCpB+U/r0GwT4WqSt+m3wWedVX5Wby8cgJGch6zTttOEzyytKVDbqC7+6z/Fo8PDS2ULEnsAk9/qbx2YvcL15wJq8wBQOV/SZ9lCiIs8POhT1J0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rohg2Ajt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rohg2Ajt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E2A1F000E9;
	Mon, 20 Jul 2026 22:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784586213;
	bh=mIax+3Jbi3+oV+xa8jofcN974l22U1pxScyWo7at74M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rohg2Ajtmopr7CVGQxDty7w60qb+ku81x2kM644I6ZnbEIlVR0/CSuVpEUSt6JXML
	 6uBYzBESZIb147v/AdfjdZ3I/x8F+f9vYW/HeqHzPNEP8wMG13kbCjspAZQqcEdPvi
	 9ulEgnf3mlLThXDNPU1WbXf2PHWCyW4r/TbYSOYAVgys3DgXvDvLEwoWj30abpSVdC
	 Mj6+NDsP7on6LRFzdEKpuoEnE+giLJXXIxnpA7wsAOtyttq1laD12+St3NTpO65odC
	 /lTn/RdqVnLjEtCGM+5aFg79yQa3ovulh/9tztyN+CaT0jcLBrpE2YFBytAcxAZJzC
	 yTYsBEROHAQdw==
Received: by venus (Postfix, from userid 1000)
	id E8AC0180A25; Tue, 21 Jul 2026 00:23:31 +0200 (CEST)
Date: Tue, 21 Jul 2026 00:23:31 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Steffen Dirkwinkel <lists@steffen.cc>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
Subject: Re: [PATCH 2/2] power: supply: leds: add a not-charging trigger
Message-ID: <al6dJek_lLPGARdU@venus>
References: <20260625-std-power-supply-triggers-v1-0-d80db570d329@beckhoff.com>
 <20260625-std-power-supply-triggers-v1-2-d80db570d329@beckhoff.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2lrgha4ncqswu4dj"
Content-Disposition: inline
In-Reply-To: <20260625-std-power-supply-triggers-v1-2-d80db570d329@beckhoff.com>


--2lrgha4ncqswu4dj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] power: supply: leds: add a not-charging trigger
MIME-Version: 1.0

Hi,

On Thu, Jun 25, 2026 at 07:07:35PM +0200, Steffen Dirkwinkel wrote:
> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
>=20
> We intend to use this with a gpio-charger ups device that reports
> charging or not-charging based on a gpio to set a "power failure" led.
>=20
> Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> ---
>  drivers/power/supply/power_supply_leds.c | 7 +++++++
>  include/linux/power_supply.h             | 1 +
>  2 files changed, 8 insertions(+)

POWER_SUPPLY_STATUS_NOT_CHARGING means, that a battery is neither
charged **nor discharged**. I think the NOT_CHARGING status has a
bad name, but it's ABI and cannot be changed easily. But I certainly
don't want it to spread further. Let's find a better name for this
trigger. Maybe idle?

Greetings,

-- Sebastian

> diff --git a/drivers/power/supply/power_supply_leds.c b/drivers/power/sup=
ply/power_supply_leds.c
> index 538cc0440e53..c82a3628765c 100644
> --- a/drivers/power/supply/power_supply_leds.c
> +++ b/drivers/power/supply/power_supply_leds.c
> @@ -131,6 +131,10 @@ static void power_supply_update_status_leds(struct p=
ower_supply *psy)
>  			LED_OFF);
>  		break;
>  	}
> +
> +	led_trigger_event(psy->not_charging_trig,
> +			  status.intval =3D=3D POWER_SUPPLY_STATUS_NOT_CHARGING ?
> +			  LED_FULL : LED_OFF);
>  }
> =20
>  static int power_supply_create_status_triggers(struct power_supply *psy)
> @@ -150,6 +154,8 @@ static int power_supply_create_status_triggers(struct=
 power_supply *psy)
>  					  &psy->charging_blink_full_solid_trig, &err);
>  	power_supply_register_led_trigger(psy, "%s-charging-orange-full-green",
>  					  &psy->charging_orange_full_green_trig, &err);
> +	power_supply_register_led_trigger(psy, "%s-not-charging",
> +					  &psy->not_charging_trig, &err);
> =20
>  	return err;
>  }
> @@ -209,6 +215,7 @@ void power_supply_remove_triggers(struct power_supply=
 *psy)
>  	power_supply_unregister_led_trigger(psy->online_trig);
>  	power_supply_unregister_led_trigger(psy->charging_or_full_trig);
>  	power_supply_unregister_led_trigger(psy->charging_trig);
> +	power_supply_unregister_led_trigger(psy->not_charging_trig);
>  	power_supply_unregister_led_trigger(psy->full_trig);
>  	power_supply_unregister_led_trigger(psy->charging_blink_full_solid_trig=
);
>  	power_supply_unregister_led_trigger(psy->charging_orange_full_green_tri=
g);
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 68b65682b14d..9052610e3910 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -349,6 +349,7 @@ struct power_supply {
>  	struct led_trigger *charging_or_full_trig;
>  	struct led_trigger *online_trig;
>  	struct led_trigger *charging_trig;
> +	struct led_trigger *not_charging_trig;
>  	struct led_trigger *full_trig;
>  	struct led_trigger *charging_blink_full_solid_trig;
>  	struct led_trigger *charging_orange_full_green_trig;
>=20
> --=20
> 2.54.0
>=20

--2lrgha4ncqswu4dj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmpen98ACgkQ2O7X88g7
+pqRZg//WcvpwN8jU59EP/Jw7kNkPArawyoth0fJ3wIlNfHftaUQfOSBQO4bpS9O
2poq73TlxM7ZTt5QVpOQzZv9ZjmaJiEiAQ/mkKHNYSmTuL8UE5MLNx9uFBAGXZZT
RuCixMXcr3JXZ6YyVF4hM9gKKk0jDDf9cXCYgnFIFJY25wXx5GCW7fnhftNce/tu
vYjYVQtfT3jxKV9YS4ls4u619jUF0++fpsBJe82zPFSbUEo9F2kpOYUV/vkHntFa
hTGZorDjNnLHznHqY7utfQBu80/bidO7GCzMlZPscZi1b3Kn/wpnVhSXSUBZ9m8Q
c2PnC9XLJb+PuTpXJ63cRha5HL4rSUi7NSqzdLXMeFr76Tj7Tdc6s7nSlIITWl2m
WWr8CP0QtyzdmgNsQI7LN/QzyHBEAWuRSLIdeDCf1dfIsEPIQxkboGrMuSRM4nMs
4iiX16G98VjMSdPNE9nJiC28B8YNDjpEf/AX4nWdo0n+VMAj4wCqGZlXQgFA/ZAi
S7OncCJIOqzhB2/gRwjUAGdxb6iyUx2HyJAyn30mFL814GSOQ2T3spQl3avy6Bcg
dJuc4UqE6qic6aDs0gi8nOg/Zx07R58V6XcXmrHD0Yae+pW2q2BjKeLvEZI43Fbd
bRk77eAsxBMzdTE4wnLM/mAKT2etlNCwXb7+PwJoLcmy7j1LLNc=
=R9sx
-----END PGP SIGNATURE-----

--2lrgha4ncqswu4dj--
