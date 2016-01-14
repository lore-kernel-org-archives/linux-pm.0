From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V4 05/16] soc: tegra: pmc: Avoid extra remapping of PMC
 registers
Date: Thu, 14 Jan 2016 18:24:59 +0100
Message-ID: <20160114172459.GA32767@ulmo>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
 <1449241037-22193-6-git-send-email-jonathanh@nvidia.com>
 <20160114134526.GA23082@ulmo>
 <5697CE50.2050004@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5697CE50.2050004@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Vince Hsu <vinceh@nvidia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 14, 2016 at 04:35:28PM +0000, Jon Hunter wrote:
>=20
> On 14/01/16 13:45, Thierry Reding wrote:
> > * PGP Signed by an unknown key
> >=20
> > On Fri, Dec 04, 2015 at 02:57:06PM +0000, Jon Hunter wrote:
> >> During early initialisation, the PMC registers are mapped and the PMC =
SoC
> >> data is populated in the PMC data structure. This allows other drivers
> >> access the PMC register space, via the public tegra PMC APIs, prior to
> >> probing the PMC device.
> >>
> >> When the PMC device is probed, the PMC registers are mapped again and =
if
> >> successful the initial mapping is freed. If the probing of the PMC dev=
ice
> >> fails after the registers are remapped, then the registers will be
> >> unmapped and hence the pointer to the PMC registers will be invalid. T=
his
> >> could lead to a potential crash, because once the PMC SoC data pointer=
 is
> >> populated, the driver assumes that the PMC register mapping is also va=
lid
> >> and a user calling any of the public tegra PMC APIs could trigger an
> >> exception because these APIs don't check that the mapping is still val=
id.
> >>
> >> Rather than adding a test to see if the PMC register mapping is valid,
> >> fix this by removing the second mapping of the PMC registers and reser=
ve
> >> the memory region for the PMC registers during early initialisation wh=
ere
> >> the initial mapping is created. During the probing of the PMC simply c=
heck
> >> that the PMC registers have been mapped.
> >>
> >> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> >> ---
> >>  drivers/soc/tegra/pmc.c | 19 +++++++++----------
> >>  1 file changed, 9 insertions(+), 10 deletions(-)
> >=20
> > devm_ioremap_resource() was used on purpose to make sure we get a proper
> > name assigned to the memory region in /proc/iomem. As it is, there will
> > be no name associated with it, which I think is unfortunate. As such I'd
> > prefer keeping that call and instead fix the issue with the invalid
> > mapping by making sure that pmc->base is assigned only after nothing can
> > fail in probe anymore.
>=20
> Yes, however, you still get a valid name in /proc/iomem with this
> change. I made sure I tested that ...
>=20
> / # cat /proc/iomem
> 6000d000-6000dfff : /gpio@0,6000d000
> 60020000-600213ff : /dma@0,60020000
> 700008d4-70000b6f : /pinmux@0,700008d4
> 70003000-70003293 : /pinmux@0,700008d4
> 70006000-7000603f : serial
> 7000d100-7000d1ff : /i2c@0,7000d100
> 7000e400-7000e7ff : /pmc@0,7000e400
> ...
>=20
> The only expection might be the non-DT case, but I am not sure we care
> about that for most boards? Hmm ... I wonder if I need to set
> "regs.name" for the non-DT case? I probably should ...

ARCH_TEGRA has depended on OF for a very long time, so I don't think we
care about the non-DT case.

