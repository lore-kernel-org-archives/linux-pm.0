From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Sun, 25 Jun 2006 04:23:28 -0400
Message-ID: <20060625082328.GC4264@neo.rr.com>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<20060624024230.GB3438@neo.rr.com>
	<Pine.LNX.4.64.0606231953560.6483@g5.osdl.org>
	<200606232104.11131.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200606232104.11131.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Kay Sievers <kay.sievers@vrfy.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 23, 2006 at 09:04:10PM -0700, David Brownell wrote:
> On Friday 23 June 2006 8:12 pm, you wrote:
> =

> > For example, on the run-time management, if we shut things down not as =
a =

> > "pci_device" but as a "network device" (which just happens to be _bound=
_ =

> > to a pci device), we could very easily do the highlevel network device =

> > crap to make sure that we don't get entered that way _first_. And do it=
 in =

> > just one place.
> =

> Heh, I said as much in a recent note.  The issue is that the network
> stack doesn't know suspend from joe.  If "eth0" had a real "struct device=
",
> that solution should work ... and simplify lots of driver suspend and
> resume methods.  Backwards compat would be an issue though.
> =

> =

> > > One thing that might help us get there is if we passed a suspend noti=
fication
> > > to the class devices (i.e. the higher level subsystems).
> > =

> > Good point. We probably should. That really really makes sense, and tha=
t =

> > also automagically solves the "network device" issue.
> =

> I'm not sure doing that with class devcies is the right idea, at least
> until they show up in the driver model tree as physical children of the
> parent hardware (so that the driver model tree automatically handles
> sequence constraints.

I agree totally, class devices should be the real children of their physical
device instances.  It's really all about representing how the drivers are
_actually_ layered.  In the PCI network device case, the code always follows
this structure:

PCI Device -> Network Device Driver (e.g. e1000) -> Network Device Class

Therefore, I think the driver model parent-child relationship should match =
the
above exactly.  Currently we don't model driver instances at all and there =
is
a lot of unneeded asymmetry between class devices and normal devices.  I've
added Kay to CC as he's posted some interesting patches in the past that wo=
rk
toward changing this.

Now for why this is relevant to suspend/resume...  If the driver model
framework exposes the correct layered structure of device drivers, then we
can just walk the device tree and call the suspend functions at each stage
of the suspend process with no special exceptions.  Currently, the device
drivers (notice that it's the middle layer in the above example) is the only
entry point for suspend notifications.  As a result, all of the burden of
quiescing the device falls on their shoulders, even though this is almost
always a higher-order subsystem issue.  In the end, we get large ammounts of
duplicated code and a the potential for added complexity.

However, it's also interesting that these device drivers have full
responsibility for enabling PME generation and entering lower PCI power sta=
tes
during a suspend transition.  Let's remember, this is entirely a
PCI-specific issue, and more often than not, every device driver is doing
the exact same thing:

pci_disable_device(dev);
pci_save_state(dev);
pci_set_power_state(dev, PCI_D3);

So the PCI device instance itself could also stand to recieve these suspend
callbacks.  Not only that, but entering the correct PCI D-state is actually
a very complicated decision, often involving platform specific data (e.g.
ACPI) and it's generally very dependent on the target system-level suspend
state.  The horribly broken pci_choose_state() interface we have today does=
n't
even come close to handling this correctly.  So again, we have large ammoun=
ts
of duplicated code, much of which isn't even correct.

However, if we pass along suspend notifications to every logical device dri=
ver
layer, then each layer only has to worry about issues that are important to
the specific hardware abstraction level it's entrusted to control.  To most
device drivers this means things become dead simple (possibly some won't ha=
ve
to do anything at all).  Also, we can put in the time and effort to make su=
re
that some of the more tricky code paths (i.e. higher layers) work well beca=
use
they will always be called in a consistent dependable manner and there is o=
nly
one entry point.  Finally, it becomes a lot easier to make revisions to each
individual driver layer suspend routine without breaking code in others.

The driver model today, in many ways, is far from providing this sort of
abstraction.  However, we can certainly work toward it gradually.  Linus's
patch to add suspend/resume callbacks at the "struct device_class" level do=
es
exactly that.

Thanks,
Adam

P.S.:  Linus, what are your thoughts on passing a mirror image of the suspe=
nd
callbacks we provide (or will provide) for the device interface to the class
device interface?  In other words, allow it to also get suspend_prepare(),
resume_finish(), etc. to encourage the sort of abstraction suggested above.
