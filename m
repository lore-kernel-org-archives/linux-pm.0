From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 10/18] staging: typec: fusb302: Add support for
 fcs,vbus-regulator-name device-property
Date: Tue, 8 Aug 2017 10:39:47 +0100
Message-ID: <20170808093947.ezczjb6stdgek4hy@sirena.org.uk>
References: <5f3d7cfa-c993-0cda-fae6-a975f7d4ca1c@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ujy25oqi53cn24gn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5f3d7cfa-c993-0cda-fae6-a975f7d4ca1c@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-pm@vger.kernel.org


--ujy25oqi53cn24gn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2017 at 09:20:05PM +0200, Hans de Goede wrote:
> On 07-08-17 17:41, Mark Brown wrote:

> > I2C has a perfectly good platform_data pointer in the board info for
> > this stuff.

> True, so you are suggesting that I define a bq24190_platform_data
> struct with a regulator_init_data pointer in there I guess?

Yes. =20

> I don't think the power-supply maintainers will be enthusiastic
> about this (hi Sebastian). But that does make sense and is
> actually a good idea for tackling the problem of regulator_init_data.

Why not?  This is just really standard usage of platform data.

> Would extending the struct regulator_map with a const char *provider_name:

> struct regulator_map {
>         struct list_head list;
>         const char *dev_name;   /* The dev_name() for the consumer */
>         const char *supply;
>         struct regulator_dev *regulator;
> 	const char *provider;	/* The dev_name() for the regulator parent-dev */
> };

Please don't invent new terminology like this.  Just call it a regulator
name.

> Alternatively the entry could additionally contain a provider_supply_name
> so that we can make arbitrary consumer-dev-name + consumer-supply-name
> provider-dev-name + provider-supply-name matches. That would probably
> be more flexible then requiring the supply name to match.

I'm sorry but I can't follow what you mean here.  What do you mean by
"provider_supply_name"?

--ujy25oqi53cn24gn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmJhuIACgkQJNaLcl1U
h9BGaAf+LfNpR+egdlA8mhuvZKvRfRMpSLj3MJmOAgN+nMwlvJvp7fXnGRfmnwCO
QY6hxGv4Ty3bA3FKnOagmeHves1tQTIkIJJkm7iOkXx+xzFXbi33PuoI3+VrSPXO
/hKepOXFZfkKRvZKEZMZjz8CQC+qSjTf1JtpDbQ5GPBCTHklhIfntU9mtS5UxJ+V
QYTL80l75NhlsNKMNGyxJHq8iho671pU+rEzBugkV84vROYjU0OxLYjsy0Jf1pdM
p7hqw68epC6S86LpE2H02J2zHUvhUTE887y95lV+UKwydKkDZD9VohqMIkGadF5a
c8rEB0ysFBkOEOMXvE4YkIH2qCINrw==
=u3k9
-----END PGP SIGNATURE-----

--ujy25oqi53cn24gn--
