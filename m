From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2 1/6] thermal: armada: add overheat interrupt support
Date: Thu, 29 Nov 2018 09:12:31 -0800
Message-ID: <20181129171229.GA3292@localhost.localdomain>
References: <20181123161730.11289-1-miquel.raynal@bootlin.com>
 <20181123161730.11289-2-miquel.raynal@bootlin.com>
 <2b2efaa3-8bfb-720b-e36c-9750661f29be@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <2b2efaa3-8bfb-720b-e36c-9750661f29be@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Gregory Clement <gregory.clement@bootlin.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, David Sniatkiwicz <davidsn@marvell.com>, Rob Herring <robh+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Nov 23, 2018 at 04:55:59PM +0000, Marc Zyngier wrote:
> On 23/11/2018 16:17, Miquel Raynal wrote:
> > The IP can manage to trigger interrupts on overheat situation from all
> > the sensors.
> > =

> > However, the interrupt source changes along with the last selected
> > source (ie. the last read sensor), which is an inconsistent behavior.
> > Avoid possible glitches by always selecting back only one channel which
> > will then be referenced as the "overheat_sensor" (arbitrarily: the first
> > in the DT which has a critical trip point filled in).
> > =

> > It is possible that the scan of all thermal zone nodes did not bring a
> > critical trip point from which the overheat interrupt could be
> > configured. In this case just complain but do not fail the probe.
> > =

> > Also disable sensor switch during overheat situations because changing
> > the channel while the system is too hot could clear the overheat state
> > by changing the source while the temperature is still very high.
> > =

> > Even if the overheat state is not declared, overheat interrupt must be
> > cleared by reading the DFX interrupt cause _after_ the temperature has
> > fallen down to the low threshold, otherwise future possible interrupts
> > would not be served. A work polls the corresponding register until the
> > overheat flag gets cleared in this case.
> > =

> > Suggested-by: David Sniatkiwicz <davidsn@marvell.com>
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/thermal/armada_thermal.c | 270 ++++++++++++++++++++++++++++++-
> >  1 file changed, 269 insertions(+), 1 deletion(-)
> > =

> > diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_=
thermal.c
> > index 92f67d40f2e9..55cfaee0da77 100644
> > --- a/drivers/thermal/armada_thermal.c
> > +++ b/drivers/thermal/armada_thermal.c
> > @@ -26,6 +26,11 @@
> >  #include <linux/iopoll.h>
> >  #include <linux/mfd/syscon.h>
> >  #include <linux/regmap.h>
> > +#include <linux/interrupt.h>
> > +
> > +#include "thermal_core.h"
> > +
> > +#define TO_MCELSIUS(c)			((c) * 1000)
> >  =

> >  /* Thermal Manager Control and Status Register */
> >  #define PMU_TDC0_SW_RST_MASK		(0x1 << 1)
> > @@ -61,9 +66,13 @@
> >  #define CONTROL1_TSEN_AVG_MASK		0x7
> >  #define CONTROL1_EXT_TSEN_SW_RESET	BIT(7)
> >  #define CONTROL1_EXT_TSEN_HW_RESETn	BIT(8)
> > +#define CONTROL1_TSEN_INT_EN		BIT(25)
> > +#define CONTROL1_TSEN_SELECT_OFF	21
> > +#define CONTROL1_TSEN_SELECT_MASK	0x3
> >  =

> >  #define STATUS_POLL_PERIOD_US		1000
> >  #define STATUS_POLL_TIMEOUT_US		100000
> > +#define OVERHEAT_INT_POLL_DELAY_MS	1000
> >  =

> >  struct armada_thermal_data;
> >  =

> > @@ -75,7 +84,11 @@ struct armada_thermal_priv {
> >  	/* serialize temperature reads/updates */
> >  	struct mutex update_lock;
> >  	struct armada_thermal_data *data;
> > +	struct thermal_zone_device *overheat_sensor;
> > +	int interrupt_source;
> >  	int current_channel;
> > +	long current_threshold;
> > +	long current_hysteresis;
> >  };
> >  =

