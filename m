From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 02/11] drivercore: Bind/unbind power domain on
 probe/remove
Date: Wed, 5 Mar 2014 12:26:02 +0800
Message-ID: <20140305042602.GE13126@sirena.org.uk>
References: <1393862536-9842-1-git-send-email-tomasz.figa@gmail.com>
 <1393862536-9842-3-git-send-email-tomasz.figa@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+wcwqhATTmTB6/2m"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1393862536-9842-3-git-send-email-tomasz.figa@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Russell King <linux@arm.linux.org.uk>, Kukjin Kim <kgene.kim@samsung.com>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Tomasz Figa <t.figa@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org


--+wcwqhATTmTB6/2m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 03, 2014 at 05:02:07PM +0100, Tomasz Figa wrote:
> On a number of platforms, devices are part of controllable power
> domains, which need to be enabled before such devices can be accessed
> and may be powered down when the device is idle to save some power.
> This means that on systems that support power domain control using
> generic power domains subsystem, it is necessary to add device to its
> power domain before binding a driver to it and remove it from its power
> domain after its driver is unbound to make sure that an unused device
> does not affect power domain state.

Reviewed-by: Mark Brown <broonie@linaro.org>

--+wcwqhATTmTB6/2m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFqdXAAoJELSic+t+oim9lJgP/3yLE8EY4S+jtsmqD3m+2F3c
RsPTLv8rvn9PEgplXczrlDf2Knisfeh7ads61m+VmoTAO+LSRDHIRS2Nbo6zGjmC
R7ZYNlGS0hzcObirMtVlX/tC0WYiqYlgFlm7/TDcbxlDvwlKz8QqRNMFly5Ufvqm
rSE0zi2J3hDKiuQPcernaOVubgv/w58kss2WWNLVKDfexcqPd8u4SOqTFvIp6r9+
/uWl8ZNzkwLr88CkqLNDrE1D4iqyKvxpmMAnxDC8dKzMoDEq+EVc8OjI31J7e4Yt
/e44dRIsdDU6J9VF9md3BKxquWFZifWBH7IvuXl8jDrdoMw3/Inb9PcpKkOYST4g
7f4Dg2QVSvMc0EeLJ5XTk6Snr8IRs1LHKlyJWtXz6eq0oPo1PpL8UTJEFyieRr+d
NVnrvahjAkVvAg+LctCalpCMK1xR8X30Qhdbd15DO+KDbBpQ5hSU6jE6gVKxaihB
dCtNfLeJZYeZT3jaddJ9Rw6zu3aeKIQcGZRth7mA00KBNsuZ0xx25k2NqdisPrkA
CqeuAZw5A5jsPNYp/iL9+cGe8szc4yI0Z7ZA0sQVX8D1uWVAHZeyqwLdIoXVNV0B
OwDZIbkldBgoRwI0n64u0rZ1YLJKOcsTlzqNi4BNqMvbebaIqupqrPIZMrkdQTdj
ml9+jUFjcAyLAhsP75ME
=Lee6
-----END PGP SIGNATURE-----

--+wcwqhATTmTB6/2m--
