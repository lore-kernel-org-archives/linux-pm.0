From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V4 00/20] Tegra210 DFLL support
Date: Mon, 28 Jan 2019 08:54:42 +0100
Message-ID: <20190128075442.GA18124@ulmo>
References: <20190104030702.8684-1-josephl@nvidia.com>
 <20190125134617.GE22565@ulmo>
 <0a7abeee-1b78-4f90-e94f-43c19eddb9b1@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8459993079152616582=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <0a7abeee-1b78-4f90-e94f-43c19eddb9b1@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Joseph Lo <josephl@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-pm@vger.kernel.org, Peter De Schrijver <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============8459993079152616582==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2019 at 09:43:00AM +0800, Joseph Lo wrote:
> On 1/25/19 9:46 PM, Thierry Reding wrote:
> > On Fri, Jan 04, 2019 at 11:06:42AM +0800, Joseph Lo wrote:
> > > This series introduces support for the DFLL as a CPU clock source
> > > on Tegra210. As Jetson TX1 uses a PWM controlled regulator IC which
> > > is driven directly by the DFLLs PWM output, we also introduce support
> > > for PWM regulators next to I2C controlled regulators. The DFLL output
> > > frequency is directly controlled by the regulator voltage. The regist=
ers
> > > for controlling the PWM are part of the DFLL IP block, so there's no
> > > separate linux regulator object involved because the regulator IC only
> > > supplies the rail powering the CPUs. It doesn't have any other contro=
ls.
> > >=20
> > > The patch 1~4 are the patches of DT bindings update for DFLL clock and
> > > Tegra124 cpufreq, which add PWM and Tegra210 support for DFLL clock a=
nd
> > > remove deprecate properties for Tegra124 cpufreq bindings.
> > >=20
> > > The patch 5~10 are the patches for DFLL clock driver update for PWM-m=
ode
> > > DFLL support.
> > >=20
> > > The patch 11~13 are the Tegra124 cpufreq driver update to make it
> > > work with Tegra210.
> > >=20
> > > The patch 14~19 are the devicetree files update for Tegra210 SoC and
> > > platforms. Two platforms are updated here for different DFLL mode usa=
ge.
> > > The Tegra210-p2371-2180 (a.k.a. Jetson Tx1) uses DFLL-PWM and the
> > > Tegra210-smaug (a.k.a. Pixel C) uses DFLL-I2C. So two different modes
> > > are verified with this series.
> > >=20
> > > The patch 20 is the patch for enabling the CPU regulator for Smaug
> > > board.
> > >=20
> > > * Update in V4:
> > >   - s/nvidia,pwm-period/nvidia,pwm-period-nanoseconds/ in patch 1 for
> > >   DFLL DT bindings update.
> > >   - remove parenthesis in Kconfig of DFLL driver
> > >   - add more ack and RB tags
> > >=20
> > > * Update in V3:
> > >   - Squash patch 9 in previous series into patch 7 (ref. [0])
> > >   - minor fixes in patch 6 for geting alignment data
> > >   - more variable type fixes in patch 7
> > >   - fix the error handling in patch 8
> > >   - collect more ack tags
> > >=20
> > > * Update in V2:
> > >   - Add two patches that suggested from comments in V1. See patch 9 a=
nd
> > >   14.
> > >   - Update DT binding for DFLL-PWM mode in patch 1.
> > >   - Update the code for how to get regulator data from DT or regulator
> > >   API in patch 6.
> > >   - Update to use lut_uv table for LUT lookup in patch 7. That makes =
the
> > >   generic lut table to work with both I2C and PWM mode.
> > >   - not allow Tegra124 cpufreq driver to be built as a module and rem=
ove
> > >   the removal function in patch 12.
> > >=20
> > > [0]: http://patchwork.ozlabs.org/project/linux-tegra/list/?series=3D8=
1595
> > >=20
> > > Joseph Lo (17):
> > >    dt-bindings: clock: tegra124-dfll: add Tegra210 support
> > >    dt-bindings: cpufreq: tegra124: remove vdd-cpu-supply from required
> > >      properties
> > >    dt-bindings: cpufreq: tegra124: remove cpu_lp clock from required
> > >      properties
> > >    clk: tegra: dfll: CVB calculation alignment with the regulator
> > >    clk: tegra: dfll: support PWM regulator control
> > >    clk: tegra: dfll: round down voltages based on alignment
> > >    clk: tegra: dfll: add CVB tables for Tegra210
> > >    cpufreq: tegra124: do not handle the CPU rail
> > >    cpufreq: tegra124: extend to support Tegra210
> > >    cpufreq: dt-platdev: add Tegra210 to blacklist
> > >    arm64: dts: tegra210: add DFLL clock
> > >    arm64: dts: tegra210: add CPU clocks
> > >    arm64: dts: tegra210-p2597: add pinmux for PWM-based DFLL support
> > >    arm64: dts: tegra210-p2371-2180: enable DFLL clock
> > >    arm64: dts: tegra210-smaug: add CPU power rail regulator
> > >    arm64: dts: tegra210-smaug: enable DFLL clock
> > >    arm64: defconfig: Enable MAX8973 regulator
> > >=20
> > > Peter De Schrijver (3):
> > >    dt-bindings: clock: tegra124-dfll: Update DFLL binding for PWM
> > >      regulator
> > >    clk: tegra: dfll: registration for multiple SoCs
> > >    clk: tegra: dfll: build clk-dfll.c for Tegra124 and Tegra210
> >=20
> > Joseph,
> >=20
> > can you detail the dependencies between the various patches. From a
> > brief look the CPU frequency driver changes are completely separate
> > bits and it should be possible to apply them to the cpufreq tree.
> >=20
> > The clock changes also seem independent of the rest.
> >=20
> > Are there any dependencies at all that we need to be mindful about?
> > Or can individual maintainers just pick up the subseries directly?
> >=20
>=20
> Yes, no dependence with each other. We can apply them separately.
> Please let me know if I need to inform cpufreq or clk maintainer to pick
> them up.

