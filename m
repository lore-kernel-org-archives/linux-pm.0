From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH 08/13] power: bq24257: Extend scope of mutex protection
Date: Tue, 1 Sep 2015 17:15:30 -0500
Message-ID: <20150901221530.GD17234@beast>
References: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
 <1441073435-12349-9-git-send-email-dannenberg@ti.com>
 <55E60BE5.5030308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47027 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256AbbIAWQD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 1 Sep 2015 18:16:03 -0400
Content-Disposition: inline
In-Reply-To: <55E60BE5.5030308@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Tue, Sep 01, 2015 at 03:34:45PM -0500, Andrew F. Davis wrote:
> On 08/31/2015 09:10 PM, Andreas Dannenberg wrote:
> >This commit extends the use of the existing mutex to pave the way for
> >using direct device access inside sysfs getter/setter routines in a
> >way that the access during interrupts and timer routines does not
> >interfere with device access by the CPU or between multiple cores.
> >
> >This also addresses a potential race condition that could be caused
> >by bq24257_irq_handler_thread() and bq24257_iilimit_autoset() accessing
> >the device simultaneously.
> >
> >Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
> >---
> >  drivers/power/bq24257_charger.c | 60 ++++++++++++++++++++++++-----------------
> >  1 file changed, 35 insertions(+), 25 deletions(-)
> >
> >diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq24257_charger.c
> >index 2271a88..ad3fd2d 100644
> >--- a/drivers/power/bq24257_charger.c
> >+++ b/drivers/power/bq24257_charger.c
> >@@ -99,7 +99,7 @@ struct bq24257_device {
> >  	struct bq24257_init_data init_data;
> >  	struct bq24257_state state;
> >
> >-	struct mutex lock; /* protect state data */
> >+	struct mutex lock; /* protect device access and state data */
> >
> 
> I think it would make more sense to make a different lock for the device access. Protecting
> unrelated things with the same lock can lead to unnecessary blocks.

Andrew- thanks for spending time analyzing the patch series.

Actually the extension of the scope of the mutex seemed to fit almost
naturally into the existing code as the device status (register
contents) I'm opening more access to is just as important "state" as the
driver-maintained "struct bq24257_state state" data that I need to
maintain together. I can either do that by extending the existing mutex
scope, or by creating a new mutex like you suggested which I think would
essentially need to be a superset of the existing mutex for the purposes
of the patched driver.

Also it was rather easy to extend because almost all of the use of the
mutex were in functions directly called from the IRQ routine (and only
from there) such as bq24257_state_changed() and
bq24257_handle_state_change() so I just had to wrap them at that level,
also protecting the device access functions contained there, effectively
killing two birds with one stone.

The bq24257_hw_init() on the other hand only needed mutex protection
when called from bq24257_resume() and I moved that up to the caller.

> 
> >  	bool in_ilimit_autoset_disable;
> >  	bool pg_gpio_disable;
> >@@ -268,10 +268,10 @@ static int bq24257_power_supply_get_property(struct power_supply *psy,
> >  {
> >  	struct bq24257_device *bq = power_supply_get_drvdata(psy);
> >  	struct bq24257_state state;
> >+	int ret = 0;
> >
> >  	mutex_lock(&bq->lock);
> >  	state = bq->state;
> >-	mutex_unlock(&bq->lock);
> >
> 
> Like here, this makes it very obvious what data the lock is protecting, wrapping this whole
> block doesn't make much sense to me as all the subsequent reads are from the thread-local data.
> I see in another patch in this series you do add a device read, but that read could be locked
> by itself (with the device access lock) so we don't block this whole function when execution
> may not even go down the path with the read.

Yes you are right it's not needed here but rather was added in
preparation for the later inclusion of functions such as for supporting
POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT do direct device access so that's
just how I split up my overall edits into patches. Also I figured
having the entire statement wrapped doesn't really hurt and enables
easier additional extensions involving device access. In fact, it was
also done out of consistency with all the other sysfs getter/setter
routines in the final combined patched driver..

Thanks,

--
Andreas Dannenberg
Texas Instruments Inc

> 
> Regards,
> Andrew
> 
> >  	switch (psp) {
> >  	case POWER_SUPPLY_PROP_STATUS:
> >@@ -351,10 +351,12 @@ static int bq24257_power_supply_get_property(struct power_supply *psy,
> >  		break;
> >
> >  	default:
> >-		return -EINVAL;
> >+		ret = -EINVAL;
> >  	}
> >
> >-	return 0;
> >+	mutex_unlock(&bq->lock);
> >+
> >+	return ret;
> >  }
> >
> >  static int bq24257_get_chip_state(struct bq24257_device *bq,
> >@@ -401,15 +403,9 @@ static int bq24257_get_chip_state(struct bq24257_device *bq,
> >  static bool bq24257_state_changed(struct bq24257_device *bq,
> >  				  struct bq24257_state *new_state)
> >  {
> >-	int ret;
> >-
> >-	mutex_lock(&bq->lock);
> >-	ret = (bq->state.status != new_state->status ||
> >-	       bq->state.fault != new_state->fault ||
> >-	       bq->state.power_good != new_state->power_good);
> >-	mutex_unlock(&bq->lock);
> >-
> >-	return ret;
> >+	return bq->state.status != new_state->status ||
> >+			bq->state.fault != new_state->fault ||
> >+			bq->state.power_good != new_state->power_good;
> >  }
> >
> >  enum bq24257_loop_status {
> >@@ -532,7 +528,9 @@ static void bq24257_iilimit_setup_work(struct work_struct *work)
> >  	struct bq24257_device *bq = container_of(work, struct bq24257_device,
> >  						 iilimit_setup_work.work);
> >
> >+	mutex_lock(&bq->lock);
> >  	bq24257_iilimit_autoset(bq);
> >+	mutex_unlock(&bq->lock);
> >  }
> >
> >  static void bq24257_handle_state_change(struct bq24257_device *bq,
> >@@ -543,9 +541,7 @@ static void bq24257_handle_state_change(struct bq24257_device *bq,
> >  	bool reset_iilimit = false;
> >  	bool config_iilimit = false;
> >
> >-	mutex_lock(&bq->lock);
> >  	old_state = bq->state;
> >-	mutex_unlock(&bq->lock);
> >
> >  	/*
> >  	 * Handle BQ2425x state changes observing whether the D+/D- based input
> >@@ -600,25 +596,30 @@ static irqreturn_t bq24257_irq_handler_thread(int irq, void *private)
> >  	struct bq24257_device *bq = private;
> >  	struct bq24257_state state;
> >
> >+	mutex_lock(&bq->lock);
> >+
> >  	ret = bq24257_get_chip_state(bq, &state);
> >  	if (ret < 0)
> >-		return IRQ_HANDLED;
> >+		goto out;
> >
> >  	if (!bq24257_state_changed(bq, &state))
> >-		return IRQ_HANDLED;
> >+		goto out;
> >
> >  	dev_dbg(bq->dev, "irq(state changed): status/fault/pg = %d/%d/%d\n",
> >  		state.status, state.fault, state.power_good);
> >
> >  	bq24257_handle_state_change(bq, &state);
> >-
> >-	mutex_lock(&bq->lock);
> >  	bq->state = state;
> >+
> >  	mutex_unlock(&bq->lock);
> >
> >  	power_supply_changed(bq->charger);
> >
> >  	return IRQ_HANDLED;
> >+
> >+out:
> >+	mutex_unlock(&bq->lock);
> >+	return IRQ_HANDLED;
> >  }
> >
> >  static int bq24257_hw_init(struct bq24257_device *bq)
> >@@ -658,9 +659,7 @@ static int bq24257_hw_init(struct bq24257_device *bq)
> >  	if (ret < 0)
> >  		return ret;
> >
> >-	mutex_lock(&bq->lock);
> >  	bq->state = state;
> >-	mutex_unlock(&bq->lock);
> >
> >  	if (bq->in_ilimit_autoset_disable) {
> >  		dev_dbg(bq->dev, "manually setting iilimit = %d\n",
> >@@ -1002,11 +1001,15 @@ static int bq24257_suspend(struct device *dev)
> >  	if (!bq->in_ilimit_autoset_disable)
> >  		cancel_delayed_work_sync(&bq->iilimit_setup_work);
> >
> >+	mutex_lock(&bq->lock);
> >+
> >  	/* reset all registers to default (and activate standalone mode) */
> >  	ret = bq24257_field_write(bq, F_RESET, 1);
> >  	if (ret < 0)
> >  		dev_err(bq->dev, "Cannot reset chip to standalone mode.\n");
> >
> >+	mutex_unlock(&bq->lock);
> >+
> >  	return ret;
> >  }
> >
> >@@ -1015,24 +1018,31 @@ static int bq24257_resume(struct device *dev)
> >  	int ret;
> >  	struct bq24257_device *bq = dev_get_drvdata(dev);
> >
> >+	mutex_lock(&bq->lock);
> >+
> >  	ret = regcache_drop_region(bq->rmap, BQ24257_REG_1, BQ24257_REG_7);
> >  	if (ret < 0)
> >-		return ret;
> >+		goto err;
> >
> >  	ret = bq24257_field_write(bq, F_RESET, 0);
> >  	if (ret < 0)
> >-		return ret;
> >+		goto err;
> >
> >  	ret = bq24257_hw_init(bq);
> >  	if (ret < 0) {
> >  		dev_err(bq->dev, "Cannot init chip after resume.\n");
> >-		return ret;
> >+		goto err;
> >  	}
> >
> >+	mutex_unlock(&bq->lock);
> >+
> >  	/* signal userspace, maybe state changed while suspended */
> >  	power_supply_changed(bq->charger);
> >-
> >  	return 0;
> >+
> >+err:
> >+	mutex_unlock(&bq->lock);
> >+	return ret;
> >  }
> >  #endif
> >
> >
> 
> -- 
> Andrew F. Davis
