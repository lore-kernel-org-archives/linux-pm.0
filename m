From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v7 04/10] i2c: i2c-smbus: add of_i2c_setup_smbus_alert
Date: Fri, 23 Jun 2017 14:15:52 +0200
Message-ID: <20170623121552.GM26073@mail.corp.redhat.com>
References: <1497535178-12001-1-git-send-email-preid@electromag.com.au>
 <1497535178-12001-5-git-send-email-preid@electromag.com.au>
 <20170619152744.4gtlyrwdhjbhy562@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170619152744.4gtlyrwdhjbhy562@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Phil Reid <preid@electromag.com.au>, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, jdelvare@suse.com, jglauber@cavium.com, david.daney@cavium.com, peda@axentia.se, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Jun 19 2017 or thereabouts, Wolfram Sang wrote:
> On Thu, Jun 15, 2017 at 09:59:32PM +0800, Phil Reid wrote:
> > This commit adds of_i2c_setup_smbus_alert which allows the smbalert
> > driver to be attached to an i2c adapter via the device tree.
> > 
> > Signed-off-by: Phil Reid <preid@electromag.com.au>
> > Acked-by: Rob Herring <robh@kernel.org>
> 
> CCing Benjamin
> 
> > ---
> >  Documentation/devicetree/bindings/i2c/i2c.txt |  4 ++--
> >  drivers/i2c/i2c-smbus.c                       | 34 ++++++++++++++++++++++++---
> >  include/linux/i2c-smbus.h                     |  9 +++++++
> >  3 files changed, 42 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c.txt b/Documentation/devicetree/bindings/i2c/i2c.txt
> > index cee9d50..1126398 100644
> > --- a/Documentation/devicetree/bindings/i2c/i2c.txt
> > +++ b/Documentation/devicetree/bindings/i2c/i2c.txt
> > @@ -59,8 +59,8 @@ wants to support one of the below features, it should adapt the bindings below.
> >  	interrupts used by the device.
> >  
> >  - interrupt-names
> > -	"irq" and "wakeup" names are recognized by I2C core, other names are
> > -	left to individual drivers.
> > +	"irq", "wakeup" and "smbus_alert" names are recognized by I2C core,
> > +	other names are	left to individual drivers.
> >  
> >  - host-notify
> >  	device uses SMBus host notify protocol instead of interrupt line.
> > diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
> > index d4af270..0ad7f7f 100644
> > --- a/drivers/i2c/i2c-smbus.c
> > +++ b/drivers/i2c/i2c-smbus.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > +#include <linux/of_irq.h>
> >  #include <linux/slab.h>
> >  #include <linux/workqueue.h>
> >  
> > @@ -131,7 +132,7 @@ static int smbalert_probe(struct i2c_client *ara,
> >  {
> >  	struct i2c_smbus_alert_setup *setup = dev_get_platdata(&ara->dev);
> >  	struct i2c_smbus_alert *alert;
> > -	struct i2c_adapter *adapter = ara->adapter;
> > +	struct i2c_adapter *adap = ara->adapter;

I am not a big fan of this rename (even for consistency with the rest of
the file). It makes the patch bigger of 2 hunks for nothing :/

(Wolfram might have a different opinion)

> >  	int res, irq;
> >  
> >  	alert = devm_kzalloc(&ara->dev, sizeof(struct i2c_smbus_alert),
> > @@ -139,7 +140,14 @@ static int smbalert_probe(struct i2c_client *ara,
> >  	if (!alert)
> >  		return -ENOMEM;
> >  
> > -	irq = setup->irq;
> > +	if (setup) {
> > +		irq = setup->irq;
> > +	} else {
> > +		irq = of_irq_get_byname(adap->dev.of_node, "smbus_alert");
> > +		if (irq <= 0)
> > +			return irq;
> > +	}
> > +
> >  	INIT_WORK(&alert->alert, smbalert_work);
> >  	alert->ara = ara;
> >  
> > @@ -153,7 +161,7 @@ static int smbalert_probe(struct i2c_client *ara,
> >  	}
> >  
> >  	i2c_set_clientdata(ara, alert);
> > -	dev_info(&adapter->dev, "supports SMBALERT#\n");
> > +	dev_info(&adap->dev, "supports SMBALERT#\n");
> >  
> >  	return 0;
> >  }
> > @@ -214,6 +222,26 @@ struct i2c_client *i2c_setup_smbus_alert(struct i2c_adapter *adapter,
> >  }
> >  EXPORT_SYMBOL_GPL(i2c_setup_smbus_alert);
> >  
> > +int of_i2c_setup_smbus_alert(struct i2c_adapter *adap)
> > +{
> > +	struct i2c_client *client;
> > +	int irq;
> > +
> > +	irq = of_property_match_string(adap->dev.of_node, "interrupt-names",
> > +				       "smbus_alert");
> > +	if (irq == -EINVAL || irq == -ENODATA)
> > +		return 0;
> > +	else if (irq < 0)
> > +		return irq;
> > +
> > +	client = i2c_setup_smbus_alert(adap, NULL);
> > +	if (!client)
> > +		return -ENODEV;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(of_i2c_setup_smbus_alert);
> > +
> >  /**
> >   * i2c_handle_smbus_alert - Handle an SMBus alert
> >   * @ara: the ARA client on the relevant adapter
> > diff --git a/include/linux/i2c-smbus.h b/include/linux/i2c-smbus.h
> > index 19efbd1..b5261c1 100644
> > --- a/include/linux/i2c-smbus.h
> > +++ b/include/linux/i2c-smbus.h
> > @@ -49,4 +49,13 @@ struct i2c_client *i2c_setup_smbus_alert(struct i2c_adapter *adapter,
> >  					 struct i2c_smbus_alert_setup *setup);
> >  int i2c_handle_smbus_alert(struct i2c_client *ara);
> >  
> > +#if IS_ENABLED(CONFIG_I2C_SMBUS)

Can't we have:
#if IS_ENABLED(CONFIG_I2C_SMBUS) && IS_ENABLED(*whatever OF config symbol is*)

Because otherwise, even if the code works from what I understand, we
will pull in i2c-smbus from i2c-core all the time.

Besides those nitpicks, the patch is OK IMO.

Cheers,
Benjamin

> > +int of_i2c_setup_smbus_alert(struct i2c_adapter *adap);
> > +#else
> > +static inline int of_i2c_setup_smbus_alert(struct i2c_adapter *adap)
> > +{
> > +	return 0;
> > +}
> > +#endif
> > +
> >  #endif /* _LINUX_I2C_SMBUS_H */
> > -- 
> > 1.8.3.1
> > 
