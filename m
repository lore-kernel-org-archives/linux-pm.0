From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v5 0/6] Add support for DA9150 Fuel-Gauge
Date: Tue, 22 Sep 2015 18:04:05 +0200
Message-ID: <20150922160405.GC4235@earth>
References: <cover.1441964153.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1441964153.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-pm@vger.kernel.org


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Fri, Sep 11, 2015 at 11:05:21AM +0100, Adam Thomson wrote:
> This patch set adds support for the Dialog DA9150 Fuel-Gauge.
>
> [...]
>=20
> Adam Thomson (6):
>   mfd: da9150: Add support for Fuel-Gauge
>   mfd: da9150: Update DT bindings for Fuel-Gauge support
>   power: Add support for DA9150 Fuel-Gauge
>   power: da9150: Add DT bindings documentation for Fuel-Gauge
>   mfd: da9150: Use relative paths in DT bindings document
>   mfd: da9150: Use DEFINE_RES_IRQ_NAMED() help macro for IRQ resource
>=20
>  Documentation/devicetree/bindings/mfd/da9150.txt   |  33 +-
>  .../devicetree/bindings/power/da9150-fg.txt        |  23 +
>  drivers/mfd/da9150-core.c                          | 191 +++++--
>  drivers/power/Kconfig                              |  10 +
>  drivers/power/Makefile                             |   1 +
>  drivers/power/da9150-fg.c                          | 578 +++++++++++++++=
++++++
>  include/linux/mfd/da9150/core.h                    |  19 +-
>  7 files changed, 810 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/da9150-fg.txt
>  create mode 100644 drivers/power/da9150-fg.c

I suggest, that you take the whole patchset via the mfd tree.

-- Sebastian

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWAXv1AAoJENju1/PIO/qaKcUP/1gkS6ZRJjotWBqt34qLYogN
6oQJrV1hiBeouL25VMSYOsAGL091FhLWCp8JV06LdyOvCncea+P0q0SLSieJbiYS
D5+6nkmdqHsoYXTcW4j2OTO84TXxetY/g1akP7+FDqttlfznQtorQK43QFu4Jf3E
/RVRX+NB6CDmOv7OTM6vPTiHYgp6nRw2XEgVXv6xKCoLQNjfEH8YXTxpQgzoLaFM
xRNsuET0oswv1VfzhzKw4q4h5WahUzu4n9yFr/BsfWNozYBvJt0NDaZP6krLX6u2
EI4h4aX63xY/2LtFTzXzY5Uc6yHLXdVshVya6IIXiV4NWdppODkZZ7C+5t+Jn7Y8
ccUV/OVnj/hGXpUdghfobf4zduz1JnbObjWS/SxTBUIxF5dB9pBz3Yt5ZHRHulC4
q+NaVb20gOiJxyScggqF20Mr7i3SQsCg0AzTmdmJx92VNiTmFTBMZo+vnMV4sXZj
q5gCzIrDciQ1Hl9tn8hWAxEluXTi19EIci+7wGBdxq6YKXCs6NSf2tcACAXkfkES
awHzEoumGuhsWPVYg9e8Q8B5zizH6Rd7RQW60KjwxwrMWt+y2Drrpbo6KBwypsi1
14Zc2hY/zA9vj7dOE3pi10aR53eGTKw1rSjy35Z4LLR6aSSeKMluNmsnJLb24tAX
rPuAQ5c2v+5SarQD2Mtn
=FXwf
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--
