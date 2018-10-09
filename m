From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH V4 2/2] firmware: imx: add SCU power domain driver
Date: Tue, 9 Oct 2018 12:35:10 +0200
Message-ID: <20181009103510.nsnfkx67djuvois6@pengutronix.de>
References: <1538917807-1921-1-git-send-email-aisheng.dong@nxp.com>
 <1538917807-1921-3-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1538917807-1921-3-git-send-email-aisheng.dong@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dong Aisheng <aisheng.dong@nxp.com>
Cc: ulf.hansson@linaro.org, dongas86@gmail.com, linux-pm@vger.kernel.org, khilman@kernel.org, rjw@rjwysocki.net, linux-imx@nxp.com, kernel@pengutronix.de, fabio.estevam@nxp.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Dong,

Looks mostly ok to me, some minor comments inside.

On Sun, Oct 07, 2018 at 09:10:07PM +0800, Dong Aisheng wrote:
> Some i.MX SoCs contain a system controller that is responsible for
> controlling the state of the IPs that are present. Communication
> between the host processor running an OS and the system controller
> happens through a SCU protocol. This patch adds SCU protocol based
> power domains drivers.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> +static struct generic_pm_domain *imx_sc_pm_add_one_domain(
> +					struct device_node *np,
> +					struct generic_pm_domain *genpd_parent)
> +{
> +	struct imx_sc_pm_domain *imx_sc_pd;
> +	u32 rsrc_id;
> +	int ret;
> +
> +	imx_sc_pd = kzalloc(sizeof(*imx_sc_pd), GFP_KERNEL);
> +	if (!imx_sc_pd)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (!of_property_read_u32(np, "reg", &rsrc_id)) {
> +		if (rsrc_id > IMX_SC_R_LAST) {

Should this be >= instead?

> +			pr_warn("%pOF: invalid rsrc id %d found", np, rsrc_id);
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +		imx_sc_pd->rsrc_id = rsrc_id;
> +	} else {
> +		imx_sc_pd->rsrc_id = IMX_SC_R_LAST;
> +	}
> +
> +	if (imx_sc_pd->rsrc_id != IMX_SC_R_LAST) {
> +		imx_sc_pd->pd.power_off = imx_sc_pd_power_off;
> +		imx_sc_pd->pd.power_on = imx_sc_pd_power_on;
> +	}

Can be moved into the property exists test above.

> +
> +	imx_sc_pd->pd.name = np->name;
> +
> +	ret = pm_genpd_init(&imx_sc_pd->pd, NULL, true);
> +	if (ret < 0)
> +		goto err;
> +
> +	if (genpd_parent) {
> +		ret = pm_genpd_add_subdomain(genpd_parent, &imx_sc_pd->pd);
> +		if (ret)
> +			goto err;
> +	}
> +
> +	ret = of_genpd_add_provider_simple(np, &imx_sc_pd->pd);
> +	if (!ret)
> +		return &imx_sc_pd->pd;
> +
> +	pm_genpd_remove_subdomain(genpd_parent, &imx_sc_pd->pd);
> +
> +err:
> +	pr_warn("failed to add PM domain %pOF: %d\n", np, ret);

You have a struct device *, you should use dev_* functions.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
