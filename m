From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 0/9] Add sbs-manager with smbalert support
Date: Mon, 1 May 2017 11:08:26 +0200
Message-ID: <20170501090826.3wci2vzilp6ogalt@ninjato>
References: <1493628599-30552-1-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wodp3e2766qt6zyv"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:48131 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1035255AbdEAJId (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 1 May 2017 05:08:33 -0400
Content-Disposition: inline
In-Reply-To: <1493628599-30552-1-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, peda@axentia.se, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org


--wodp3e2766qt6zyv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 01, 2017 at 04:49:50PM +0800, Phil Reid wrote:
> This is another go of the sbs-manager driver using smbalert for
> irq support from a while ago.=20

Thanks for keeping at it!

Adding Benjamin Tissoires to CC, he worked lately on I2C device IRQs...
@Benjamin: do you need the patches, too, or do you read the I2C list?

> Enables the existing smbalert driver to be loaded via the device tree.
> Only need to add smbus_alert interrupt to the i2c bus segement in the
> devicetree and the core will then enable the alert driver.
>=20
> Reorders the rquest irq call in the pca954x driver to ensure each
> muxed i2c segment can handle service smbalerts on that segment before
> irq's are enabled. The pca954x can't mask individual irq's routed thru
> them.
>=20
> Add the sbs-manager from Karl-Heinz.
> Add the alert call back and gpio interface to allow the battery detect
> logic in the existing sbs-battery driver to work.
>=20
>=20
>=20
> Karl-Heinz Schneider (2):
>   Documentation: Add sbs-manager device tree node documentation
>   power: Adds support for Smart Battery System Manager
>=20
> Phil Reid (7):
>   i2c: i2c-smbus: Support threaded irqs.
>   i2c: i2c-smbus: Add null ptr guard in smb_alert_probe
>   i2c: i2c-smbus: add of_i2c_setup_smbus_alert
>   i2c: core: call of_i2c_setup_smbus_alert in i2c_register_adapter
>   i2c: mux: pca954x: Call request irq after adding mux segments
>   power: supply: sbs-battery: Add alert callback
>   power: supply: sbs-manager: Add alert callback and battery change
>     notification
>=20
>  Documentation/devicetree/bindings/i2c/i2c.txt      |   4 +-
>  .../bindings/power/supply/sbs,sbs-manager.txt      |  64 +++
>  drivers/i2c/i2c-core.c                             |   4 +
>  drivers/i2c/i2c-smbus.c                            |  64 ++-
>  drivers/i2c/muxes/i2c-mux-pca954x.c                |  52 ++-
>  drivers/power/supply/Kconfig                       |  14 +
>  drivers/power/supply/Makefile                      |   1 +
>  drivers/power/supply/sbs-battery.c                 |  16 +-
>  drivers/power/supply/sbs-manager.c                 | 448 +++++++++++++++=
++++++
>  include/linux/i2c-smbus.h                          |   9 +
>  10 files changed, 637 insertions(+), 39 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/sbs,sb=
s-manager.txt
>  create mode 100644 drivers/power/supply/sbs-manager.c
>=20
> --=20
> 1.8.3.1
>=20

--wodp3e2766qt6zyv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkG+wYACgkQFA3kzBSg
KbbT3g//UIFZyKp5VnJ1Ecd7bBJCj+c/yRaIZTAGzRXAYVy3G6AUdhEVeotcMg1b
g5UMAFvhm359CeHnRB2j8I9ThTK8tazPdU4c9IIjfX0FyYy1rD3DeB059IulwoWO
7cA0G7+uFTKrvwhU5JwWUVLKE/I09etKbYnmRe9inSW/fMmpdmZVqWJXrInctwxP
u887TmJoJqASU3b21GFIBmVuf5+ckAmBvUZM1pTYkymyFhfqciBcW/xgG3ufPA4F
9EFv94DYR9X9gnBPC6PR1gpteaNhO6UGIoiVtbNIgZZBu3YpsKw9Obc0NPOm+z1p
Q8J3sQKJidUaig8PdPYmYTPi2RDTXHiJVGZUbrK6qblF8Chm2jWXlI86WbFETjCH
PgvUYReC1J7aJcYQmnyMvA6a4LVFcmlpqVyJiaRfFntptEKJeynUYOKaj3Jokkm0
PtPbFGSR6VwTv/3mxiunY8CDdL5IqAM9/bit4pjxeptSzTntqg8mgMEvJdNthlPt
3s14l3bcHhxpcYF8hfQLlxuoT1VOJyOUFIT5+pB2ryBKH2/ntLxKRTbUg0b+57lT
jXrrhUaspFlvCGzyNcZ3ksRgkWkXGn3SHzWgsVAp2xjvPEZ9vSA0OOgXUcke6eK0
o/x01+Bm5mZDib1wZaosTrotNvT+a3BypheUQ0EceaJgSO/8q80=
=M5mc
-----END PGP SIGNATURE-----

--wodp3e2766qt6zyv--
