From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v7 03/10] i2c: i2c-smbus: Use threaded irq for smbalert
Date: Fri, 23 Jun 2017 14:11:30 +0200
Message-ID: <20170623121130.GL26073@mail.corp.redhat.com>
References: <1497535178-12001-1-git-send-email-preid@electromag.com.au>
 <1497535178-12001-4-git-send-email-preid@electromag.com.au>
 <20170619152718.3xjksam7ns4ms6xk@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37506 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751182AbdFWMLn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Jun 2017 08:11:43 -0400
Content-Disposition: inline
In-Reply-To: <20170619152718.3xjksam7ns4ms6xk@ninjato>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Phil Reid <preid@electromag.com.au>, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, jdelvare@suse.com, jglauber@cavium.com, david.daney@cavium.com, peda@axentia.se, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

Hi,

On Jun 19 2017 or thereabouts, Wolfram Sang wrote:
> On Thu, Jun 15, 2017 at 09:59:31PM +0800, Phil Reid wrote:
> > Prior to this commit the smbalert_irq was handling in the hard irq
> > context. This change switch to using a thread irq which avoids the need
> > for the work thread. Using threaded irq also removes the need for the
> > edge_triggered flag as the enabling / disabling of the hard irq for level
> > triggered interrupts will be handled by the irq core.
> > 
> > Without this change have an irq connected to something like an i2c gpio
> > resulted in a null ptr deferences. Specifically handle_nested_irq calls
> > the threaded irq handler.
> > 
> > There are currently 3 in tree drivers affected by this change.
> > 
> > i2c-parport driver calls i2c_handle_smbus_alert in a hard irq context.
> > This driver use edge trigger interrupts which skip the enable / disable
> > calls. But it still need to handle the smbus transaction on a thread. So
> > the work thread is kept for this driver.
> > 
> > i2c-parport-light & i2c-thunderx-pcidrv provide the irq number in the
> > setup which will result in the thread irq being used.
> > 
> > i2c-parport-light is edge trigger so the enable / disable call was
> > skipped as well.
> > 
> > i2c-thunderx-pcidrv is getting the edge / level trigger setting from of
> > data and was setting the flag as required. However the irq core should
> > handle this automatically.
> > 
> > Signed-off-by: Phil Reid <preid@electromag.com.au>
> 
> CCing Benjamin for smbus changes (like last time). Please CC him in the
> future in case we need another revision of this series.

Thanks Wolfram.

I wonder if we can not have something similar than what we do for host notify
for removing the worker all together:

In host notify, we request a new IRQ number, and when the Host Notify
function is called, we simply call generic_handle_irq(). Switching
i2c-parport to something similar could help us remove this worker
entirely. But given this change would require to actually have a device
handled by i2c-parport, we might postpone this later.

Other than that, the patch looks good to me. The commit message is a
little bit messy IMO, and it took me a while to understand all the
subtleties (most of the issues raised in the messaged are simpler to
understand when reading the code).

