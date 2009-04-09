From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC Disable suspend on a specific device] This is a
 little change in linux power scheme
Date: Thu, 9 Apr 2009 14:27:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0904091419330.2992-100000@iolanthe.rowland.org>
References: <200904082356.01357.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200904082356.01357.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, 8 Apr 2009, Rafael J. Wysocki wrote:

> > the way suspend is currently implemented.  From the PM core's point of
> > view, system suspend involves two main activities:
> > 
> > 	Telling drivers to stop using their devices, and
> > 
> > 	Turning off (or reducing) power to the devices.
> > 
> > The PM framework does not treat these separately; a single suspend
> > method call is used for both purposes.  But more and more we are seeing
> > that they should be, especially on non-ACPI systems.  This patch is, in
> > a roundabout way, an attempt to do so.
> 
> Well, with the recent changes of the PM framework that have just gone into
> .30-rc1 the "late" suspend call may in fact be regarded as a "turn off" or
> "power down" one, while the "regular" suspend callback has become a "stop using
> the device" one.

Sort of, but that's not the real difference between suspend and 
suspend_late.  The real difference has to do with whether or not 
interrupts are enabled.

Still, if drivers begin to adopt this approach then it is a step in the 
right direction.

> > Part of the problem is that people tend to think of "suspend" as
> > meaning "suspend the system".  However a much more flexible -- dare I
> > say more valid? -- point of view is "suspend the CPUs and at the same
> > time remove (or reduce) power for devices that will no longer need it".  
> > In other words, system suspend really is just a kind of runtime
> > suspend, in which the devices being suspended are the CPUs and the
> > sysdevs.
> > 
> > Obviously this is an oversimplification, but I think it's a useful 
> > approach.
> 
> Well, unfortunately ACPI makes the distinction between suspending devices
> in order to put the system into a sleep state and suspending devices at run
> time (ACPI requires us to specify the target sleep state of the whole system in
> advance and presumably the outcome of some AML routines used for suspending
> devices may depend on this).  That's why the people who work primarily on ACPI
> systems regard suspend as meaning "suspend the system".

Just because ACPI has this requirement, that doesn't mean drivers have
to be designed around it.  We should be able to write a runtime-suspend
routine that does the right thing even when a system-suspend transition
is underway.

BTW, how does ACPI formally handle the case where the system is about
to go to sleep and some devices are already runtime-suspended?  Does it
require that the devices be resumed first so that they can be suspended
again the "right" way?

> > Just think about it.  Suppose every driver supported autosuspend.  
> > When a driver received a notification that the CPU was going to be
> > suspended, it would know that its device wasn't going to need power
> > (since the device can't do anything useful without the driver telling
> > it what to do) and so it would automatically power the device down,
> > while also arranging not to access the device any more.  Thus the
> > suspend method calls would really exist only to let drivers know that
> > their code was going to stop running (since the CPU was about to stop
> > all activity); the device-power management part would merely be a side
> > effect.
> 
> Yes, I think this is the situation we should be targeting, but we seem to be
> very far from it at the moment. :-)

True...  But let's not lose hope!  :-)

Alan Stern
