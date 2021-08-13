Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F410C4338F
	for <linux-pm@archiver.kernel.org>; Fri, 13 Aug 2021 16:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 476DC6109D
	for <linux-pm@archiver.kernel.org>; Fri, 13 Aug 2021 16:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhHMQM5 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 13 Aug 2021 12:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhHMQM4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Aug 2021 12:12:56 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AB0C061756;
        Fri, 13 Aug 2021 09:12:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 516D71F44A4C
Received: by earth.universe (Postfix, from userid 1000)
        id 3D07F3C0C99; Fri, 13 Aug 2021 18:12:26 +0200 (CEST)
Date:   Fri, 13 Aug 2021 18:12:26 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Bruno Meneguele <bruno.meneguele@smartgreen.net>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] power: supply: bq24735: reorganize ChargeOption
 command macros
Message-ID: <20210813161226.phnswlf7lnpjkizu@earth.universe>
References: <20210709142731.23418-1-bruno.meneguele@smartgreen.net>
 <20210709142731.23418-2-bruno.meneguele@smartgreen.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ay3hu2slrqbfq2lf"
Content-Disposition: inline
In-Reply-To: <20210709142731.23418-2-bruno.meneguele@smartgreen.net>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ay3hu2slrqbfq2lf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 09, 2021 at 11:27:30AM -0300, Bruno Meneguele wrote:
> Rename ChargeOption macros to match the others for ChargeCurrent and
> ChargeVoltage and also separate the command & masks macros from the bits =
of
> interest macros for each command.  This macro doesn't introduce any
> functional change, only code re-org.
>=20
> Signed-off-by: Bruno Meneguele <bruno.meneguele@smartgreen.net>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq24735-charger.c | 27 ++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/suppl=
y/bq24735-charger.c
> index b5d619db79f6..3ce36d09c017 100644
> --- a/drivers/power/supply/bq24735-charger.c
> +++ b/drivers/power/supply/bq24735-charger.c
> @@ -31,9 +31,8 @@
> =20
>  #include <linux/power/bq24735-charger.h>
> =20
> -#define BQ24735_CHG_OPT			0x12
> -#define BQ24735_CHG_OPT_CHARGE_DISABLE	(1 << 0)
> -#define BQ24735_CHG_OPT_AC_PRESENT	(1 << 4)
> +/* BQ24735 available commands and their respective masks */
> +#define BQ24735_CHARGE_OPT		0x12
>  #define BQ24735_CHARGE_CURRENT		0x14
>  #define BQ24735_CHARGE_CURRENT_MASK	0x1fc0
>  #define BQ24735_CHARGE_VOLTAGE		0x15
> @@ -43,6 +42,10 @@
>  #define BQ24735_MANUFACTURER_ID		0xfe
>  #define BQ24735_DEVICE_ID		0xff
> =20
> +/* ChargeOptions bits of interest */
> +#define BQ24735_CHARGE_OPT_CHG_DISABLE	(1 << 0)
> +#define BQ24735_CHARGE_OPT_AC_PRESENT	(1 << 4)
> +
>  struct bq24735 {
>  	struct power_supply		*charger;
>  	struct power_supply_desc	charger_desc;
> @@ -167,8 +170,8 @@ static inline int bq24735_enable_charging(struct bq24=
735 *charger)
>  	if (ret)
>  		return ret;
> =20
> -	return bq24735_update_word(charger->client, BQ24735_CHG_OPT,
> -				   BQ24735_CHG_OPT_CHARGE_DISABLE, 0);
> +	return bq24735_update_word(charger->client, BQ24735_CHARGE_OPT,
> +				   BQ24735_CHARGE_OPT_CHG_DISABLE, 0);
>  }
> =20
>  static inline int bq24735_disable_charging(struct bq24735 *charger)
> @@ -176,9 +179,9 @@ static inline int bq24735_disable_charging(struct bq2=
4735 *charger)
>  	if (charger->pdata->ext_control)
>  		return 0;
> =20
> -	return bq24735_update_word(charger->client, BQ24735_CHG_OPT,
> -				   BQ24735_CHG_OPT_CHARGE_DISABLE,
> -				   BQ24735_CHG_OPT_CHARGE_DISABLE);
> +	return bq24735_update_word(charger->client, BQ24735_CHARGE_OPT,
> +				   BQ24735_CHARGE_OPT_CHG_DISABLE,
> +				   BQ24735_CHARGE_OPT_CHG_DISABLE);
>  }
> =20
>  static bool bq24735_charger_is_present(struct bq24735 *charger)
> @@ -188,14 +191,14 @@ static bool bq24735_charger_is_present(struct bq247=
35 *charger)
>  	} else {
>  		int ac =3D 0;
> =20
> -		ac =3D bq24735_read_word(charger->client, BQ24735_CHG_OPT);
> +		ac =3D bq24735_read_word(charger->client, BQ24735_CHARGE_OPT);
>  		if (ac < 0) {
>  			dev_dbg(&charger->client->dev,
>  				"Failed to read charger options : %d\n",
>  				ac);
>  			return false;
>  		}
> -		return (ac & BQ24735_CHG_OPT_AC_PRESENT) ? true : false;
> +		return (ac & BQ24735_CHARGE_OPT_AC_PRESENT) ? true : false;
>  	}
> =20
>  	return false;
> @@ -208,11 +211,11 @@ static int bq24735_charger_is_charging(struct bq247=
35 *charger)
>  	if (!bq24735_charger_is_present(charger))
>  		return 0;
> =20
> -	ret  =3D bq24735_read_word(charger->client, BQ24735_CHG_OPT);
> +	ret  =3D bq24735_read_word(charger->client, BQ24735_CHARGE_OPT);
>  	if (ret < 0)
>  		return ret;
> =20
> -	return !(ret & BQ24735_CHG_OPT_CHARGE_DISABLE);
> +	return !(ret & BQ24735_CHARGE_OPT_CHG_DISABLE);
>  }
> =20
>  static void bq24735_update(struct bq24735 *charger)
> --=20
> 2.31.1
>=20

