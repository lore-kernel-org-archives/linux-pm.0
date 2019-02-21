From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH 12/12] thermal: qoriq: Add support for multiple thremal sites
Date: Thu, 21 Feb 2019 10:53:52 -0800
Message-ID: <CAHQ1cqHnuzPuaVKHRTzEhj=H7Rd0+kBA4p5iXnvbT2=DzLZMVQ@mail.gmail.com>
References: <20190218191141.3729-1-andrew.smirnov@gmail.com>
 <20190218191141.3729-13-andrew.smirnov@gmail.com> <20190221005717.GC31479@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190221005717.GC31479@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, dl-linux-imx <linux-imx@nxp.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 20, 2019 at 4:57 PM Eduardo Valentin <edubezval@gmail.com> wrote:
>
> On Mon, Feb 18, 2019 at 11:11:41AM -0800, Andrey Smirnov wrote:
> > TMU IP block provides temerature measurement for up to 16 sites,
> > current implementation of the driver however hardcodes a single site
> > ID. Change the code so it would be possible to reference multiple
> > sites as indivudial sensors and get their temperature readings.
>
> small typo: indivudial/individual.
>
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: linux-imx@nxp.com
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/thermal/qoriq_thermal.c | 132 ++++++++++++++++++++------------
> >  1 file changed, 84 insertions(+), 48 deletions(-)
> >
> > diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> > index f746c62789b0..6cc6e6b36fb0 100644
> > --- a/drivers/thermal/qoriq_thermal.c
> > +++ b/drivers/thermal/qoriq_thermal.c
> > @@ -24,6 +24,8 @@
> >  #define TMR_DISABLE  0x0
> >  #define TMR_ME               0x80000000
> >  #define TMR_ALPF     0x0c000000
> > +#define TMR_ALPF_MASK        GENMASK(27, 26)
> > +
> >
> >  #define REGS_TMTMIR  0x008   /* Temperature measurement interval Register */
> >  #define TMTMIR_DEFAULT       0x0000000f
> > @@ -41,21 +43,32 @@
> >  #define REGS_TTRnCR(n)       (0xf10 + 4 * (n)) /* Temperature Range n
> >                                          * Control Register
> >                                          */
> > +struct qoriq_tmu_sensor {
> > +     struct thermal_zone_device *tz;
> > +     int id;
> > +};
> > +
> >  /*
> >   * Thermal zone data
> >   */
> >  struct qoriq_tmu_data {
> >       struct thermal_zone_device *tz;
> >       struct regmap *regmap;
> > -     int sensor_id;
> > +     struct qoriq_tmu_sensor sensors[SITES_MAX];
> >  };
> >
> > +static struct qoriq_tmu_data *qoriq_sensor_to_data(struct qoriq_tmu_sensor *s)
> > +{
> > +     return container_of(s, struct qoriq_tmu_data, sensors[s->id]);
> > +}
> > +
> >  static int tmu_get_temp(void *p, int *temp)
> >  {
> >       u32 val;
> > -     struct qoriq_tmu_data *data = p;
> > +     struct qoriq_tmu_sensor *s = p;
> > +     struct qoriq_tmu_data *data = qoriq_sensor_to_data(s);
> >
> > -     regmap_read(data->regmap, REGS_TRITSR(data->sensor_id), &val);
> > +     regmap_read(data->regmap, REGS_TRITSR(s->id), &val);
> >       if (!(val & TRITSR_V))
> >               return -ENODATA;
> >
> > @@ -63,38 +76,86 @@ static int tmu_get_temp(void *p, int *temp)
> >       return 0;
> >  }
> >
> > -static int qoriq_tmu_get_sensor_id(void)
> > +static const struct thermal_zone_of_device_ops tmu_tz_ops = {
> > +     .get_temp = tmu_get_temp,
> > +};
> > +
> > +static int qoriq_tmu_populate_sensors(struct device *dev,
> > +                                   struct qoriq_tmu_data *data)
> >  {
> > -     int ret, id;
> > +     int ret, id, i, count = 0;
> >       struct of_phandle_args sensor_specs;
> >       struct device_node *np, *sensor_np;
> > +     struct qoriq_tmu_sensor *s;
> >
> >       np = of_find_node_by_name(NULL, "thermal-zones");
> >       if (!np)
> >               return -ENODEV;
> >
> > -     sensor_np = of_get_next_child(np, NULL);
> > -     ret = of_parse_phandle_with_args(sensor_np, "thermal-sensors",
> > -                     "#thermal-sensor-cells",
> > -                     0, &sensor_specs);
> > -     if (ret) {
> > -             id = ret;
> > -             goto out;
> > +     for_each_child_of_node(np, sensor_np) {
> > +             u16 msite;
> > +
> > +             ret = of_parse_phandle_with_args(sensor_np, "thermal-sensors",
> > +                                              "#thermal-sensor-cells",
> > +                                              0, &sensor_specs);
> > +             if (ret)
> > +                     break;
> > +
> > +             if (sensor_specs.args_count != 1) {
> > +                     pr_err("%pOFn: Invalid number of cells in sensor specifier %d\n",
> > +                            sensor_specs.np, sensor_specs.args_count);
> > +                     ret = -EINVAL;
> > +                     break;
> > +             }
> > +
> > +             id = sensor_specs.args[0];
> > +             if (id >= SITES_MAX) {
> > +                     ret = -EINVAL;
> > +                     dev_err(dev, "Sensor id %d is out of range\n", id);
> > +                     break;
> > +             }
> > +
> > +             msite = BIT(15 - id);
> > +             /* Enable monitoring of that particular sensor*/
> > +             regmap_update_bits(data->regmap, REGS_TMR, msite, msite);
> > +
> > +             s = &data->sensors[id];
> > +             s->id = id;
> > +             count++;
>
> Not sure I follow why you need to bother about thermal-sensor-cells..
>

devm_thermal_zone_of_sensor_register() will call
.get_temp()/tmu_get_temp(), so all present sensors need to be enabled
before that to avoid returning bogus data. The first loop going over
thermal-sensor-cells does exactly that as well as count # of sensors
present to avoid having to loop over all 16 possible sensors in the
code that follow.

Given how there's already a patch adding multiple sensors support, not
a lot of this patch will probably survive, so we can pretty much
disregard it.

Thanks,
Andrey Smirnov
