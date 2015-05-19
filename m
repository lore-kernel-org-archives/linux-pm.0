From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v10 05/17] clk: tegra: Introduce ability for SoC-specific
 reset control callbacks
Date: Tue, 19 May 2015 17:22:10 +0200
Message-ID: <20150519152208.GB28161@ulmo.nvidia.com>
References: <1431529131-16710-6-git-send-email-mikko.perttunen@kapsi.fi>
 <1432035567-19008-1-git-send-email-mikko.perttunen@kapsi.fi>
 <20150519145922.GA28018@ulmo>
 <555B517F.4080506@kapsi.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <555B517F.4080506@kapsi.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Cc: swarren@wwwdotorg.org, gnurou@gmail.com, pdeschrijver@nvidia.com, mturquette@linaro.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, pwalmsley@nvidia.com, vinceh@nvidia.com, pgaikwad@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tuomas.tynkkynen@iki.fi
List-Id: linux-pm@vger.kernel.org


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2015 at 06:06:39PM +0300, Mikko Perttunen wrote:
> On 05/19/2015 05:59 PM, Thierry Reding wrote:
> >On Tue, May 19, 2015 at 02:39:27PM +0300, Mikko Perttunen wrote:
> >>This patch allows SoC-specific CAR initialization routines to register
> >>their own reset_assert and reset_deassert callbacks with the common Teg=
ra
> >>CAR code. If defined, the common code will call these callbacks when a
> >>reset control with number >=3D num_periph_banks * 32 is attempted to be=
 asserted
> >>or deasserted respectively. Numbers greater than or equal to num_periph=
_banks * 32
> >>are used to avoid clashes with low numbers that are automatically mappe=
d to
> >>standard CAR reset lines.
> >>
> >>Each SoC with these special resets should specify the defined reset con=
trol
> >>numbers in a device tree header file.
> >
> >This is looking pretty good, but I think we can simplify a wee bit
> >more...
> >
> >>Signed-off-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
> >>Acked-by: Michael Turquette <mturquette@linaro.org>
> >>---
> >>  drivers/clk/tegra/clk.c | 39 +++++++++++++++++++++++++++++++--------
> >>  drivers/clk/tegra/clk.h |  3 +++
> >>  2 files changed, 34 insertions(+), 8 deletions(-)
> >>
> >>diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
> >>index 41cd87c..c093ed9 100644
> >>--- a/drivers/clk/tegra/clk.c
> >>+++ b/drivers/clk/tegra/clk.c
> >>@@ -49,7 +49,6 @@
> >>  #define RST_DEVICES_L			0x004
> >>  #define RST_DEVICES_H			0x008
> >>  #define RST_DEVICES_U			0x00C
> >>-#define RST_DFLL_DVCO			0x2F4
> >>  #define RST_DEVICES_V			0x358
> >>  #define RST_DEVICES_W			0x35C
> >>  #define RST_DEVICES_X			0x28C
> >>@@ -79,6 +78,11 @@ static struct clk **clks;
> >>  static int clk_num;
> >>  static struct clk_onecell_data clk_data;
> >>
> >>+/* Handlers for SoC-specific reset lines */
> >>+static int (*special_reset_assert)(unsigned long);
> >>+static int (*special_reset_deassert)(unsigned long);
> >>+static int special_reset_num;
> >
> >I think we can get rid of this if we...
> >
> >>+
> >>  static struct tegra_clk_periph_regs periph_regs[] =3D {
> >>  	[0] =3D {
> >>  		.enb_reg =3D CLK_OUT_ENB_L,
> >>@@ -152,19 +156,29 @@ static int tegra_clk_rst_assert(struct reset_cont=
roller_dev *rcdev,
> >>  	 */
> >>  	tegra_read_chipid();
> >>
> >>-	writel_relaxed(BIT(id % 32),
> >>-			clk_base + periph_regs[id / 32].rst_set_reg);
> >>+	if (id < periph_banks * 32) {
> >>+		writel_relaxed(BIT(id % 32),
> >>+			       clk_base + periph_regs[id / 32].rst_set_reg);
> >>+		return 0;
> >>+	} else if (id < periph_banks * 32 + special_reset_num) {
> >>+		return special_reset_assert(id);
> >>+	}
> >
> >... pass id - periph_banks * 32 into special_reset_assert(). Oh, but
> >then...
>=20
> The reason I don't subtract periph_banks * 32 is because this way the code
> in the SoC-specific callback can just include the dt-bindings header and =
use
> the same defines used in the device tree.

Indeed, you're right. Now if

	static int special_reset_num;

could be turned into

	static unsigned int num_special_reset;

I'd be happy to take this into the Tegra clock tree.

Thierry

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVW1UgAAoJEN0jrNd/PrOhRiYQAJ5U7P2LdmXYDWf5bklITLT5
B1UuYQo4UUljiagLsRZ0asTEdd2QpIL29MT8RdxmHXSLiE6tiC4q8b+fJvjOfGMt
2fLbDXVfeHIoTa9Wyq2YOcmqn68qd8Ox7LKMOIshkXPI4VGURFEY9o44hpGPACuV
lU+MX+GcxQabec7DtcD4rRf1jjW8cMRqHidFesT/wRLn5JnXUBUD1nuZSV1Xrd3m
EEaNRYdsB+EQ6K+tNoCDEOQ8zw6QjuOBTPquFg355qwg7ejkZaUao26rI11wH+C1
8XkZnM9Hyc44omM+978tv+PPEY6PRE3AIR7n1Nz9xaMmY1i7/2BXRdzWQnOkWh+J
T4c4FxlmkQjhXnhZxhcPwm7YUnL0nRECICvJ0dfplbh/KQjMyjPJaDhBi3bUgkWu
jE0yenjvJ0D8bt5fvMq/ilwZApA4KT7woC2ISm54A5nKkLdOSgW2Sq0fN+n1R41U
v0UV7BObvG+k0gTZv+JZBH+cIGJH6J31V0tGln7QYBH8yh3fAUH4ZziLcXyV6038
Rd/MCTWyz1emD8xPJiGGPyTTMv69jEuPGKL/MtdR0kTML6+w+Fp3RYC6MdmjtxoP
3R3cm+zkFD3UDW2t5YUPLBxyVKNp4oqoJ4Z+4Ox0TLnArwNi5DLRIUWrZV0ctT+S
ABKYPYQN3v++1DM7j3ql
=NA7o
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
