From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 1/7] dt-bindings: Add DT bindings documentation for
 Allwinner Thermal Sensor Controller
Date: Mon, 20 Aug 2018 13:17:55 +0200
Message-ID: <20180820111755.rzg7l2lznmbpuf2e@flea>
References: <20180804070355.14857-1-manu@freebsd.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3wnikgdamrq32ce2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180804070355.14857-1-manu@freebsd.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Emmanuel Vadot <manu@freebsd.org>
Cc: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--3wnikgdamrq32ce2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 04, 2018 at 09:03:49AM +0200, Emmanuel Vadot wrote:
> This patch adds documentation for Device-Tree bindings for the Allwinner
> Thermal Sensor Controller found on the H3, H5 and A64 SoCs
>=20
> Signed-off-by: Emmanuel Vadot <manu@freebsd.org>

I'm not going to merge a binding for a device that doesn't have any
driver implemented at the moment in Linux.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--3wnikgdamrq32ce2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlt6o2IACgkQ0rTAlCFN
r3TBUQ//Zzcda8FBwMHlOeqZgRlXnJc1Q9VU/IeQIRCOXWDjIeJCiYUmuyuDV2Ry
aF7wBQjAIHld6t4IzFchoBJTyykEBJn+l6d//2ap8qoG0TrmVevVwXVkN2Gsu7yP
SiqPApfsq6OT7WuBGi43PyfgwNNgwBTICRcYMAszfXJv+c0WK4Doapwd24RTJ4pR
rRmfCtU6bZlKdQ6Sj+eIJgKcuCSpkfiHCcogZ8CwanKWr1I9pPSRejzVLjwhTOtB
Bg5YW5PTdqrJ+wNh7JotWDFQTk9zGNy1qBnw2yNReynCnQhmYL1j7MhEAGcL3kDd
iS7pKNSFx+OhyO/KsQRYeFzTm9iMY/wNm+3w5/HJgtvhPBfYrH8uZ9035qlBXZlI
SNrr5A2fxguV9+Wt14BMIn+bcFrDi+WMD8JoJuAAp5YfpWZI369DSm+laNgRuw23
5ZPPMsIzMWvvWwH2h8cyByOBMQYW5e16MtQbmyyJsrKanuH5gVk76M3H8sE1TTZC
GpkvqQc2SrKCiRLSXXBEDJvU0v4PMjVHaW8til03/WJobRwEwMsm71CwIrxe5rh7
6OS7HvDxncKsa+GQZ/SN85/4p5P3z9Q1ZcyrK8xHhf8wRhi0YzvWwUV6ZWO9AG7R
0NJRPoyP7X/qnKiEEmmHtXIEmSmKQhjYgR//9hCo1CDH7dxde/o=
=0Njf
-----END PGP SIGNATURE-----

--3wnikgdamrq32ce2--
