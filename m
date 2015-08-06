From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/3] thermal: Add Mediatek thermal controller support
Date: Thu, 6 Aug 2015 10:10:11 +0200
Message-ID: <20150806081011.GM18700@pengutronix.de>
References: <1438777538-1269-1-git-send-email-s.hauer@pengutronix.de>
 <1438777538-1269-3-git-send-email-s.hauer@pengutronix.de>
 <CAGS+omBvkS4tZirsPp2L=vQaV7aWheEL0Nov1Yvu81dVbWdz-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGS+omBvkS4tZirsPp2L=vQaV7aWheEL0Nov1Yvu81dVbWdz-g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mediatek@lists.infradead.org, Sasha Hauer <kernel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 06, 2015 at 02:02:30AM +0800, Daniel Kurtz wrote:
> 
> > +
> > +#define THERMAL_NAME    "mtk-thermal"
> > +
> > +struct mtk_thermal;
> > +
> > +struct mtk_thermal_bank {
> > +       struct mtk_thermal *mt;
> > +       struct thermal_zone_device *tz;
> 
> A better name for this field is "tzd" - that is what is used in
> drivers/thermal/of-thermal.c.
> 
> > +       int id;
> 
> nit: we don't need both *mt and id, since "id" here is always just the
> index into the mtk_thermal->banks[] array, given either mt or id and
> our bank pointer, we can derive the other.
> 
> I think something like this would work:
> 
> static inline struct mtk_thermal *to_mtk_thermal(struct mtk_thermal_bank* bank)
> {
>   struct mtk_thermal_bank *banks = bank - bank->id;
>   return container_of(banks, struct mtk_thermal_bank, banks);
> }
> 
> or:
> 
> static inline int mtk_thermal_bank_id(struct mtk_thermal_bank* bank)
> {
>   return bank - bank->mt->banks;
> }

Yes, probably both work. I don't think though that any of these makes
the code clearer.

> > +static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
> > +               u32 apmixed_phys_base, u32 auxadc_phys_base)
> > +{
> > +       struct mtk_thermal_bank *bank = &mt->banks[num];
> > +       const struct mtk_thermal_bank_cfg *cfg = &bank_data[num];
> > +       int i;
> > +
> > +       bank->id = num;
> > +       bank->mt = mt;
> > +
> > +       mtk_thermal_get_bank(bank);
> > +
> > +       /* bus clock 66M counting unit is 12 * 15.15ns * 256 = 46.540us */
> > +       writel(TEMP_MONCTL1_PERIOD_UNIT(12), mt->thermal_base + TEMP_MONCTL1);
> > +
> 
> The only things that look zone specific here are the following:
> 
>   mtk_thermal_get_bank(bank);
>   for (i = 0; i < cfg->num_sensors; i++)
>     writel(sensor_mux_values[cfg->sensors[i]], mt->thermal_base +
> sensing_points[i].adcpnp);
>   writel((1 << cfg->num_sensors) - 1, mt->thermal_base + TEMP_MONCTL0);
>   mtk_thermal_put_bank(bank);
> 
> The rest is just rewriting the same constants to the same fixed
> register addresses.
> 
> But maybe that get/put zone thing does some magic shadow register selecting?

Yes. The comment above mtk_thermal_get_bank() explains that.

> > +
> > +       ret = clk_prepare_enable(mt->clk_peri_therm);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "Can't enable peri clk: %d\n", ret);
> > +               goto err_disable_clk_auxadc;
> > +       }
> > +
> > +       /*
> > +        * These calibration values should finally be provided by the
> > +        * firmware or fuses. For now use default values.
> > +        */
> > +       mt->calib_a = -123;
> > +       mt->calib_b = 465124;
> > +
> > +       for (i = 0; i < MT8173_NUM_BANKS; i++)
> > +               mtk_thermal_init_bank(mt, i, apmixed_phys_base, auxadc_phys_base);
> > +
> > +       platform_set_drvdata(pdev, mt);
> > +
> > +       for (i = 0; i < MT8173_NUM_BANKS; i++) {
> > +               struct mtk_thermal_bank *bank = &mt->banks[i];
> > +
> > +               bank->tz = thermal_zone_of_sensor_register(&pdev->dev, i, bank,
> > +                               &mtk_thermal_ops);
> 
> Hmm..  the 'i' passed here to thermal_zone_of_sensor_register is the
> id that a .dts thermal-zone will use to select one of the sensors
> provided by our "mediatek,mt8173-thermal" compatible thermal node.
> So, I think it is really ABI and should be some label defined in a
> header file as part of the of binding for the sensor node.  Each label
> would then be encoded somehow in mtk_thermal_bank_cfg[] (or perhaps
> used as the index when initializing the array, like you did for scpsys
> in

Makes sense. I'll add that for the next version.

Thanks for reviewing,

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
