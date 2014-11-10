From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] PM / Domains: Fix initial default state of the
 need_restore flag
Date: Mon, 10 Nov 2014 19:39:31 +0000
Message-ID: <20141110193931.GN3815@sirena.org.uk>
References: <1415366847-4807-1-git-send-email-ulf.hansson@linaro.org>
 <7hr3xerdw6.fsf@deeprootsystems.com>
 <20141107215751.GA4439@dtor-ws>
 <CAPDyKFot-LZjazq190cY3-tawB_-ukdsmrLcD3vtidLvX68FOg@mail.gmail.com>
 <20141110183224.GA5626@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PrbR2RMKSe7tzlp9"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141110183224.GA5626@dtor-ws>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaro
List-Id: linux-pm@vger.kernel.org


--PrbR2RMKSe7tzlp9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 10, 2014 at 10:32:24AM -0800, Dmitry Torokhov wrote:

> - I do not see why sirincling platform specific code around i2c, spi,
>   etc bus code (which is not platform-specific) is OK, but a no-no for
>   the driver ocre.

sirincling?  In the case of I2C and SPI the buses don't define any sort
of power management or power domain so any management is going to be
device or system specific.

--PrbR2RMKSe7tzlp9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUYRRyAAoJECTWi3JdVIfQSV4H/03djnyX8cEbZgLueUjpEZmq
/wqWq1iEWdh9gD/kc7TT/44U2f940mDZcArfTw//TQ7TgZ16+ZvOFJ1uGPjVbIy6
ofXKasafjlgL4UAGDTB6X077vPbPSFT4UimHuIyQ2T1iEJYVV32oIm4EtbNDkoF4
lP4JzboxWM6JYKMHqmTX17ZJ/F00SDWn6k2dWM0CdYWAGvn44qsPnZKLnnzjWrqh
9nLXTPHRshoZ7LrgxBpg/NOoTgmCCFyOCkXEXcN6YepAxqFhb9SzIkje8Mvx9dO9
iwfo3BAi1D0uS+XcDAnpSeYvvOVR/JPfx/luLpT/Cfx7w8MEtgna0RwsXiX7DrI=
=MpIf
-----END PGP SIGNATURE-----

--PrbR2RMKSe7tzlp9--
