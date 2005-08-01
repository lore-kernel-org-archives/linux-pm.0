From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Toward runtime power management in Linux
Date: Mon, 1 Aug 2005 10:07:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0508010935440.4961-100000@iolanthe.rowland.org>
References: <20050801021054.GA30859@best.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============59392139301471225=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050801021054.GA30859@best.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Leo L. Schwab" <ewhac@best.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============59392139301471225==
Content-Type: TEXT/PLAIN; charset=US-ASCII

Evidently between us there is a tremendous communication gap.  No doubt 
it's mostly my fault for not making the original document sufficiently 
detailed.  Let me try to clear things up...


On Sun, 31 Jul 2005, Leo L. Schwab wrote:

> On Sat, Jul 30, 2005 at 10:36:56PM -0400, Alan Stern wrote:
> > An example will make this clearer.  A PCI bridge is a parent, with a
> > PCI device as its child.  The set of device states for both the parent and 
> > the child is {D0, D1, D2, D3}.  (Maybe some variants of D3 for special
> > situations; let's not worry about the details.)  The link states will
> > also be D0 - D3.  When the child want to go from D0 to D3, it first
> >                                                            ^^^^^^^^
> > changes the device's actual state and then notifies the parent about
> > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > the link change.
> > ^^^^^^^^^^^^^^^
> 
> 	Strong disagreement.  Power state changes must be allowed to fail
> ("Spin up the 15K RPM drive?  I'm sorry, there's only 3 Watts of power left
> to spare").  So you must first ask the parent for a power state change
> before you perform your own so it has the opportunity to deny the request.

Yes, power state changes must be allowed to fail.  I omitted discussing
error handling, but clearly the parent notification must be able to return
an error code, which might force the child to abort a state change.

However you have badly misunderstood this example.  In the example the
device goes from D0 to D3, thereby _reducing_ its power consumption.  
Hence it doesn't want to ask the parent to reduce the available power
supply _before_ it prepares the device -- rather just the opposite.  If
the device were moving from D3 back to D0 then, as you say, it would have
to notify the parent first.

> Besides, in the case of USB, you may not have any power at all until you
> notify the parent bus/hub manager to wake up.

Just so.  The important point is that the parent notification and the 
device state change must happen in the correct relative order, and that 
order depends on the exact nature of the change.  A really complicated 
state change might even require multiple intermediate parent 
notifications, or separate notifications to multiple parents.


> > These notifications are one-way, child-to-parent only.  We don't need
> > pre- and post-notifications; each message will inform the parent of a
> > single link-state change, which the parent will then carry out.
> 
> 	I don't see how this will work.  Bringing up power/resuming must
> happen in parent-to-child order, otherwise endpoint devices may not have any
> power at all when you try to bring them up.  Cutting off power/suspending
> must happen in child-to-parent order, since parents can't know when it's
> safe to cut off power until the child is completely quiesced.

Here's how it will work:  For bringing up power/resuming, the child first
notifies the parent about its impending state change.  The parent realizes
that it must increase its own power allocation, and it does so before
returning.  Then the child can continue the resume procedure, with
sufficient power available.  For cutting off power/suspending, the child
first reduces its power consumption and then notifies the parent about the
state change.  The parent realizes that it can now decrease its own power
level, and it does so before returning.

In each case there is only _one_ notification.  It's not necessary for the
child to notify the parent both before and after each individual state
change.  And it's not necessary for the parent to notify the child at all
(other than by possibly returning an error code in response to the child's
notification).


> > Idle-timeout RTPM: We certainly should have an API whereby userspace
> > can inform the kernel of an idle-timeout value to use for
> > autosuspending.  (In principle there could be multiple timeout values,
> > for successively deeper levels of power saving.)  This cries out to be
> > managed in a centralized way rather than letting each driver have its
> > own API.  It's not so clear what the most efficient implementation
> > will be.  Should every device have its own idle-timeout kernel timer?
> > (That's a lot of kernel timers.)
> 
> 	Whether you do it in user space or kernel space, you're going to
> potentially schedule a lot of timers.

You must have written that before reading the very next sentence:

> > Or should the RTPM kernel thread
> > wake up every second to scan a list of devices that may have exceeded
> > their idle timeouts?

If we have a kernel thread working like this, then there's no need for a
lot of kernel timers.

> 	This could potentially make performance-conscious apps "hiccup"
> once every second as this thread goes walking the list looking for
> candidates to shut off.  Try to avoid this; if nothing is happening, nothing
> should be running.

I don't understand this comment at all.  Lots of things happen 
periodically in the kernel: threads wake up, timers go off...  Are you 
suggesting that, for example, the page-flush thread shouldn't wake up 
from time to time either?

Furthermore, there's a trade-off between doing a bunch of chores all at 
once (i.e., have a kernel thread scan a list of devices to see which have 
exceeded their idle timeouts) and distributing those chores piecemeal 
(i.e., have each driver reschedule an idle timer every time one of its 
devices carries out some activity).  In the absence of actual measurements 
it's impossible to know which will affect performance more -- and in fact 
the effects are likely to be highly variable, depending on workload.

As for your "if nothing is happening, nothing should be running" mantra, 
it runs counter to the very idea of runtime PM.  If nothing is happening, 
the system should wait until enough idle time has gone past, and then it 
should actively turn off power to devices that don't need it.  That's very 
different from running nothing!


> > Userspace support: It's easy to see how userspace could use sysfs to
> > request a single device state change.  But what if the user wants to
> > suspend an entire subtree?  [ ... ]
> 
> 	If you wanted to get really fancy, you could establish via a
> userspace API a named "device collection" which acts as a virtual device.
> You then apply the state change to the device collection, and the kernel
> percolates it through all the actual devices, taking locking into account.

I suspect that's fancier than we need, although perhaps it would come in 
handy in special circumstances.  For now, it should be good enough to 
restrict such "device collections" to be subtrees of the device tree.

Alan Stern


--===============59392139301471225==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============59392139301471225==--
