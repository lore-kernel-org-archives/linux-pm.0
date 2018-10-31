From: "A.s. Dong" <aisheng.dong@nxp.com>
Subject: RE: [PATCH V8 5/5] firmware: imx: add SCU power domain driver
Date: Wed, 31 Oct 2018 01:45:49 +0000
Message-ID: <AM0PR04MB4211084AB67D86ED162FDB1280CD0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1540739690-23750-1-git-send-email-aisheng.dong@nxp.com>
 <1540739690-23750-6-git-send-email-aisheng.dong@nxp.com>
 <CAPDyKFp=ajE5gh5KnfKjm31x1oKDu3O56Yki1CvrTEf0SysS7w@mail.gmail.com>
 <AM0PR04MB4211F8B08821BEA7CEA8950880CC0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CAPDyKFpzvN1R91ByRUmZ8XDsm6L2SF92oOrDSn3qv-d9wWGYtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFpzvN1R91ByRUmZ8XDsm6L2SF92oOrDSn3qv-d9wWGYtA@mail.gmail.com>
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
> Sent: Wednesday, October 31, 2018 12:00 AM
[...]
> On 30 October 2018 at 14:20, A.s. Dong <aisheng.dong@nxp.com> wrote:
> > [...]
> >
> >> }
> >> > +
> >> > +static struct imx_sc_pm_domain *
> >> > +imx_scu_add_pm_domain(struct device *dev, int idx,
> >> > +                     const struct imx_sc_pd_range *pd_ranges) {
> >> > +       struct imx_sc_pm_domain *sc_pd;
> >> > +       int ret;
> >> > +
> >> > +       sc_pd = devm_kzalloc(dev, sizeof(*sc_pd), GFP_KERNEL);
> >> > +       if (!sc_pd)
> >> > +               return ERR_PTR(-ENOMEM);
> >> > +
> >> > +       sc_pd->rsrc = pd_ranges->rsrc + idx;
> >> > +       sc_pd->pd.power_off = imx_sc_pd_power_off;
> >> > +       sc_pd->pd.power_on = imx_sc_pd_power_on;
> >>
> >> So, this means you are going to register one genpd per device (one
> >> for each uart, pwm etc), but there is actually a better option.
> >>
> >> What you seems to be needing is a way to "power on/off" devices,
> >> rather than the PM domain. Right? The PM domain, is managed internally
> by the FW, no?
> >>
> >
> > Yes, you're right.
> >
> >> In any case, it looks like what you should do is to implement the
> >> ->attach|detach_dev() callback for the genpd and use the regular
> >> of_genpd_add_provider_simple(). From within the ->attach_dev(), you
> >> should get the OF node for the device that is being attached and then
> >> parse the power-domain cell containing the "resource id" and store
> >> that in the per device struct generic_pm_domain_data (we have void
> >> pointer there for storing these kind of things).
> >>
> >> Additionally, you need to implement the ->stop() and ->start()
> >> callbacks of genpd, which is where you "power on/off" devices, rather
> >> than using the above
> >> ->power_on|off() callbacks.
> >>
> >> Please have a look a drivers/soc/ti/ti_sci_pm_domains.c. Apologize, I
> >> should have pointed you towards that reference already in the earlier
> version.
> >>
> >
> > Appreciated for such detailed explanation. lt's a good suggestion and
> > I really like to switch to it.  However, after digged a bit more, i found a few
> blocking issues:
> > 1. The .attach_dev() of power domain infrastructure still does not support
> multi domains case.
> >
> > It looks like there's no way for .attach_dev() to understand which sub 'power
> domain'
> > the device is attaching for one global power domain provider like ti_sci as
> you suggested.
> > Secondly, the struct device *dev passed into is a virtual PD device.
> > It does not help for parsing the real device resource id.
> >
> > So framework probably needs some extension to support multi power
> domain cases.
> 
> Right, you are correct.
> 
> Let me think about this and see what I can come up with - unless you already
> have something you want to propose?
> 

I have thought we may need add two more params (real dev and pd index) for
.attach_dev().detach_dev() and .start()/.stop() for multi PDs case.
But I'm not sure if they are proper.


> >
> > 2. It also breaks most of current drivers as the driver probe sequence
> > behavior changed If removing .power_on() and .power_off() callback and
> use .start() and .stop() instead.
> >
> > genpd_dev_pm_attach will only power up the domain and attach device,
> > but will not call .start() which relies on device runtime pm. That
> > means the device power is still not up before running driver probe
> > function. For SCU enabled platforms, all device drivers accessing
> > registers/clock without power domain enabled will trigger a HW access
> > error. That means we need fix most of drivers probe sequence with proper
> runtime pm. So I'm a bit wondering whether we should still keep the exist way.
> 
> I see what you are trying to say, but I am not sure why you consider this as
> they would break? How did they work in the first place?
> 

Most drivers does not require power domains before. E.g. GPIO, I2C, PWM, MMC.
Or even we need power domain(PUs/PCIE), they're enabled in .power_on()/.power_off()
which has been already up before probe.

> Anyway, the problem you are talking about have so far been addressed by
> making buses/drivers to call pm_runtime_enable() and
> pm_runtime_get_sync() - before trying to probe their devices.
>

Yes, called them early before accessing clock and hw registers.

> Do you have an idea of the amount of drivers that needs to fixed, in regards to
> this?
> 

So far all enabled devices I tested need fixes. GPIO/I2C/FEC/MMC and etc.
Suppose other need the same fix as we have not met this situation before.

> I guess an option could be to, that via the ->attach_dev() callback perform the
> same operations as also being done during ->start(). Of course, you may need
> to keep a flag about this being done, so that operations that need to be
> balanced with get/put or the like is managed correctly, the next time
> ->start|stop() becomes called.
> 

That might be a way to try. The follow seems may introduce a bit complexities
and driver needs to maintainer the runtime status along with framework in order to 
keep the balance?

> >
> > In summary, we probably may not be able to try ti_sci way before fixing
> above two issues.
> >
> > Do you think I should wait for them to be fixed or if we could use the current
> way at first?
> > I might be a little intend to the second way as we now have a lot
> > upstreaming work pending on this. But please let me know if you have a
> different idea.
> 
> As this is also about deploying a DTB with a correctly modeled HW, I think we
> need to fix the above issues.
> 

DTB are the same with #power-domain-cells 1 (resource ID) in either case.
So DTB don't need change and driver could be optimized.

> I am happy to help, in one way or the other.
> 

Thanks.

Regards
Dong Aisheng

> [...]
> 
> Kind regards
> Uffe
