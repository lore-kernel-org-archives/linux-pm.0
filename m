From: "A.s. Dong" <aisheng.dong@nxp.com>
Subject: RE: [PATCH V8 5/5] firmware: imx: add SCU power domain driver
Date: Thu, 1 Nov 2018 14:02:55 +0000
Message-ID: <VI1PR04MB4222DFDFBC78B546084E2B8880CE0@VI1PR04MB4222.eurprd04.prod.outlook.com>
References: <1540739690-23750-1-git-send-email-aisheng.dong@nxp.com>
 <1540739690-23750-6-git-send-email-aisheng.dong@nxp.com>
 <CAPDyKFp=ajE5gh5KnfKjm31x1oKDu3O56Yki1CvrTEf0SysS7w@mail.gmail.com>
 <AM0PR04MB4211F8B08821BEA7CEA8950880CC0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CAPDyKFpzvN1R91ByRUmZ8XDsm6L2SF92oOrDSn3qv-d9wWGYtA@mail.gmail.com>
 <AM0PR04MB4211084AB67D86ED162FDB1280CD0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CAPDyKFoEbuLcA5AZPQob0PgK=A3pAH5N8CacHb3WO+54-0svrA@mail.gmail.com>
 <AM0PR04MB42116E6F24F4943BC999CAEE80CD0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CAPDyKFrBNoXiWgjKk7mdOEARgOV+7RQPnMcDRccS04triaUHtg@mail.gmail.com>
 <AM0PR04MB42113E0E18DA5CC4C7A7B2B380CE0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CAPDyKFpPvPeW-6FN-vZC=Lg2oOsvq-5mytf5L3L0whRUu-XPJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFpPvPeW-6FN-vZC=Lg2oOsvq-5mytf5L3L0whRUu-XPJw@mail.gmail.com>
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
Cc: "dongas86@gmail.com" <dongas86@gmail.com>, "khilman@kernel.org" <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