Anyway, not a big deal, this one is:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> 
> > ---
> >  drivers/i2c/busses/i2c-parport-light.c   |  1 -
> >  drivers/i2c/busses/i2c-parport.c         |  1 -
> >  drivers/i2c/busses/i2c-thunderx-pcidrv.c |  6 -----
> >  drivers/i2c/i2c-smbus.c                  | 41 +++++++++++++-------------------
> >  include/linux/i2c-smbus.h                |  1 -
> >  5 files changed, 17 insertions(+), 33 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-parport-light.c b/drivers/i2c/busses/i2c-parport-light.c
> > index 1bcdd10..e6e22b8 100644
> > --- a/drivers/i2c/busses/i2c-parport-light.c
> > +++ b/drivers/i2c/busses/i2c-parport-light.c
> > @@ -123,7 +123,6 @@ static int parport_getsda(void *data)
> >  
> >  /* SMBus alert support */
> >  static struct i2c_smbus_alert_setup alert_data = {
> > -	.alert_edge_triggered	= 1,
> >  };
> >  static struct i2c_client *ara;
> >  static struct lineop parport_ctrl_irq = {
> > diff --git a/drivers/i2c/busses/i2c-parport.c b/drivers/i2c/busses/i2c-parport.c
> > index a8e54df..319209a 100644
> > --- a/drivers/i2c/busses/i2c-parport.c
> > +++ b/drivers/i2c/busses/i2c-parport.c
> > @@ -237,7 +237,6 @@ static void i2c_parport_attach(struct parport *port)
> >  
> >  	/* Setup SMBus alert if supported */
> >  	if (adapter_parm[type].smbus_alert) {
> > -		adapter->alert_data.alert_edge_triggered = 1;
> >  		adapter->ara = i2c_setup_smbus_alert(&adapter->adapter,
> >  						     &adapter->alert_data);
> >  		if (adapter->ara)
> > diff --git a/drivers/i2c/busses/i2c-thunderx-pcidrv.c b/drivers/i2c/busses/i2c-thunderx-pcidrv.c
> > index 1d4c2be..c27a50f 100644
> > --- a/drivers/i2c/busses/i2c-thunderx-pcidrv.c
> > +++ b/drivers/i2c/busses/i2c-thunderx-pcidrv.c
> > @@ -112,8 +112,6 @@ static void thunder_i2c_clock_disable(struct device *dev, struct clk *clk)
> >  static int thunder_i2c_smbus_setup_of(struct octeon_i2c *i2c,
> >  				      struct device_node *node)
> >  {
> > -	u32 type;
> > -
> >  	if (!node)
> >  		return -EINVAL;
> >  
> > @@ -121,10 +119,6 @@ static int thunder_i2c_smbus_setup_of(struct octeon_i2c *i2c,
> >  	if (!i2c->alert_data.irq)
> >  		return -EINVAL;
> >  
> > -	type = irqd_get_trigger_type(irq_get_irq_data(i2c->alert_data.irq));
> > -	i2c->alert_data.alert_edge_triggered =
> > -		(type & IRQ_TYPE_LEVEL_MASK) ? 1 : 0;
> > -
> >  	i2c->ara = i2c_setup_smbus_alert(&i2c->adap, &i2c->alert_data);
> >  	if (!i2c->ara)
> >  		return -ENODEV;
> > diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
> > index f9271c7..d4af270 100644
> > --- a/drivers/i2c/i2c-smbus.c
> > +++ b/drivers/i2c/i2c-smbus.c
> > @@ -25,8 +25,6 @@
> >  #include <linux/workqueue.h>
> >  
> >  struct i2c_smbus_alert {
> > -	unsigned int		alert_edge_triggered:1;
> > -	int			irq;
> >  	struct work_struct	alert;
> >  	struct i2c_client	*ara;		/* Alert response address */
> >  };
> > @@ -72,13 +70,12 @@ static int smbus_do_alert(struct device *dev, void *addrp)
> >   * The alert IRQ handler needs to hand work off to a task which can issue
> >   * SMBus calls, because those sleeping calls can't be made in IRQ context.
> >   */
> > -static void smbus_alert(struct work_struct *work)
> > +static irqreturn_t smbus_alert(int irq, void *d)
> >  {
> > -	struct i2c_smbus_alert *alert;
> > +	struct i2c_smbus_alert *alert = d;
> >  	struct i2c_client *ara;
> >  	unsigned short prev_addr = 0;	/* Not a valid address */
> >  
> > -	alert = container_of(work, struct i2c_smbus_alert, alert);
> >  	ara = alert->ara;
> >  
> >  	for (;;) {
> > @@ -115,21 +112,17 @@ static void smbus_alert(struct work_struct *work)
> >  		prev_addr = data.addr;
> >  	}
> >  
> > -	/* We handled all alerts; re-enable level-triggered IRQs */
> > -	if (!alert->alert_edge_triggered)
> > -		enable_irq(alert->irq);
> > +	return IRQ_HANDLED;
> >  }
> >  
> > -static irqreturn_t smbalert_irq(int irq, void *d)
> > +static void smbalert_work(struct work_struct *work)
> >  {
> > -	struct i2c_smbus_alert *alert = d;
> > +	struct i2c_smbus_alert *alert;
> > +
> > +	alert = container_of(work, struct i2c_smbus_alert, alert);
> >  
> > -	/* Disable level-triggered IRQs until we handle them */
> > -	if (!alert->alert_edge_triggered)
> > -		disable_irq_nosync(irq);
> > +	smbus_alert(0, alert);
> >  
> > -	schedule_work(&alert->alert);
> > -	return IRQ_HANDLED;
> >  }
> >  
> >  /* Setup SMBALERT# infrastructure */
> > @@ -139,28 +132,28 @@ static int smbalert_probe(struct i2c_client *ara,
> >  	struct i2c_smbus_alert_setup *setup = dev_get_platdata(&ara->dev);
> >  	struct i2c_smbus_alert *alert;
> >  	struct i2c_adapter *adapter = ara->adapter;
> > -	int res;
> > +	int res, irq;
> >  
> >  	alert = devm_kzalloc(&ara->dev, sizeof(struct i2c_smbus_alert),
> >  			     GFP_KERNEL);
> >  	if (!alert)
> >  		return -ENOMEM;
> >  
> > -	alert->alert_edge_triggered = setup->alert_edge_triggered;
> > -	alert->irq = setup->irq;
> > -	INIT_WORK(&alert->alert, smbus_alert);
> > +	irq = setup->irq;
> > +	INIT_WORK(&alert->alert, smbalert_work);
> >  	alert->ara = ara;
> >  
> > -	if (setup->irq > 0) {
> > -		res = devm_request_irq(&ara->dev, setup->irq, smbalert_irq,
> > -				       0, "smbus_alert", alert);
> > +	if (irq > 0) {
> > +		res = devm_request_threaded_irq(&ara->dev, irq,
> > +						NULL, smbus_alert,
> > +						IRQF_SHARED | IRQF_ONESHOT,
> > +						"smbus_alert", alert);
> >  		if (res)
> >  			return res;
> >  	}
> >  
> >  	i2c_set_clientdata(ara, alert);
> > -	dev_info(&adapter->dev, "supports SMBALERT#, %s trigger\n",
> > -		 setup->alert_edge_triggered ? "edge" : "level");
> > +	dev_info(&adapter->dev, "supports SMBALERT#\n");
> >  
> >  	return 0;
> >  }
> > diff --git a/include/linux/i2c-smbus.h b/include/linux/i2c-smbus.h
> > index a138502..19efbd1 100644
> > --- a/include/linux/i2c-smbus.h
> > +++ b/include/linux/i2c-smbus.h
> > @@ -42,7 +42,6 @@
> >   * properly set.
> >   */
> >  struct i2c_smbus_alert_setup {
> > -	unsigned int		alert_edge_triggered:1;
> >  	int			irq;
> >  };
> >  
> > -- 
> > 1.8.3.1
> > 
