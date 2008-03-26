From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and
 hibernation callbacks (rev. 3)
Date: Wed, 26 Mar 2008 16:36:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803261633190.9881-100000__24674.1542280235$1206564021$gmane$org@iolanthe.rowland.org>
References: <200803262126.58357.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803262126.58357.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Wed, 26 Mar 2008, Rafael J. Wysocki wrote:

> On Wednesday, 26 of March 2008, Alan Stern wrote:
> > On Tue, 25 Mar 2008, Rafael J. Wysocki wrote:
> > 
> > > > I just thought of another problem.  At the point where
> > > > local_irq_disable() is called, in between device_suspend() and
> > > > device_power_down(), it is possible in a preemptible kernel that
> > > > another task is holding dpm_list_mtx and is in the middle of updating
> > > > the list pointers.  This would mess up the traversal in
> > > > device_power_down().
> > > > 
> > > > I'm not sure about the best way to prevent this.  Is it legal to call
> > > > unlock_mutex() while interrupts or preemption are disabled?
> > > 
> > > Well, I think it is, but I'm not sure how that can help.
> > > 
> > > To prevent the race from happening, we can lock dpm_list_mtx before switching
> > > interrupts off in kernel/power/main.c:suspend_enter() and analogously in
> > > kernel/power/disk.c .
> > 
> > That's right.  And once interrupts are turned off you should unlock 
> > dpm_list_mtx again, in case a noirq method wants to unregister a 
> > device.
> 
> Why would a noirq method want to do that?  IMO, it's not a big deal if noirq
> methods are not allowed to unregister devices.

Okay, that's fine.  It keeps things simple.

> > Hence my question: Is it legal to call unlock_mutex() while interrupts are
> > disabled? 
> 
> Well, I suspect that will confuse lockdep quite a bit.  Otherwise, I don't see
> a problem with it (it's just changing the value of a shared variable after
> all).

Then you have your answer.  Perhaps have device_suspend() exit with the
mutex held and have device_resume() release it (with appropriate
handling for error situations, of course).

Alan Stern