--ay3hu2slrqbfq2lf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmEWmeUACgkQ2O7X88g7
+pojqw/8D02O/nqnfBLzGbC/szuhXuvSNNjch3qGxCdcRxQ8nRkRqP27/jxFlzVG
KTZpywsMek/txT+EoUuMawWpD/VtdDj6X2nvGAnmXLV8+S6/wVSSLRzJoba3QOWt
AddeNNB/yuJDiDssRBMcFDyFyr7iFvg+jlGtgdtDRCzJ79MeEVNdFU5OlBnarHn9
o4B9HLys1eUXDYqAmADXFFm16Q3S90tuHdzjxEfITlXxQHicCPevGmJ07s8kw+/5
p0RmAWBjOQA42bo9tPJTJ0cdds3YTIyzhzZEuuNF6B7f+cYRoVYkoMWnVqF/LjmL
UXR1frqHu7HxB254N2MnYfUkM0viaR9x5F1LW7BZG2NiZzbK4uh2KRQ87c/EWdKd
uWt4Cebk2Ma5voAAFBZBGbo7nNdGbqWuOpM3f9QPH7QcXcqSWQ/KQF212X8G7uGk
gVWqBDGYRg4/a8SVORFPkSDsMfIGvBc5DYraFVydU9hoBqDKHRVGfHQwYtnmmFhj
gRaKChxeJva8UT9ZiGpETGYMlFcp8wzT/p6PcEFqO56tO2eJsbLbsPfWKDEGHWwV
U31mNHyMpdjPl7whlmoGUqyxgN0bQoHTspjCuEaDzc1H86WKLRDnHuVjxk6vClrE
4RVI2jg/D0xas7OIP/UPDLS3StzGI83ETb+nEnKFG0mzDUO3j7U=
=35pV
-----END PGP SIGNATURE-----

--ay3hu2slrqbfq2lf--
