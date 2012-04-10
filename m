From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Runtime PM for host controllers
Date: Tue, 10 Apr 2012 15:48:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204101535090.1605-100000@iolanthe.rowland.org>
References: <CAJiQ=7AL24L2-KJ405jOkFutti5QcGfMEzp2rKbcrMY=5TuJzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJiQ=7AL24L2-KJ405jOkFutti5QcGfMEzp2rKbcrMY=5TuJzg@mail.gmail.com>
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

On Tue, 10 Apr 2012, Kevin Cernekee wrote:

> > The entire controller goes into a low-power mode.  For example, a PCI
> > controller would go into D3hot.  The hardware is no longer responsive
> > to register accesses, but it can generate a wakeup signal in response
> > to device hotplug.
> 
> Do you have any estimates of power savings on the host controller side?

No.  Other people may have measured it, though.

> On my systems, it would take a lot of extra power to maintain the
> ability to detect device hotplug.  I am wondering if the PCI based
> controller has a better way of handling it in the hardware than we do,
> or if the power savings from D3hot are just very small.

PCI devices have two different power wells, one for normal use and one 
for use during suspend.  As far as I know, there is no way to turn off 
power to the auxiliary well short of turning off the entire computer.  
Rafael may have a more complete picture.

> >> Is there a way to initiate USB runtime suspend on the host controller
> >> even if there are devices plugged into the downstream ports?
> >
> > Yes, provided all those devices are themselves already suspended.
> 
> But a lot of the drivers for USB devices do not even support suspend,
> correct?  And many of them become unreliable if you turn it on?

I haven't counted, but I think most of the commonly used drivers do
support it.  And most of the devices can be suspended and resumed
reliably, although there certainly are exceptions.

> What if I just want to forcibly suspend the entire USB subsystem?

Your rmmod approach will always work, but that isn't really a suspend.  
The USB subsystem doesn't provide any way to "force" a device to be
suspended against the kernel's will.

> >> Assuming that somebody is able to come up with a satisfactory
> >> implementation, are you open to allowing a "user-initiated suspend"
> >> mode, in addition to "opportunistic suspend"?
> >
> > I'm not sure what you are asking.  If "use-initiated suspend"
> > involves loss of functionality (such as loss of hotplug/unplug
> > detection) then no, it is generally not acceptable -- although the
> > final decision rests with the subsystem's maintainer.
> 
> Who is the right person to make the call?  Rafael?

The maintainer for whatever subsystem you're working on.  However,
general policy is set by Rafael and overall consensus on the linux-pm
list.

> > If it does not
> > involve any such loss then no "user-initiated suspend" should be
> > needed, because the existing runtime suspend methods will do the job.
> 
> Right.  Unfortunately I don't really have any devices that work this
> way.  Most are "all or nothing."

Is the loss of functionality you're talking about essentially the same
as removing the driver?  I don't think anybody would object to a
driverless device being put into a non-functional low-power mode, since
without a driver, it's pretty non-functional anyway.  It's easy for
userspace to unbind a device from its driver; would that then do what
you want?

> >> This is not a very clean way of doing things, so I would prefer to use
> >> runtime PM if at all possible.  But I don't think my hardware is
> >> designed in a way that is compatible with "opportunistic suspend."
> >
> > In what way is it incompatible?
> 
> My devices lose functionality when they are put into low-power modes.

What functionality do they lose?

Alan Stern
