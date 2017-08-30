From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v3 09/11] power: supply: bq24190_charger: Get
 input_current_limit from our supplier
Date: Wed, 30 Aug 2017 18:32:54 +0200
Message-ID: <20170830163253.ay6qjpld5i2bwmgs@earth>
References: <20170830094814.17758-1-hdegoede@redhat.com>
 <20170830094814.17758-10-hdegoede@redhat.com>
 <20170830144746.GG6008@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t2ce6ual62q36b7d"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170830144746.GG6008@atomide.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Liam Breck <liam@networkimprov.net>, linux-pm@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-pm@vger.kernel.org


--t2ce6ual62q36b7d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 30, 2017 at 07:47:46AM -0700, Tony Lindgren wrote:
> * Hans de Goede <hdegoede@redhat.com> [170830 02:49]:
> > On some devices the USB Type-C port power (USB PD 2.0) negotiation is
> > done by a separate port-controller IC, while the current limit is
> > controlled through another (charger) IC.
> >=20
> > It has been decided to model this by modelling the external Type-C
> > power brick (adapter/charger) as a power-supply class device which
> > supplies the charger-IC, with its voltage-now and current-max represent=
ing
> > the negotiated voltage and max current draw.
> >=20
> > This commit adds support for this to the bq24190_charger driver by addi=
ng
> > an external_power_changed callback and calling
> > power_supply_set_input_current_limit_from_supplier from this callback.
> > This callback will only get called if the bq24190 has a parent-supply.
> >=20
> > Note this replaces the functionality to get the current-limit from an
> > extcon device, which will be removed in a follow-up commit.
> >=20
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>=20
> Acked-by: Tony Lindgren <tony@atomide.com>

Thanks, queued.

-- Sebastian

--t2ce6ual62q36b7d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmm6LUACgkQ2O7X88g7
+po7lxAAkCj3GJhbz6mqDmbPlklpZ+xO1THvQXSo7E6ZSCXpyysl2cGqGdBJ6jHs
UDjtnozsCFjsJK7cPohB40GYJ1v0q5r21ewAa9QQh6F6jrXpAP8xMIvFNgxriOIP
4VseYXwYrVHGZETumbAi2b22EBtFrvwij/VmKkdyAoq4WkmG7AV1k4+DBum2kK+P
Qb7fqarmuNvnA1DjhBvMgXf4pz3PRQobPjOrEoOI3QB/eA4Su/dbWdJVbkOs+B+I
l9Z44LnSt/CV5IBy5EJRvr1UaqFWQUV2aI1JE5lGzOf4T2mT2zkLj5fs98w+9gxo
MVWU6+6uhjwwJapZWrZfUFaSw7ump0kd1/pHNxysfcVRjG69gskwwmVagBWTzSfn
So9xybn9rbdlAjr/mdSzj9/FrL/uvgqIdvHQq2SwWqzAOJvfVvFzY60XBjHLTgEs
F7+nmYIUIaFaVPZyk/Ti05lwBOR6yCekdlxAea4rr7JIH23jlFwRKdjmlsQwafBI
6vo6/ktp/GP8lk7IWLtZ9lanLuW7Od0hMcvFgQRrdMw0GK0/lOIIzymked3NJ9Ue
t3b2YsMhEi1SOPCtJEc2568KFWZZISlb1Gm7SZJk7rjwhnx+vfzEnVnPfguaQohI
cW8MNqPIVd9/7cTlTrMSX3PARiYKTX92cLuo4KlN1uPv5WRekb0=
=WIkY
-----END PGP SIGNATURE-----

--t2ce6ual62q36b7d--
