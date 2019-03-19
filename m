From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] dt-bindings: hwmon (pwm-fan) Remove dead
 "cooling-*-state" properties
Date: Tue, 19 Mar 2019 16:14:07 +0100
Message-ID: <20190319151407.GA30117@ulmo>
References: <afde4ebd929821d63b5172c8e70e15f0725a4b49.1553006788.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6991963019920697400=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <afde4ebd929821d63b5172c8e70e15f0725a4b49.1553006788.git.robin.murphy@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, jdelvare@suse.com, heiko@sntech.de, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, krzk@kernel.org, jonathanh@nvidia.com, kgene@kernel.org, linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org, linux@roeck-us.net
List-Id: linux-pm@vger.kernel.org


--===============6991963019920697400==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2019 at 02:54:04PM +0000, Robin Murphy wrote:
> The old "cooling-{min,max}-state" properties for thermal bindings were
> ratified to "cooling-{min,max}-level" by commit eb168b70dea5 ("of:
> thermal: Fix inconsitency between cooling-*-state and cooling-*-level"),
> which were later removed entirely by commit e04907dbc259 ("dt-bindings:
> thermal: Remove "cooling-{min|max}-level" properties").
>=20
> The pwm-fan binding, however, was apparently in-flight in parallel with
> that ratification, and so managed to introduce an example of the old
> properties which escaped the scope of the later cleanup and has thus
> continued to be dutifully copied for new boards despite being useless.
> Clean up these remaining undocumented anachronisms to minimise any
> further confusion.
>=20
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>=20
> Presented as one big hwmon patch for simplicity, but the DT changes
> can quite easily be broken out by platform if maintainers prefer.
>=20
> Robin.
>=20
>  Documentation/devicetree/bindings/hwmon/pwm-fan.txt | 2 --
>  arch/arm/boot/dts/exynos4412-odroidu3.dts           | 2 --
>  arch/arm/boot/dts/exynos5410-odroidxu.dts           | 2 --
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi  | 2 --
>  arch/arm/boot/dts/imx6qdl-emcon.dtsi                | 2 --
>  arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts  | 2 --

Acked-by: Thierry Reding <treding@nvidia.com>

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyRBzwACgkQ3SOs138+
s6FiOA/7BkzGBW7hWW2KtXIWUMWewb3SleBXsp/dx7l2U0rsm77sHX9lHnWCfAxE
fSkK6n+ND8WLb4Yqy4B/ZF1JDQ5PXW3OLhjZUymh3re0hdEN7c0GCeN6Byyu7WJt
IT0tMp5eS6jRxdOYa2AYYs2goG0DAb//TN3Fa4gXb327uNyjApiHKCgM8c1h1yxv
lU57rksIdG3Q/JfovZrNvqHQD4/CxG4szOXpFmLpBCBHG8cTL9Q5DbKgeLQGspqB
dmIIXg8xoVxTm20PgSDneSkkNuAXV0FykBqbrbeDDeV8QCli0e/YCAYEjLN9MCIi
3jEt+oxVaHDgGaYsGzExDx/i1JmNV4ZnVcHPWcTKoUB1Cw+m95gBYF/T8mdMA4kc
CX7Ifbb/15Dw3HlVEquOtXILdNHdv2zJ7/4uQStf22J+ilQDqA86gjynEYF0VSQY
EYSUmTPBoQCEd79W/pBG6pMIihhcLC1sQ55rFkL9lt42ZSZWF7Y6t3aA5SjmLUdB
Kx79+1pkA/XyiQSc6njs8lzm30Rr9I43ShYJsfwVLqeosGM5ahZqD0fvr+Ixo6AU
kLVoT2AKNkN6YOja9znodLUNLA9GfNGBdzuDs4HKxA4nPBtqw7NokLSRYFNjbpyo
Z6oIa9cbLjGpeBskG3xSH7/OYixfQB7yXdjTWj2+QdjWdhqwCyY=
=GdJ9
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--


--===============6991963019920697400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6991963019920697400==--
