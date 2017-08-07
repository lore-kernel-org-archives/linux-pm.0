From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 10/18] staging: typec: fusb302: Add support for
 fcs,vbus-regulator-name device-property
Date: Mon, 7 Aug 2017 16:41:52 +0100
Message-ID: <20170807154152.wt5b4y3s3oe4cnam@sirena.org.uk>
References: <20170806123555.5124-1-hdegoede@redhat.com>
 <20170806123555.5124-11-hdegoede@redhat.com>
 <2d04e538-0594-0073-939e-feb6c1a66cdf@roeck-us.net>
 <85c668d5-c6f0-a94c-4dd5-1b425cdff339@redhat.com>
 <20170807111054.4lp5rgc5vpnsmhim@sirena.org.uk>
 <dcbddc43-e581-505e-915b-3bf16b477422@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6206346871107004435=="
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <dcbddc43-e581-505e-915b-3bf16b477422@redhat.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: devel@driverdev.osuosl.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Liam Breck <liam@networkimprov.net>, Guenter Roeck <linux@roeck-us.net>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Andy Shevchenko <andy@infradead.org>, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--===============6206346871107004435==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3xhp6eecqwa65oob"
Content-Disposition: inline


--3xhp6eecqwa65oob
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 07, 2017 at 04:41:18PM +0200, Hans de Goede wrote:
> On 07-08-17 13:10, Mark Brown wrote:

> Problem 1)

> The regulator in question is part of the bq24292i charger-IC attached to
> a private i2c bus between the PMIC and the charger. The driver for the i2c
> controller inside the PMIC which drivers this bus currently also instantiates
> the i2c-client for the charger:

...

> Note that the bq24190 driver is a generic driver, so to pass the
> board specific regulator_init_data to it I would need to somehow
> pass it here, but I don't see how, except by storing a pointer to
> it in an u64 device-property which seems like a bad idea

I2C has a perfectly good platform_data pointer in the board info for
this stuff.

> Problem 2)

> Even if I could add the mapping through regulator_init_data
> then it may well be too late, if the regulator_get happens
> before the bq24190 driver registers its regulator (and thus
> the mapping) the regulator_get for it may have already
> happened and returned a dummy-regulator, or another regulator
> with the rather generic vbus name.

If you don't have control over the instantiation ordering but you have a
firmware which claims to provide a complete description of regulators
then you'd need to add an interface that allows mappings to be
registered separately to regulator registration.

Whatever you're doing the answer isn't to try to specify the name of the
supply through some firmware binding, that's just obviously not sensible
both in terms of a firmware abstraction and in terms of how the
abstractions in Linux work.

--3xhp6eecqwa65oob
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmIij8ACgkQJNaLcl1U
h9BNuwf+PWkLyNaHfN0NiBNfczWsNCL6qAEBsD7KWz+h8eroBWBoJhiS87B3uxwO
dGzmtkpKFY/KcrvjNKmCD4lHJV3D9N9KPxfhQV69q4rWaMyfgelMyUudwvwOpgGL
Vs0e8qxdwtCtnzZdg8dSS7tVMdxBqnnPMRFevlLRFHezriCKbCLT0ckw4yEnZebc
sPMjQuApMZzZ0JBtWNwod4trkK3fJ2MK7QQhD4XpXEDTYPyfYAIs7yBNhtJGgkkM
vbEokYgyXXsQ+u3wcEn8PJSVuK+8AaIrczZcv2lv7cD7jPpk5dK/3QDJeCnjx2Yc
dz8Cc9ZVEljEbXm66bP7lOPccROlrw==
=1mgV
-----END PGP SIGNATURE-----

--3xhp6eecqwa65oob--

--===============6206346871107004435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============6206346871107004435==--
