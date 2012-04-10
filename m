From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Runtime PM for host controllers
Date: Tue, 10 Apr 2012 10:15:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204100949390.1605-100000@iolanthe.rowland.org>
References: <CAJiQ=7CVzOpRdKWMzLwtYznjOno-GQjOZ8Jm7EiEzs9icWwnHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJiQ=7CVzOpRdKWMzLwtYznjOno-GQjOZ8Jm7EiEzs9icWwnHw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 9 Apr 2012, Kevin Cernekee wrote:

> On Mon, Apr 9, 2012 at 7:14 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> >> USB runtime PM seems to focus on the individual USB devices, and does
> >> not allow for dynamically suspending the entire host controller
> >> AFAICT.
> >
> > That is not correct.  USB host controllers _can_ be suspended.  (Not
> > all of them; many of the platform drivers don't implement controller
> > suspend.  But some of them do, and almost all of the PCI-based drivers
> > do.)
> 
> I am not clear on what is actually happening at the chip level in these cases?
> 
> i.e. is the entire USB core getting clock gated or power gated, such
> that it is completely non-responsive to register accesses or device
> hotplug?  Or is the driver just shutting down a few tiny pieces of the
> hardware?

The entire controller goes into a low-power mode.  For example, a PCI 
controller would go into D3hot.  The hardware is no longer responsive 
to register accesses, but it can generate a wakeup signal in response 
to device hotplug.

> Is there a way to initiate USB runtime suspend on the host controller
> even if there are devices plugged into the downstream ports?

Yes, provided all those devices are themselves already suspended.

> >>  In general I don't
> >> see any facility where the application can explicitly tell the PM core
> >> to suspend a device (incurring a potential loss of functionality, such
> >> as hot plug/unplug detection).
> >
> > Right; there is no way to do this.  The OS will suspend a device only
> > when it believes it is safe to do so.
> 
> Assuming that somebody is able to come up with a satisfactory
> implementation, are you open to allowing a "user-initiated suspend"
> mode, in addition to "opportunistic suspend"?

I'm not sure what you are asking.  If "use-initiated suspend"  
involves loss of functionality (such as loss of hotplug/unplug
detection) then no, it is generally not acceptable -- although the
final decision rests with the subsystem's maintainer.  If it does not
involve any such loss then no "user-initiated suspend" should be
needed, because the existing runtime suspend methods will do the job.

On the other hand, if you really want to suspend a device and don't
care about using it, then unbinding it from its driver is a good start.  
For USB devices, that alone will cause the device to be suspended.  
For PCI devices (such as host controllers), unfortunately, it isn't
sufficient -- the PCI subsystem doesn't allow driverless devices to be
suspended.  Perhaps the same is true of the platform subsystem; I'm not
sure.

If you'd like to work on a method of allowing driverless PCI or
platform devices to be runtime-suspended, that would be okay.  It 
probably wouldn't be very hard to do.

> >> d) Or should I just go back to using "rmmod"?
> >
> > I don't see how rmmod will save any power.
> 
> rmmod allows me to forcibly shut down the controller, cleanly (in
> theory) disconnecting any active devices and preventing the kernel
> from touching the registers.
> 
> After rmmod, I can then tell the SoC to put the whole core into an
> unresponsive, low power state.
> 
> This is not a very clean way of doing things, so I would prefer to use
> runtime PM if at all possible.  But I don't think my hardware is
> designed in a way that is compatible with "opportunistic suspend."

In what way is it incompatible?

Alan Stern
