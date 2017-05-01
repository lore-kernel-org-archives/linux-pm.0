From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v11 04/10] power: power_supply: Add
 power_supply_battery_info and API
Date: Mon, 1 May 2017 17:11:28 +0200
Message-ID: <20170501151128.3lp3udfawwmx76jd@earth>
References: <20170320094335.19224-1-liam@networkimprov.net>
 <20170320094335.19224-5-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bekurqhgy55zewka"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58161 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751115AbdEAPp3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 11:45:29 -0400
Content-Disposition: inline
In-Reply-To: <20170320094335.19224-5-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>


--bekurqhgy55zewka
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 20, 2017 at 02:43:29AM -0700, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
>=20
> power_supply_get_battery_info() reads battery data from devicetree.
> struct power_supply_battery_info provides battery data to drivers.
> Drivers may surface battery data in sysfs via corresponding
> POWER_SUPPLY_PROP_* fields.
>=20
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>

Thanks, queued.

-- Sebastian

--bekurqhgy55zewka
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHUCAACgkQ2O7X88g7
+pqA3g//TEqH3G3TG8DvSY82NjN/VUbEkaaCGjEMqD9vt+7I6Ew3HfUUc97dlx5R
TZK9Qh307X6wIRKGkB+k/ARZyCnKOrBG0JBdWUjEM8cNrE7aR49YZsDGL3c2kYoj
62IWfplsJxpRlbEzwEjImGsheJuWMwiDw830zjTfLiGRrBDcF3P1td+bncOnj18j
W5pl5AYVknbvnFowXKXBkEmyXGnoqqDXgtxtugN6r1PyDWRnlPMk/Pf1q3RBviUk
M+HHc6qeIe95Jcn/vML0UcNPWY4khb3CSbSJ6ndyl6Y4T3vr5OQ1q/OK8zvdCj3x
zLH8HXr19pU9yn/9n7aDoslqVKUek3eXxEgJy0CqkXl5L1UD/WlvwaSl2dBiWQL9
YpH+pBjbVt6Y0I5n4fwJ4oUFkq8WsoLsLJfGJtVvdmAEr3pcVns4+M9/BRbWO+Qv
uk2dhp7RYLS/OyCEAzs5/Va2ISH+jOvfvvUJqd7VURPSSGJtEsIqZOoJvwaueOWx
cvTrlAZLZsfZ+0rDWsfweExVnBkHNettZRinaRoR1E+832yjD0Xg22/qkWzx8+h0
oWOKzSA2JC0SglZaVG4fWaMHP1zwudU4r293AIoQBbDjR7JhwJVxXz2o6TJNtyGx
EK9YxPY8AanSbjezX5PAxMjBD9Ls0qP3AtFw5PYNF0sa9M3TiM0=
=t3tH
-----END PGP SIGNATURE-----

--bekurqhgy55zewka--
