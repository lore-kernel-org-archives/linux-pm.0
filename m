From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v6 2/8] power: add power sequence library
Date: Mon, 22 Aug 2016 12:23:31 +0200
Message-ID: <20160822102331.bimz22w6z2v65jd7@earth>
References: <1471252398-957-1-git-send-email-peter.chen@nxp.com>
 <1471252398-957-3-git-send-email-peter.chen@nxp.com>
 <20160822065158.GB4362@shlinux2>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yl54hewicxwxsn6y"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160822065158.GB4362@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Chen <peter.chen@nxp.com>, gregkh@linuxfoundation.org, ulf.hansson@linaro.org, broonie@kernel.org, stern@rowland.harvard.edu, robh+dt@kernel.org, shawnguo@kernel.org, dbaryshkov@gmail.com, dwmw3@infradead.org, k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org, stillcompiling@gmail.com, linux-kernel@vger.kernel.org, mka@chromium.org
List-Id: linux-pm@vger.kernel.org


--yl54hewicxwxsn6y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Mon, Aug 22, 2016 at 02:51:58PM +0800, Peter Chen wrote:
> On Mon, Aug 15, 2016 at 05:13:12PM +0800, Peter Chen wrote:
> > We have an well-known problem that the device needs to do some power
> > sequence before it can be recognized by related host, the typical
> > example like hard-wired mmc devices and usb devices.
> >=20
> > This power sequence is hard to be described at device tree and handled =
by
> > related host driver, so we have created a common power sequence
> > library to cover this requirement. The core code has supplied
> > some common helpers for host driver, and individual power sequence
> > libraries handle kinds of power sequence for devices.
> >=20
> > pwrseq_generic is intended for general purpose of power sequence, which
> > handles gpios and clocks currently, and can cover regulator and pinctrl
> > in future. The host driver calls pwrseq_alloc_generic to create
> > an generic pwrseq instance.
> >=20
> > Signed-off-by: Peter Chen <peter.chen@nxp.com>
> > Tested-by Joshua Clayton <stillcompiling@gmail.com>
> > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > Tested-by: Matthias Kaehlcke <mka@chromium.org>
>=20
> Hi Greg, Sebastian, Dmitry, and David
>=20
> I find the code under drivers/power have several subsystems.
> Does this power sequence patch set can go git://git.infradead.org/battery=
-2.6.git?
> Or can go the Greg's tree?

I think this does not really fit into the power-supply tree.
I would expect this to go through Rafael's linux-pm tree.

Note: I moved all the power-supply code into drivers/power/supply/
in linux-next, among other things because of this patchset. To avoid
merge conflicts in drivers/power/Makefile and drivers/power/Kconfig
the tree pulling this patchset should also pull a (yet to be
created) immutable branch containing
https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/com=
mit/drivers/power?h=3Dfor-next&id=3D8c0984e5a75337df513047ec92a6c09d78e3e5cd

-- Sebastian

--yl54hewicxwxsn6y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXutKgAAoJENju1/PIO/qadnEQAJWe760BcSWrBm+G5uwCtajf
0dxlyup6SG/k30WAW5ZFxc4Lg1z8gYZCniiAv3azkCCLDzeDjjygaNcd34m/82nQ
TEydwVDfkg2LsUfFmH5aEEPklxGHzLRKx9GNIxzKTbaw4LvBfo5AAf7oLEYZziHE
qj5RIBZdZ6Y4gkcJTOBdiwxiE1nLW0wxuOGR+7afJoYosyGiqdThFj5xEJkmo0v8
k45jsiI5zG7D6aqClWNbzynKFVeAUXOwfTDo4ayqwdnEWbpbdrP6ep0ss6QiVOxp
4FGocRE8GjD+tkXVPLOvvQwxyJOMmnV9gnSiKhK6txElCOk0y4e9tvyq7xLyEEyM
xA+YEtj0S2Sg+IzKfme7F0MgxM7RM+ra1UKU+HblCVyh2j9fx01BtjMJmi/R+T7l
FuBV6M1xXB4TPjvVYiQ92Io1BfJ9j7jigKoxeTmzkfS57RUn5RAej5kksBw9xuB6
Fh4HfWIiIRdOU++4CYou1ZPV9sEomvdZRvaa0tlO7PUqtVCKiWZuaWHAfuYqpFWR
a2ZgyBhXCckQ+DsMEFVsV3TaLJLqLMm9UJsRrAgN6kUxndl4aUKvniwwrL2hlk8w
V5b0dpUod7sYAhz6wnf8qDH8WuwPVIRL1R52lPwX7qENiUuGelC2ChdVKTGUsR6F
KsbiNhqDxiV9mowxm1p2
=bGiF
-----END PGP SIGNATURE-----

--yl54hewicxwxsn6y--
