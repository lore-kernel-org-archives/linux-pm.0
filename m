From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH 1/1] PM / Domains: Add multi PM domains support for attach_dev
Date: Wed, 2 Jan 2019 11:49:20 +0100
Message-ID: <CAPDyKFq4eji_FVKrRJ2k=c1iKuVP_3aERspy6vpXQzeFdBYt9w@mail.gmail.com>
References: <1545930550-9906-1-git-send-email-aisheng.dong@nxp.com>
 <CAPDyKFrP8HOum_4S0-4Bx+sYbTNSyctv3rQDB78zozeNWOuv=A@mail.gmail.com> <AM0PR04MB42117D773477A408462D19D180B00@AM0PR04MB4211.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM0PR04MB42117D773477A408462D19D180B00@AM0PR04MB4211.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aisheng Dong <aisheng.dong@nxp.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "dongas86@gmail.com" <dongas86@gmail.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "shawnguo@kernel.org" <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "khilman@kernel.org" <khilman@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 29 Dec 2018 at 07:43, Aisheng Dong <aisheng.dong@nxp.com> wrote:
>
> > From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> > Sent: Friday, December 28, 2018 11:37 PM
> >
> > On Thu, 27 Dec 2018 at 18:14, Aisheng Dong <aisheng.dong@nxp.com>
> > wrote:
> > >
> > > Currently attach_dev() in power domain infrastructure still does not
> > > support multi domains case as the struct device *dev passed down from
> > > genpd_dev_pm_attach_by_id() is a virtual PD device, it does not help
> > > for parsing the real device information from device tree, e.g.
> > > Device/Power IDs, Clocks and it's unware of which real power domain
> > > the device should attach.
> >
> > Thanks for working on this!
> >
> > I would appreciate if the changelog could clarify the problem a bit.
> > Perhaps something along the lines of the below.
> >
>
> Sounds good to me.
> I will add them in commit message.
> Thanks for the suggestion.
>
> > "A genpd provider's ->attach_dev() callback may be invoked with a so called
> > virtual device, which is created by genpd, at the point when a device is being
> > attached to one of its corresponding multiple PM domains.
> >
> > In these cases, the genpd provider fails to look up any resource, by a
> > clk_get() for example, for the virtual device in question. This is because, the
> > virtual device that was created by genpd, does not have the virt_dev->of_node
> > assigned."
> >
> > >
> > > Extend the framework a bit to store the multi PM domains information
> > > in per-device struct generic_pm_domain_data, then power domain driver
> > > could retrieve it for necessary operations during attach_dev().
> > >
> > > Two new APIs genpd_is_mpd_device() and dev_gpd_mpd_data() are also
> > > introduced to ease the driver operation.
> > >
> > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > Cc: Kevin Hilman <khilman@kernel.org>
> > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > > ---
> > > This patch is a follow-up work of the earlier discussion with Ulf
> > > Hansson about the multi PM domains support for the attach_dev() function
> > [1].
> > > After a bit more thinking, this is a less intrusive implementation
> > > with the mininum impact on the exist function definitions and calling
> > follows.
> > > One known little drawback is that we have to use the device driver
> > > private data (device.drvdata) to pass down the multi domains
> > > information in a earlier time. However, as multi PD devices are
> > > created by domain framework, this seems to be safe to use it in domain
> > > core code as device driver is not likely going to use it.
> > > Anyway, if any better ideas, please let me know.
> > >
> > > With the two new APIs, the using can be simply as:
> > > static int xxx_attach_dev(struct generic_pm_domain *domain,
> > >                           struct device *dev) {
> > >         ...
> > >         if (genpd_is_mpd_device(dev)) {
> > >                 mpd_data = dev_gpd_mpd_data(dev);
> > >                 np = mpd_data->parent->of_node;
> > >                 idx = mpd_data->index;
> > >                 //dts parsing
> > >                 ...
> > >         }
> > >         ...
> >
> > I think we can make this a lot less complicated. Just assign virt_dev->of_node =
> > of_node_get(dev->of_node), somewhere in
> > genpd_dev_pm_attach_by_id() and before calling __genpd_dev_pm_attach().
> >
> > Doing that, would mean the genpd provider's ->attach_dev() callback, don't
> > have to distinguish between virtual and non-virtual devices.
> > Instead they should be able to look up resources in the same way as they did
> > before.
> >
>
> Yes, that seems like a smart way.
> But there's still a remain problem that how about the domain index information
> needed for attach_dev()?
>

What do you mean by domain index?

The ->attach_dev() is given both the device and the genpd in question
as in-parameters. Could you store the domain index as part of your
genpd struct? No?

If you are talking about using the "power-domains" specifier from the
DT node of the device, that should then work, similar to as been done
in:

drivers/soc/ti/ti_sci_pm_domains.c
ti_sci_pd_attach_dev()

You may also provide your own xlate callback for your genpd provider,
like what is done in drivers/soc/tegra/powergate-bpmp. - if that
helps!?

Or am I missing something?

[...]

Kind regards
Uffe
