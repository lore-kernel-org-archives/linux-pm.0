From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Summary of today's IRC discussion
Date: Thu, 17 Mar 2005 13:37:35 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0503171331071.855-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============80857946637056033=="
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============80857946637056033==
Content-Type: TEXT/PLAIN; charset=US-ASCII

Note: the live IRC log is available (thanks to Bernard!) at
<http://helicon.ucs.uwa.edu.au/~bernard/irc/%23pm.log>.

The session got started after some minor confusion caused by incorrect
time-zone calculations (now all fixed up on the wiki for the future 
sessions).

People agreed that the list of topics I wrote up in
<http://lists.osdl.org/pipermail/linux-pm/2005-March/000633.html> was
good but too extensive to cover over IRC.  Patrick suggested sticking
to a single topic, more or less, for each session.

We started by talking about the internal representation of device power
states.  It was agreed that the representation should be a pointer to
struct, where the contents of the struct are to be determined.  (In
some cases it might just encapsulate pm_message_t.)  There will be a
name field, but other fields are bus- and device-specific.  Should
attributes like FROZEN be included as well?

Information about these states is passed to/from userspace via sysfs.
It can also be passed between drivers, as in a child telling its
parent when it changes state, or a parent asking a child to change
state.  (Although the PM core never asks a device to go from one
suspend state to another without passing through resume, such a
requirement should not be enforced generally.)

A good way of doing state transformations is needed.  The important case
is going from generic system states (Standby, STR, STD) to device states.  
Often ACPI can help provide such a mapping, but many systems don't support
ACPI and sometimes the ACPI mappings are wrong.  There should be a way to
override them from userspace, say at boot time.  Also ACPI only knows
about devices on the motherboard.  But when available (and appropriate!)
it makes a good starting point.

In many situations these mapping can be done at the bus level so
device drivers don't need to worry about it.  There may also be a set
of mappings available for a device to use, like "PCI", "ACPI",
"Custom",...

(Side issue: The list of wakeup devices currently maintained by the
ACPI core is a temporary hack that will go away, replaced by a
property of the real devices in sysfs.  David Brownell will repost an
old patch that exposes this information.)

Mapping for device sub-states, as used in runtime power management, is
harder.  Maybe such sub-states shouldn't be exposed at all.  Sometimes
there are intricate relations among device states and system states
that are platform-specific; it would be easist to leave the complexity
sitting in the driver.

There was considerable disagreement over the matter of vetoing system
sleep transitions.  A driver might want to avoid sleeping if it's busy
doing something that shouldn't be interrupted.  But some situations
(like battery power low) can't be vetoed.  Suggestions included adding
a new system power state for non-vetoable sleeping and multi-stage
suspend messaging (first stage is notification with a chance to
veto).  Multi-stage was tried in the past and didn't work because of
bugs in drivers and immaturity of the model.  We may need to revisit
it in the future.

(Note that even now drivers are allowed to delay a suspend, although
they can't veto it.)

Since system sleeps come from userspace, perhaps questions of vetoable
or forced sleeps should be considered part of the userspace policy.
There's also the question of computer-user interaction: When people
tell their computer to do something, they want it to obey.  But other
people might not care so much, especially if they just told the
computer to do something it shouldn't.  The relations between a
userspace policy manager and the kernel's policy manager (if any!) are
very unclear.

Lastly people decided it was a good idea to have a small list of
targeted systems for PM development.  That way we have a minimum set
of goals for PM -- it has to work on those platforms -- and something to
focus on.  Also we'll have an excuse when someone asks "Why doesn't
this work on platform X?"  Suggested targets included x86 and ppc (both
workstations and laptops), a couple of embedded systems (OMAP ARM and
ppc8xx) with maybe a few odd additions such as MIPS.

It was also agreed that we should document what hardware is supported,
and what states are supported by which drivers.

Alan Stern


--===============80857946637056033==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============80857946637056033==--
