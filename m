From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: System sleep vs. runtime PM
Date: Thu, 3 Dec 2009 14:52:15 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912031444300.4795-100000@iolanthe.rowland.org>
References: <200912032034.39761.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912032034.39761.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 3 Dec 2009, Oliver Neukum wrote:

> Am Donnerstag, 3. Dezember 2009 18:50:28 schrieb Alan Stern:
> > On Thu, 3 Dec 2009, Oliver Neukum wrote:
> > > > However, I don't see any reason to know what woke us up.  All we really
> > > > need to know is what devices have wakeup requests outstanding when the
> > > > system resume is finished.  It doesn't matter which request came first
> > > > (presumably that was the one which woke us up).
> > >
> > > That assumes that the firmware doesn't do anything stupid with
> > > pending remote wakeups as it resumes the system. I'd call this
> > > unwarranted optimism. The conservative solution would be to resume
> > > every device whose driver has requested remote wakeup be enabled.
> > 
> > Drivers certainly can use that as one of their criteria for whether to
> > power-up a device during system resume.
> 
> Leaving this decision to the drivers won't work because they don't
> know enough.
> For reliable operation we must guarantee no remote wakeup is lost.

That's not necessarily so.  If remote wakeup is disabled at a device
between the CPU and the source device, then wakeup events are indeed
allowed to get lost.  For example, even though a USB hub may be enabled
for remote wakeup, if its host controller isn't then a wakeup event
won't generate an IRQ and so won't awaken the system.  And in fact this
behavior may be desired by the user.  After all, who would want their
laptop to wake up merely because a USB mouse was unplugged?

> But remote wakeups must travel a whole chain of busses and the
> guarantees is of the weakest link apply. Drivers must not know
> over which busses they are connected higher up.
> 
> Therefore you must make the decision in core.

This doesn't follow.  The decision is made individually for each 
device, based on whether or not the device is enabled for remote 
wakeup.  There's no need to know anything about higher-up buses.

>  But the core doesn't
> know specifics. Unless you really want to overengineer this and compute
> the reliability of each path, resuming only those whose drivers have
> requested that remote wakeup be enabled is the best you can do.

Isn't that what I agreed drivers should do?

Alan Stern
