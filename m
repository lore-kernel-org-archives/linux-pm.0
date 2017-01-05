From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 01/22] dt-bindings: iio: adc: add AXP20X/AXP22X ADC DT
 binding
Date: Thu, 5 Jan 2017 17:40:47 +0100
Message-ID: <20170105164047.ksaww7punkcyrl2t@lukather>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-2-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5033505760592207363=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170102163723.7939-2-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lars@metafoo.de, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, sre@kernel.org, linux@armlinux.org.uk, wens@csie.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, pmeerw@pmeerw.net, knaack.h@gmx.de, bonbons@linux-vserver.org, lee.jones@linaro.org, thomas.petazzoni@free-electrons.com, jic23@kernel.org, icenowy@aosc.xyz
List-Id: linux-pm@vger.kernel.org


--===============5033505760592207363==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yfaedtjmyrcaqnge"
Content-Disposition: inline


--yfaedtjmyrcaqnge
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 02, 2017 at 05:37:01PM +0100, Quentin Schulz wrote:
> The X-Powers AXP20X and AXP22X PMICs have multiple ADCs. They expose the
> battery voltage, battery charge and discharge currents, AC-in and VBUS
> voltages and currents, 2 GPIOs muxable in ADC mode and PMIC temperature.
>=20
> This adds the device tree binding documentation for the X-Powers AXP20X
> and AXP22X PMICs ADCs.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--yfaedtjmyrcaqnge
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYbncPAAoJEBx+YmzsjxAgoZkP/2M78NSaTbG++99eZf8pEhDA
ncr5S6Ydy/eLV6yg3e0H5uGh39Hj6C/WnmyvLeQ9fwNUl5O+nkrXZBOt+bsTRcCk
OrECsueqFMR/VigyzRDm8k+KEvkpoEOfLV0OlrjaFESdUhYOnY5mnuYj1pGGU8kZ
F88rxPAC/EogcieWVaWDldCuVYTVhr7ltUtels1bqWE52hY3RbVb0KBmPldd/QcA
1u+ZtjTNnK8gENC4QSlpsE8jIHyJL30eLrM2Z+v9WK887uMktH/6yyX+amX0PEgr
S2fingkWz2C588XTDuvf2AWx1ABAGnH+oVTKDox+8ZoZoP5b8y2DtLUgrvAPeoIf
Khbr0975ozHFfIFrgBcF8/D9TKYZwV4UpOI2U2hXVjFMN19JDSMPp/Rcyj6XIJzB
ShdfR6yIEd0ae6CLOuCb91eK+ypjJd59AF1rwXv8LZNWIA+6DsypVab2jiHST5HD
zYRPwPKcfPRqHbywGukD0YBFO9OQ2Xhhyj4jriQWoQfEFS/i4n2a75QRspZ9U9s8
RIJNP7kPuxle3q1c+WFeRHmCCJlW3i67o4WXR7edaLMGcMSgEyGLclcaxno9CD44
ieYHWRAneMzQb2CAAEdkWYkFfI3bYTfvfLX4MjMoNUOQErC0ua8wna87cZA7fni8
DkzhQutkhwEqtV5kKwgH
=R8go
-----END PGP SIGNATURE-----

--yfaedtjmyrcaqnge--


--===============5033505760592207363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5033505760592207363==--
