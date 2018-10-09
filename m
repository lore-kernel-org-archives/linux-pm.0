From: "A.s. Dong" <aisheng.dong@nxp.com>
Subject: RE: [PATCH V4 2/2] firmware: imx: add SCU power domain driver
Date: Tue, 9 Oct 2018 11:19:33 +0000
Message-ID: <AM0PR04MB4211AEE1258E2813B635D05A80E70@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1538917807-1921-1-git-send-email-aisheng.dong@nxp.com>
 <1538917807-1921-3-git-send-email-aisheng.dong@nxp.com>
 <20181009103510.nsnfkx67djuvois6@pengutronix.de>
 <AM0PR04MB42118ACA68B91B0C7D51C0C780E70@AM0PR04MB4211.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <AM0PR04MB42118ACA68B91B0C7D51C0C780E70@AM0PR04MB4211.eurprd04.prod.outlook.com>
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

Hi Sascha,

> > > +
> > > +	ret = of_genpd_add_provider_simple(np, &imx_sc_pd->pd);
> > > +	if (!ret)
> > > +		return &imx_sc_pd->pd;
> > > +
> > > +	pm_genpd_remove_subdomain(genpd_parent, &imx_sc_pd->pd);
> > > +
> > > +err:
> > > +	pr_warn("failed to add PM domain %pOF: %d\n", np, ret);
> >
> > You have a struct device *, you should use dev_* functions.
> 
> Good suggestion.
> 

A bit more thinking of it.

It may be not quite suitable to use dev_* here for print functions
as we need pass in a pointer of struct device for debug purpose only.
And we need change other two places as well which are in the same situation.

In current patch, we already define the print format at the top of the file.
#define pr_fmt(fmt) "scu_pd: " fmt
As SCU PD has only one device, it may does not help too much to use dev_* functions.

Do you think it's reasonable?

If you're okay with this, I will drop this change and resend with other things updated
according to your suggestions.

Regards
Dong Aisheng
