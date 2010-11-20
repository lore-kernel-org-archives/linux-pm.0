From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH ver. 2] PM: add synchronous runtime interface
 for interrupt handlers
Date: Sat, 20 Nov 2010 14:41:00 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1011201437450.8483-100000__28868.8660752543$1290282170$gmane$org@netrider.rowland.org>
References: <Pine.LNX.4.44L0.1011201152210.5871-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1011201152210.5871-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Partha Basak <p-basak2@ti.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, 20 Nov 2010, Alan Stern wrote:

> On Sat, 20 Nov 2010, Rafael J. Wysocki wrote:
> 
> > On Friday, November 19, 2010, Alan Stern wrote:
> > > This patch (as1431b) makes the synchronous runtime-PM interface
> > > suitable for use in interrupt handlers.  Subsystems can call the new
> > > pm_runtime_irq_safe() function to tell the PM core that a device's
> > > runtime-PM callbacks should be invoked with interrupts disabled
> > > (runtime_suspend and runtime_resume callbacks will be invoked with the
> > > spinlock held as well).  This permits the pm_runtime_get_sync() and
> > > pm_runtime_put_sync() routines to be called from within interrupt
> > > handlers.
> > > 
> > > When a device is declared irq-safe in this way, the PM core increments
> > > the parent's usage count, so the parent will never be runtime
> > > suspended.  This prevents difficult situations in which an irq-safe
> > > device can't resume because it is forced to wait for its non-irq-safe
> > > parent.
> > > 
> > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> > > --- usb-2.6.orig/drivers/base/power/runtime.c
> > > +++ usb-2.6/drivers/base/power/runtime.c
> > > @@ -223,11 +223,19 @@ static int rpm_idle(struct device *dev, 
> > >  		callback = NULL;
> > >  
> > >  	if (callback) {
> > > -		spin_unlock_irq(&dev->power.lock);
> > > +		if (dev->power.irq_safe) {
> > > +			spin_unlock(&dev->power.lock);
> > >  
> > > -		callback(dev);
> > > +			callback(dev);
> > >  
> > > -		spin_lock_irq(&dev->power.lock);
> > > +			spin_lock(&dev->power.lock);
> > > +		} else {
> > > +			spin_unlock_irq(&dev->power.lock);
> > > +
> > > +			callback(dev);
> > > +
> > > +			spin_lock_irq(&dev->power.lock);
> > > +		}
> > >  	}
> > 
> > I didn't like this change before and I still don't like it.  Quite frankly, I'm
> > not sure I can convince Linus to pull it. :-)
> > 
> > Why don't we simply execute the callback under the spinlock in the
> > IRQ safe case?
> 
> Because it wouldn't work.  The job of the runtime_idle callback is to
> call pm_runtime_suspend when needed.  But if the callback runs under
> the spinlock then pm_runtime_suspend would hang when it tries to grab
> the lock.
> 
> I don't think Linus will object to this.  What he doesn't like is when
> some code drops a lock, reacquires it, and then behaves as though the
> lock had been held all along.  That's not the case here; rpm_idle()  
> does not depend on any state remaining unchanged across the callback.

One other thing I forgot to mention...  If Linus doesn't like the way
the new code drops the spinlock and then reacquires it, then he must
also not like the existing code, which does the same thing.  The only
difference lies in whether or not interrupts are re-enabled.

Alan Stern
