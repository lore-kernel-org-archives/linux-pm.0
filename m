From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH update x2] PM: Introduce core framework for
	run-time PM of I/O devices (rev. 13)
Date: Sat, 8 Aug 2009 23:55:32 +0200
Message-ID: <200908082355.32749.rjw__14879.6599511572$1249768681$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0908081120160.19562-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0908081120160.19562-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 08 August 2009, Alan Stern wrote:
> On Sat, 8 Aug 2009, Rafael J. Wysocki wrote:
> 
> > > We may need to be more careful here.  The driver's remove method may
> > > want to do some runtime PM stuff to the device before giving up
> > > control.  On the other hand I'm not sure what _should_ be done here, so
> > > I can't suggest anything better.
> > 
> > Hmm.  Perhaps we can do something along the lines of our .probe() handling.
> > Namely, call
> > 
> > pm_runtime_disable(dev);
> > pm_runtime_get_noresume(dev);
> > pm_runtime_enable(dev);
> > 
> > before and
> > 
> > pm_runtime_put_noidle()
> > 
> > after?  Then, if the driver's or bus type's .remove() needs to resume, it will
> > be able to do that right away and if it wants to suspend, it can always call
> > pm_runtime_put*(), because our pm_runtime_put_noidle() won't decrease the
> > usage counter below zero.
> > 
> > At the same time we can avoid "leftover" suspends that could interfere with
> > .remove() in case it needs to access the hardware.
> 
> The problem with this is that it calls pm_runtime_disable() at a time 
> when the driver is still supposed to be in control of the device.  
> Interfering with the driver's legitimate activity in this way is a bad 
> thing to do.
> 
> The difficulty here is that our requirements are a little
> contradictory.  We want to prevent all runtime PM callbacks while the
> remove method is running, but we also want the remove method to be able
> to carry out its own runtime PM activities.
> 
> So maybe what we really need is more like a barrier.  That is,
> something that will do a "get", wait for outstanding callbacks to
> finish, carry out a resume if one is pending, and cancel other pending
> requests.  This could easily share code with pm_runtime_disable.  We 
> should be able to use this for both probe and remove.

Isn't it what's done in rev. 14?

pm_runtime_disable(dev);
pm_runtime_get_noresume(dev);
pm_runtime_enable(dev);

is exactly a barrier like this.  How exactly would you like to implement it
instead?

> We will also need to be a lot more careful about handling runtime PM 
> during system sleep transitions.  The current code runs a risk of 
> losing remote wakeup requests.  One scenario goes like this:
> 
>      1. The device sends a wakeup request, probably in the form of
> 	an IRQ.
> 
>      2.	The driver fields the interrupt and tells the device to turn
> 	off its interrupt request signal.
> 
>      3. The driver calls pm_request_resume.
> 
>      4. The runtime PM core carries out the resume callback.
> 
> If the core disables runtime PM before step 1 (and before we begin the
> "late" stage of a system sleep, so interrupts still get delivered) then 
> steps 1 and 2 will succeed but step 3 will fail.  The wakeup event will 
> be lost.

The idea is that once the system sleep transition has started, the non-runtime
callbacks are in charge of handling the device.

> Perhaps this means we don't want to disable runtime PM during system 
> sleep callbacks, but instead use the "barrier" scheme.

I'm not really sure about that.  I'd rather do what's right now in the patch
(well, that's why it's in there) until drivers and bus types start using the
runtime PM framework.  If it turns out to be problematic, we'll change it
later.

Best,
Rafael
