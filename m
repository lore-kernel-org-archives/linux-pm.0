From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] PM / OPP: Use - instead of @ for DT entries
Date: Mon, 10 Apr 2017 08:10:45 +0200
Message-ID: <20170410061045.2jjk5aw75s6am7xv@lukather>
References: <5ce1fbbc7cd37a6cfe54e93eeca311a7a52093ff.1491801395.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dvwcogjz63nwnatx"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5ce1fbbc7cd37a6cfe54e93eeca311a7a52093ff.1491801395.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.orgVincent Guittot <v>
List-Id: linux-pm@vger.kernel.org


--dvwcogjz63nwnatx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 10, 2017 at 10:46:37AM +0530, Viresh Kumar wrote:
> Compiling the DT file with W=3D1, DTC warns like follows:
>=20
> Warning (unit_address_vs_reg): Node /opp_table0/opp@1000000000 has a
> unit name, but no reg property
>=20
> Fix this by replacing '@' with '-' as the OPP nodes will never have a
> "reg" property.
>=20
> Reported-by: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
> Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  .../devicetree/bindings/devfreq/exynos-bus.txt     | 46 +++++++--------
>  Documentation/devicetree/bindings/opp/opp.txt      | 38 ++++++-------
>  arch/arm/boot/dts/exynos3250.dtsi                  | 46 +++++++--------
>  arch/arm/boot/dts/exynos4210.dtsi                  | 32 +++++------
>  arch/arm/boot/dts/exynos4412-prime.dtsi            |  4 +-
>  arch/arm/boot/dts/exynos4412.dtsi                  | 66 +++++++++++-----=
------
>  arch/arm/boot/dts/exynos5420.dtsi                  | 40 ++++++-------
>  arch/arm/boot/dts/exynos5800.dtsi                  | 56 +++++++++-------=
--
>  arch/arm/boot/dts/pxa25x.dtsi                      |  8 +--
>  arch/arm/boot/dts/pxa27x.dtsi                      | 14 ++---
>  arch/arm/boot/dts/sun8i-a33.dtsi                   |  8 +--

For sunxi,
Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--dvwcogjz63nwnatx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJY6yHhAAoJEBx+YmzsjxAgQyAP/2E0WtvSilSrUz9Jj+gapYhN
Htvn9T0ibs7adniSriv3V5sCAQuCCUgS2wTx1B6Yv+wOQIE3TmO1UGJtpYfXcQ70
WGHpZ02tYg6uaEBnW84zYnvAoR2Z8drbTYDj4Jd5Hhdqo4y0GXVlHr581EkUieAw
mmZ9TlGzD4linhqtn6tMMgcLHNRLm8QdcM9aUjWWC5rB8Cymhmkautu8w49yai/d
+njJQWojDkkjU/1ESjJ5VVQWizT+cyOpKo5YS3HRHJJVEhBuJFE+WzipTMJVdZ2P
FGNimu1mYS4g+m+onFJoqySLwC4i3Sx4aMAo1rzbmjcKFXL2tT8S6sspZtdoOh/P
CHPsMMKveI70erQEqp+lYzOCNa2EawWrUy2qasObSE/8PX2B2Gef3n7Qk3THDZO+
Ui6ExnkNXc/nE2kd3QR42atjxANRi3tuFTWjnfTAAQIjKOWCbGVmyTrflS2gFt2b
ortp7Uu6g1AUR5u+kxvg/hrwg8oJkkRZYREIKWPxA5jzsxMo3iVxS75Vx0hu8++w
/8IkyqzGPZMu57SgKEL0fMwcRNtFraUhuUMvxhOPgEyBqTCOrKKeEuPRTXltiwjk
hXP2iCij/IEHTomXzRSdvPaHbfef5RJxOOfuFKcsvctLYq4muIpNTnWv8GtPkhr8
a5jcCeQIyn+hGX2vtLg6
=fllD
-----END PGP SIGNATURE-----

--dvwcogjz63nwnatx--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
