From: Ian Campbell <ijc@hellion.org.uk>
Subject: Re: [Xen-devel] Re: [PATCH 0/2] Fix hangup after
 creating checkpoint on Xen.
Date: Thu, 10 Feb 2011 16:34:48 +0000
Message-ID: <1297355688.21980.488.camel__16961.6334060722$1297355809$gmane$org@zakaz.uk.xensource.com>
References: <Pine.LNX.4.44L0.1102101043010.2029-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1102101043010.2029-100000@iolanthe.rowland.org>
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
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, LKML <linux-kernel@vger.kernel.org>, Brendan Cully <brendan@cs.ubc.ca>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "SUZUKI,
	Kazuhiro" <kaz@jp.fujitsu.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 2011-02-10 at 11:00 -0500, Alan Stern wrote:
> On Thu, 10 Feb 2011, Ian Campbell wrote:
> 
> > On Wed, 2011-02-09 at 23:42 +0000, Alan Stern wrote:
> > > In fact there already is a "fast suspend & resume" path in the PM core.  
> > > It's the freeze/thaw procedure used when starting to hibernate.  The
> > > documentation specifically says that drivers' freeze methods are
> > > supposed to quiesce their devices but not change power levels.  In
> > > addition, the thaw method is invoked as part of recovery from a failed
> > > hibernation attempt, so it already has the "cancel" semantics that xen 
> > > seems to want.
> > 
> > Sounds like that would work and I would much prefer to simply make
> > correct use of the core functionality.
> 
> It seems like a reasonable approach.  Whether it will actually _work_ 
> is a harder question...  :-)

Heh.

> > So PMSG_FREEZE is balanced by either PMSG_RECOVER or PMSG_THAW depending
> > on whether the suspend was cancelled or not?
> 
> Basically yes.  It is also "balanced" by PMSG_RESTORE, which is used
> after a memory image has been restored (although this isn't relevant to
> your snapshotting).  See the comments in include/linux/pm.h.

The documentation of the individual events in pm.h is good. Is there a
reference for the sequence of events for the different types of
suspend/hibernate/etc?

> >  So the sequence of events
> > is something like:
> > 	dpm_suspend_start(PMSG_FREEZE);
> >          
> > 		dpm_suspend_noirq(PMSG_FREEZE);
> >                          
> > 			sysdev_suspend(PMSG_QUIESCE);
> 
> This should say sysdev_suspend(PMSG_FREEZE).
> 
> > 			cancelled = suspend_hypercall()
> 
> At this point swsusp_arch_suspend() is called.  If that translates to 
> suspend_hypercall() in your setting, then yes.
> 
> > 			sysdev_resume();
> >                  
> > 		dpm_resume_noirq(cancelled ? PMSG_RECOVER : PMSG_THAW);
> >          
> > 	dpm_resume_end(cancelled ? PMSG_RECOVER : PMSG_THAW);
> > ?
> 
> Yes.

Both of those call ->thaw ->complete. Did I mean "cancelled ?
PMSG_THAW : PMSG_RESTORE"? (or s/THAW/RECOVER?)

If the suspend was cancelled then we want the devices to simply pickup
where they were before the freeze, wereas if we really did suspend (or
migrate or whatever) then they need to do a more complete reset and
reconnect operation so we want some sort of indication to the driver
which happened.

> > (For comparison we currently have:
> > > > >         dpm_suspend_start(PMSG_SUSPEND);
> > > > >         
> > > > >                 dpm_suspend_noirq(PMSG_SUSPEND);
> > > > >                         
> > > > >                         sysdev_suspend(PMSG_SUSPEND);
> > > > >                         /* suspend hypercall */
> > > > >                         sysdev_resume();
> > > > >                 
> > > > >                 dpm_resume_noirq(PMSG_RESUME);
> > > > >         
> > > > >         dpm_resume_end(PMSG_RESUME);
> > )
> 
> Right.  The sequence of calls is the same, but the PMSG_ argument is 
> different so drivers are expected to act differently in response.

The drivers don't actually see the PMSG_* though right? They only see a
differing sequence of hooks from dev_pm_ops called.

Thanks,
Ian.

> 
> Alan Stern
> 
> 

-- 
Ian Campbell
Current Noise: Sworn Amongst - Useless

Accident, n.:
	A condition in which presence of mind is good, but absence of
	body is better.
		-- Foolish Dictionary
