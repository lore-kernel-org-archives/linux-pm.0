From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: bq24735 charger and ac-detect
Date: Wed, 14 Dec 2016 15:59:51 +0100
Message-ID: <20161214145951.uuoijetzat2bxmbv@earth>
References: <d796f6f9-1b6a-647c-100b-b3e85fc2f4c0@axentia.se>
 <20161214142502.su4auesnlqmgxspv@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qwhxxahzxg3qxq3v"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161214142502.su4auesnlqmgxspv@earth>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--qwhxxahzxg3qxq3v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Ok, Darbha Sriharsha's mail address no longer works, so I Cc'd
linux-tegra instead. Maybe some of the people there have the
schematics for one of the Tegra boards using the bq24735 and/or
could check if charger presence detection actually works on
those boards with current mainline kernel.

-- Sebastian

On Wed, Dec 14, 2016 at 03:25:02PM +0100, Sebastian Reichel wrote:
> Hi Peter,
>=20
> On Mon, Dec 12, 2016 at 12:12:47AM +0100, Peter Rosin wrote:
> > Hi!
> >=20
> > I'm wondering about the dt bindings for the bq24735 charger. Specifical=
ly
> > the ac-detect property. The bindings say:
>=20
> I don't have a device with bq24735 and the driver has been added
> before I was the maintainer of the power-supply subsystem.
>=20
> >  - ti,ac-detect-gpios : This GPIO is optionally used to read the AC ada=
pter
> >    presence. This is a Host GPIO that is configured as an input and
> >    connected to the bq24735.
> >=20
> > The only way I can make sense of that is if this is the pin on the bq24=
735
> > that is named ACOK.
>=20
> Yes. I would expect the same.
>=20
> > But that pin is active high, and the code has this:
> >=20
> > static bool bq24735_charger_is_present(struct bq24735 *charger)
> > {
> > 	if (charger->status_gpio)
> > 		return !gpiod_get_value_cansleep(charger->status_gpio);
> > ...
> >=20
> >=20
> > (status_gpio is what holds the gpio_desc of ac-detect)
> >=20
> > In other words, the code seems to want a signal that is effectively
> > active low (the code negates the signal and thus returns "present"
> > when the signal is zero). The existing dts users all have active high
> > in their bindings, so it's not like they say active low to work around
> > the negation in the code...
> >=20
> > This just makes no sense to me and I'm wondering what I'm missing and
> > what pin is really meant to be fed to ac-detect???
> >=20
> > Yes, there is a pin on the bq24735 that is named ACDET which seems like
> > a good match, but that is a signal that is entering the bq24735. And it
> > is also active high, at least the way I read it so the problem persists=
=2E..
> >=20
> > Cheers,
> > Peter
>=20
> As far as I can see all current users are Tegra boards and the
> driver is also from Nvidia, so let's ask them directly. I guess
> the driver was ported incorrectly and the "!" should be removed.
>=20
> -- Sebastian



--qwhxxahzxg3qxq3v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhRXmQACgkQ2O7X88g7
+pq6fQ/8CrznY73hQRm+XJj7nrX9rcgOuuE7Y5QNioqGjJmULaQpx4Oh82vjFu7d
rpGCYbSS/aDZHNQ7oqzl+fXJcXWmw6L56/6FBaSITBXDMQN0J5gVWdyIOQ6z25bU
HPP0CumvQ5w0zAVuEVi/l7KZjqYsRR9yb2c2TmgwyJ4JCCpDlsjk+8q4yIYEDPv0
pJguu762hiq/7cLeFeU8XP8gChcX3CkXmd+8y2O+dCCvRNhOHoOeLf2pr287P204
OdzXSj3rB/qYeHBnrNB3IEaSWOKrWIMnkdcxspVCZ8IUEP9+IRN46y70kyqQjM5y
LAXDcVkJXYhRTc39ES1JN7tK33T2z0mbnzX8+Bn7w1RdPeS6k4Qv4huJf06DltLO
do9yvtAhBk+MX6RKQkV+1lb3FBG9pJ/kRIw+oGRdsGpY2z1cWwHr22TUN6W6EmF4
V2CawC9ehf20v888P0kvHQhQLLGI/jytknTDn+rW0ZyeWOY45OJiE9J5z8krlaHQ
hqEXgUV0JBl5E8z/uZtxyXttfmmbbJGkOu2SGxstUSszBxAYQ6DauQN+qHcQu4w8
D4HeZbOQq9439MzJVu7MX2pcjcmLwXaP9G0f6USpVhM/9pLXcs04Js/odIqKN44W
P5+rKUurdlHEpy6BnSV8AGPg7PrCOhzfIxPp0+/pD/W2RPlug80=
=Srg5
-----END PGP SIGNATURE-----

--qwhxxahzxg3qxq3v--