> -----Original Message-----
> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> Sent: Thursday, November 1, 2018 5:52 PM
[...]
> 
> On 1 November 2018 at 02:28, A.s. Dong <aisheng.dong@nxp.com> wrote:
> >> -----Original Message-----
> >> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> >> Sent: Thursday, November 1, 2018 5:49 AM
> > [...]
> >>
> >> On 31 October 2018 at 18:24, A.s. Dong <aisheng.dong@nxp.com> wrote:
> >> >> -----Original Message-----
> >> >> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> >> >> Sent: Wednesday, October 31, 2018 11:56 PM
> >> > [...]
> >> >> On 31 October 2018 at 02:45, A.s. Dong <aisheng.dong@nxp.com>
> wrote:
> >> >> >> -----Original Message-----
> >> >> >> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> >> >> >> Sent: Wednesday, October 31, 2018 12:00 AM
> >> >> > [...]
> >> >> >> On 30 October 2018 at 14:20, A.s. Dong <aisheng.dong@nxp.com>
> >> wrote:
> >> >> >> > [...]
> >> >> >> >
> >> >> >> >> }
> >> >> >> >> > +
> >> >> >> >> > +static struct imx_sc_pm_domain *
> >> >> >> >> > +imx_scu_add_pm_domain(struct device *dev, int idx,
> >> >> >> >> > +                     const struct imx_sc_pd_range
> >> >> >> >> > +*pd_ranges)
> >> {
> >> >> >> >> > +       struct imx_sc_pm_domain *sc_pd;
> >> >> >> >> > +       int ret;
> >> >> >> >> > +
> >> >> >> >> > +       sc_pd = devm_kzalloc(dev, sizeof(*sc_pd),
> GFP_KERNEL);
> >> >> >> >> > +       if (!sc_pd)
> >> >> >> >> > +               return ERR_PTR(-ENOMEM);
> >> >> >> >> > +
> >> >> >> >> > +       sc_pd->rsrc = pd_ranges->rsrc + idx;
> >> >> >> >> > +       sc_pd->pd.power_off = imx_sc_pd_power_off;
> >> >> >> >> > +       sc_pd->pd.power_on = imx_sc_pd_power_on;
> >> >> >> >>
> >> >> >> >> So, this means you are going to register one genpd per
> >> >> >> >> device (one for each uart, pwm etc), but there is actually a better
> option.
> >> >> >> >>
> >> >> >> >> What you seems to be needing is a way to "power on/off"
> >> >> >> >> devices, rather than the PM domain. Right? The PM domain, is
> >> >> >> >> managed internally
> >> >> >> by the FW, no?
> >> >> >> >>
> >> >> >> >
> >> >> >> > Yes, you're right.
> >> >> >> >
> >> >> >> >> In any case, it looks like what you should do is to
> >> >> >> >> implement the
> >> >> >> >> ->attach|detach_dev() callback for the genpd and use the
> >> >> >> >> ->attach|regular
> >> >> >> >> of_genpd_add_provider_simple(). From within the
> >> >> >> >> ->attach_dev(), you should get the OF node for the device
> >> >> >> >> that is being attached and then parse the power-domain cell
> >> >> >> >> containing the
> >> "resource id"
> >> >> >> >> and store that in the per device struct
> >> >> >> >> generic_pm_domain_data (we have void pointer there for storing
> these kind of things).
> >> >> >> >>
> >> >> >> >> Additionally, you need to implement the ->stop() and
> >> >> >> >> ->start() callbacks of genpd, which is where you "power
> >> >> >> >> on/off" devices, rather than using the above
> >> >> >> >> ->power_on|off() callbacks.
> >> >> >> >>
> >> >> >> >> Please have a look a drivers/soc/ti/ti_sci_pm_domains.c.
> >> >> >> >> Apologize, I should have pointed you towards that reference
> >> >> >> >> already in the earlier
> >> >> >> version.
> >> >> >> >>
> >> >> >> >
> >> >> >> > Appreciated for such detailed explanation. lt's a good
> >> >> >> > suggestion and I really like to switch to it.  However, after
> >> >> >> > digged a bit more, i found a few
> >> >> >> blocking issues:
> >> >> >> > 1. The .attach_dev() of power domain infrastructure still
> >> >> >> > does not support
> >> >> >> multi domains case.
> >> >> >> >
> >> >> >> > It looks like there's no way for .attach_dev() to understand
> >> >> >> > which sub 'power
> >> >> >> domain'
> >> >> >> > the device is attaching for one global power domain provider
> >> >> >> > like ti_sci as
> >> >> >> you suggested.
> >> >> >> > Secondly, the struct device *dev passed into is a virtual PD device.
> >> >> >> > It does not help for parsing the real device resource id.
> >> >> >> >
> >> >> >> > So framework probably needs some extension to support multi
> >> >> >> > power
> >> >> >> domain cases.
> >> >> >>
> >> >> >> Right, you are correct.
> >> >> >>
> >> >> >> Let me think about this and see what I can come up with -
> >> >> >> unless you already have something you want to propose?
> >> >> >>
> >> >> >
> >> >> > I have thought we may need add two more params (real dev and pd
> >> >> > index) for
> >> >> > .attach_dev().detach_dev() and .start()/.stop() for multi PDs case.
> >> >> > But I'm not sure if they are proper.
> >> >>
> >> >> Right.
> >> >>
> >> >> I don't think we need to change the definition of the callbacks.
> >> >> However, from within the callbacks (or at least the
> >> >> ->attach_dev()) we need access to the data you suggest above.
> >> >>
> >> >> To make that data available, genpd needs to store it in the per
> >> >> device struct generic_pm_domain_data, but of course before
> >> >> invoking the
> >> >> ->attach_dev() callback.
> >> >>
> >> >
> >> > Yes, that's an option.
> >> > Currently gpd_data is allocated in genpd_add_device() which looks
> >> > like to be designed to attach device to the specified power domain
> >> > passed in, so it's unware of whether it's multi domains or not.
> >> > Then we may still need fine tune those functions in different abstract
> layers.
> >>
> >> Yes, something like that. I don't think it should be that hard, I can
> >> have a stab at it of you like?
> >>
> >
> > Yes, that's fine to me. I just don't have too much time to handle it right now.
> > I can help do some basic function test later. May not be stress as we
> > still have no devices using multi domains supported In kernel.
> > So I can construct simple case to test.
> 
> Okay, I am adding it to my TODO list for genpd.
> 

Great.

> >
> >> >
> >> >> >
> >> >> >
> >> >> >> >
> >> >> >> > 2. It also breaks most of current drivers as the driver probe
> >> >> >> > sequence behavior changed If removing .power_on() and
> >> >> >> > .power_off() callback and
> >> >> >> use .start() and .stop() instead.
> >> >> >> >
> >> >> >> > genpd_dev_pm_attach will only power up the domain and attach
> >> >> >> > device, but will not call .start() which relies on device
> >> >> >> > runtime pm. That means the device power is still not up
> >> >> >> > before running driver probe function. For SCU enabled
> >> >> >> > platforms, all device drivers accessing registers/clock
> >> >> >> > without power domain enabled will trigger a HW access error.
> >> >> >> > That means we need fix most of drivers probe sequence with
> >> >> >> > proper
> >> >> >> runtime pm. So I'm a bit wondering whether we should still keep
> >> >> >> the exist
> >> >> way.
> >> >> >>
> >> >> >> I see what you are trying to say, but I am not sure why you
> >> >> >> consider this as they would break? How did they work in the first
> place?
> >> >> >>
> >> >> >
> >> >> > Most drivers does not require power domains before. E.g. GPIO,
> >> >> > I2C, PWM,
> >> >> MMC.
> >> >> > Or even we need power domain(PUs/PCIE), they're enabled in
> >> >> > .power_on()/.power_off() which has been already up before probe.
> >> >> >
> >> >> >> Anyway, the problem you are talking about have so far been
> >> >> >> addressed by making buses/drivers to call pm_runtime_enable()
> >> >> >> and
> >> >> >> pm_runtime_get_sync() - before trying to probe their devices.
> >> >> >>
> >> >> >
> >> >> > Yes, called them early before accessing clock and hw registers.
> >> >> >
> >> >> >> Do you have an idea of the amount of drivers that needs to
> >> >> >> fixed, in regards to this?
> >> >> >>
> >> >> >
> >> >> > So far all enabled devices I tested need fixes. GPIO/I2C/FEC/MMC and
> etc.
> >> >> > Suppose other need the same fix as we have not met this situation
> before.
> >> >>
> >> >> Okay, I see.
> >> >>
> >> >> >
> >> >> >> I guess an option could be to, that via the ->attach_dev()
> >> >> >> callback perform the same operations as also being done during
> >> >> >> ->start(). Of course, you may need to keep a flag about this
> >> >> >> ->being
> >> >> >> done, so that operations that need to be balanced with get/put
> >> >> >> or the like is managed correctly, the next time
> >> >> >> ->start|stop() becomes called.
> >> >> >>
> >> >> >
> >> >> > That might be a way to try. The follow seems may introduce a bit
> >> >> > complexities and driver needs to maintainer the runtime status
> >> >> > along with framework in order to keep the balance?
> >> >>
> >> >> Yeah, it's likely not going to be very elegant, but should be
> >> >> rather self contained in the PM domain driver and could serve as a
> >> >> way forward - while working on fixing the drivers long term.
> >> >>
> >> >> >
> >> >> >> >
> >> >> >> > In summary, we probably may not be able to try ti_sci way
> >> >> >> > before fixing
> >> >> >> above two issues.
> >> >> >> >
> >> >> >> > Do you think I should wait for them to be fixed or if we
> >> >> >> > could use the current
> >> >> >> way at first?
> >> >> >> > I might be a little intend to the second way as we now have a
> >> >> >> > lot upstreaming work pending on this. But please let me know
> >> >> >> > if you have a
> >> >> >> different idea.
> >> >> >>
> >> >> >> As this is also about deploying a DTB with a correctly modeled
> >> >> >> HW, I think we need to fix the above issues.
> >> >> >>
> >> >> >
> >> >> > DTB are the same with #power-domain-cells 1 (resource ID) in either
> case.
> >> >> > So DTB don't need change and driver could be optimized.
> >> >>
> >> >> You are correct.
> >> >>
> >> >> Although, how does $subject patch solves the case where a device
> >> >> may have multiple PM domains attached to it? Or is left as a
> >> >> future
> >> improvement?
> >> >>
> >> >
> >> > IIRC this patch does not have such issue for multi PM domains as we
> >> > have individual power domains for each resources. Devices will be
> >> > attached to each individual domains in __genpd_dev_pm_attach rather
> >> > than the single one global virtual SCU domain. Furthermore we're
> >> > using domains .power_on()/
> >> > power_off() callback which means the power will be up before the probe.
> >> > (no the issue like when using .attach_dev()/.detach_dev() and run
> >> > .start()/stop() via runtime pm).
> >>
> >> I don't follow your reasoning here, sorry. You stated earlier, that
> >> there was a need to support multiple PM domains per device.
> >>
> >> How can that problem be resolved by using one genpd per device? What
> >> am I missing?
> >
> > Sorry I may be not clear before.
> > We still support using multiple power domains.
> > For example:
> > Mipi_csi0 {
> >         ...
> >         Power_domains = <&PD SC_R_IPI_CH0>,
> >                                    <&PD SC_R_MIPI_CSI0>;
> >         Power_domains_names = "ss", "csi"; };
> >
> > The difference is that each SC resource has individual power domains
> > in driver And __genpd_dev_pm_attach will bind the virtual devices to
> > the correct individual domain and do properly power_on/off of that
> domains.
> > So it does not have the issue that .attach_dev() has, also does not
> > have issue that power domain is still not up before running probe.
> > (The detailed using is just like Tegra xHCI you pointed to me before)
> 
> Aha, I see. Thanks for clarifying.
> 
> >
> >>
> >> >
> >> > Actually I'm a bit wondering that if abstracting SCU domains into
> >> > one global virtual domain is certainly better than individual
> >> > domains. For SCU based SoCs, the power domain service is provided
> >> > by SCU firmware, users don't have to care too much about the HW
> >> > internals. And according to SCU definition, each devices is
> >> > associated with a power domain, devices should treat it as a
> >> > separate domain and have to enable it before accessing HW. So one
> >> > single global domain looks like not
> >> exactly as SCU firmware defines. Not quite sure, but a bit feel like that....
> >>
> >> I don't agree with you here, sorry. As also pointed out by Rob
> >> earlier, in regards to the DT bindings. Simply put, I doubt the SoC
> >> deploys separate power rails/islands for each of the available
> >> devices. Instead, it seems like the SCU interface, allows its clients
> >> to controls "power" to each of the available
> >> *devices* - and not power domains.
> >>
> >
> > Yes, that's the trick part. For me, I feel like devices are unware of
> > HW internals but using SCU power domains service. So devices think
> > it's seaparte domains may not be strictly wrong.
> > Anyway, I'm also agree with the later way (signal global power domains
> > with
> > .attach_dev()/.start() to power on device). Just because we met those
> > two Issues blocking us to do it right now.
> >
> >> Anyway, we are debating how to implement this in software and not in
> >> DT. :-)
> >>
> >> That said, if you strongly feel that the short cut, about registering
> >> one genpd per device and thus suffer from the overhead it gives, is
> >> the best approach to start with, feel free to do that.
> >>
> >
> > I just feel like that starting with current way could give us more
> > time to fine tune it later without blocking other drivers upstreaming.
> > And maybe we can do better work once we have real multi domains users in
> kernel.
> >
> > Anyway, I can do either, so please me know if you still think we
> > should strictly start with signal global power domain way.
> 
> As stated, feel free to pick whatever option that makes sense to you.
> 
> However, if you decide to start with the approach taken in $subject patch, it
> would be nice if the new drivers/firmware/imx/scu-pd.c file, could have some
> comments in the top, about what things are needed to convert to the "single
> global domain", just so we don't forget about it.
> 

Sounds good to me.
Thanks for the suggestion.
I will do it.

Regards
Dong Aisheng

> Kind regards
> Uffe
