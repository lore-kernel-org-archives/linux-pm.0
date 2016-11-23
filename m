From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: power: add bindings for sbs-charger
Date: Wed, 23 Nov 2016 14:45:20 +0100
Message-ID: <20161123134520.kpyb2v42rrrnge4i@earth>
References: <1479900044-19270-1-git-send-email-nicolas.saenz@prodys.net>
 <1479900044-19270-3-git-send-email-nicolas.saenz@prodys.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t54nomo3ghgu5cn5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1479900044-19270-3-git-send-email-nicolas.saenz@prodys.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Saenz Julienne <nicolas.saenz@prodys.net>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--t54nomo3ghgu5cn5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 23, 2016 at 12:20:44PM +0100, Nicolas Saenz Julienne wrote:
> Adds device tree documentation for SBS charger compilant devices as defin=
ed
> here: http://sbs-forum.org/specs/sbc110.pdf
>=20
> Signed-off-by: Nicolas Saenz Julienne <nicolas.saenz@prodys.net>
> ---
>  .../bindings/power/supply/sbs_sbs-charger.txt      | 22 ++++++++++++++++=
++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/sbs_sb=
s-charger.txt
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/sbs_sbs-charg=
er.txt b/Documentation/devicetree/bindings/power/supply/sbs_sbs-charger.txt
> new file mode 100644
> index 0000000..b18ee2a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/sbs_sbs-charger.txt
> @@ -0,0 +1,22 @@
> +SBS sbs-charger
> +~~~~~~~~~~
> +
> +Required properties :
> + - compatible : "sbs,sbs-charger"

I think the binding should request to add a more specific compatible
value and use "sbs,sbs-charger" as fallback. The sbs-charger spec
provides a few vendor specific registers. Like this:

compatible =3D "lltc,ltc4100", "sbs,sbs-charger"

> +Optional properties :
> +- interrupt-parent: Should be the phandle for the interrupt controller. =
Use in
> +    conjunction with "interrupts".
> +- interrupts: Interrupt mapping for GPIO IRQ. Use in conjunction with
> +    "interrupt-parent". If an interrupt is not provided the driver will =
switch
> +    automatically to polling.
> +
> +Example:
> +
> +	ltc4100@9 {
> +		compatible =3D "sbs,sbs-charger";
> +		reg =3D <0x9>;
> +		interrupt-parent =3D <&gpio6>;
> +		interrupts =3D <7 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +

-- Sebastian

--t54nomo3ghgu5cn5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlg1nXAACgkQ2O7X88g7
+pouyg//U3KCoLGrMy2H1wAW3mYa0Wr31CiWHkfAREORNhMotgk5eZx6+Q1rK+uQ
pgNR9IR+wh+5Yojfqj5zt4H6MtAHQ3WuYnEPdCdDoLw5FGRz/44hwjOQEF6+cRX2
Rvu5NpIR6S7kwTsUAf2zefUc3w3ObR/dp6chak8AS+gHkZGs46ttsObZ/WzgrYl8
zf61WvRrgbehNUAJD9ix2HD+VB5hHknCc1kxE3bJcugbr+0dCkBRAX5tHIQ0SB2r
mhTn+6zHXuRRzWfMq7XDlwC2Xv2QQaNWsGMTKUQQYUxx1jkh/+UQM1BqXUYQwlPX
hMiPg34u/BQYO312owUUnSMOOdE1NfqV3P8bQ1Tq1zOsMKTseIdcEf/fOt/heZWm
scbvxp7cPhHPq2KfpcwZNEjLS4z8CqtTDNIH4xdpPjZNtACzODdxcrNAdDY3TQau
a8oU9YluOt2mNH3D804HTVWXaTa5KJncX1r1DAUKBuyVsPXhDbpmL4lrBxzVJfqe
/Jp2895/rKTtNrv6ln/h78NdfziU+oY9EIEkIJl0fEVVjCN9wVuPHL6st9R94igU
1qNBEQwjO6id1yIUQ2uBPzWb/VV1ZHVvjKgNIGDdsWEtMszWUrs3ntT/rVjryJCg
cw4M9V79+ly6dOXoSlHpgsUeVEQLO19C2+AOn3BLW92ZtcRKRWA=
=xUn5
-----END PGP SIGNATURE-----

--t54nomo3ghgu5cn5--
