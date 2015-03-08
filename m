From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC 1/4] power_supply: Introduce charging object table
Date: Sun, 8 Mar 2015 02:31:42 +0100
Message-ID: <20150308013142.GA25160@earth>
References: <1425638007-9411-1-git-send-email-jenny.tc@intel.com>
 <1425638007-9411-2-git-send-email-jenny.tc@intel.com>
 <1425640370.2197.0.camel@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35756 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024AbbCHBcK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 7 Mar 2015 20:32:10 -0500
Content-Disposition: inline
In-Reply-To: <1425640370.2197.0.camel@suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Jenny TC <jenny.tc@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Anton Vorontsov <anton.vorontsov@linaro.org>, David Woodhouse <dwmw2@infradead.org>, jonghwa3.lee@samsung.com, myungjoo.ham@gmail.com, Pallala Ramakrishna <ramakrishna.pallala@intel.com>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 06, 2015 at 12:12:50PM +0100, Oliver Neukum wrote:
> On Fri, 2015-03-06 at 16:03 +0530, Jenny TC wrote:
> > +struct psy_temp_mon_table {
> > +	int temp_max;
> > +	int temp_min;
> > +	int charging_current; /* CC */
> > +	int charging_voltage; /* CV */
>=20
> In which units?

First few lines from power_supply.h:

/*
 * All voltages, currents, charges, energies, time and temperatures in uV,
 * =B5A, =B5Ah, =B5Wh, seconds and tenths of degree Celsius unless otherwise
 * stated. It's driver's job to convert its raw values to units in which
 * this class operates.
 */

-- Sebastian

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU+6Z3AAoJENju1/PIO/qa/sEP/ifFjFX2T5rAzXVLBUx3iaTf
HesZ3R6Uqvw9Zj4Dsy3yZi6eE63FXJLvWlQRqXe2ubpf/j8AVwZkyoxwikSmwDMR
uzHLk6yLS/7KmDeVcL9xONi6OCs/mjsjJ4gKlGIHzt6d3YUNpaPqgP8Vlo+EU2XD
frJLILsTzLAG7UDxSSaKMl+Rj2H2Qw++QqOrEGz716jMv9okcl6H6sCuO8T1oggI
m4gT7iul+tJfjJrgMNQ9JH6oYoF+rPXwkt43+AL6LENQM5Sq0S44tHz1CtAt7lDW
fOAufu+YhRA4kVekQaAh1ZFG6QN2OSJbJxSlNLc/C7KQAwzp3bThCOvADq1ebLmR
i68YMA+0w2c9sSsow6rQWQx1YLPUQmcBKz6SpOLzYUmRlT0leqSeS5K/hyMaZfOl
Ho0FIgxta51OFWeOkgL4kQj2RATux07acJTAQg6DWkngqXjyjpKcStJIo8abWnd4
Pj6gfDqjoPiJdo105qgzH6q+XTYQO9EF/31f9+oFbHqSklrlK1pe8yBorZTdpDR+
l1Zkrk61TObfcH79CrcYsYkb2BLKhMD84i4/LP7Js63mqAcImQzq0dbNc4IIXOYp
40/qvatZTu/XunknFHF4lWKU9eW4+WK7T6FwaGWiEUCWGl94r/2dkwy4dJJhCau7
ZV9yx/GQmbyqbqra96AW
=W1hc
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
