From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 1/3] PM: Asynchronous resume of devices
Date: Sat, 15 Aug 2009 22:59:18 +0200
Message-ID: <200908152259.18417.rjw__29882.4626989246$1250369963$gmane$org@sisk.pl>
References: <200908122218.13975.rjw@sisk.pl> <200908122220.03363.rjw@sisk.pl>
	<20090814163328.GF1626@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090814163328.GF1626@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Friday 14 August 2009, Pavel Machek wrote:
> > The patch below introduces a mechanism allowing some devices to be
> > resumed asynchronously, using completions with the following rules:
> > (1) There is a completion, dev->power.comp, for each device object.
> > (2) All of these completions are reset before suspend as well as
> >     each resume stage (dpm_resume_noirq(), dpm_resume()).
> > (3) If dev->power.async_suspend is set for dev or for its parent, the
> >     PM core waits for the parent's completion before attempting to
> >     run the resume callbacks, appropriate for this particular stage
> >     of resume, for dev.
> 
> at least this needs to go in as a comment.

OK, this is a prototype patch, still under discussion.

> > (4) dev->power.comp is completed for each device after running its
> > @@ -411,9 +412,12 @@ struct dev_pm_info {
> >  	pm_message_t		power_state;
> >  	unsigned int		can_wakeup:1;
> >  	unsigned int		should_wakeup:1;
> > +	unsigned		async_suspend:1;
> >  	enum dpm_state		status;		/* Owned by the PM core */
> 
> unsigned int? Or bool?

unsigned means 'unsigned int'.  I should have added 'int', but again, this is
a prototype patch.

> Should it go under config_pm_sleep?

Not necessaily.  'status' is not there as well.

> >  #ifdef CONFIG_PM_SLEEP
> >  	struct list_head	entry;
> > +	struct completion	comp;
> > +	pm_message_t		async_state;
> >  #endif
> >  }
> >  
> > +static inline void device_enable_async_suspend(struct device *dev, bool enable)
> > +{
> > +	if (dev->power.status == DPM_ON)
> > +		dev->power.async_suspend = enable;
> > +}
> > +
> > @@ -163,6 +166,34 @@ void device_pm_move_last(struct device *
> >  	list_move_tail(&dev->power.entry, &dpm_list);
> >  }
> >  
> > +static void dpm_synchronize_noirq(void)
> > +{
> > +	struct device *dev;
> > +
> > +	async_synchronize_full();
> > +
> > +	list_for_each_entry(dev, &dpm_list, power.entry)
> > +		INIT_COMPLETION(dev->power.comp);
> > +}
> > +
> > +static void dpm_synchronize(void)
> > +{
> > +	struct device *dev;
> > +
> > +	async_synchronize_full();
> > +
> > +	mutex_lock(&dpm_list_mtx);
> > +	list_for_each_entry(dev, &dpm_list, power.entry)
> > +		INIT_COMPLETION(dev->power.comp);
> > +	mutex_unlock(&dpm_list_mtx);
> > +}
> 
> Why is it ok to avoid locking in noirq case?

It's not, but we hold dpm_list_mtx throughout the entire noirq suspend.

> Do we really need async for noirq handlers?

Yes, we do.  Specifically, for PCI.

> >  /**
> > - *	device_resume_noirq - Power on one device (early resume).
> > - *	@dev:	Device.
> > - *	@state: PM transition of the system being carried out.
> > + * __device_resume_noirq - Execute an "early resume" callback for given device.
> > + * @dev: Device to resume.
> > + * @state: PM transition of the system being carried out.
> >   *
> > - *	Must be called with interrupts disabled.
> > + * The driver of the device won't receive interrupts while this function is
> > + * being executed.
> >   */
> 
> You still want it called with interrupts disabled, right?

No.  It's not called with interrupts off now.

Thanks,
Rafael
