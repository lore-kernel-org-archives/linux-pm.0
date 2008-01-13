From: Michael Buesch <mb@bu3sch.de>
Subject: Re: b43_suspend problem
Date: Sun, 13 Jan 2008 18:16:14 +0100
Message-ID: <200801131816.15278.mb__16602.6811268695$1200325251$gmane$org@bu3sch.de>
References: <Pine.LNX.4.44L0.0801131157290.20625-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0801131157290.20625-100000@netrider.rowland.org>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, bcm43xx-dev@lists.berlios.de, Larry Finger <larry.finger@lwfinger.net>
List-Id: linux-pm@vger.kernel.org

On Sunday 13 January 2008 18:08:57 Alan Stern wrote:
> On Sun, 13 Jan 2008, Rafael J. Wysocki wrote:
> 
> > On Sunday, 13 of January 2008, Michael Buesch wrote:
> > > On Sunday 13 January 2008 00:08:29 Rafael J. Wysocki wrote:
> > > > There is a problem with b43_suspend() that it (indirectly) causes
> > > > b43_leds_exit() to be called, which attempts to unregister the leds device
> > > > objects, which is forbidden (ie. you can't unregister and/or register devices
> > > > during a suspend or resume).
> > > 
> > > Why?
> > 
> > Well, the unregistering itself is not really harmful, provided that the device
> > is not registered back during the subsequent resume.
> > 
> > The PM core uses a list of active devices that are added to the list in
> > device_add().  The ordering of this list is important, because it is expected
> > to reflect the order in which the devices are to be suspended.
> > 
> > This list is manipulated during suspend/resume and devices are moved from it
> > and back to it, so unregistering devices during a suspend and registering them
> > during the subsequent resume generally changes its ordering and may lead to
> > problems during the next suspend/resume cycle.
> > 
> > This is also undesirable if we're going to stop using the freezer for
> > suspend/resume at one point in the future.
> > 
> > I'm sure Alan can add some more details.
> 
> Indeed.  A system suspend is a delicate operation, and the PM core
> needs to access all the devices in the system.  To have devices being
> registered and unregistered at the same time would cause a lot of
> confusion.  In self defense, the PM core starts out by acquiring all 
> the device semaphores before calling the suspend routines.  This means 
> that if a suspend routine tries to unregister anything, it will 
> deadlock at the point where the driver core tries to acquire the device 
> semaphore prior to invoking the driver's remove method.
> 
> Besides, if you're going to register the device right back again during 
> the subsequent resume, then why go to the trouble of unregistering it 
> during suspend?  Why not just leave it registered the whole time and 
> avoid all the complication (and excess meaningless uevents)?

Well, because not doing it complicates code :)
Currently suspend/resume calls the same code as init/exit.
The b43 init/exit code is really complicated, compared to other
drivers, due to dozens of hardware versions. So I just avoided
having yet other codepaths for suspend/resume. But I will add
a flag to the device structure that's used to avoid unregistering stuff.

-- 
Greetings Michael.
