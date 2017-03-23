From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 5/7] power: supply: bq24190_charger: Don't spam the
 logs on charger plug / unplug
Date: Thu, 23 Mar 2017 12:17:14 +0100
Message-ID: <20170323111713.4drgrikoxdvlsmma@earth>
References: <20170322145536.30570-1-hdegoede@redhat.com>
 <20170322145536.30570-6-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="owadzwyn6fey4a2c"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751510AbdCWLRT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Mar 2017 07:17:19 -0400
Content-Disposition: inline
In-Reply-To: <20170322145536.30570-6-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>, Tony Lindgren <tony@atomide.com>


--owadzwyn6fey4a2c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 22, 2017 at 03:55:34PM +0100, Hans de Goede wrote:
> If the charger gets unplugged before the battery is fully charged we will
> get a one time Input fault. Ignore this rather then logging a message for
> it. Likewise on the next interrupt after the one time Input fault all
> fault flags will be 0, do not log a message when there are no faults.
>=20
> This fixes messages like these getting logged on charger unplug + replug:
> bq24190-charger 15-006b: Fault: boost 0, charge 1, battery 0, ntc 0
> bq24190-charger 15-006b: Fault: boost 0, charge 0, battery 0, ntc 0
>=20
> Cc: Liam Breck <kernel@networkimprov.net>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -This is a new patch in v2 of this patch-set
> ---

Thanks, queued.

-- Sebastian

--owadzwyn6fey4a2c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljTrrkACgkQ2O7X88g7
+pqEUA//aP7c5X/LWvYVoXRFG1TvhP2zkcUoqcMdh3YRcgas9nqpr4TCmZ8EanwC
E+rQxD32llO0DI+tLzbh4B3IcEg904Qw4bh/D6UE3fZTuc/nYMRm3gkJbD5iXtT5
zpqXQ8wGxyp9Xs+rI7pJjQzOtSm1X/oWjqQkZ3TOc3IAgux6Ft1pKLWbzFxRcILX
WMYLyQSlOXTAG9EgR0cjRFndZ8xkl6jbv0u55GrPfv57OOVwIKyLPnW6u7kvXfhQ
HhTimqunO8tdFmfWM9WMJ9O4eQQ+Rp0R40Ow97JewaysVWgBFxXyeNokxm2HLEmE
ARPEIFGxxd5GOdeGe1HDg6A9UtA6sru+0leeim5y5CTqK6T5phqlRJfP3iEdY8J9
4gi1598YRdlF4aH9fn+flxBW+7Z4No4uxOMN8bjXKqwCP6eak4SbWHvjPBeUQR53
DjBUhTys9YXkYhgvVguq8qUbhdPrpuCTq8IIR26x/AjSEaEb4jPdyk2jdjEfGHY7
TR2YIVpHaZ9U6W/khIshgoLYGTYjYkSS4FNHL9+6pwhI/HzmYnydK4GDb2y5vmWj
Hr5ghbTjys8kveDAr9rZpraKv5eLNJxO6iV5b9BFuHOB7AzdM31xJiYVu5kio+wZ
uyCQT//AjQRoSlxlSkCeUIoHDxUMX/iXvpVctfP4xm4Gwv1flnM=
=zHVt
-----END PGP SIGNATURE-----

--owadzwyn6fey4a2c--
