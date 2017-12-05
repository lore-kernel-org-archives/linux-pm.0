From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH] power: ltc2941-battery-gauge: Disable continuous
 monitoring on shutdown
Date: Tue, 5 Dec 2017 10:08:24 +0100
Message-ID: <20171205090824.GA4865@lenoch>
References: <1511448065-2727-1-git-send-email-mike.looijmans@topic.nl>
 <20171201154210.l5wrmqipb5eeamzc@earth>
 <708849a5-5b66-effc-21d7-f8d7c2f7be61@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <708849a5-5b66-effc-21d7-f8d7c2f7be61@topic.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Dragos.Bogdan@analog.com
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 05, 2017 at 08:10:27AM +0100, Mike Looijmans wrote:
> ﻿On 01-12-17 16:42, Sebastian Reichel wrote:
> > Hi,
> > 
> > On Thu, Nov 23, 2017 at 03:41:05PM +0100, Mike Looijmans wrote:
> > > The driver sets the fuel gauge to continuous monitoring on startup, for
> > > the models that support this. When the board shuts down, the chip remains
> > > in that mode, causing a few mA drain on the battery every 2 or 10 seconds.
> > > 
> > > This patch registers a shutdown handler that turns off the monitoring to
> > > prevent this battery drain.
> > > 
> > > Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> > > ---
> > 
> > Thanks, queued. I wonder if you need a second patch to also disable
> > the monitoring for suspend (and re-enable on resume)?
> 
> For now, yes, that would probably make sense.
> 
> The gauge also has "alert" functionality, once that is enabled in the
> driver, the monitoring shouldn't be disabled and the device would even be
> able to wake the system. But that's no concern yet, so just stopping it on
> suspend would be better for now.

That should be probably somehow configurable. DT property? As some boards
might continue to drain power in suspended state and disabling gas gauge
might cause inaccuracy in battery charge after some time. The same will
happen when charging device in suspended (or even disabled) state.

Best regards,
	ladis

> > -- Sebastian
> > 
> > >   drivers/power/supply/ltc2941-battery-gauge.c | 25 +++++++++++++++++++++++++
> > >   1 file changed, 25 insertions(+)
> > > 
> > > diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
> > > index 08e4fd9..4cfa3f0 100644
> > > --- a/drivers/power/supply/ltc2941-battery-gauge.c
> > > +++ b/drivers/power/supply/ltc2941-battery-gauge.c
> > > @@ -60,6 +60,7 @@ enum ltc294x_id {
> > >   #define LTC294X_REG_CONTROL_PRESCALER_SET(x) \
> > >   	((x << 3) & LTC294X_REG_CONTROL_PRESCALER_MASK)
> > >   #define LTC294X_REG_CONTROL_ALCC_CONFIG_DISABLED	0
> > > +#define LTC294X_REG_CONTROL_ADC_DISABLE(x)	((x) & ~(BIT(7) | BIT(6)))
> > >   struct ltc294x_info {
> > >   	struct i2c_client *client;	/* I2C Client pointer */
> > > @@ -523,6 +524,29 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
> > >   	return 0;
> > >   }
> > > +static void ltc294x_i2c_shutdown(struct i2c_client *client)
> > > +{
> > > +	struct ltc294x_info *info = i2c_get_clientdata(client);
> > > +	int ret;
> > > +	u8 value;
> > > +	u8 control;
> > > +
> > > +	/* The LTC2941 does not need any special handling */
> > > +	if (info->id == LTC2941_ID)
> > > +		return;
> > > +
> > > +	/* Read control register */
> > > +	ret = ltc294x_read_regs(info->client, LTC294X_REG_CONTROL, &value, 1);
> > > +	if (ret < 0)
> > > +		return;
> > > +
> > > +	/* Disable continuous ADC conversion as this drains the battery */
> > > +	control = LTC294X_REG_CONTROL_ADC_DISABLE(value);
> > > +	if (control != value)
> > > +		ltc294x_write_regs(info->client, LTC294X_REG_CONTROL,
> > > +			&control, 1);
> > > +}
> > > +
> > >   #ifdef CONFIG_PM_SLEEP
> > >   static int ltc294x_suspend(struct device *dev)
> > > @@ -589,6 +613,7 @@ static int ltc294x_resume(struct device *dev)
> > >   	},
> > >   	.probe		= ltc294x_i2c_probe,
> > >   	.remove		= ltc294x_i2c_remove,
> > > +	.shutdown	= ltc294x_i2c_shutdown,
> > >   	.id_table	= ltc294x_i2c_id,
> > >   };
> > >   module_i2c_driver(ltc294x_driver);
> > > -- 
> > > 1.9.1
> > > 
> 
> 
> -- 
> Mike Looijmans
> 
> 
> Kind regards,
> 
> Mike Looijmans
> System Expert
> 
> TOPIC Products
> Materiaalweg 4, NL-5681 RJ Best
> Postbus 440, NL-5680 AK Best
> Telefoon: +31 (0) 499 33 69 79
> E-mail: mike.looijmans@topicproducts.com
> Website: www.topicproducts.com
> 
> Please consider the environment before printing this e-mail
> 
> 
