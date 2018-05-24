From: "A.s. Dong" <aisheng.dong@nxp.com>
Subject: RE: [PATCH 2/2] soc: imx: add SCU power domains driver
Date: Thu, 24 May 2018 08:37:07 +0000
Message-ID: <AM0PR04MB42114331A1E75B3B90B07E56806A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1524855063-14996-1-git-send-email-aisheng.dong@nxp.com>
 <1524855063-14996-3-git-send-email-aisheng.dong@nxp.com>
 <CAPDyKFowdpxwNMmDjdD3qcqnAcQZA9-MYWnTcZL-oSbwg8WYMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFowdpxwNMmDjdD3qcqnAcQZA9-MYWnTcZL-oSbwg8WYMg@mail.gmail.com>
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
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Dong Aisheng <dongas86@gmail.com>, Kevin Hilman <khilman@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Ulf,

Thanks for the review.

> -----Original Message-----
> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> Sent: Wednesday, May 9, 2018 3:16 AM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>; Dong Aisheng
> <dongas86@gmail.com>; Sascha Hauer <kernel@pengutronix.de>; Shawn
> Guo <shawnguo@kernel.org>; Fabio Estevam <fabio.estevam@nxp.com>;
> dl-linux-imx <linux-imx@nxp.com>; Rafael J. Wysocki <rjw@rjwysocki.net>;
> Kevin Hilman <khilman@kernel.org>; Linux PM <linux-pm@vger.kernel.org>
> Subject: Re: [PATCH 2/2] soc: imx: add SCU power domains driver
> 
> [...]
> 
> > +
> > +static int __init imx_sc_init_pm_domains(void) {
> > +       struct generic_pm_domain *pd;
> > +       struct device_node *np;
> > +       sc_err_t sci_err;
> > +
> > +       if (!of_machine_is_compatible("fsl,imx8qxp"))
> > +               return 0;
> > +
> > +       sci_err = sc_ipc_get_handle(&pm_ipc_handle);
> > +       if (sci_err != SC_ERR_NONE) {
> > +               pr_err("imx_sc_pd: can't get sc ipc handle\n");
> > +               return -ENODEV;
> > +       }
> > +
> > +       for_each_matching_node(np, imx_sc_pm_domain_of_match) {
> > +               pd = imx_sc_pm_add_one_domain(np, NULL);
> > +               if (!IS_ERR(pd))
> > +                       imx_sc_pm_add_subdomains(np, pd);
> > +       }
> 
> Perhaps using of_genpd_add_subdomain() may help here and possibly could
> avoid some open coding!?
> 

Thanks for the suggestion. I thought of it a lot and the result is that I'm not sure
If it's quite suitable for i.MX cases. Currently seems there's only one user, Samsung,
 in kernel using that API which takes two struct of_phandle_args as arguments,
parent and child. It looks needs special handling in code before using it, e.g.
register both parent and child domain first, which is somehow not like i.MX flow
of registration. It looks like to me not see much benefits to enforce a big
change to switch to it. Or am I missed anything?

If you have better idea please let me know.

> > +
> > +       return 0;
> > +}
> > +early_initcall(imx_sc_init_pm_domains);
> 
> Otherwise this looks good to me!
> 

Thanks

Regards
Dong Aisheng

> Kind regards
> Uffe
