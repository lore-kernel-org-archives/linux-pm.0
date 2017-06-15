From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v14 09/11] power: supply: bq27xxx: Enable data memory
 update for certain chips
Date: Thu, 15 Jun 2017 18:02:18 +0200
Message-ID: <20170615160218.sq5jychjn7x2dhyq@earth>
References: <20170607183759.20261-1-liam@networkimprov.net>
 <20170607183759.20261-10-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ikzm2nxuzyhhosk2"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45446 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751789AbdFOQCW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Jun 2017 12:02:22 -0400
Content-Disposition: inline
In-Reply-To: <20170607183759.20261-10-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Pali Rohar <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, Enric Balletbo <enric.balletbo@collabora.com>, Paul Kocialkowski <contact@paulk.fr>, Quentin Schulz <quentin.schulz@free-electrons.com>, Liam Breck <kernel@networkimprov.net>


--ikzm2nxuzyhhosk2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Jun 07, 2017 at 11:37:57AM -0700, Liam Breck wrote:
>  static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
> -	{ "bq27200", BQ27000 },
> -	{ "bq27210", BQ27010 },
> -	{ "bq27500", BQ2750X },
> -	{ "bq27510", BQ2751X },
> -	{ "bq27520", BQ2751X },
> -	{ "bq27500-1", BQ27500 },
> -	{ "bq27510g1", BQ27510G1 },
> -	{ "bq27510g2", BQ27510G2 },
> -	{ "bq27510g3", BQ27510G3 },
> -	{ "bq27520g1", BQ27520G1 },
> -	{ "bq27520g2", BQ27520G2 },
> -	{ "bq27520g3", BQ27520G3 },
> -	{ "bq27520g4", BQ27520G4 },
> -	{ "bq27530", BQ27530 },
> -	{ "bq27531", BQ27530 },
> -	{ "bq27541", BQ27541 },
> -	{ "bq27542", BQ27541 },
> -	{ "bq27546", BQ27541 },
> -	{ "bq27742", BQ27541 },
> -	{ "bq27545", BQ27545 },
> -	{ "bq27421", BQ27421 },
> -	{ "bq27425", BQ27421 },
> -	{ "bq27441", BQ27421 },
> -	{ "bq27621", BQ27421 },
> +	/* dest.    di->real_chip       di->chip      */
> +	{ "bq27200",   (BQ27000   << 16) |  BQ27000   },
> +	{ "bq27210",   (BQ27010   << 16) |  BQ27010   },
> +	{ "bq27500",   (BQ2750X   << 16) |  BQ2750X   },
> +	{ "bq27510",   (BQ2751X   << 16) |  BQ2751X   },
> +	{ "bq27520",   (BQ2752X   << 16) |  BQ2751X   },
> +	{ "bq27500-1", (BQ27500   << 16) |  BQ27500   },
> +	{ "bq27510g1", (BQ27510G1 << 16) |  BQ27510G1 },
> +	{ "bq27510g2", (BQ27510G2 << 16) |  BQ27510G2 },
> +	{ "bq27510g3", (BQ27510G3 << 16) |  BQ27510G3 },
> +	{ "bq27520g1", (BQ27520G1 << 16) |  BQ27520G1 },
> +	{ "bq27520g2", (BQ27520G2 << 16) |  BQ27520G2 },
> +	{ "bq27520g3", (BQ27520G3 << 16) |  BQ27520G3 },
> +	{ "bq27520g4", (BQ27520G4 << 16) |  BQ27520G4 },
> +	{ "bq27530",   (BQ27530   << 16) |  BQ27530   },
> +	{ "bq27531",   (BQ27531   << 16) |  BQ27530   },
> +	{ "bq27541",   (BQ27541   << 16) |  BQ27541   },
> +	{ "bq27542",   (BQ27542   << 16) |  BQ27541   },
> +	{ "bq27546",   (BQ27546   << 16) |  BQ27541   },
> +	{ "bq27742",   (BQ27742   << 16) |  BQ27541   },
> +	{ "bq27545",   (BQ27545   << 16) |  BQ27545   },
> +	{ "bq27421",   (BQ27421   << 16) |  BQ27421   },
> +	{ "bq27425",   (BQ27425   << 16) |  BQ27421   },
> +	{ "bq27441",   (BQ27441   << 16) |  BQ27421   },
> +	{ "bq27621",   (BQ27621   << 16) |  BQ27421   },

This is ugly. The proper way to do this is by providing a pointer
to a structure with all required information. E.g.:

static const struct bq27xxx_pdata chip_info_bq27530 {
    .reg_layout = &reg_info_bq27530,
    .feature = false,
    /* more stuff */
};

static const struct bq27xxx_pdata chip_info_bq27531 {
    .reg_layout = &reg_info_bq27530,
    .feature = true,
    /* more stuff */
};

/* ... */

static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
/* ... */
{ "bq27530", &chip_info_bq27530 },
{ "bq27531", &chip_info_bq27531 },
/* ... */
}

-- Sebastian

--ikzm2nxuzyhhosk2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllCr4QACgkQ2O7X88g7
+prP6A//W04rzXmgc7yz5X5C8tAEq+u+CmjIAZgMgVEVs0adCX015odoRYTSgyLP
eUnydlszrnIlXh1SJi97hToqtYuGMvI0cmH12qTSBhpBkClX94mSmoM0gciLPFjK
8UYOqKJpq+KhqC6qowDtSwN6ZtDNK9hU1EY3NhlxOJ0PCU72Q8RqsvkZSo7HTy26
hY3C5UtLcUgeYQHKLsXQRgtKNXLIkJ0h6Pj4Z91q6m/0H+C1ORHbdrWcvCZ5McOo
GMct2jRE2LtfFrK41Nm1kXAt1ZjR1EqjsobCsNOsfxGkZiRv3iQZHEmhfwBGeqUZ
M0l/zlPhLUkLFUcX40oEHqUPHxzTyg7eKr/+HX+V8poVh+KYIXtRKsbPeUQRr2lJ
81H8QKjFsZDu8V/zqkA4SRGXhNMFu2yHCPflsoOh1qgjkdDhLyM/W0HgF/+y6Izy
0QqFCtF9V6HUQeLN8L2ObrUtta7JcjkF99V1wlYk6lGIGvDdV/IL6QX7JnoD0uYn
P2C/OIWqZP9CUcKc2+XWl7spN/7USFjcclfQv0K556Bey93bW0jD8WhAcN2EZkL/
tXK8/GhOca+WZz5LeiiVgyOZIBi8tApOrCW/icxaJmbDxs+0BmIG9pWEk0TNH3/y
bZ3wZ4yxNKwpOZwT8c868yf94zA01j74+iwnezukm4wwCPYicfc=
=F0ws
-----END PGP SIGNATURE-----

--ikzm2nxuzyhhosk2--
