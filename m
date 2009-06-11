From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch update] Re: Run-time PM idea (was: Re:
	[RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Thu, 11 Jun 2009 21:43:56 +0200
Message-ID: <200906112143.57361.rjw__36460.0536101081$1244749803$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0906111041020.3040-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0906111041020.3040-100000@iolanthe.rowland.org>
Content-Disposition: inline
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 11 June 2009, Alan Stern wrote:
> On Thu, 11 Jun 2009, Rafael J. Wysocki wrote:
> 
> > The point here is what the core is supposed to do.  Does it need to handle
> > this at all or leave it to the bus type and driver?
> > 
> > After reconsidering it for a while I think that we should define what
> > "suspended" is supposed to mean from the core point of view.  And my opinion
> > is that it should mean "device doesn't communicate with the CPUs and RAM due
> > to power management".  That need not be power management of the device itself,
> > but such that leads to the device not doing I/O.
> > 
> > Under this definition all devices behind an inactive link are suspended,
> > because they can't do any I/O.  Which appears to makes sense, because their
> > drivers have to be notified before the link is suspended and the link has to be
> > turned on for the devices to be able to communicate with the CPU and RAM.
> > 
> > If this definition is adopted, then it's quite clear that the device can only
> > be suspended if all of its children are suspended and it's always necessary
> > to resume the parent of a device in order to resume the device itself.
> 
> Okay, I'll agree to that.  It should be made clear that a device which 
> is "suspended" according to this definition is not necessarily in a 
> low-power state.  For example, before powering down the link to a disk 
> drive you might want the drive's suspend method to flush the drive's 
> cache, but it wouldn't have to spin the drive down.

Exactly.

> (But this example leaves open the question of how we would go about
> spinning down the disk.  Submitting a 15-minute (or whatever) delayed
> autosuspend request wouldn't work; the request wouldn't be accepted
> because the disk is already suspended as far as the PM core is
> concerned.  The disk's driver would have to implement its own 
> spin-down delayed_work.)

Yes, it would.

> > > > > I haven't checked the details of the code yet.  More later...
> > > 
> > > One more thought...  The autosuspend and autoresume callbacks need to 
> > > be mutually exclusive with probe and remove.  So somehow the driver 
> > > core will need to block runtime PM calls.
> > 
> > That's correct and I'm going to take care of this.
> > 
> > > It might also be nice to make sure that the driver core autoresumes a 
> > > device before probing it and autosuspends a device (after some 
> > > reasonable delay) after unbinding its driver.
> > 
> > Agreed.
> 
> This is another case where a usage counter comes in handy.  The driver
> core resumes the device and increments the counter -- thus preventing
> any unwanted autosuspends -- before making the probe and remove calls.

I like this idea.

BTW, where exactly the counter should be increased in that case?

I thought of driver_probe_device(), but is it sufficient?  Or is there a better
place?

Best,
Rafael
