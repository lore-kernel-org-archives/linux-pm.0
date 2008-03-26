From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and
	hibernation callbacks (rev. 3)
Date: Wed, 26 Mar 2008 21:54:01 +0100
Message-ID: <200803262154.03129.rjw__19324.0511733622$1206565075$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0803261633190.9881-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0803261633190.9881-100000@iolanthe.rowland.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 26 of March 2008, Alan Stern wrote:
> On Wed, 26 Mar 2008, Rafael J. Wysocki wrote:
> 
> > On Wednesday, 26 of March 2008, Alan Stern wrote:
> > > On Tue, 25 Mar 2008, Rafael J. Wysocki wrote:
> > > 
> > > > > I just thought of another problem.  At the point where
> > > > > local_irq_disable() is called, in between device_suspend() and
> > > > > device_power_down(), it is possible in a preemptible kernel that
> > > > > another task is holding dpm_list_mtx and is in the middle of updating
> > > > > the list pointers.  This would mess up the traversal in
> > > > > device_power_down().
> > > > > 
> > > > > I'm not sure about the best way to prevent this.  Is it legal to call
> > > > > unlock_mutex() while interrupts or preemption are disabled?
> > > > 
> > > > Well, I think it is, but I'm not sure how that can help.
> > > > 
> > > > To prevent the race from happening, we can lock dpm_list_mtx before switching
> > > > interrupts off in kernel/power/main.c:suspend_enter() and analogously in
> > > > kernel/power/disk.c .
> > > 
> > > That's right.  And once interrupts are turned off you should unlock 
> > > dpm_list_mtx again, in case a noirq method wants to unregister a 
> > > device.
> > 
> > Why would a noirq method want to do that?  IMO, it's not a big deal if noirq
> > methods are not allowed to unregister devices.
> 
> Okay, that's fine.  It keeps things simple.
> 
> > > Hence my question: Is it legal to call unlock_mutex() while interrupts are
> > > disabled? 
> > 
> > Well, I suspect that will confuse lockdep quite a bit.  Otherwise, I don't see
> > a problem with it (it's just changing the value of a shared variable after
> > all).
> 
> Then you have your answer.  Perhaps have device_suspend() exit with the
> mutex held and have device_resume() release it (with appropriate
> handling for error situations, of course).

That wouldn't work, because enable_nonboot_cpus() is called before
device_resume() and the notifiers in there may want to unregister devices
if some CPUs fail to go online.

I added two accessor functions device_pm_lock() and device_pm_unlock()
to be called just prior to disabling interrupts and right after enabling them,
respectively, in the higher-level PM core (ie. kernel/power/main(disk).c).

Thanks,
Rafael
