From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v8 00/18] Tegra124 CL-DVFS / DFLL clocksource + cpufreq
Date: Wed, 11 Mar 2015 11:07:43 +0100
Message-ID: <20150311100741.GK19577@ulmo.nvidia.com>
References: <1425213881-5262-1-git-send-email-mikko.perttunen@kapsi.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OX2aLCKeO1apYW07"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:41013 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbbCKKHt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2015 06:07:49 -0400
Content-Disposition: inline
In-Reply-To: <1425213881-5262-1-git-send-email-mikko.perttunen@kapsi.fi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Mikko Perttunen <mikko.perttunen@kapsi.fi>, swarren@wwwdotorg.org, gnurou@gmail.com, pdeschrijver@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, pwalmsley@nvidia.com, vinceh@nvidia.com, pgaikwad@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tuomas.tynkkynen@iki.fi


--OX2aLCKeO1apYW07
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mike,

Have you had a chance to look at these changes to the Tegra clock
driver? If you're fine with it, I'd like to take these patches through
the Tegra tree because the rest of the series depends on them. I can
provide a stable branch in case we need to base other Tegra clock
changes on top of this.

Thierry

On Sun, Mar 01, 2015 at 02:44:23PM +0200, Mikko Perttunen wrote:
> Hi, this is v8 of the Tegra124 cpufreq series. Aside rebasing on latest -=
next,
> the following changes have been done:
>=20
> clk: tegra: Add binding for the Tegra124 DFLL clocksource
> - Changed dfll@ -> clock@
> - Changed compatibility string to "nvidia,tegra124-dfll"
> - Clarified how the vdd-cpu-supply property is used
> - Marked nvidia,cg-scale as optional since it is a boolean property
> - Expanded the 'FS mode' term to 'full speed mode'
> - Added dvco reset control
>=20
> ARM: tegra: Add the DFLL to Tegra124 device tree
> - Changed dfll@ -> clock@
> - Added dvco reset control
>=20
> ARM: tegra: Enable the DFLL on the Jetson TK1
> - Changed dfll@ -> clock@
>=20
> clk: tegra: Initialize PLL_X before CCLK_G to ensure it has a parent
> - Added
>=20
> clk: tegra: Introduce ability for SoC-specific reset control callbacks
> - Added
>=20
> clk: tegra: Add DFLL DVCO reset control for Tegra124
> - Changed to use SoC-specific reset control callback
>=20
> clk: tegra: Add Tegra124 DFLL clocksource platform driver
> - Don't set DVCO reset handlers
>=20
> clk: tegra: Add library for the DFLL clock source (open-loop mode)
> - Use reset control instead of function pointers
>=20
> also added acks from v7.
>=20
> The series is available in a git repository at
>   git://github.com/cyndis/linux.git cldvfs-v8
>=20
> Tested by me on Jetson-TK1 (rev. D).
>=20
> Original cover letter:
>=20
> This series implements the DFLL/CL-DVFS clock source for the fast CPU
> cluster on Tegra124, and a cpufreq driver that uses the DFLL for
> clocking the CPU. Most of this is based on Paul Walmsley's public patch
> set from December 2013, which is available at
> http://comments.gmane.org/gmane.linux.ports.tegra/15273
>=20
> The DFLL clock hardware is a voltage-controlled oscillator plus
> control logic that compares the generated output clock with a
> 51 MHz reference clock, and can make decisions to either lower
> or raise the DFLL voltage to keep the output rate close to the
> software-requested rate. The voltage changes are done by
> communicating with an off-chip PMIC via either I2C or PWM.
> As the DFLL oscillator is powered via the CPU rail, using
> the DFLL as the CPU clocksource also gives us dynamic CPU
> voltage scaling.
>=20
> This series has been tested on the Jetson TK1 (Rev C). Porting this to
> the Venice2 should be simple, though do note that it does not have
> active cooling.
>=20
> Thanks,
> Tuomas
>=20
> Mikko Perttunen (3):
>   clk: tegra: Introduce ability for SoC-specific reset control callbacks
>   clk: tegra: Initialize PLL_X before CCLK_G to ensure it has a parent
>   ARM: tegra: Add CPU regulator to the Jetson TK1 device tree
>=20
> Paul Walmsley (1):
>   clk: tegra: Add DFLL DVCO reset control for Tegra124
>=20
> Tuomas Tynkkynen (14):
>   clk: tegra: Add binding for the Tegra124 DFLL clocksource
>   clk: tegra: Add library for the DFLL clock source (open-loop mode)
>   clk: tegra: Add closed loop support for the DFLL
>   clk: tegra: Add functions for parsing CVB tables
>   clk: tegra: Add Tegra124 DFLL clocksource platform driver
>   clk: tegra: Save/restore CCLKG_BURST_POLICY on suspend
>   clk: tegra: Add the DFLL as a possible parent of the cclk_g clock
>   ARM: tegra: Add the DFLL to Tegra124 device tree
>   ARM: tegra: Enable the DFLL on the Jetson TK1
>   cpufreq: tegra124: Add device tree bindings
>   cpufreq: tegra: Rename tegra-cpufreq to tegra20-cpufreq
>   cpufreq: Add cpufreq driver for Tegra124
>   ARM: tegra: Add entries for cpufreq on Tegra124
>   ARM: tegra: enable Tegra124 cpufreq driver by default
>=20
>  .../bindings/clock/nvidia,tegra124-dfll.txt        |   79 +
>  .../bindings/cpufreq/tegra124-cpufreq.txt          |   44 +
>  arch/arm/boot/dts/tegra124-jetson-tk1.dts          |   15 +-
>  arch/arm/boot/dts/tegra124.dtsi                    |   34 +
>  arch/arm/configs/tegra_defconfig                   |    1 +
>  arch/arm/mach-tegra/Kconfig                        |    1 +
>  drivers/clk/tegra/Makefile                         |    3 +
>  drivers/clk/tegra/clk-dfll.c                       | 1755 ++++++++++++++=
++++++
>  drivers/clk/tegra/clk-dfll.h                       |   54 +
>  drivers/clk/tegra/clk-tegra-super-gen4.c           |   50 +-
>  drivers/clk/tegra/clk-tegra124-dfll-fcpu.c         |  163 ++
>  drivers/clk/tegra/clk-tegra124.c                   |   82 +
>  drivers/clk/tegra/clk.c                            |   36 +-
>  drivers/clk/tegra/clk.h                            |    3 +
>  drivers/clk/tegra/cvb.c                            |  133 ++
>  drivers/clk/tegra/cvb.h                            |   67 +
>  drivers/cpufreq/Kconfig.arm                        |   13 +-
>  drivers/cpufreq/Makefile                           |    3 +-
>  drivers/cpufreq/tegra124-cpufreq.c                 |  217 +++
>  .../cpufreq/{tegra-cpufreq.c =3D> tegra20-cpufreq.c} |    0
>  include/dt-bindings/reset/tegra124-car.h           |   11 +
>  21 files changed, 2730 insertions(+), 34 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra1=
24-dfll.txt
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/tegra124-cp=
ufreq.txt
>  create mode 100644 drivers/clk/tegra/clk-dfll.c
>  create mode 100644 drivers/clk/tegra/clk-dfll.h
>  create mode 100644 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
>  create mode 100644 drivers/clk/tegra/cvb.c
>  create mode 100644 drivers/clk/tegra/cvb.h
>  create mode 100644 drivers/cpufreq/tegra124-cpufreq.c
>  rename drivers/cpufreq/{tegra-cpufreq.c =3D> tegra20-cpufreq.c} (100%)
>  create mode 100644 include/dt-bindings/reset/tegra124-car.h
>=20
> --
> 2.3.0
>=20

