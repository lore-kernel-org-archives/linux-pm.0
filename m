From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] soc: imx: add SCU power domains driver
Date: Thu, 24 May 2018 11:00:12 +0200
Message-ID: <CAPDyKFrZHB2ti75zQav_SSXndorV38TcXMCoRBvDzdE5SS-WhA@mail.gmail.com>
References: <1524855063-14996-1-git-send-email-aisheng.dong@nxp.com>
 <1524855063-14996-3-git-send-email-aisheng.dong@nxp.com>
 <CAPDyKFowdpxwNMmDjdD3qcqnAcQZA9-MYWnTcZL-oSbwg8WYMg@mail.gmail.com>
 <AM0PR04MB42114331A1E75B3B90B07E56806A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <AM0PR04MB42114331A1E75B3B90B07E56806A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Dong Aisheng <dongas86@gmail.com>, Kevin Hilman <khilman@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 24 May 2018 at 10:37, A.s. Dong <aisheng.dong@nxp.com> wrote:
> Hi Ulf,
>
> Thanks for the review.
>
>> -----Original Message-----
>> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
>> Sent: Wednesday, May 9, 2018 3:16 AM
>> To: A.s. Dong <aisheng.dong@nxp.com>
>> Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>; Dong Aisheng
>> <dongas86@gmail.com>; Sascha Hauer <kernel@pengutronix.de>; Shawn
>> Guo <shawnguo@kernel.org>; Fabio Estevam <fabio.estevam@nxp.com>;
>> dl-linux-imx <linux-imx@nxp.com>; Rafael J. Wysocki <rjw@rjwysocki.net>;
>> Kevin Hilman <khilman@kernel.org>; Linux PM <linux-pm@vger.kernel.org>
>> Subject: Re: [PATCH 2/2] soc: imx: add SCU power domains driver
>>
>> [...]
>>
>> > +
>> > +static int __init imx_sc_init_pm_domains(void) {
>> > +       struct generic_pm_domain *pd;
>> > +       struct device_node *np;
>> > +       sc_err_t sci_err;
>> > +
>> > +       if (!of_machine_is_compatible("fsl,imx8qxp"))
>> > +               return 0;
>> > +
>> > +       sci_err = sc_ipc_get_handle(&pm_ipc_handle);
>> > +       if (sci_err != SC_ERR_NONE) {
>> > +               pr_err("imx_sc_pd: can't get sc ipc handle\n");
>> > +               return -ENODEV;
>> > +       }
>> > +
>> > +       for_each_matching_node(np, imx_sc_pm_domain_of_match) {
>> > +               pd = imx_sc_pm_add_one_domain(np, NULL);
>> > +               if (!IS_ERR(pd))
>> > +                       imx_sc_pm_add_subdomains(np, pd);
>> > +       }
>>
>> Perhaps using of_genpd_add_subdomain() may help here and possibly could
>> avoid some open coding!?
>>
>
> Thanks for the suggestion. I thought of it a lot and the result is that I'm not sure
> If it's quite suitable for i.MX cases. Currently seems there's only one user, Samsung,
>  in kernel using that API which takes two struct of_phandle_args as arguments,
> parent and child. It looks needs special handling in code before using it, e.g.
> register both parent and child domain first, which is somehow not like i.MX flow
> of registration. It looks like to me not see much benefits to enforce a big
> change to switch to it. Or am I missed anything?

It's up to you. The idea was to make the code easier and a bit future
proof. Perhaps that isn't suitable here.

In any case, if you have a device node and all power-domain providers
are listed below it, one can call for_each_child_of_node() and search
for provider nodes hierarchically. I thought that is kind of nice.

Something along the lines of what I done in
psci_dt_set_genpd_topology(), from a patch I posted a while ago:
https://patchwork.kernel.org/patch/10338399/

[...]

If you decide to sticking to the existing way, anyway feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
