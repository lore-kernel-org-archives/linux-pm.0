From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v3 08/11] power: supply: bq24190_charger: Export 5V boost
 converter as regulator
Date: Wed, 30 Aug 2017 18:32:27 +0200
Message-ID: <20170830163227.ew3jon24s3mdajiv@earth>
References: <20170830094814.17758-1-hdegoede@redhat.com>
 <20170830094814.17758-9-hdegoede@redhat.com>
 <20170830144649.GF6008@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ysqxn6cyw6biivfy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170830144649.GF6008@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Liam Breck <liam@networkimprov.net>, linux-pm@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-pm@vger.kernel.org


--ysqxn6cyw6biivfy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 30, 2017 at 07:46:50AM -0700, Tony Lindgren wrote:
> * Hans de Goede <hdegoede@redhat.com> [170830 02:49]:
> > Register the 5V boost converter as a regulator named "usb_otg_vbus".
> >=20
> > This commit also adds support for bq24190_platform_data, through which
> > non device-tree platforms can pass the regulator_init_data (containing
> > mappings for the consumer amongst other things).
> >=20
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>=20
> This will make it easy for USB PHY drivers to implement USB host mode:
>=20
> Acked-by: Tony Lindgren <tony@atomide.com>

Thanks, queued.

-- Sebastian

--ysqxn6cyw6biivfy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmm6JgACgkQ2O7X88g7
+prGjg/+JaamhKJCKsMpNmHofemdPOvZlbmiMMGxLh6fh8CF9+xsNfyNPpHxDz9T
IOzj5BnFJh+HyPSvxzpI44SUvmGpiUg9KTZObpnrt9aJRxX98llfj/t0t0x5jivH
L+t0qCBk6sF5HSdan0HIpdWQisilBIeDDDYAtxZRD+7K5Tg+P2jHyJMFiD1f2f7o
ZYClCteNHtFfFyMSKnphSnJGQEYVGYc1KzwUIxhpvre5W1tfoJtRn7muux+pGQYl
P0LH1uOLL68QN9tvn66G3VnvlGfkGWeoew7PzxeaRofNO8PG9o+4KnMqqcif3C/e
Q6lSQ0rnXzrNmgmU66V3pBCvVp0z6x6yIFg/+VG62sW32yP49OA2PHtOq1whCnI3
UagpSZYQKvwMlPUKOMpP8H7A/lTwujUCP7zBnmCXlN6/gvqCVhdhlMuKHzc1xM+E
6jD8EOs8yrBqsXoyyxfCEFgs1CSzXbmLjYCVTeVOg8EbTkkuiml5WFhSCyTbG99r
vJ8oBl1nrXQvCnS5VUdXP3fRIsd45lnqZ6DsWT4IxaTSC6HZe2NOkSusUvrXn790
sf3CyXjdg8gSgxDam03VTRzZdWmBIQgrMr0mehF2YXa2xylOdjnGvXjoBl5eJ/Ei
qcNfW7qrRigIjQjb3fiPxcqZE1BbwsD41TnB6GYep9YaatWimfg=
=0Sj2
-----END PGP SIGNATURE-----

--ysqxn6cyw6biivfy--
