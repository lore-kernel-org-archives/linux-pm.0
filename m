From: Alan Stern <stern@rowland.harvard.edu>
Subject: Toward runtime power management in Linux
Date: Sat, 30 Jul 2005 22:36:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0507302219250.13423-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0084909612416510516=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============0084909612416510516==
Content-Type: TEXT/PLAIN; charset=US-ASCII

Here are some preliminary thoughts on how runtime power management
(RTPM) should be implemented.  They are very incomplete, but at least
I think they are heading in the right direction.  Contributions are
welcome.

(Note: Below I will use "power states" and "power parent" in a very
general way.  The actual states and dependencies need not be directly
connected with power utilization -- they can be more general concepts,
anything related to RTPM.  Note also that this document does not
address system power management or the connections between the two
types of power management.)


	Basic ideas

To start with, we've already agreed that drivers should maintain some
set of states for their devices.  What these states should be, how
they are implemented and exported to userspace, and whether they are
defined by the device driver or by the bus subsystem, are all beyond
the scope of this document.  We only need to know that there is a
userspace API (presumably involving sysfs) for requesting state
changes.

We have also agreed that runtime power state changes need to bubble up
the device tree.  To handle this, drivers for interior nodes in the
tree can define "link states".  Unlike the device states, these don't
necessarily describe physical hardware and they are not exported.  A
link state merely encapsulates everything a power parent needs to know
about its children's requirements.  Quite often these link states will
be identical with the parent's or the child's device states, but this
isn't a requirement since the link state is entirely private to the
parent and the child.

When a driver changes a device's state, it will notify all of the
power parents about link state changes while doing so.  Note that a
device can have power parents other than its parent in the device
tree.  A good example is a logical volume, whose parents would be all
the physical drives that support it.  Other examples are plentiful in
the embedded world, where a device may rely on multiple buses for its
operation.

These notifications are one-way, child-to-parent only.  We don't need
pre- and post-notifications; each message will inform the parent of a
single link-state change, which the parent will then carry out.  The
parent will keep track of the link states for all its children, and
will adjust its own device state accordingly.  How it does so is up to
the parent's driver.

An example will make this clearer.  A PCI bridge is a parent, with a
PCI device as its child.  The set of device states for both the parent and 
the child is {D0, D1, D2, D3}.  (Maybe some variants of D3 for special
situations; let's not worry about the details.)  The link states will
also be D0 - D3.  When the child want to go from D0 to D3, it first
changes the device's actual state and then notifies the parent about
the link change.  The PCI bridge driver (which might be part of the
PCI core or might have to be added -- I don't know how this currently
works) will know how many child links it has in each state.  If this
no more links remain in D0 then maybe the bridge can lower its own
power usage (and notify its parent in turn).

Similarly, when the PCI driver wants to increase its device's power
usage it will notify the parent first, which may cause the parent to
change its own power state.  Then it will change the device's state.

It might turn out in practice that link states don't really need to be
separate from device states.  However it's easy to think of situations
where the set of link states does have to be different from the set of
parent device states.  For instance, a PCI USB controller will have
the usual D0 - D3 device states, but it will allow only ON and
SUSPENDED link states for the root-hub child.  Likewise, there could
well be situations where link states are not the same as the child
device states.  For instance, a device that uses multiple buses might
have to maintain different sorts of link states for each bus, all of
them different from its set of device states.


	Practical considerations

Power-parent relations: How should we represent the extra power
parent-child relationships that aren't present in the device tree?
Would it be enough to give each device that needs it a subdirectory in
sysfs with symlinks to its power parents?  Do we also need a symlink
from each parent to the child?

RTPM core: The scheme described above doesn't necessarily involve the
PM core.  The notifications can be simple subroutine calls, perhaps
with support from the bus subsystem.  It's not obvious how much core
support we will need for RTPM, apart from the sysfs interface.

Recursion: A consequence of doing things this way is that the
notifications can potentially use a lot of stack space as they
progress up the device tree.  (I can't think of any simple
non-recursive technique for implementing the scheme.)  Fortunately
this probably won't be too bad; the notifications will stop when they
reach a device that doesn't want to change its state (because it has
other children).  So the recursion should not involve too many levels.
Still, it is something to watch out for.

Context: A relatively recent change to the driver model core added a
semaphore to struct device, and we will want to hold this semaphore
while making state changes.  This immediately implies that RTPM needs
a process context to run in.  Should we have a kernel thread or work
queue specially devoted to RTPM activities (idle autosuspend and so
forth)?

Order of locking: The general rule, needed to prevent deadlock, for
acquiring the device semaphores is this: Don't lock a device if you
already hold one of its descendants' locks.  In other words, acquire
locks from the top of the tree going down.  This makes things very
awkward, because the notification scheme for power state changes goes
in the wrong direction: up the tree.  Even worse, it sometimes goes
_across_ the tree since power parents need not be device-tree parents.
I don't know how this should be resolved.

Idle-timeout RTPM: We certainly should have an API whereby userspace
can inform the kernel of an idle-timeout value to use for
autosuspending.  (In principle there could be multiple timeout values,
for successively deeper levels of power saving.)  This cries out to be
managed in a centralized way rather than letting each driver have its
own API.  It's not so clear what the most efficient implementation
will be.  Should every device have its own idle-timeout kernel timer?
(That's a lot of kernel timers.)  Or should the RTPM kernel thread
wake up every second to scan a list of devices that may have exceeded
their idle timeouts?

Userspace support: It's easy to see how userspace could use sysfs to
request a single device state change.  But what if the user wants to
suspend an entire subtree?  Should there be support in the kernel for
doing this, including locking to prevent various races?  Or should we
keep things simple and force the userspace tools to change the state
of each individual device in the subtree, working up from the bottom?
How can we cope with PPC suspend-to-ram, which doesn't use the
refrigerator?  We don't want processes to go around resuming devices
in the middle of a system suspend.

Initial implementation: The USB core already contains code that
partially resembles this scheme.  It's not fully correct for a couple of
reasons: The hub driver does not yet check to see when all of the
hub's children are suspended (which would allow the hub to suspend as
well).  And the code does not include any provision for automatically
suspending a USB device when all of its interfaces are suspended.

What other considerations are there?...

Alan Stern


--===============0084909612416510516==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0084909612416510516==--