> >> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> >> index e60fc2d33c94..fdd1a8d0940f 100644
> >> --- a/drivers/soc/tegra/pmc.c
> >> +++ b/drivers/soc/tegra/pmc.c
> >> @@ -807,22 +807,17 @@ out:
> >> =20
> >>  static int tegra_pmc_probe(struct platform_device *pdev)
> >>  {
> >> -	void __iomem *base =3D pmc->base;
> >=20
> > The alternative that I proposed above would entail not setting this...
> >=20
> >> -	struct resource *res;
> >>  	int err;
> >> =20
> >> +	if (!pmc->base) {
> >> +		dev_err(&pdev->dev, "base address is not configured\n");
> >> +		return -ENXIO;
> >> +	}
> >> +
> >>  	err =3D tegra_pmc_parse_dt(pmc, pdev->dev.of_node);
> >>  	if (err < 0)
> >>  		return err;
> >> =20
> >> -	/* take over the memory region from the early initialization */
> >> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> -	pmc->base =3D devm_ioremap_resource(&pdev->dev, res);
> >=20
> > ... and storing the result of the mapping in "base" instead...
> >=20
> >> -	if (IS_ERR(pmc->base))
> >> -		return PTR_ERR(pmc->base);
> >> -
> >> -	iounmap(base);
> >=20
> > ... and move the unmap to the very end of the probe function, which
> > would look something like:
> >=20
> > 	/* take over the memory region from the early initialization */
> > 	iounmap(pmc->base);
> > 	pmc->base =3D base;
> >=20
> > That way the mapping in "base" will automatically be undone upon error
> > and the pmc->base will only be overridden when it's certain that the
> > probe will succeed.
> >=20
> > What do you think?
>=20
> I thought about that, but it still seems racy. You probably want to
> assign the new base before freeing the old and so you would need another
> tmp variable.

Ah yes, of course. You could still do it with just the two pointers if
you keep the code as-is and revert back to the backed up value in case
of errors. Along this line:

	base =3D pmc->base;

	pmc->base =3D devm_ioremap_resource(&pdev->dev, res);

	/* on success */
	iounmap(base);

	/* on error */
	pmc->base =3D base;

These pointer assignments should be atomic, so no potential for races
there. I've attached a patch which should do the trick, though I have
not tested it.

>               Even so, I was not sure if there could be a race here.
> Ideally, you would lock, but then you need to lock everywhere that you
> use base. Given that my patch still provides a /proc/iomem entry with a
> valid name, it seems best to me.

The primary reason for the "takeover" is that except for the extra
iounmap() and pointer swapping the tegra_pmc_probe() function is really
a standard driver implementation. The idea behind this had always been
that it should be possible to easily convert this to a proper driver if
either we ended up with PSCI exclusively for SMP or defer SMP setup
until the PMC driver had been probed, so that we could get rid of the
early_initcall().

Thierry

--- >8 ---
diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index d53030ac56f0..f2f6ddfd9399 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -925,7 +925,7 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 	if (IS_ERR(pmc->clk)) {
 		err =3D PTR_ERR(pmc->clk);
 		dev_err(&pdev->dev, "failed to get pclk: %d\n", err);
-		return err;
+		goto error;
 	}
=20
 	pmc->dev =3D &pdev->dev;
@@ -937,17 +937,23 @@ static int tegra_pmc_probe(struct platform_device *pd=
ev)
 	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
 		err =3D tegra_powergate_debugfs_init();
 		if (err < 0)
-			return err;
+			goto error;
 	}
=20
 	err =3D register_restart_handler(&tegra_pmc_restart_handler);
 	if (err) {
 		dev_err(&pdev->dev, "unable to register restart handler, %d\n",
 			err);
-		return err;
+		goto error;
 	}
=20
+	iounmap(base);
+
 	return 0;
+
+error:
+	pmc->base =3D base;
+	return err;
 }
=20
 #if defined(CONFIG_PM_SLEEP) && defined(CONFIG_ARM)

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWl9noAAoJEN0jrNd/PrOhFc4P/RrJ6GsqbsoUPPhUmbo+jsZM
wfJMh2P9SD08Xt0Kvzq0wgAZAf2ujGC2sfqXjblPiDFou5fagCULNJOr/3AtkHYS
YU7es4ZPkjj3ZHqhRhZ+WBpfxJCBG+DvtTZcktKKjE2o3r/Ejd5A13dfcTYbjtAm
viHWtlzxxT+ectXRMhOFay+FXTxgb6zdzVYyHKVd6VRl0Zko8DjUgf23wNisqG4G
5Z008RD5UrdjCtWZZxh6z/OcN8NLpsX7ImFTyKnb/ID1+XKhr1okw+p15YtetbHB
z9Hx2m26JeMnvNhZCyFD6aY4i0rYS7lY2qE89CikY3Q5ntB5F+FWlnDtRbS+WrfE
uSNuage3jliIwzTGyuYdIodppbcObqpclkUYcZdb3KJii1aPzqMat60icdsXFBoC
jSgc5z9sXCFLlsL+JcN3GxlnWoUcF6eCtD+gzy9S+FdO/wipL+hoch8EI4QMP2+O
sFOlzOBZ28wHDbH7CfWmIMTAVke47/Mcag9Q4iihovcCwajJrXfSIctW+lyc9xRs
Ojmg1F+1METMsVQyR9u0kSBHP2jfp09MQDtoxeYS72UQ+WrFjJTzhNCWsowhDuw0
yF98ZECf+7Dj+d9OcclORL37sKO2a+psqMx7AmtNhcscb986C8g1eeWHgb/237Oz
RSg1PN7m/5miuGwyaYUZ
=SBRp
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
