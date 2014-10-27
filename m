From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 07/10] ARM: dts: tegra: Use standard power-off
 property in tps65911 for tegra30 apalis
Date: Mon, 27 Oct 2014 11:42:14 -0500
Message-ID: <20141027164214.GF14253@saruman>
References: <1414427215-14380-1-git-send-email-romain.perier@gmail.com>
 <1414427215-14380-7-git-send-email-romain.perier@gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7cm2iqirTL37Ot+N"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1414427215-14380-7-git-send-email-romain.perier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Romain Perier <romain.perier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--7cm2iqirTL37Ot+N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2014 at 04:26:52PM +0000, Romain Perier wrote:
> Signed-off-by: Romain Perier <romain.perier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  arch/arm/boot/dts/tegra30-apalis.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/te=
gra30-apalis.dtsi
> index a5446cb..ced4436 100644
> --- a/arch/arm/boot/dts/tegra30-apalis.dtsi
> +++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
> @@ -412,7 +412,7 @@
>  			#interrupt-cells =3D <2>;
>  			interrupt-controller;
> =20
> -			ti,system-power-controller;
> +			system-power-controller;

this board is broken until this patch is applied.

--=20
balbi

--7cm2iqirTL37Ot+N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUTnXmAAoJEIaOsuA1yqREfDMP/j7ucJq3vB78FGIOTHhaE8NC
bd9AawfKX6pK1rH7K9gqQGn/KEk4IjUSRxNIjQwwyYmWN3dU9Ouox9qcp3fVVTj7
R74o7v6eJxZIGncKIrEOqUVnmbDuWKCArzZIk+ssd8FnJnTiDDi4AxWCBofcTZVb
HSEi8JqwjVkU+Sie8CerWa/YrUsOX0nnVeTzYGAGraXY80iFkl5yRx/g2w8hwuAy
XAwn+AyPzqCFLl2lVX2FTXHdBQQ/asyKxDrh9KTLP2B3kY6bILluP6XOYaiqDPwk
Xffk6hwziypeddH7Gao5iS/zlB3SophXfXPmwa0PUDae3CHPMirGQyXSG++V6rCD
xX8Tfd+eX8v1FehBLAffb/zm8Kj/YpFz8VxMbvQqux7Se1AAcqiWO143jY1eijyz
oExG7eQG2bWsTHidCROmJ7k4eJRFkreUEOka6CNPD/1cbF8HTQxrdZ3RhyQc7HXz
pb9pY8EY1c3Xd3x4cjWkPWdaPnFmyu6+5LC7lgrrkl8fpnrMIDaze39E/vL1iDLd
7PG0AAQ+ki/CNOAjwb2tysC0MFJtWDVPeOq8w8zebXfqQyo9fCGBllFlc+eaNpKP
e8rAaBKy4/2cjj+y6Ch7RZ33Z6QwbQZsFTMr1UYBcbDZepggZfNs97Y7YvRdo4T/
roJIHiMccfxOBcTCF8LW
=YXmf
-----END PGP SIGNATURE-----

--7cm2iqirTL37Ot+N--