> >  struct armada_thermal_data {
> > @@ -93,12 +106,20 @@ struct armada_thermal_data {
> >  	/* Register shift and mask to access the sensor temperature */
> >  	unsigned int temp_shift;
> >  	unsigned int temp_mask;
> > +	unsigned int thresh_shift;
> > +	unsigned int hyst_shift;
> > +	unsigned int hyst_mask;
> >  	u32 is_valid_bit;
> >  =

> >  	/* Syscon access */
> >  	unsigned int syscon_control0_off;
> >  	unsigned int syscon_control1_off;
> >  	unsigned int syscon_status_off;
> > +	unsigned int dfx_irq_cause_off;
> > +	unsigned int dfx_irq_mask_off;
> > +	unsigned int dfx_overheat_irq;
> > +	unsigned int dfx_server_irq_mask_off;
> > +	unsigned int dfx_server_irq_en;
> >  =

> >  	/* One sensor is in the thermal IC, the others are in the CPUs if any=
 */
> >  	unsigned int cpu_nr;
> > @@ -272,6 +293,41 @@ static bool armada_is_valid(struct armada_thermal_=
priv *priv)
> >  	return reg & priv->data->is_valid_bit;
> >  }
> >  =

> > +static void armada_enable_overheat_interrupt(struct armada_thermal_pri=
v *priv)
> > +{
> > +	struct armada_thermal_data *data =3D priv->data;
> > +	u32 reg;
> > +
> > +	/* Clear DFX temperature IRQ cause */
> > +	regmap_read(priv->syscon, data->dfx_irq_cause_off, &reg);
> > +
> > +	/* Enable DFX Temperature IRQ */
> > +	regmap_read(priv->syscon, data->dfx_irq_mask_off, &reg);
> > +	reg |=3D data->dfx_overheat_irq;
> > +	regmap_write(priv->syscon, data->dfx_irq_mask_off, reg);
> > +
> > +	/* Enable DFX server IRQ */
> > +	regmap_read(priv->syscon, data->dfx_server_irq_mask_off, &reg);
> > +	reg |=3D data->dfx_server_irq_en;
> > +	regmap_write(priv->syscon, data->dfx_server_irq_mask_off, reg);
> > +
> > +	/* Enable overheat interrupt */
> > +	regmap_read(priv->syscon, data->syscon_control1_off, &reg);
> > +	reg |=3D CONTROL1_TSEN_INT_EN;
> > +	regmap_write(priv->syscon, data->syscon_control1_off, reg);
> > +}
> > +
> > +static void __maybe_unused
> > +armada_disable_overheat_interrupt(struct armada_thermal_priv *priv)
> > +{
> > +	struct armada_thermal_data *data =3D priv->data;
> > +	u32 reg;
> > +
> > +	regmap_read(priv->syscon, data->syscon_control1_off, &reg);
> > +	reg &=3D ~CONTROL1_TSEN_INT_EN;
> > +	regmap_write(priv->syscon, data->syscon_control1_off, reg);
> > +}
> > +
> >  /* There is currently no board with more than one sensor per channel */
> >  static int armada_select_channel(struct armada_thermal_priv *priv, int=
 channel)
> >  {
> > @@ -388,6 +444,16 @@ static int armada_get_temp(void *_sensor, int *tem=
p)
> >  =

> >  	/* Do the actual reading */
> >  	ret =3D armada_read_sensor(priv, temp);
> > +	if (ret)
> > +		goto unlock_mutex;
> > +
> > +	/*
> > +	 * Select back the interrupt source channel from which a potential
> > +	 * critical trip point has been set.
> > +	 */
> > +	ret =3D armada_select_channel(priv, priv->interrupt_source);
> > +	if (ret)
> > +		goto unlock_mutex;
> =

> Do you really need a "goto" to the immediately following line?
> =


Agreed, that goto can be removed..

> >  =

> >  unlock_mutex:
> >  	mutex_unlock(&priv->update_lock);
> > @@ -399,6 +465,121 @@ static struct thermal_zone_of_device_ops of_ops =
=3D {
> >  	.get_temp =3D armada_get_temp,
> >  };
> >  =

> > +static unsigned int armada_mc_to_reg_temp(struct armada_thermal_data *=
data,
> > +					  unsigned int temp_mc)
> > +{
> > +	s64 b =3D data->coef_b;
> > +	s64 m =3D data->coef_m;
> > +	s64 div =3D data->coef_div;
> > +	unsigned int sample;
> > +
> > +	if (data->inverted)
> > +		sample =3D div_s64(((temp_mc * div) + b), m);
> > +	else
> > +		sample =3D div_s64((b - (temp_mc * div)), m);
> > +
> > +	return sample & data->temp_mask;
> > +}
> > +
> > +static unsigned int armada_mc_to_reg_hyst(struct armada_thermal_data *=
data,
> > +					  unsigned int hyst_mc)
> > +{
> > +	/*
> > +	 * The documentation states:
> > +	 * high/low watermark =3D threshold +/- 0.4761 * 2^(hysteresis + 2)
> > +	 * which is the mathematical derivation for:
> > +	 * 0x0 <=3D> 1.9=B0C, 0x1 <=3D> 3.8=B0C, 0x2 <=3D> 7.6=B0C, 0x3 <=3D>=
 15.2
> > +	 */
> > +	unsigned int hyst_levels_mc[] =3D {1900, 3800, 7600, 15200};
> =

> Why isn't this a static array rather than something you have to push on
> the stack each time you execute this function?

Also, where those constants come from? Is this something the driver
needs to be updated when new chips are added for instance?

> =

> > +	int i;
> > +
> > +	/*
> > +	 * We will always take the smallest possible hysteresis to avoid risk=
ing
> > +	 * the hardware integrity by enlarging the threshold by +8=B0C in the
> > +	 * worst case.
> > +	 */
> > +	for (i =3D ARRAY_SIZE(hyst_levels_mc) - 1; i > 0; i--)
> > +		if (hyst_mc >=3D hyst_levels_mc[i])
> > +			break;
> > +
> > +	return i & data->hyst_mask;
> > +}
> > +
> > +static void armada_set_overheat_thresholds(struct armada_thermal_priv =
*priv,
> > +					   int thresh_mc, int hyst_mc)
> > +{
> > +	struct armada_thermal_data *data =3D priv->data;
> > +	unsigned int threshold =3D armada_mc_to_reg_temp(data, thresh_mc);
> > +	unsigned int hysteresis =3D armada_mc_to_reg_hyst(data, hyst_mc);
> > +	u32 ctrl1;
> > +
> > +	regmap_read(priv->syscon, data->syscon_control1_off, &ctrl1);
> > +
> > +	/* Set Threshold */
> > +	if (thresh_mc >=3D 0) {
> > +		ctrl1 &=3D ~(data->temp_mask << data->thresh_shift);
> > +		ctrl1 |=3D threshold << data->thresh_shift;
> > +		priv->current_threshold =3D thresh_mc;
> > +	}
> > +
> > +	/* Set Hysteresis */
> > +	if (hyst_mc >=3D 0) {
> > +		ctrl1 &=3D ~(data->hyst_mask << data->hyst_shift);
> > +		ctrl1 |=3D hysteresis << data->hyst_shift;
> > +		priv->current_hysteresis =3D hyst_mc;
> > +	}
> > +
> > +	regmap_write(priv->syscon, data->syscon_control1_off, ctrl1);
> > +}
> > +
> > +static irqreturn_t armada_overheat_isr(int irq, void *blob)
> > +{
> > +	/*
> > +	 * Disable the IRQ and continue in thread context (thermal core
> > +	 * notification and temperature monitoring).
> > +	 */
> > +	disable_irq_nosync(irq);
> > +
> > +	return IRQ_WAKE_THREAD;
> > +}
> > +
> > +static irqreturn_t armada_overheat_isr_thread(int irq, void *blob)
> > +{
> > +	struct armada_thermal_priv *priv =3D (struct armada_thermal_priv *)bl=
ob;
> =

> Unnecessary cast.
> =

> > +	int low_threshold =3D priv->current_threshold - priv->current_hystere=
sis;
> > +	int temperature;
> > +	u32 dummy;
> > +	int ret;
> > +
> > +	/* Notify the core in thread context */
> > +	thermal_zone_device_update(priv->overheat_sensor,
> > +				   THERMAL_EVENT_UNSPECIFIED);
> > +
> > +	/*
> > +	 * The overheat interrupt must be cleared by reading the DFX interrupt
> > +	 * cause _after_ the temperature has fallen down to the low threshold.
> > +	 * Otherwise future interrupts might not be served.
> > +	 */
> > +	do {
> > +		msleep(OVERHEAT_INT_POLL_DELAY_MS);
> > +		mutex_lock(&priv->update_lock);
> > +		ret =3D armada_read_sensor(priv, &temperature);
> > +		mutex_unlock(&priv->update_lock);
> > +		if (ret)
> > +			return ret;
> =

> How will the interrupt fire again if you exit without re-enabling it? Is
> "ret" guaranteed to be a valid irqreturn_t?
> =

> > +	} while (temperature >=3D low_threshold);
> > +
> > +	regmap_read(priv->syscon, priv->data->dfx_irq_cause_off, &dummy);
> > +
> > +	/* Notify the thermal core that the temperature is acceptable again */
> > +	thermal_zone_device_update(priv->overheat_sensor,
> > +				   THERMAL_EVENT_UNSPECIFIED);
> > +
> > +	enable_irq(irq);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> >  static const struct armada_thermal_data armadaxp_data =3D {
> >  	.init =3D armadaxp_init,
> >  	.temp_shift =3D 10,
> > @@ -454,6 +635,9 @@ static const struct armada_thermal_data armada_ap80=
6_data =3D {
> >  	.is_valid_bit =3D BIT(16),
> >  	.temp_shift =3D 0,
> >  	.temp_mask =3D 0x3ff,
> > +	.thresh_shift =3D 3,
> > +	.hyst_shift =3D 19,
> > +	.hyst_mask =3D 0x3,
> >  	.coef_b =3D -150000LL,
> >  	.coef_m =3D 423ULL,
> >  	.coef_div =3D 1,
> > @@ -462,6 +646,11 @@ static const struct armada_thermal_data armada_ap8=
06_data =3D {
> >  	.syscon_control0_off =3D 0x84,
> >  	.syscon_control1_off =3D 0x88,
> >  	.syscon_status_off =3D 0x8C,
> > +	.dfx_irq_cause_off =3D 0x108,
> > +	.dfx_irq_mask_off =3D 0x10C,
> > +	.dfx_overheat_irq =3D BIT(22),
> > +	.dfx_server_irq_mask_off =3D 0x104,
> > +	.dfx_server_irq_en =3D BIT(1),
> >  	.cpu_nr =3D 4,
> >  };
> >  =

> > @@ -470,6 +659,9 @@ static const struct armada_thermal_data armada_cp11=
0_data =3D {
> >  	.is_valid_bit =3D BIT(10),
> >  	.temp_shift =3D 0,
> >  	.temp_mask =3D 0x3ff,
> > +	.thresh_shift =3D 16,
> > +	.hyst_shift =3D 26,
> > +	.hyst_mask =3D 0x3,
> >  	.coef_b =3D 1172499100ULL,
> >  	.coef_m =3D 2000096ULL,
> >  	.coef_div =3D 4201,
> > @@ -477,6 +669,11 @@ static const struct armada_thermal_data armada_cp1=
10_data =3D {
> >  	.syscon_control0_off =3D 0x70,
> >  	.syscon_control1_off =3D 0x74,
> >  	.syscon_status_off =3D 0x78,
> > +	.dfx_irq_cause_off =3D 0x108,
> > +	.dfx_irq_mask_off =3D 0x10C,
> > +	.dfx_overheat_irq =3D BIT(20),
> > +	.dfx_server_irq_mask_off =3D 0x104,
> > +	.dfx_server_irq_en =3D BIT(1),
> >  };
> >  =

> >  static const struct of_device_id armada_thermal_id_table[] =3D {
> > @@ -592,6 +789,48 @@ static void armada_set_sane_name(struct platform_d=
evice *pdev,
> >  	} while (insane_char);
> >  }
> >  =

> > +/*
> > + * The IP can manage to trigger interrupts on overheat situation from =
all the
> > + * sensors. However, the interrupt source changes along with the last =
selected
> > + * source (ie. the last read sensor), which is an inconsistent behavio=
r. Avoid
> > + * possible glitches by always selecting back only one channel (arbitr=
arily: the
> > + * first in the DT which has a critical trip point). We also disable s=
ensor
> =

> The DT doesn't seem to *mandate* this. Should it? Does it also mean that
> you can only have a single critical point that will generate an
> interrupt on overheat?
> =


Also, keep in mind that thermal core will shutdown the system when it
sees any zone with temp crossing the first critical trip.


> > + * switch during overheat situations.
> > + */
> > +static int armada_configure_overheat_int(struct armada_thermal_priv *p=
riv,
> > +					 struct thermal_zone_device *tz,
> > +					 int sensor_id)
> > +{
> > +	/* Retrieve the critical trip point to enable the overheat interrupt =
*/
> > +	const struct thermal_trip *trips =3D of_thermal_get_trip_points(tz);
> > +	int ret;
> > +	int i;
> > +
> > +	if (!trips)
> > +		return -EINVAL;
> > +
> > +	for (i =3D 0; i < of_thermal_get_ntrips(tz); i++)
> > +		if (trips[i].type =3D=3D THERMAL_TRIP_CRITICAL)
> > +			break;
> > +
> > +	if (i =3D=3D of_thermal_get_ntrips(tz))
> > +		return -EINVAL;
> > +
> > +	ret =3D armada_select_channel(priv, sensor_id);
> > +	if (ret)
> > +		return ret;
> > +
> > +	armada_set_overheat_thresholds(priv,
> > +				       trips[i].temperature,
> > +				       trips[i].hysteresis);
> > +	priv->overheat_sensor =3D tz;
> > +	priv->interrupt_source =3D sensor_id;
> > +
> > +	armada_enable_overheat_interrupt(priv);
> > +
> > +	return 0;
> > +}
> > +
> >  static int armada_thermal_probe(struct platform_device *pdev)
> >  {
> >  	struct thermal_zone_device *tz;
> > @@ -599,7 +838,7 @@ static int armada_thermal_probe(struct platform_dev=
ice *pdev)
> >  	struct armada_drvdata *drvdata;
> >  	const struct of_device_id *match;
> >  	struct armada_thermal_priv *priv;
> > -	int sensor_id;
> > +	int sensor_id, irq;
> >  	int ret;
> >  =

> >  	match =3D of_match_device(armada_thermal_id_table, &pdev->dev);
> > @@ -669,6 +908,23 @@ static int armada_thermal_probe(struct platform_de=
vice *pdev)
> >  	drvdata->data.priv =3D priv;
> >  	platform_set_drvdata(pdev, drvdata);
> >  =

> > +	irq =3D platform_get_irq(pdev, 0);
> > +	if (irq =3D=3D -EPROBE_DEFER)
> > +		return irq;
> > +
> > +	/* The overheat interrupt feature is not mandatory */
> > +	if (irq >=3D 0) {
> =

> 0 is not a valid interrupt.
> =

> > +		ret =3D devm_request_threaded_irq(&pdev->dev, irq,
> > +						armada_overheat_isr,
> > +						armada_overheat_isr_thread,
> > +						0, NULL, priv);
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "Cannot request threaded IRQ %d\n",
> > +				irq);
> > +			return ret;
> > +		}
> > +	}
> > +
> >  	/*
> >  	 * There is one channel for the IC and one per CPU (if any), each
> >  	 * channel has one sensor.
> > @@ -692,8 +948,20 @@ static int armada_thermal_probe(struct platform_de=
vice *pdev)
> >  			devm_kfree(&pdev->dev, sensor);
> >  			continue;
> >  		}
> > +
> > +		/*
> > +		 * The first channel that has a critical trip point registered
> > +		 * in the DT will serve as interrupt source. Others possible
> > +		 * critical trip points will simply be ignored by the driver.
> > +		 */
> > +		if (irq >=3D 0 && !priv->overheat_sensor)
> =

> Same here.
> =

> > +			armada_configure_overheat_int(priv, tz, sensor->id);
> >  	}
> >  =

> > +	/* Just complain if no overheat interrupt was set up */
> > +	if (!priv->overheat_sensor)
> > +		dev_warn(&pdev->dev, "Overheat interrupt not available\n");
> > +
> >  	return 0;
> >  }
> >  =

> > =

> =

> Thanks,
> =

> 	M.
> -- =

> Jazz is not dead. It just smells funny...
