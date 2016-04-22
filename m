From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 09/11] arm64: tegra: Add DFLL clock node on Jetson TX1
Date: Fri, 22 Apr 2016 15:28:39 +0200
Message-ID: <20160422132839.GO9047@ulmo.ba.sec>
References: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
 <1461321071-6431-10-git-send-email-pchiu@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sGwo475CiIwWEjLI"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1461321071-6431-10-git-send-email-pchiu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Penny Chiu <pchiu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--sGwo475CiIwWEjLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 22, 2016 at 06:31:09PM +0800, Penny Chiu wrote:
> Add DFLL clock device-tree node for Tegra210 DFLL IP block.
>=20
> Signed-off-by: Penny Chiu <pchiu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi | 16 ++++++++++++++++
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi       | 15 +++++++++++++++
>  2 files changed, 31 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi b/arch/arm64/=
boot/dts/nvidia/tegra210-p2180.dtsi
> index 9d02db2..5cf07f2 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
> @@ -43,6 +43,22 @@
>  		};
>  	};
> =20
> +	dfll: clock@70110000 {
> +		status =3D "okay";
> +
> +		reg =3D <0x0 0x70110000 0x0 0x400>;
> +		vdd-cpu-supply =3D <&cpu_ovr_reg>;
> +		nvidia,pwm-to-pmic;
> +		nvidia,init-uv =3D <1000000>;
> +		nvidia,align-step-uv =3D <19200>; /* 19.2mv */
> +		nvidia,sample-rate =3D <25000>;
> +		nvidia,droop-ctrl =3D <0x00000f00>;
> +		nvidia,force-mode =3D <1>;
> +		nvidia,cf =3D <6>;
> +		nvidia,ci =3D <0>;
> +		nvidia,cg =3D <2>;
> +	};
> +
>  	pwm_dfll: pwm@70110000 {
>  		compatible =3D "nvidia,tegra210-dfll-pwm";
>  		reg =3D <0x0 0x70110000 0x0 0x400>;

This isn't good. We're effectively sharing the same I/O memory between
two devices. Let's avoid that if possible.

It would seem to me that this DFLL PWM device isn't really a proper PWM
controller in the sense supported by the PWM framework. As such it might
be easier to have the nvidia,tegra210-dfll compatible device expose a
regulator directly rather than go via a "fake" PWM device and a
PWM-based regulator on top of that.

Thierry

--sGwo475CiIwWEjLI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXGicHAAoJEN0jrNd/PrOhFcIQALu8KPx3XHNpjf25ucGG4Qlp
9ytJNTuHr4TqoHs6gJyo1rlyz2sGq6cRnjiRkfMTVJS13eS+9VK5z8Kgi8c28NSI
sFaAoq2GRNOwn93t9adEz3PW8uhZbabBk+rC3kXo3YhjU8puGBzd3y3He7Wmi1z0
6W3ds5C9qYZBBgQfiAs/zT7I4alswpQaT6U1c2IwRho6S7jUtLh2l2i/+pKL7Jyc
MeNeVaWx1l/mAfeO09sWJSEW+JktJlTgLfuB1onQXbkxWWINIHcfnBX+jYRD1qdP
ds52CvSa3zjHEHxEsKQwcLTD4g/IQlTavNJXsSmsg9paLLxfHb63EH19DjMRQzU4
uWI0GcY8KoRe5Ep7gBFVH96Qt4MlaSxvHbhViQYWREACO3OX2KtgCUvgl49IoMCT
DLPIGZ26mYHYdOlSEJcBiJjpwzzSJwTZDl/KcC6egZXL7baQOD0trVRWuQtxCXwA
j2TvFmYTUSh0cl0i+W0SH9a7sK3oDFQsIafkK2Csuxiq2zqgeOhLVbN1w0HnKTpW
Kdboitv8LX5r6rsLTPHWAuyUJcSvkEBI4hMOyhRTq5gLfF2eI9blEZcC3O1VmLQb
Wa0Q6syUwpMbm1sOlzY0f2/PxOBHeuJXBKKaLIOh4A/Z8SDMxVSQP8wV9mdTd89P
O/50iHCFM55HS6wA2pax
=87MQ
-----END PGP SIGNATURE-----

--sGwo475CiIwWEjLI--
