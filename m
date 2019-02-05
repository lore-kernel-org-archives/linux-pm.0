From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH 1/1] PM / Domains: Add multi PM domains support for attach_dev
Date: Tue, 5 Feb 2019 10:39:47 +0100
Message-ID: <CAPDyKFrnUK1_=0okEPTxCjACbOpYuOF9h3oK6pBTXrR9OYje+A@mail.gmail.com>
References: <1545930550-9906-1-git-send-email-aisheng.dong@nxp.com>
 <CAPDyKFrP8HOum_4S0-4Bx+sYbTNSyctv3rQDB78zozeNWOuv=A@mail.gmail.com>
 <AM0PR04MB42117D773477A408462D19D180B00@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CAPDyKFq4eji_FVKrRJ2k=c1iKuVP_3aERspy6vpXQzeFdBYt9w@mail.gmail.com>
 <AM0PR04MB421124AE755C01CEEC0CF31D808C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CAPDyKFodySv0A9ESDWwpJU=FQeyZ3FpOG0BMVBPxfgxd3oLWDw@mail.gmail.com> <AM0PR04MB4211C13768DD0D9543B6A59F808E0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM0PR04MB4211C13768DD0D9543B6A59F808E0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aisheng Dong <aisheng.dong@nxp.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "dongas86@gmail.com" <dongas86@gmail.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "shawnguo@kernel.org" <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "khilman@kernel.org" <khilman@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pm@vger.kernel.org

[...]

> > > Then attach_dev() can parse the correct "resource id" (e.g.
> > > IMX_SC_R_SDHC_1) from device tree And store it in per-device struct
> > generic_pm_domain_data for later start()/stop() using.
> >
> > I see, thanks for clarifying.
> >
> > Seem like, we have two options to make this work.
> >
> > 1. Let genpd pre-store the index in a the per device generic_pm_domain_data
> > while doing the attach and before calling the
> > ->attach_dev() callback. This would make sense, if we consider this to
> > be a common thing.
> >
> > 2. Provide the index as an additional new in-parameter to the
> > ->attach_dev() callback. This requires a tree wide change as it means
> > we need to update existing code using the ->attach_dev() callback.
> >
> > I would probably try 1) first to see how the code would look like and then fall
> > back to 2). What do you think?
> >
>
> Yes, I agree with you.
> This patch is exactly doing 1.
>
> For your former suggestion:
> " Just assign virt_dev->of_node = of_node_get(dev->of_node), somewhere in
> genpd_dev_pm_attach_by_id() and before calling __genpd_dev_pm_attach().
> Doing that, would mean the genpd provider's ->attach_dev() callback,
> don't have to distinguish between virtual and non-virtual devices"
>
> As this can only solve passing the real device node issue and we still need
> pre-store the index in a the per device generic_pm_domain_data and then
> distinguish if it's multi power domain virtual devices in attach_dev(), so
> I'm not sure if it's still quite necessary to do that way by assigning
> "virt_dev->of_node = of_node_get(dev->of_node) before attach".
> Probably after fully switch to option 2, then we can do it to fully drop the using
> of per device generic_pm_domain_data to make it transparent to attach_dev()
> users.
>
> So now the options may be:
> 1. Pre-store both device node and domain index in generic_pm_domain_data before
>   Calling attach_dev(). This is exactly this patch does.
> 2. Pre-store only domain index in generic_pm_domain_data. For device node, assigning
>   "virt_dev->of_node = of_node_get(dev->of_node) before attach.
> 3. Change attach_dev() to passing domain index and assigning
>   "virt_dev->of_node = of_node_get(dev->of_node) before attach.
>
> Can you please tell what's your prefer?

Apologize for the delay, just realized that you were expecting a reply from me.

To me is sounds like option 2) is the most feasible. Perhaps it's even
a good idea to store the domain index in the struct
generic_pm_domain_data, as it allows it then to be used at any point
later in time, this not only from the ->attach_dev() callback as
option 3) would mean.

So according to my understandings, then your genpd backend driver's
->attach_dev() callback, would use dev_gpd_data() to find out the
domain index for the device in question. Is that sufficient, or is
there anything else that is needed?

[...]

Kind regards
Uffe
