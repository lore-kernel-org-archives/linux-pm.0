From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v7 01/16] clk: tegra: Add binding for the Tegra124 DFLL
 clocksource
Date: Thu, 12 Feb 2015 23:42:44 +0100
Message-ID: <20150212224242.GA23500@mithrandir>
References: <1420723339-30735-1-git-send-email-mikko.perttunen@kapsi.fi>
 <1420723339-30735-2-git-send-email-mikko.perttunen@kapsi.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420723339-30735-2-git-send-email-mikko.perttunen@kapsi.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Cc: swarren@wwwdotorg.org, gnurou@gmail.com, pdeschrijver@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@linaro.org, pwalmsley@nvidia.com, vinceh@nvidia.com, pgaikwad@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tuomas.tynkkynen@iki.fi, Tuomas Tynkkynen <ttynkkynen@nvidia.com>
List-Id: linux-pm@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 08, 2015 at 03:22:04PM +0200, Mikko Perttunen wrote:
> From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
>=20
> The DFLL is the main clocksource for the fast CPU cluster on Tegra124
> and also provides automatic CPU rail voltage scaling as well. The DFLL
> is a separate IP block from the usual Tegra124 clock-and-reset
> controller, so it gets its own node in the device tree.
>=20
> Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
> Signed-off-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
> ---
>  .../bindings/clock/nvidia,tegra124-dfll.txt        | 69 ++++++++++++++++=
++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra1=
24-dfll.txt
>=20
> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll=
=2Etxt b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
> new file mode 100644
> index 0000000..54c62ac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
> @@ -0,0 +1,69 @@
> +NVIDIA Tegra124 DFLL FCPU clocksource
> +
> +This binding uses the common clock binding:
> +Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +The DFLL IP block on Tegra is a root clocksource designed for clocking
> +the fast CPU cluster. It consists of a free-running voltage controlled
> +oscillator connected to the CPU voltage rail (VDD_CPU), and a closed loop
> +control module that will automatically adjust the VDD_CPU voltage by
> +communicating with an off-chip PMIC either via an I2C bus or via PWM sig=
nals.

How would PWM communication work? The documentation below doesn't
describe it, so perhaps either leave that part out until the binding is
updated to support it, or maybe make an explicit note that this mode of
operation isn't supported yet?

> +Required properties:
> +- compatible : should be "nvidia,tegra124-dfll-fcpu"
> +- reg : Defines the following set of registers, in the order listed:
> +        - registers for the DFLL control logic.
> +        - registers for the I2C output logic.
> +        - registers for the integrated I2C master controller.
> +        - look-up table RAM for voltage register values.

Why do these all need to be separate sets? According to the TRM this is
a single IP block with a single register region, why the need to split
them apart?

> +- interrupts: Should contain the DFLL block interrupt.
> +- clocks: Must contain an entry for each entry in clock-names.
> +  See ../clocks/clock-bindings.txt for details.
> +- clock-names: Must include the following entries:
> +  - soc: Clock source for the DFLL control logic.
> +  - ref: The closed loop reference clock
> +  - i2c: Clock source for the integrated I2C master.
> +- #clock-cells: Must be 0.
> +- clock-output-names: Name of the clock output.
> +- vdd-cpu-supply: Regulator for the CPU voltage rail that the DFLL
> +  hardware will start controlling.

How does the hardware control it? How do we go from regulator phandle to
something that the hardware will know how to access?

> +Required properties for the control loop parameters:
> +- nvidia,sample-rate: Sample rate of the DFLL control loop.
> +- nvidia,droop-ctrl: See the register CL_DVFS_DROOP_CTRL in the TRM.
> +- nvidia,force-mode: See the field DFLL_PARAMS_FORCE_MODE in the TRM.
> +- nvidia,cf: Numeric value, see the field DFLL_PARAMS_CF_PARAM in the TR=
M.
> +- nvidia,ci: Numeric value, see the field DFLL_PARAMS_CI_PARAM in the TR=
M.
> +- nvidia,cg: Numeric value, see the field DFLL_PARAMS_CG_PARAM in the TR=
M.
> +- nvidia,cg-scale: Boolean value, see the field DFLL_PARAMS_CG_SCALE in =
the TRM.
> +
> +Required properties for I2C mode:
> +- nvidia,i2c-fs-rate: I2C transfer rate, if using FS mode.

What's FS mode?

> +
> +Example:
> +
> +dfll@0,70110000 {

Perhaps this should be "clock@0,70110000"?

> +        compatible =3D "nvidia,tegra124-dfll";
> +        reg =3D <0 0x70110000 0 0x100>, /* DFLL control */
> +              <0 0x70110000 0 0x100>, /* I2C output control */
> +              <0 0x70110100 0 0x100>, /* Integrated I2C controller */
> +              <0 0x70110200 0 0x100>; /* Look-up table RAM */
> +        interrupts =3D <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks =3D <&tegra_car TEGRA124_CLK_DFLL_SOC>,
> +                 <&tegra_car TEGRA124_CLK_DFLL_REF>,
> +                 <&tegra_car TEGRA124_CLK_I2C5>;

If this controls I2C5 now, should it be documented that we can't use
this controller in software while it is in use by DFLL?

Thierry

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJU3SxdAAoJEN0jrNd/PrOhZn8P/R+RqI5NoTtPgEW5f8ojoyjZ
rqNppPezGsXcD+S9Z7mLOLYnUJ+ZPgMt4V6eYOyoOfwr7+a43C5M0c9dMT66gVgv
P4NsKMb7xdcpbSuuUXzKMTlFNJYyUaOx1Us/kfXLNE27c8uJvH/glA1FwdR0+P9k
+iatDFkrUxFbXBzFAoXIcrTpWduLOuU93mayFoVtHfQSPwc6khcG8UKSYT/DWNJJ
gUAoJEorbNPy4nblq8VcUdRuobKc/v7dueAVlnAa7mw+rqE2s0Eu0hLNqFQtVz2T
GK5dB8Z0NAEh+lKxa7/piGyB8TjVSo1kmHhgwtQOwDUmKQBt/1dx+1dbxb1x5GAZ
AUCYVcRu26GtnTxT1AOMHyjoReFIIfvKYkaSoG3TCcDiVZkLLI/UP/pBZTiHf/e2
5eTrulvDHUWyM7VVQIu9oVPQvlvyLpGs/wrH0BDYGpEL91lcvmv2Kwz1lvPQ2rbD
xYgioJCPzatvWVLlrlEFeoseMK/QHgZTEJKkZTcNA0GiFt29WIs4CebMmhSo5k0E
bIRYTGHx2kJNLzU0GBhm4mYnzXnQr1lEJgybPPafZen4wL5nzhA8lZxkq50/7Kn3
kI5sy2snoCrlTz+H+Dx+xidF4mEqqN7XXvkrQmbVsiqswaiYrBebFSQ7Tn2jDwgE
wupUliJZ5jnwfUcM6npX
=5CO2
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
