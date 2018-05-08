From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] soc: imx: add SCU power domains driver
Date: Tue, 8 May 2018 21:15:52 +0200
Message-ID: <CAPDyKFowdpxwNMmDjdD3qcqnAcQZA9-MYWnTcZL-oSbwg8WYMg@mail.gmail.com>
References: <1524855063-14996-1-git-send-email-aisheng.dong@nxp.com>
 <1524855063-14996-3-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1524855063-14996-3-git-send-email-aisheng.dong@nxp.com>
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
Cc: Dong Aisheng <dongas86@gmail.com>, Kevin Hilman <khilman@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-imx@nxp.com, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

[...]

> +
> +static int __init imx_sc_init_pm_domains(void)
> +{
> +       struct generic_pm_domain *pd;
> +       struct device_node *np;
> +       sc_err_t sci_err;
> +
> +       if (!of_machine_is_compatible("fsl,imx8qxp"))
> +               return 0;
> +
> +       sci_err = sc_ipc_get_handle(&pm_ipc_handle);
> +       if (sci_err != SC_ERR_NONE) {
> +               pr_err("imx_sc_pd: can't get sc ipc handle\n");
> +               return -ENODEV;
> +       }
> +
> +       for_each_matching_node(np, imx_sc_pm_domain_of_match) {
> +               pd = imx_sc_pm_add_one_domain(np, NULL);
> +               if (!IS_ERR(pd))
> +                       imx_sc_pm_add_subdomains(np, pd);
> +       }

Perhaps using of_genpd_add_subdomain() may help here and possibly
could avoid some open coding!?

> +
> +       return 0;
> +}
> +early_initcall(imx_sc_init_pm_domains);

Otherwise this looks good to me!

Kind regards
Uffe
