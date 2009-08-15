From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 2/3] PM: Asynchronous suspend of devices
Date: Sat, 15 Aug 2009 23:04:59 +0200
Message-ID: <200908152304.59881.rjw__18051.8126501285$1250370302$gmane$org@sisk.pl>
References: <200908122218.13975.rjw@sisk.pl> <200908122221.20568.rjw@sisk.pl>
	<20090814163509.GK1626@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090814163509.GK1626@ucw.cz>
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
> > @@ -659,26 +674,61 @@ static pm_message_t resume_event(pm_mess
> >  }
> >  
> >  /**
> > - *	device_suspend_noirq - Shut down one device (late suspend).
> > - *	@dev:	Device.
> > - *	@state: PM transition of the system being carried out.
> > + * __device_suspend_noirq - Execute a "late" suspend callback for given device.
> > + * @dev: Device to suspend.
> > + * @state: PM transition of the system being carried out.
> 
> >   *
> > - *	This is called with interrupts off and only a single CPU running.
> 
> that still looks like useful comment... why delete it?

Because it's not valid any more.

> > + * The driver of the device won't receive interrupts while this function is
> > + * being executed.
> >   */
> > @@ -696,13 +746,19 @@ int dpm_suspend_noirq(pm_message_t state
> >  	suspend_device_irqs();
> >  	mutex_lock(&dpm_list_mtx);
> >  	list_for_each_entry_reverse(dev, &dpm_list, power.entry) {
> > +		dev->power.status = DPM_OFF_IRQ;
> >  		error = device_suspend_noirq(dev, state);
> >  		if (error) {
> >  			pm_dev_err(dev, state, " late", error);
> > +			dev->power.status = DPM_OFF;
> > +			break;
> > +		}
> > +		if (async_error) {
> > +			error = async_error;
> >  			break;
> 
> async_error is 'interesting'. How does locking work in noirq case?

It's racy, a little bit. :-)

If two async drivers return errors exactly at the same time, one of them will
win the race, but it doesn't really matter which one wins as long as
async_error is different from zero as a result.  And it will be, since it's
an 'int' and the integrity of these is guaranteed.

Thanks,
Rafael
