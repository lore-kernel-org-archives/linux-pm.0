From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 05/13] PM: Add option to disable
	/sys/power/state interface
Date: Mon, 9 Feb 2009 00:40:21 +0100
Message-ID: <200902090040.22364.rjw@sisk.pl>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200902081450.46584.rjw@sisk.pl>
	<20090208140404.GA22084@bulgaria.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090208140404.GA22084@bulgaria.corp.google.com>
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
To: Brian Swetland <swetland@google.com>
Cc: ncunningham@crca.org.au, u.luckas@road.de, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sunday 08 February 2009, Brian Swetland wrote:
> ["Rafael J. Wysocki" <rjw@sisk.pl>]
> > 
> > Just to make things crystal clear, in fact I don't like any patches in this
> > series.
> > 
> > The wakelocks seem to be overdesigned to me and the "early suspend" thing
> > doesn't really fit our suspend-resume framework, especially after the changes
> > made recently to the PCI PM code (and the changes that are going to be made
> > to it shortly).
> 
> Out of curiosity, do these changes provide a model where the system can
> be in suspend 99+% of the time, waking up for specific events
> (voice/data telephony, user interaction, etc), and rapidly returning to
> suspend when the processing required is complete?

The changes I was referring to above were rather related to the "normal"
suspend (ie. the one happening as a result of writing "mem" into
/sys/power/state).  Namely, we believe that for some devices it is not
necessary or even desirable to allow the driver to perform all of the power
management operations by itself.  For example, we are going to make the PCI
PM core (which in fact is the PCI bus type driver) handle the saving and
restoration of PCI devices' configuration registers as well as putting the
devices into low power states and back into the full power state.  We can do
that, because in the "normal" suspend code path the suspend routines of a
driver are executed by the appropriate bus type's suspend routines and not
directly by the PM core.  The "early suspend" mechanism seems to go round this
by calling directly into device drivers.

Also, please observe that if there is a mechanism allowing us to put individual
devices, or entire subsystems (such as a bus with devices attached to it), into
low power states at run time, without placing the entire system in a sleep
state, and put them back into the full power state as needed, we won't need
anything like the "early suspend" introduced by this series of patches.

In fact, there is an ongoing effort to design such a mechanism and the USB
autosuspend may be considered as a part of it.  I'm currently working on doing
something similar for PCI devices.  I have some prototype patches and I can
post them if you'd like to look at them, although they really are work in
progress right now.

> That's the larger goal that the wakelock design seeks to accomplish, which
> is working pretty well for us in shipping mobile devices.
>
> Being in suspend, where periodic user and kernel timers aren't running,
> and random userspace threads aren't possibly spinning, rather than just 
> being in idle in the lowest power possible state, represent a pretty 
> significant power savings.

I generally agree, but I don't think that the approach presented by this series
of patches is one I'd like to implement.

> None of the hardware we're working with has a PCI bus, or ACPI, or much
> of any traditional desktop/server pc features, which may account for
> some of the difference in outlook and approach here.

Yes, certainly.  That's why the "early suspend" approach as proposed here does
not look practical to us.

As far as the wakelocks are concerned, the goal they are designed to achieve is
quite simple: you want to prevent suspend from happening in certain situations.
In principle, one flag is sufficient for that.  Still, there are many code
paths that might set and unset this flag and it would have been bad if the flag
had been set by one code path and then immediately unset by another one.
To prevent this from happening one can use a reference count with the rule that
suspend can only happen if it is equal to zero.

However, you want the user land to be able to prevent suspend from happening.
Now, there are couple of questions that need to be answered.  Namely, do you
want any user space processes to be able to block suspend and if so, then
why?  If not, then which processes should be able to do that?  How many of
such processes are going to be?  The solution of choice may well depend on the
answers here, but I don't see why the wakelocks as proposed are necessary for
that in any case.

Thanks,
Rafael
