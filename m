From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: b43_suspend problem
Date: Sun, 13 Jan 2008 12:08:57 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801131157290.20625-100000@netrider.rowland.org>
References: <200801130152.31724.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801130152.31724.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, bcm43xx-dev@lists.berlios.de, Michael Buesch <mb@bu3sch.de>, Larry Finger <larry.finger@lwfinger.net>
List-Id: linux-pm@vger.kernel.org

On Sun, 13 Jan 2008, Rafael J. Wysocki wrote:

> On Sunday, 13 of January 2008, Michael Buesch wrote:
> > On Sunday 13 January 2008 00:08:29 Rafael J. Wysocki wrote:
> > > There is a problem with b43_suspend() that it (indirectly) causes
> > > b43_leds_exit() to be called, which attempts to unregister the leds device
> > > objects, which is forbidden (ie. you can't unregister and/or register devices
> > > during a suspend or resume).
> > 
> > Why?
> 
> Well, the unregistering itself is not really harmful, provided that the device
> is not registered back during the subsequent resume.
> 
> The PM core uses a list of active devices that are added to the list in
> device_add().  The ordering of this list is important, because it is expected
> to reflect the order in which the devices are to be suspended.
> 
> This list is manipulated during suspend/resume and devices are moved from it
> and back to it, so unregistering devices during a suspend and registering them
> during the subsequent resume generally changes its ordering and may lead to
> problems during the next suspend/resume cycle.
> 
> This is also undesirable if we're going to stop using the freezer for
> suspend/resume at one point in the future.
> 
> I'm sure Alan can add some more details.

Indeed.  A system suspend is a delicate operation, and the PM core
needs to access all the devices in the system.  To have devices being
registered and unregistered at the same time would cause a lot of
confusion.  In self defense, the PM core starts out by acquiring all 
the device semaphores before calling the suspend routines.  This means 
that if a suspend routine tries to unregister anything, it will 
deadlock at the point where the driver core tries to acquire the device 
semaphore prior to invoking the driver's remove method.

Besides, if you're going to register the device right back again during 
the subsequent resume, then why go to the trouble of unregistering it 
during suspend?  Why not just leave it registered the whole time and 
avoid all the complication (and excess meaningless uevents)?

Alan Stern
