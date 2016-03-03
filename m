From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power_supply: 88pm860x_charger: do not pass NULL to
 power_supply_put
Date: Thu, 3 Mar 2016 15:21:30 +0100
Message-ID: <20160303142129.GD29689@earth>
References: <1456689478-7318-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RhUH2Ysw6aD5utA4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456689478-7318-1-git-send-email-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sun, Feb 28, 2016 at 07:57:58PM +0000, Colin King wrote:
> In the case where power_supply_get_by_name returns NULL the current
> error return path calls power_supply_put with a NULL psy which will
> cause a null pointer dereference.  Avoid this with an immediate
> return.

Thanks, queued.

-- Sebastian

--RhUH2Ysw6aD5utA4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW2EhpAAoJENju1/PIO/qadcIQAKOwD6YX/+Ll8wHidQkBUfp6
OyfkhEyILzUK8b/vYCjdhd3vkRc4qFzmih68AAunSOvrtL9B61Gnkn9ZxVdmU/zF
EeFbuI6B+cgBixigYJ0T+CXTyjYiKFwvPzB9detvtlK+EpuJGr26ubn4moJurKqv
GIjh61wQ7JQJovUHy5alP17tVQ2O1U5hb+jXa04hlvlKJQqp3Q5EhssNz0yxGDjl
9TzM7MUOrutt1nF7C2WpPd869ZDZs66vzqAv+V8sJ37G/Uu5gIH3jJxYSCYGpAAP
soeOXsMY6BaK+oVJ4ZyIKGnDkh3FQp/OiZ8e+Lj3qmkQxsTNQvqxWQcN29Jb4fSN
A0tftT0NZsumL7+cHIk/MNfj8/BVQsD8xtTs6FsPLWJKt1nbenazAQgoGwUpMyqG
sqPzOhfPET1/PCTrhvq+xOtsVqMeja/3DMpwnyhZXIX7efsLXw3ZxrT0M68xLMMX
Z1p0xeSfIh0qtl8l4ha0asFahmg5+EAminiJ/j6x7NaV+4BCIpnIKrgM9HZL62S6
wIlXAlJATOu11eOOyRNruBsjgpSiVtW1sgE4D/0bHc6PCnMLNyoAEvX2YMMd4Dj1
aA2sIlxClCaKh587bUXVJSeGUC1Pd84cKMtdh/H/27mRCIIb3YfPzxOzv7yLhuPP
l4tsvLzShiW445XZikcx
=HFbD
-----END PGP SIGNATURE-----

--RhUH2Ysw6aD5utA4--
