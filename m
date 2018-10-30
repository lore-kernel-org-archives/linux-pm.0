From: "A.s. Dong" <aisheng.dong@nxp.com>
Subject: RE: [PATCH V8 5/5] firmware: imx: add SCU power domain driver
Date: Tue, 30 Oct 2018 13:20:00 +0000
Message-ID: <AM0PR04MB4211F8B08821BEA7CEA8950880CC0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1540739690-23750-1-git-send-email-aisheng.dong@nxp.com>
 <1540739690-23750-6-git-send-email-aisheng.dong@nxp.com>
 <CAPDyKFp=ajE5gh5KnfKjm31x1oKDu3O56Yki1CvrTEf0SysS7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFp=ajE5gh5KnfKjm31x1oKDu3O56Yki1CvrTEf0SysS7w@mail.gmail.com>
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

[...]

> }
> > +
> > +static struct imx_sc_pm_domain *
> > +imx_scu_add_pm_domain(struct device *dev, int idx,
> > +                     const struct imx_sc_pd_range *pd_ranges) {
> > +       struct imx_sc_pm_domain *sc_pd;
> > +       int ret;
> > +
> > +       sc_pd = devm_kzalloc(dev, sizeof(*sc_pd), GFP_KERNEL);
> > +       if (!sc_pd)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       sc_pd->rsrc = pd_ranges->rsrc + idx;
> > +       sc_pd->pd.power_off = imx_sc_pd_power_off;
> > +       sc_pd->pd.power_on = imx_sc_pd_power_on;
> 
> So, this means you are going to register one genpd per device (one for each
> uart, pwm etc), but there is actually a better option.
> 
> What you seems to be needing is a way to "power on/off" devices, rather than
> the PM domain. Right? The PM domain, is managed internally by the FW, no?
> 

Yes, you're right.

> In any case, it looks like what you should do is to implement the
> ->attach|detach_dev() callback for the genpd and use the regular
> of_genpd_add_provider_simple(). From within the ->attach_dev(), you should
> get the OF node for the device that is being attached and then parse the
> power-domain cell containing the "resource id" and store that in the per device
> struct generic_pm_domain_data (we have void pointer there for storing these
> kind of things).
> 
> Additionally, you need to implement the ->stop() and ->start() callbacks of
> genpd, which is where you "power on/off" devices, rather than using the above
> ->power_on|off() callbacks.
> 
> Please have a look a drivers/soc/ti/ti_sci_pm_domains.c. Apologize, I should
> have pointed you towards that reference already in the earlier version.
> 

Appreciated for such detailed explanation. lt's a good suggestion and I really like to
switch to it.  However, after digged a bit more, i found a few blocking issues:
1. The .attach_dev() of power domain infrastructure still does not support multi domains case.

It looks like there's no way for .attach_dev() to understand which sub 'power domain'
the device is attaching for one global power domain provider like ti_sci as you suggested.
Secondly, the struct device *dev passed into is a virtual PD device. It does not help
for parsing the real device resource id. 

So framework probably needs some extension to support multi power domain cases.

2. It also breaks most of current drivers as the driver probe sequence behavior changed
If removing .power_on() and .power_off() callback and use .start() and .stop() instead.

genpd_dev_pm_attach will only power up the domain and attach device, but will not call .start()
which relies on device runtime pm. That means the device power is still not up before
running driver probe function. For SCU enabled platforms, all device drivers accessing registers/clock
without power domain enabled will trigger a HW access error. That means we need fix most
of drivers probe sequence with proper runtime pm. So I'm a bit wondering whether we should
still keep the exist way.

In summary, we probably may not be able to try ti_sci way before fixing above two issues.

Do you think I should wait for them to be fixed or if we could use the current way at first?
I might be a little intend to the second way as we now have a lot upstreaming work pending on
this. But please let me know if you have a different idea.

Regards
Dong Aisheng

> > +
> > +       if (pd_ranges->postfix)
> > +               snprintf(sc_pd->name, sizeof(sc_pd->name),
> > +                        "%s%i", pd_ranges->name, idx);
> > +       else
> > +               snprintf(sc_pd->name, sizeof(sc_pd->name),
> > +                        "%s", pd_ranges->name);
> > +
> > +       sc_pd->pd.name = sc_pd->name;
> > +
> > +       if (sc_pd->rsrc >= IMX_SC_R_LAST) {
> > +               dev_warn(dev, "invalid pd %s rsrc id %d found",
> > +                        sc_pd->name, sc_pd->rsrc);
> > +
> > +               devm_kfree(dev, sc_pd);
> > +               return NULL;
> > +       }
> > +
> > +       ret = pm_genpd_init(&sc_pd->pd, NULL, true);
> > +       if (ret) {
> > +               dev_warn(dev, "failed to init pd %s rsrc id %d",
> > +                        sc_pd->name, sc_pd->rsrc);
> > +               devm_kfree(dev, sc_pd);
> > +               return NULL;
> > +       }
> > +
> > +       return sc_pd;
> > +}
> 
> [...]
> 
> Kind regards
> Uffe
