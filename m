From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: dts: NSP: Add Thermal Support
Date: Thu, 27 Apr 2017 09:38:36 -0700
Message-ID: <20170427163834.GD18276@localhost.localdomain>
References: <1493153351-12698-1-git-send-email-jon.mason@broadcom.com>
 <1493153351-12698-3-git-send-email-jon.mason@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qrgsu6vtpU/OV/zm"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1493153351-12698-3-git-send-email-jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Florian Fainelli <florian.fainelli-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--Qrgsu6vtpU/OV/zm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 25, 2017 at 04:49:11PM -0400, Jon Mason wrote:
> Add thermal support via the ns-thermal driver and create a single
> thermal zone for the entire SoC.
>=20
> Signed-off-by: Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

Acked-by: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

> ---
>  arch/arm/boot/dts/bcm-nsp.dtsi | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.d=
tsi
> index 832795b..be6fcfb 100644
> --- a/arch/arm/boot/dts/bcm-nsp.dtsi
> +++ b/arch/arm/boot/dts/bcm-nsp.dtsi
> @@ -383,6 +383,12 @@
>  			      <0x3f408 0x04>;
>  		};
> =20
> +		thermal: thermal@3f2c0 {
> +			compatible =3D "brcm,ns-thermal";
> +			reg =3D <0x3f2c0 0x10>;
> +			#thermal-sensor-cells =3D <0>;
> +		};
> +
>  		sata_phy: sata_phy@40100 {
>  			compatible =3D "brcm,iproc-nsp-sata-phy";
>  			reg =3D <0x40100 0x340>;
> @@ -533,4 +539,24 @@
>  			brcm,pcie-msi-inten;
>  		};
>  	};
> +
> +	thermal-zones {
> +		cpu-thermal {
> +			polling-delay-passive =3D <0>;
> +			polling-delay =3D <1000>;
> +			coefficients =3D <(-556) 418000>;
> +			thermal-sensors =3D <&thermal>;
> +
> +			trips {
> +				cpu-crit {
> +					temperature     =3D <125000>;
> +					hysteresis      =3D <0>;
> +					type            =3D "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +			};
> +		};
> +	};
>  };
> --=20
> 2.7.4
>=20

--Qrgsu6vtpU/OV/zm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZAh6EAAoJEA6VkvSQfF5T8bsP/3lwtsfjoV6xjszpgR5vh1c8
q75XpkItcmt56q3Vwyf3IMhJ+zEBu0wVHVTaas7R6jh2/rBHgvenDbdqNhNk4zBJ
CZK4+WwFghH0jrt+R20lEPtLq/Q40Cq3Si1PN6LxrCe/KObkXsSphG7YFXngDxzt
2F78AxIa2vWUbW2peY7dGuaJunKsu3QgSIrs1r5Rfaekx8n5D9+mMnqDXskXmVv8
cZfB+v1bGTUFt1txKHG1+947rIYEJYzdg7FkQlQJh4i+YhHY5i0hYbmtya70Tk02
bFHRY1cb68hyCOgG08XGpeAXbIQwA2XfrC91rbf+gbv60f24s22zujvifHe0ylgK
A7rlEKkTOgSKUGp5kkNIonsrjpdnzLVo/GWYP4Mj3C5/1IUySTdWlmT869NXBPWs
HSd4+RHHvPbFZa3kMcy6DbipUdBXOlZSadsYL4S9F8S04NGy+aoJsv8JbqvNJbIg
3uLceG/g6lq9ugS931d3rW+nPNFex7e6ezd2f4jS7oV5g6Zca2nSLAXUJGG6d2X4
zpGzc74p0xbDc0RdqBFlHWbQhhTmEiPdR+4J0d4Z4A4VjCarrOh97+mjECIUJt55
e/fTgAaVA8/DTs+6zy8/MKy2/c/h/FyFYcIHIJUshcitAwyMYp4IhsO/y4+wiIIe
uRDZ76yHje1+4gC6hG/p
=V2aa
-----END PGP SIGNATURE-----

--Qrgsu6vtpU/OV/zm--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
