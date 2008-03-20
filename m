From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 1/3] PM: Introduce new top level suspend
 and hibernation callbacks
Date: Thu, 20 Mar 2008 18:57:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803201841520.8453-100000__1941.60681353441$1206053958$gmane$org@netrider.rowland.org>
References: <1206052477.8420.26.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1206052477.8420.26.camel@pasglop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Fri, 21 Mar 2008, Benjamin Herrenschmidt wrote:

> 
> On Thu, 2008-03-20 at 14:26 -0400, Alan Stern wrote:
> > 
> > One of the things we don't want to do is bind a new driver to a device
> > after it has gone through the prepare() stage.  Doing so would involve
> > calling the driver's probe() routine, which is likely to want to
> > register new children and who knows what else.  The probe routine might 
> > even end up running after the device was suspended!  Clearly this 
> > should be avoided.
> > 
> > But the user can force a binding to occur by writing the device's path
> > to the driver's "bind" attribute in sysfs.  This means that
> > driver_bind() in drivers/base/bus.c will need to know whether or not
> > the device has gone through the prepare() stage, which means the device
> > structure will need to have a flag set before prepare() is called (more 
> > precisely, the flag must be set before dev->sem is released following 
> > the call to prepare).
> > 
> > Either that or else driver_bind() must always block whenever a system
> > sleep is in progress.  That would be easier -- but it's a lot like what 
> > the freezer would do.  Which would you prefer?
> 
> I don't fully understand what you are saying here.
> 
> You say "bind a new driver to a device after it has gone through the
> prepare() stage"
> 
> So either there was already a driver bound to that device, which got a
> prepare() callback, and in which case bind() doesn't mean much. Or there
> was not, in which case there was no prepare() call involved.

That's why I said "gone through the prepare() stage" instead of saying 
"after prepare() was called".  Yes, if there's no driver bound then 
there's no method to call.  But the PM core will still pass the device 
to a subroutine whose job is to call the corresponding method, if one 
exists.

> I suppose if you prepare(), then unbind(), then something tries to
> bind()... But wouldn't the core flag set after prepare() be plenty
> enough to shield against that ?
> 
> I fail to see the race you are talking about here.

Let's say Task 0 is starting a sleep transition when Task 1 calls
driver_bind():

	Task 0				Task 1
	------				------
	down(&dev->sem) succeeds	down(&dev->sem) blocks
	Sees that dev has no driver
	  so there is no prepare
	  method to call
	up(&dev->sem)
					down() succeeds
					Sees that dev->power.prepared
					  flag isn't set
					Calls (drv->probe)(dev)
	Sets dev->power.prepared
	  flag
					drv tries to register a child
					  device and fails for no good
					  reason

One way to fix this is to set dev->power.prepared before releasing
dev->sem.  Another way to fix it is to have driver_bind() block
(as though it were frozen) whenever a system sleep is underway.

Which do you prefer?

Alan Stern
