From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] PCI: imx: Fix probe failure without power domain
Date: Tue, 22 Jan 2019 10:44:30 +0100
Message-ID: <20190122094430.rg76mkemz5wvk5t3@pengutronix.de>
References: <cover.1548110502.git.leonard.crestez@nxp.com>
 <375a852ae9170a5f8f53fdd364a7fb7ea642e89c.1548110502.git.leonard.crestez@nxp.com>
 <20190122071251.tgdwnunxksa45n5q@pengutronix.de>
 <VI1PR04MB5533DE236150B01461555A5BEE980@VI1PR04MB5533.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <VI1PR04MB5533DE236150B01461555A5BEE980@VI1PR04MB5533.eurprd04.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Richard Zhu <hongxing.zhu@nxp.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, "Lukas F . Hartmann" <lukas@mntmn.com>, Jon Hunter <jonathanh@nvidia.com>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 22, 2019 at 09:17:22AM +0000, Leonard Crestez wrote:
> On 1/22/2019 9:12 AM, Uwe Kleine-K=F6nig wrote:
> > On Mon, Jan 21, 2019 at 10:50:04PM +0000, Leonard Crestez wrote:
> >> On chips without a separate power domain for PCI (such as 6q/6qp) the
> >> imx6_pcie_attach_pd function incorrectly returns an error.
> >>
> >> Fix by returning 0 if dev_pm_domain_attach_by_name doesn't find
> >> anything.
> >>
> >> Fixes: 3f7cceeab895 ("PCI: imx: Add multi-pd support")
> >>
> >> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/contr=
oller/dwc/pci-imx6.c
> >> @@ -308,10 +308,13 @@ static int imx6_pcie_attach_pd(struct device *de=
v)
> >>   		return 0;
> >>   =

> >>   	imx6_pcie->pd_pcie =3D dev_pm_domain_attach_by_name(dev, "pcie");
> >>   	if (IS_ERR(imx6_pcie->pd_pcie))
> >>   		return PTR_ERR(imx6_pcie->pd_pcie);
> >> +	/* Do nothing when power domain missing */
> >> +	if (!imx6_pcie->pd_pcie)
> >> +		return 0;
> > =

> > As I said in the mail that proposed this patch for testing: I think it
> > would be better to change dev_pm_domain_attach_by_name to not return an
> > error indication by returning NULL or an ERR_PTR value. (Or change
> > device_link_add to accept NULL if NULL is a dummy value.)
> > =

> > Just repeating it here to have it near the actual patch.
> =

> Link to that previous discussion: =

> http://lists.infradead.org/pipermail/linux-arm-kernel/2019-January/626859=
.html
> =

> I'm not sure what you mean. Should dev_pm_domain_attach_by_name return =

> ERR_PTR(-ENOENT) for name not found? It would still require special =

> handling for callers.

Yes, callers would still need to handle an error, but they only need to
check for IS_ERR(retval) instead of IS_ERR(retval) && retval !=3D NULL.

> The device_link_add function already returns NULL if the consumer or =

> supplier is NULL but that's also the only way it signals failure. Maybe =

> that function should be adjusted to return ERR_PTR instead?
> =

> Changing core API for a driver bug seems inappropriate.

Well, if the driver bug is there because the API is used in a wrong way
and the right way is strange, fixing the API and checking other users
for similar mistakes is the right thing to do.

> The current imx6_pcie_attach_pd code is complicated because it tries to =

> distinguish between "multi pd" and "no pd / single pd". I wish there was =

> a way for these PM_RUNTIME device_links to be setup automatically in =

> core and have multi-PD behave the same as a single PD.
> =

> There aren't many multi-PD users but commit 6494a9ad86de ("usb: xhci: =

> tegra: Add genpd support") seems to do pretty much the same thing.

I don't know enough about power domains to follow this argumentation in
the time I have available.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
