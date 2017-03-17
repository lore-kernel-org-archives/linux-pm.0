From: "Niklas =?iso-8859-1?Q?S=F6derlund?=" <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH 5/7] thermal: rcar_gen3_thermal: enable hardware
 interrupts for trip points
Date: Fri, 17 Mar 2017 11:06:30 +0100
Message-ID: <20170317100630.GA20587@bigcity.dyn.berto.se>
References: <20170306200401.29923-1-niklas.soderlund+renesas@ragnatech.se>
 <20170306200401.29923-6-niklas.soderlund+renesas@ragnatech.se>
 <20170307195533.GE2554@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170307195533.GE2554@tetsubishi>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Wolfram,

Thanks for your feedback.

On 2017-03-07 20:55:33 +0100, Wolfram Sang wrote:
> Hi Niklas,
> 
> thanks for your work!
> 
> On Mon, Mar 06, 2017 at 09:03:59PM +0100, Niklas Söderlund wrote:
> > Enable hardware trip points by implementing the set_trips callback. The
> > thermal core will take care of setting the initial trip point window and
> > to update it once the driver reports a TSC have moved outside it.
> > 
> > The interrupt structure for this device is a bit odd. There is not a
> > dedicated IRQ for each TSC, instead the interrupts are shared between
> > all TSC. IRQn is fired if the temp monitored in IRQTEMPn is reached in
> > any of the TSC, example IRQ3 is fired if temperature in IRQTEMP3 is
> > reached in either TSC0, TSC1 or TSC2.
> > 
> > For this reason the usage of interrupts in this driver is a all on or
> 
> s/a all/an all/

Will fix

> 
> > all off design. When an interrupt happens all TSC are checked and all
> > thermal zones are updated. This could be refined to be more fine grained
> > but the thermal core takes care of only updating the thermal zones that
> > have left there trip point window.
> 
> s/there/the/

Will fix

> 
> > 
> > Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> > ---
> >  drivers/thermal/rcar_gen3_thermal.c | 137 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 137 insertions(+)
> > 
> > +static int rcar_gen3_thermal_set_trips(void *devdata, int low, int high)
> > +{
> > +	struct rcar_gen3_thermal_tsc *tsc = devdata;
> > +
> > +	if (low < -40000)
> > +		low = -40000;
> > +	if (high > 125000)
> > +		high = 125000;
> 
> Use clamp_val()?

Good idea, will use.

> 
> > +
> > +	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQTEMP1,
> > +				rcar_gen3_thermal_mcelsius_to_temp(tsc, low));
> > +
> > +	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQTEMP2,
> > +				rcar_gen3_thermal_mcelsius_to_temp(tsc, high));
> > +
> > +	dev_dbg(tsc->dev, "TSC%d: low: %d high: %d\n", tsc->num, low, high);
> 
> Is there no sysfs/debugfs way to get this from thermal core? I'd bet
> this is of generic interest. Bonus point: if we drop this dbg, we can
> also drop the 'dev' and 'num' members from the struct again.

I can't find any sysfs or debugfs knobs to show this information, what 
do exist is a dev_dbg in thermal_zone_set_trips() which can print 
similar information. The difference is that the trip values have not 
been clamped to the device specification in that printout since it 
happens before the call to the rcar_gen3_thermal_set_trips() call (where 
they are still clamped before anything is written to hardware):


thermal_zone_set_trips():
[    2.014173] thermal thermal_zone0: new temperature boundaries: -2147483647 < x < 120000

rcar_gen3_thermal_set_trips():
[    2.014180] rcar_gen3_thermal e6198000.thermal: TSC0: low: -40000 high: 120000

But this is for debugging so I see no issue whit dropping this debug 
printout from the driver and depend on the one from thermal core. Will 
remove this and the patch which stores tsc->dev and tsc->num form the 
next version.

> 
> > +
> > +	return 0;
> > +}
> > +
> >  static struct thermal_zone_of_device_ops rcar_gen3_tz_of_ops = {
> >  	.get_temp	= rcar_gen3_thermal_get_temp,
> > +	.set_trips	= rcar_gen3_thermal_set_trips,
> >  };
> >  
> > +static void rcar_thermal_irq_disable(struct rcar_gen3_thermal_priv *priv)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < TSC_MAX_NUM; i++)
> > +		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQMSK, 0);
> > +}
> > +
> > +static void rcar_thermal_irq_enable(struct rcar_gen3_thermal_priv *priv)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < TSC_MAX_NUM; i++)
> > +		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQMSK,
> > +					IRQ_TEMPD1 | IRQ_TEMP2);
> > +}
> 
> Merge the two into one with a second parameter which is bool?
> rcar_gen3_irq_enable(priv, true/false)?

OK

> 
> >  	pm_runtime_enable(dev);
> > @@ -277,6 +388,8 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
> >  
> >  	for (i = 0; i < TSC_MAX_NUM; i++) {
> >  		struct rcar_gen3_thermal_tsc *tsc;
> > +		char *irqname;
> > +		int irq;
> >  
> >  		tsc = devm_kzalloc(dev, sizeof(*tsc), GFP_KERNEL);
> >  		if (!tsc) {
> > @@ -299,6 +412,25 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
> >  			goto error_unregister;
> >  		}
> >  
> > +		irq = platform_get_irq(pdev, i);
> 
> Hmmm, with reusing 'i' for getting the interrupt resource, you assume
> that the number of TSC will always equal the number of interrupts. It's
> somewhat reasonable, yet we have seen enough surprises in HW to better
> not assume it IMO.
> 
> Another advantage of decoupling it into a seperate loop is that you only
> need to register as much interrupts as the driver actually uses. It uses
> 2 interrupts, so no need for installing 3 handlers, no?

That is correct, will update for next version.

> 
> > +		if (irq < 0) {
> > +			ret = irq;
> > +			goto error_unregister;
> > +		}
> 
> ...
> 
> > +
> > +		dev_info(tsc->dev, "TSC%d: Loaded %d trip points\n", tsc->num,
> > +			 of_thermal_get_ntrips(tsc->zone));
> 
> I'd think the of_thermal_get_ntrips is a little bit hidden in the
> dev_info. Would like it more explicitly. Also, it cannot fail? What
> happens if DT provides broken trip points...

All thermal zones are parsed by the thermal core by 
of_parse_thermal_zones() called from thermal_init() which is called 
using fs_initcall(thermal_init). Then the call chain

devm_thermal_zone_of_sensor_register()
    thermal_zone_of_sensor_register()
       thermal_zone_of_add_sensor()
          thermal_zone_get_zone_by_name()

Finds the zone parsed at init time, so if the zone is broken in some way 
it would not be available and devm_thermal_zone_of_sensor_register() 
would fail.

But you are correct of_thermal_get_ntrips() could return -ENODEV I will 
add check for this and error out if that is the case.

> 
> >  	}
> >  
> > +	rcar_thermal_irq_enable(priv);
> 
> ... because we enable interrupts unconditionally here?
> 
> Regards,
> 
>    Wolfram
> 

-- 
Regards,
Niklas Söderlund
