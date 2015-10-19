From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 3/3] power: bq27xxx_battery: fix defined but not used
 warnings
Date: Mon, 19 Oct 2015 11:37:22 +0200
Message-ID: <20151019093721.GA11028@earth>
References: <1445003052-31373-1-git-send-email-sre@kernel.org>
 <1445003052-31373-4-git-send-email-sre@kernel.org>
 <20151016144705.GG28216@pali>
 <5621114D.7010002@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5621114D.7010002@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2015 at 10:01:33AM -0500, Andrew F. Davis wrote:
> On 10/16/2015 09:47 AM, Pali Roh=E1r wrote:
> >On Friday 16 October 2015 15:44:12 Sebastian Reichel wrote:
> >>If BQ27XXX is enabled, but neither I2C based initialization, nor
> >>platform based initialization are activated, bq27xxx_powersupply_init
> >>and bq27xxx_powersupply_unregister are defined but not used.
> >>
> >>This configuration doesn't make sense, but there is no easy way
> >>to make it unavailable in the build system, so just mark the
> >>functions as __maybe_unused instead.
> >>
> >
> >What about?
> >
> >#if defined(CONFIG_1) || defined(CONFIG_2)
> >#define NEED_POWER_SUPPLY
> >#endif
> >
> >And then wrap power supply code into #ifdef NEED_POWER_SUPPLY?

I thought about wrapping the whole code in an ifdef, but I don't
think compiling an empty file is any better than adding the
__maybe_unused flag.

> We would need to wrap everything in that then, so without I2C or
> platform enabled we end up compiling an empty file. I think the
> better fix would be to modify the Kconfig, something like:

Handling this in Kconfig is preferred of course.

> config BATTERY_BQ27XXX
> 	tristate
> 	depends on (BATTERY_BQ27XXX_I2C || BATTERY_BQ27XXX_PLATFORM)
> 	default y
>=20
> config BATTERY_BQ27XXX_I2C
> 	bool "BQ27200/BQ27500 support"
> 	depends on I2C
> 	help
> 	  Say Y here to enable support for batteries with BQ27x00 (I2C) chips.
>=20
> config BATTERY_BQ27XXX_PLATFORM
> 	bool "BQ27000 support"
> 	help
> 	  Say Y here to enable support for batteries with BQ27000 (HDQ) chips.
>=20
> This would be more in line with how other multi-bus devices handle
> this issue when nether bus is selected.

If I'm not mistaken, this way it's impossible to build the code as
module. You need to move the tristate to the individual bus options.
This would require to split the code, so that two separate modules
are built. I checked the tree and found a few examples:

 * building one modules for each bus, core support is autoselected, but alw=
ays built-in
  - BMP085

 * building a core modules + one module for each bus
  - AD525X_DPOT
  - ADE7854
  - ADT7316
  - INPUT_AD714X
  - INPUT_ADXL34X
  - TOUCHSCREEN_AD7879
  - TOUCHSCREEN_CYTTSP_CORE
  - TOUCHSCREEN_CYTTSP4_CORE

Instead of restructuring the whole driver, we could also just built
the platform code unconditionally. The platform specific code is
just a probe + remove function and bq27xxx_battery_platform_read().
The last one could be dropped, if the pdata->read function is
modified (effectively moving the code into the w1 driver).

-- Sebastian

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWJLnPAAoJENju1/PIO/qaSuUP/3BPiWMpyi1w3rQwWC5dHd9s
r6jVw/qENkqllsy4jXvM4tPkVfy83IwV95XSfBDpf1dMyU1dWLv1O5pajx9ouS1c
eM7sCUNQaetxIAaK5hoOXFuAX6NLshVFjM8TFXriFhFeao4rOGsY0/qj51phV9/2
FH0nR58naT5Sv004bbVFvqgDDUaIuJqLupyqkz7yYY1Q78lo95350uEIh43TOzqn
PmqmrEr4G+um4FEdAZHCbNgwCRXCY0wwueK7OUsMa1eRYunfeiM/o7Y0cMkXbP7W
bUo5b0IgML9E1Oe8FTe4h2tPUjiYMdobgvrtsWxN2BqhoOLKeuPDQ5tL9cvFIgFb
5SL+9AIP7LqcsKLECEh4ofz212/Z/8MAnRMMc61k/fFgPavSwQAQtUYjAi/4qIMl
XMDrc/le9vQtm5HoMVMEAouBxJT+OoIuJPCZnQh4ksVvjFFnRo46dXttCDvcXgxN
aMcNlwM9YGdaJ1L/iIs3aQZygVf8oCC19h1rCsAyCbIAlcTSz9ah0qHOl5aKmLLd
eT6sGYzCKjrkthvRM4gcdnhxazdpNW3i50htYYJQvWjdOhQJ5BOxtuN0ZVcaePuD
9Av/STagq95eu3JhinIs0kC/73AM0l9HmHU3lAbNAMYpNzxd/VNFAcl7yaNOzqjz
ZOaP08WziNJxFE1b85h6
=inwf
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
