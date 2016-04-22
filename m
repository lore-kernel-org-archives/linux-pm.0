From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 10/11] arm64: tegra: Add clock properties on cpu0 for
 Tegra210
Date: Fri, 22 Apr 2016 15:23:25 +0200
Message-ID: <20160422132325.GN9047@ulmo.ba.sec>
References: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
 <1461321071-6431-11-git-send-email-pchiu@nvidia.com>
 <571A0E95.9040203@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E0h0CbphJD8hN+Gf"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <571A0E95.9040203@nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Penny Chiu <pchiu@nvidia.com>, swarren@wwwdotorg.org, gnurou@gmail.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org, linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--E0h0CbphJD8hN+Gf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 22, 2016 at 12:44:21PM +0100, Jon Hunter wrote:
> Hi Penny,
>=20
> On 22/04/16 11:31, Penny Chiu wrote:
> > Add clocks, clock-names, and clock-latency into cpu0 node.
> > These properties will be used by cpufreq driver.
> >=20
> > Signed-off-by: Penny Chiu <pchiu@nvidia.com>
> > ---
> >  arch/arm64/boot/dts/nvidia/tegra210.dtsi | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot=
/dts/nvidia/tegra210.dtsi
> > index 204d9cd..1a85857 100644
> > --- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> > +++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> > @@ -782,6 +782,12 @@
> >  			device_type =3D "cpu";
> >  			compatible =3D "arm,cortex-a57";
> >  			reg =3D <0>;
> > +			clocks =3D <&tegra_car TEGRA210_CLK_CCLK_G>,
> > +				 <&tegra_car TEGRA210_CLK_PLL_X>,
> > +				 <&tegra_car TEGRA210_CLK_PLL_P_OUT4>,
> > +				 <&dfll>;
> > +			clock-names =3D "cpu_g", "pll_x", "pll_p", "dfll";
> > +			clock-latency =3D <300000>;
> >  		};
> > =20
> >  		cpu@1 {
> >=20
>=20
> Can you include a patch with this series to update the binding
> documentation for the nvidia,tegra124-cpufreq.txt? I think that although
> there is no specific nvidia,tegra210-cpufreq compatible string the
> documentation should state that both tegra124 and tegra210 are supported
> so it is clear.
>=20
> Also I see the above binding no longer includes the "cpu_lp" for
> tegra210 which I understand we don't use here. However, the binding
> documentation should reflect this. Having said that, looking at the
> driver it appears the "cpu_lp" clock is not even used for tegra124. I
> wonder if we should drop this from the binding documentation and the
> tegra124.dtsi altogether?
>=20
> What about the "vdd-cpu-supply" property? Don't we need this?

For some reason that seems to have moved into the clock@70110000 node.

Thierry

--E0h0CbphJD8hN+Gf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXGiXNAAoJEN0jrNd/PrOhBk4P/jb2b73ahmJWWLCMhTVdj6WL
0PW8QbXi8+uy8EsFYFtbjiEIDtMH9EozmpkGtIxypzZ0KDfbnxaOQczEkEFRDBMn
rVVKANIozpXLe4rU8a8719GxeEitg8+gwmzz3G8nFPMwtmb7rfPjl1P0ZW5d5Bqh
BpL1q0gQFWG5t8lGUF5QO21WFbxcQQ8G1d7PzE9IARcwgQpxiy9GrsPthxTI649K
TZRiR//NpYxU6meh1x98Wfw9noJRI5dAbIWNQjKwTjUGeD4gezBEDQhllAJeiIHE
9ULFuWRZr+/xspD9wnv6E+/STMZQ9t8XOXzBWQpXyyjYzvTSz5N9d1A4XvfRAyJD
5wcZ4wwn5JjOlwuklE6XyJiwSKDxHezFvO5HbmLkDcqwX2++NkYWjXz6z7ONm4cV
OXgLHFQSSkTp0v566xsxoU1vAC5p2fZZmn7xwA9zoYxOffATik5jY+bm6YCh5k1Z
T85ee/gxRFe5cDDiPB1GoUkqbFQJ479oWufpK+MaIFDEnn/J08/OizfXAkXIl0nd
qiwCkZ3BK1xVDMP48UjnIq4gkTfuFAg0FkLwjShbU6G5CMo2FFc2rJUbZSsi7JC0
ZDiksOsdcxQPHCuB5tWkHVfQXfMZcD1zRTme/Hb7WER5Yj8RhD8QzdeTX/ch/caa
J9309qUY43TvAJNaDAjO
=6WzJ
-----END PGP SIGNATURE-----

--E0h0CbphJD8hN+Gf--
