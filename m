From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v1 6/7] power: bq24190_charger: Add
 power_supply_battery_info and devicetree support
Date: Fri, 24 Mar 2017 10:20:15 +0100
Message-ID: <20170324092015.to2yyy5465o4w7lm@earth>
References: <20170321220921.5834-1-liam@networkimprov.net>
 <20170321220921.5834-7-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zqwctgetz754gtoa"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934157AbdCXJUU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Mar 2017 05:20:20 -0400
Content-Disposition: inline
In-Reply-To: <20170321220921.5834-7-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Mark Greer <mgreer@animalcreek.com>, Liam Breck <kernel@networkimprov.net>


--zqwctgetz754gtoa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 21, 2017 at 03:09:20PM -0700, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
>=20
> Obtain pre-charge and end-charge current values from power_supply_battery=
_info.
> Obtain minimum system voltage level from devicetree.
>=20
> Cc: Mark Greer <mgreer@animalcreek.com>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>
> [...]
>
> @@ -1314,6 +1358,39 @@ static int bq24190_hw_init(struct bq24190_dev_info=
 *bdi)
>  #ifdef CONFIG_OF
>  static int bq24190_setup_dt(struct bq24190_dev_info *bdi)
>  {
> +	struct power_supply_battery_info info =3D {};
> +	const char const* s =3D "ti,system-minimum-microvolt";
> +	int v;
> +
> +	if (!of_property_read_u32(bdi->dev->of_node, s, &v)) {
> +		v /=3D 1000;
> +		if (v >=3D BQ24190_REG_POC_SYS_MIN_MIN
> +		 && v <=3D BQ24190_REG_POC_SYS_MIN_MAX)
> +			bdi->sys_min =3D v;
> +		else
> +			dev_err(bdi->dev, "invalid value for %s: %u\n", s, v);
> +	}

Let's use device_property_read_u32 here. With that change
there is nothing DT specific, so the function can be named
bq24190_setup (or everything is done directly in probe, that's
also fine with me).

> +	if (!power_supply_get_battery_info(bdi->battery, &info)) {
> +		v =3D info.precharge_current_ua / 1000;
> +		if (v >=3D BQ24190_REG_PCTCC_IPRECHG_MIN
> +		 && v <=3D BQ24190_REG_PCTCC_IPRECHG_MAX)
> +			bdi->iprechg =3D v;
> +		else
> +			dev_err(bdi->dev,
> +				"invalid value for battery:precharge-current-microamp: %d\n",
> +				v);
> +
> +		v =3D info.endcharge_current_ua / 1000;
> +		if (v >=3D BQ24190_REG_PCTCC_ITERM_MIN
> +		 && v <=3D BQ24190_REG_PCTCC_ITERM_MAX)
> +			bdi->iterm =3D v;
> +		else
> +			dev_err(bdi->dev,
> +				"invalid value for battery:endcharge-current-microamp: %d\n",
> +				v);
> +	}
> +
>  	bdi->irq =3D irq_of_parse_and_map(bdi->dev->of_node, 0);
>  	if (bdi->irq <=3D 0)
>  		return -1;

-- Sebastian

--zqwctgetz754gtoa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljU5M8ACgkQ2O7X88g7
+poZ8A/9Eyt6cJ1tilXM2GMIxGZ6pTMhFsrcTLWCBAn9Xh1rUZJfgwfx25Bdy8b0
KuP90rEKMJG3mHdDuTrMOf0GlaBuQRbYmkZjVQidbtpkjHSU/nE86+jvhx3bOaB8
K5pQAC+HSGTAOSlcyRwxHen9tQWaWdzww7xPO8OhasO40MnBCp0ShbWat55WxTuR
S/uMOfsGFDE+Ys/K5MyDhpKZgjnHR/RAHwAIvUNZj/0EQP2tA+D81PxGGzoPmMBF
4VapvxpLLcJcWc3Yd3X9jRIP+KqzpfyKh1njpeQH1oxP34FJJVGYQbLc4KBsdrCo
VNLlm9gN72yLxraPBlDrISbS0zQ3H7fM7h7UQyAcImLgrYmCi+R1k04VEAG8QxL0
JlxnZfklKjFj43LhaWxVuSEY0YHybWC+nFgWBs5gxTzfdsqCYIEw7tZG5tNu2meF
0Ago47RFszDaL5d3TOwDnKo+JrD0LR+ClSnpypa2B42df03eqg5BuU6/ecGomBlQ
PG8yHnwDNQKONJHlUPAfhhT/MiwxKz65iyqJ+J+Td2miGwFmC308h9rQe7W94xlF
i3D/D1hPZ6M3ueeg9nKxttUMdZTdjPBTx6GQ1Yiilv5hGxVT+oYw0ORXwch13MtS
wZZO4Fa8U6sxYzdTVlC62pmOn0quaN1jcQDWhKeJFQXLwAN88Ac=
=fVC8
-----END PGP SIGNATURE-----

--zqwctgetz754gtoa--