--OX2aLCKeO1apYW07
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVABPqAAoJEN0jrNd/PrOhyYQP/2giwh2WkLFyuj0ROTOvJxhQ
svV79n45jh38xbJg/8JFYwF3uWHQaXgYQngKBU0BlKynwRQmozr/UxTs8ym5XMNv
Y3e5X4dWGJnlMyt3swxt1cbK6SCeoHSocW0qu7Dr+5NlXZwdZRPpfEckGa+dOaE+
NnbVJvrJ31rwjKW3sRs3plLhP5e6tMhnJtTgxPpxi18TJRCpyxLIvSs7Y3HhFXC2
klj6rf/lqMFT7u2hMkHOXcII+wfL2lfrI6OvXsW+ehYCPGy+C9IA5mDTj2YEV6Xr
VrL7/wTjPAUm2/T0FbRqVlUUD0JDO2g1VfescC8LPzDT7w6rrx57ECyZ9fqVpTUL
HMR3SyrSXPUUobPc4FQEBV0W2k4mwIyCrR6iCVHmH1rOzs5fs7Ivj1GOJ2c5fzUw
rm45OsmsjDQe+cDF6VUbkh8bcG5WTYkzqF1IRtm8Vjn2SAEBi9rI4LdlaWVU0vJ3
S2wghNDSBfcsc0aXTMAcwCib83e5P8lPFa1Uxoztkh107PQT9u478HIwFS75SAT4
BMkZOD8lyu4PLUSn73AqtqT6SV57nc02qJeLdfgc6/OMjXb7eH9FdeTr6J0+BVmj
+PQC1KC72DqT4zf0e5yGz1RAA7nVFOGojulJTn/uZN70izicNrcWvtm1sbdH/3gQ
OooZQY4de+PPb/IRnWW6
=9FhG
-----END PGP SIGNATURE-----

--OX2aLCKeO1apYW07--
