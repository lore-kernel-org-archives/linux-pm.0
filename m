From: Sebastian Reichel <sre@kernel.org>
Subject: Re: Status of merging "power: supply: axp288_fuel_gauge: Drop
 platform_data dependency" patch ?
Date: Sat, 24 Dec 2016 19:50:41 +0100
Message-ID: <20161224185041.74mq4gsz7aoqnv55@earth>
References: <13747ac6-ff54-6e0b-1992-6d020209c58f@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ejy6n4pwwqgdyedo"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932780AbcLXSur (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 24 Dec 2016 13:50:47 -0500
Content-Disposition: inline
In-Reply-To: <13747ac6-ff54-6e0b-1992-6d020209c58f@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-pm@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, "russianneuromancer@ya.ru" <russianneuromancer@ya.ru>


--ejy6n4pwwqgdyedo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 23, 2016 at 10:13:45PM +0100, Hans de Goede wrote:
> Thank you for merging all the axp288_charger patches into for-next-next.
>
> When I posted the "power: supply: axp288_fuel_gauge: Drop platform_data d=
ependency"
> patch about a week ago you replied that it looked good, but you wanted to=
 give
> others a chance to respond. So I wonder what he status on this is now ?
>
> In the mean time I've tested it successfully on another model cherrytrail
> tablet with an axp288 pmic, and one of the people following:
>=20
> https://bugzilla.kernel.org/show_bug.cgi?id=3D88471
>=20
> Has tested it on yet another model, so from a testing pov it looks good.
>
> I realize we still have a lot of time to get this merged for 4.11, just
> making sure it does not fall through the cracks.
>
>=20
> Regards,
>=20
> Hans
>=20
>=20
> p.s.
>
> Today you replied to:
>=20
> "power: supply: axp288_fuel_gauge: Remove unnecessary irq?_en register wr=
ites"
>=20
> That you merged it, but I don't see it in for-next-next, I guess it did n=
ot
> apply without the $subject patch?

I got confused with axp288_fuel_gauge vs axp288_charger and similar
patch names :) Everything should be merged now. Please complain if
you think anything is missing.

-- Sebastian

--ejy6n4pwwqgdyedo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhew3oACgkQ2O7X88g7
+prVMA//aNi6k0M5NSOyVUkN7VM0ZelyR5Cee3CIYdMPoUqoPn5XPo7NFQGO5bXn
pg3yfvcjJ7XNcPSU8z6aZAkjeeJueTJ5P27lI82IZFVaVlsplJ0O0ySWRHxeH7Lj
2fjoiCzy68lRz8bwjcUWtV58mRoWjMyslak6QtM0fZLcKVFvuEyV15GTQ8KfaFUI
A58f6dFtc0lhaVaM1JarlVNnVzuw/F3w98Rdww1cjT7xYgslrWmx6n7QmPwCGTXD
LVDoQUr+VpPUaXBVjd6h5aFqidFAaMf1WnwgQzxrQE1GSepTNpPQLMAU8LP3sLYt
tzDYLWeZ6/+IsfIBQwto2RRcaiPOA9tECqNNV4rC139exbdMUNbLaWvV8FY4RgRj
lWnRpTuMz2uX2fy7tZHtsgL6qzqNTH28p8w6ZK/hulZSsEiwhnRbzVb/Fq648BO9
3hKuGQspe2UaY2bHUtl8AudbHB92AaAaiO9EKQ1hOZunBGD8an0UedN/wUj07wSw
8nua+k8qJEvPQBJdpRsgwExb5LXl7078n7DalgUcZhFP07uPyyVKkJ+M2MM563GG
DMWksXbCKDEJAv7ToLEDaJIjEHhfXPIZkbXnvs8XbnCOQ2hreXbQBfvaaBt0Lell
TkS4Fc/y2ODSxUAyts65CRHXi09H0khEGgLODOPDddcVt0ORUIU=
=Zhcx
-----END PGP SIGNATURE-----

--ejy6n4pwwqgdyedo--
