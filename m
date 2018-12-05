From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v6 0/8] AXP8x3 AC and battery power supply support
Date: Wed, 5 Dec 2018 19:00:42 +0100
Message-ID: <20181205180042.fr5npvtwuvt2c6q3@earth.universe>
References: <20181120175211.3913-1-oskari@lemmela.net>
 <CAGb2v65Bwve25jwdGHHK9j03RxQ3tKwme51762DjyQK2femG6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xnlkjubit7aft5id"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGb2v65Bwve25jwdGHHK9j03RxQ3tKwme51762DjyQK2femG6g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Lee Jones <lee.jones@linaro.org>, oskari@lemmela.net, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Quentin Schulz <quentin.schulz@bootlin.com>, Vasily Khoruzhick <anarsoul@gmail.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org


--xnlkjubit7aft5id
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 30, 2018 at 04:31:28PM +0800, Chen-Yu Tsai wrote:
> On Wed, Nov 21, 2018 at 1:52 AM Oskari Lemmela <oskari@lemmela.net> wrote:
> >
> > AXP813 AC power supply support with input current and
> > voltage limiting support.
> >
> > AXP803 AC and battery power supply support.
> >
> > Changes in v6:
> > * Collected tags
> > * Rebase to master
> > * Dropped AXP803 compatible patches
> >
> > Changes in v5:
> > * Return correct input current limit for values 0x6 and 0x7
> > * Add specific compatibles for AXP803
> > * Change commit messages
> > * Add Vasily Khoruzhick Pinebook DTS patch
> >
> > Changes in v4:
> > * Change order of axp20x-gpio in axp20x.c
> > * Fix indentation and spaces to tabs in axp20x.c
> >
> > Changes in v3:
> > * Reorder ac_power_supply DT node
> > * Rename axp20x_ac_power_set_property function
> > * Split mfd commit
> >
> > Changes in v2:
> > * Reuse axp813 compatibles for axp803
> > * Refactor axp20x_ac_power.c
> >
> >
> > Oskari Lemmela (7):
> >   dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
> >   ARM: dts: axp81x: add AC power supply subnode
> >   arm64: dts: allwinner: axp803: add AC and battery power supplies
> >   arm64: dts: allwinner: a64: sopine-baseboard: enable power supplies
> >   power: supply: add AC power supply driver for AXP813
> >   mfd: axp20x: Add AC power supply cell for AXP813
> >   mfd: axp20x: Add supported cells for AXP803
> >
> > Vasily Khoruzhick (1):
> >   arm64: dts: allwinner: a64: pinebook: enable power supplies
>=20
> Since this series has been fully reviewed, and the devices it
> adds/enables aren't critical, i.e. won't cause the system to fail
> if the drivers are missing, I've merged the dts patches for 4.21.
>=20
> Hopefully Sebastian and Lee will get around to merging the driver
> patches.

I queued the power-supply driver changes and prepared a signed
immutable tag for Lee:

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-su=
pply.git tags/psy-mfd-axp813-immutable-for-v4.21-signed

for you to fetch changes up to 7693b5643fd2d682de90733b67fc8032b9646911:

  power: supply: add AC power supply driver for AXP813 (2018-12-05 18:49:32=
 +0100)

----------------------------------------------------------------
Immutable branch between mfd and power-supply for driver
changes related to axp813.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

----------------------------------------------------------------
Oskari Lemmela (2):
      dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
      power: supply: add AC power supply driver for AXP813

 .../bindings/power/supply/axp20x_ac_power.txt      |  3 +
 drivers/power/supply/axp20x_ac_power.c             | 94 ++++++++++++++++++=
++++
 include/linux/mfd/axp20x.h                         |  1 +
 3 files changed, 98 insertions(+)

--xnlkjubit7aft5id
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIEkoACgkQ2O7X88g7
+pp4IA//c/ChZY6UHh9Rulc+1lkt/+KeQcJh9PpdFVZFJqr0zC+5B6VtMGXartdt
lswJovpYhjmy4kXT06kqD0MmJHh29s+a76Fj4DV1c+uUglhec1AuRwFviGXBZg7y
ush9s2FgUsPl9JBlQdElJb06oEKqsPDZ5iRssPloJngzMFg3xLdunnLW59Vv5XBq
qg2umsW1UWKKtaSKnYQ8aSQ6wmNBOERPcvYkOjiPRL943Bn0Od73GVxcR0lOtWqR
8v/f7Ah8qtnYWm1QPdNO2O9Hb67/gF6GKhTjI9YqdNe4Qcmp1rVoB0PPVjAlBUBD
XZIvs5HT2YQaqtoFmkSfyHxovYbeu1bIe8ZNaZMF2++UVTRA9kB5pIy2ScMlvYmR
DwiwRSiaJ125tnR8tTtMzJGAnrE36EAT/C9fKhW3+uq7/b0M/pqjgaMorKNOCw6u
1VfCPY8vQN5ke5ib5My/V4HyHaRJ95OdlzOaRwZ9EqjSthOYk1IWx2ehZeTOFIuB
XNLvR1dt4PeyYqpK5G5NG87XCvMjkF7/YWRC+zRu1R8UYHzAFzJMQG+jHXbYd7AO
BGMFtO7cJ1eRcg6VfpigKrs6laFoaScKnhf/Y5yPrBqlkyw7WO35bYqaICush93x
5HfcOMuR/iDnHuNf1aIQRUWc928lq5gaykdewbaWluKI+b7o8aY=
=WNDV
-----END PGP SIGNATURE-----

--xnlkjubit7aft5id--
