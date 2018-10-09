From: "A.s. Dong" <aisheng.dong@nxp.com>
Subject: RE: [PATCH V4 2/2] firmware: imx: add SCU power domain driver
Date: Tue, 9 Oct 2018 10:48:54 +0000
Message-ID: <AM0PR04MB42118ACA68B91B0C7D51C0C780E70@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1538917807-1921-1-git-send-email-aisheng.dong@nxp.com>
 <1538917807-1921-3-git-send-email-aisheng.dong@nxp.com>
 <20181009103510.nsnfkx67djuvois6@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181009103510.nsnfkx67djuvois6@pengutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "dongas86@gmail.com" <dongas86@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "khilman@kernel.org" <khilman@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org


> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer@pengutronix.de]
> Sent: Tuesday, October 9, 2018 6:35 PM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org; ulf.hansson@linaro.org;
> dongas86@gmail.com; khilman@kernel.org; linux-pm@vger.kernel.org;
> rjw@rjwysocki.net; dl-linux-imx <linux-imx@nxp.com>;
> kernel@pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> shawnguo@kernel.org
> Subject: Re: [PATCH V4 2/2] firmware: imx: add SCU power domain driver
> 
> Hi Dong,
> 
> Looks mostly ok to me, some minor comments inside.
> 
> On Sun, Oct 07, 2018 at 09:10:07PM +0800, Dong Aisheng wrote:
> > Some i.MX SoCs contain a system controller that is responsible for
> > controlling the state of the IPs that are present. Communication
> > between the host processor running an OS and the system controller
> > happens through a SCU protocol. This patch adds SCU protocol based
> > power domains drivers.
> >
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Kevin Hilman <khilman@kernel.org>
> > Cc: linux-pm@vger.kernel.org
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> > +static struct generic_pm_domain *imx_sc_pm_add_one_domain(
> > +					struct device_node *np,
> > +					struct generic_pm_domain *genpd_parent) {
> > +	struct imx_sc_pm_domain *imx_sc_pd;
> > +	u32 rsrc_id;
> > +	int ret;
> > +
> > +	imx_sc_pd = kzalloc(sizeof(*imx_sc_pd), GFP_KERNEL);
> > +	if (!imx_sc_pd)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	if (!of_property_read_u32(np, "reg", &rsrc_id)) {
> > +		if (rsrc_id > IMX_SC_R_LAST) {
> 
> Should this be >= instead?
> 

You're right. 

> > +			pr_warn("%pOF: invalid rsrc id %d found", np, rsrc_id);
> > +			ret = -EINVAL;
> > +			goto err;
> > +		}
> > +		imx_sc_pd->rsrc_id = rsrc_id;
> > +	} else {
> > +		imx_sc_pd->rsrc_id = IMX_SC_R_LAST;
> > +	}
> > +
> > +	if (imx_sc_pd->rsrc_id != IMX_SC_R_LAST) {
> > +		imx_sc_pd->pd.power_off = imx_sc_pd_power_off;
> > +		imx_sc_pd->pd.power_on = imx_sc_pd_power_on;
> > +	}
> 
> Can be moved into the property exists test above.
> 

Good suggestion

> > +
> > +	imx_sc_pd->pd.name = np->name;
> > +
> > +	ret = pm_genpd_init(&imx_sc_pd->pd, NULL, true);
> > +	if (ret < 0)
> > +		goto err;
> > +
> > +	if (genpd_parent) {
> > +		ret = pm_genpd_add_subdomain(genpd_parent, &imx_sc_pd->pd);
> > +		if (ret)
> > +			goto err;
> > +	}
> > +
> > +	ret = of_genpd_add_provider_simple(np, &imx_sc_pd->pd);
> > +	if (!ret)
> > +		return &imx_sc_pd->pd;
> > +
> > +	pm_genpd_remove_subdomain(genpd_parent, &imx_sc_pd->pd);
> > +
> > +err:
> > +	pr_warn("failed to add PM domain %pOF: %d\n", np, ret);
> 
> You have a struct device *, you should use dev_* functions.

Good suggestion.

Will update and resend a new version.
Thanks for the carefully review.

Regards
Dong Aisheng

> 
> Sascha
> 
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=02%7C01%7Caisheng.dong%40nxp.com%7C49
> 9fbc118b8948ed075908d62dd2e6b1%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C636746781171494898&amp;sdata=MwU9%2BAzpX8Tmwd
> pYch7ztNZXRo4aqifxbbtALjuW9lo%3D&amp;reserved=0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