Rafael,

the three CPU frequency patches in this series were acked by Viresh
already, but unfortunately you don't seem to be Cc'ed on these. Are
you okay with me picking these up into the Tegra tree and send you
a pull request in a couple of days? That way we can get the whole
set tested a bit in linux-next. If you'd prefer to pick these up in
the PM tree, here are the corresponding patchwork links:

	https://patchwork.kernel.org/patch/10747943/
	https://patchwork.kernel.org/patch/10747947/
	https://patchwork.kernel.org/patch/10747953/

I'll go and give my Acked-by on these patches if the latter is the
way you prefer.


Stephen, Mike,

the same applies for clk patches. Stephen's acked all of them and I
think all of the series is good to go. How about if I pick up these
up in the Tegra tree and let this all cook in linux-next for a week
or so and then send you a pull request with these? Stephen already
picked up a couple of fixes for clk/tegra, but I don't think any of
those would conflict with this series.

All of that said, Joseph confirmed that there are no dependencies
between these subsystem subseries, so if you'd prefer to pick up the
patches into your respective trees, I have no objections to that.

Thierry

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxOtT8ACgkQ3SOs138+
s6HBcRAApHy2CW/WZBXKOmNovh29XJrNWIDxMREUrfkdrCI0oa8ugHPZ2Zhp75Sz
zFYnM2PgMF0uyfLz4a7zbEVEVZgt6LWOKU1AYtTjHSPpMcfo6A0CD1gOutT8CsVu
uIBKaTGECl3bJjMq6ohwWw/nTOW3IaObe+3yWfUbtsEhFRRjzxEQ4D1MPqF8o3U4
xWsDgRiZ8rZt7r7mZIUSJnp4ZTPF+5xIpMu2uUbgZPnQCCfzvHcFyp2P/QCN65u/
FyoqPV9ISZYQDGYCemdJJi0fN3ZYgaqjmFAGW62EPowsnZGqpqAp++AtEcU476n3
KH+9PwVKokOdBQFFGPwjyyhm8AD7eAltXhzd0yPL0x4da3pfyFzZPZ2KQQTm21Uu
SF1j7IuuPSQg9ML8riKD2hYERrcR1cpL1RPsrej3uyqFRVpLxC3potKVTqi7gKtX
Y/JqdXfPeocivOYHUUth3PYLNWguODNoZYVVn07Pm0GijaP5xg6o8eGyC/or/NiZ
phoiK4LOFC8S+rDhhqEb8sooWW4vNbFupK0rxfWGpDWTBb3iu0o5K58UqHU2ZHDw
Xv9ifwCkQS36MrmfVmT0W0fZlfTYf33NoqkmXH6XV+70zbD55NsnpJWxMlE2p71o
n32O9QM2UZPV4o3cPbKzSxgxAFgY31G1bUnnZWEqvVBryi66h38=
=kzjf
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--


--===============8459993079152616582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8459993079152616582==--
