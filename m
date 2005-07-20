From: david-b@pacbell.net
Subject: Re: PM Summit in Ottawa
Date: Tue, 19 Jul 2005 22:34:16 -0700
Message-ID: <20050720053416.A9150BF389@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B300410F9A0@hdsmsx401.amr.corp.intel.com>
	<20050717211230.GA26394@kroah.com>
	<Pine.LNX.4.50.0507190737120.8463-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============039230361968212613=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0507190737120.8463-100000@monsoon.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: ncunningham@cyclades.com, abelay@novell.com, vojtech@suse.cz, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

--===============039230361968212613==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Greg suggested this was in shape for the PM list, typos and all,
so here goes... :)


=============================	CUT HERE

Date: Tue, 19 Jul 2005 07:39:33 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
To: Greg KH <greg@kroah.com>
Cc: "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	"" <abelay@novell.com>, "" <benh@kernel.crashing.org>,
	"" <david-b@pacbell.net>, "" <ncunningham@cyclades.com>,
	"" <stern@rowland.harvard.edu>,
	"Starikovskiy, Alexey Y" <alexey.y.starikovskiy@intel.com>,
	Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: PM Summit in Ottawa


Here is a write-up of the Summit, based on the notes and my own fuzzy
memory. I'll be making a small presentation for the session this
afternoon, too.

Let me know if you find any typos or gross inaccuracies.

Thanks,


	Pat




Power Management Summit


On Sunday, 17 July 2005, there was a meeting of several kernel
developers on the topic of Power Management with the goal of sorting
out some of the details that have been causing much disagreement and
confusion in the last few years. In Kernel Land these days, such a
meeting is called a "Summit", and so for 8 hours this week was the
first Power Management Summit.

Power Management is a big, complicated topic with many things working
against it. Instead of being contained in a single subsystem or being
relevant on a single architecture, it has the potential to affect
users of nearly every type of computer. Furthermore, it can mean one
of a number of things to different people, depending on the platform
most familiar to them: system suspend states, CPU performance scaling,
runtime power management, or general efficiency. And, many of those
things can behave very differently depending on the CPU architecture
platforms. Discussions can get lively, especially when an impedence
mismatch in understanding and terminology. Our goal on Sunday was to
sit down and determine what we could agree upon.

The attendees of the Summit were:

Pavel Machek (Novell)
Vojtech Pavlik (Novell, Guest of Pavel)
Nigel Cunningham (Cyclades)
Benjamin Herrenschmidt (IBM)
Len Brown (Intel)
Alexey Starikovskiy (Intel, Guest of Len)
Greg KH
Patrick Mochel

Even though there are many more people with a vested interest in Power
Management, and some that maintain more embedded systems that one can
shake a USB Memory Stick at, the goal for this initial meeting was to
keep the group small, contained to those most active on general PM
infrastructure, and focused. A couple more (David Brownell and Alan
Stern) were invited but unfortunately could not make it. As such, the
group was most concerned with x86 systems, especially notebook
computers.

Because of our expertise, we wanted to focus on the two main concerns
of users of those systems: System power management (where the entire
system goes to a low power state, e.g. Suspend-to-RAM and
Suspend-to-Disk) and Runtime power management (where individual
devices selectively or automatically enter low power states when not
in use). The two other main topics in most peoples' minds, CPU
performance scaling and Embedded power management, were touched upon
briefly.


System Power Management
-----------------------

System Power Management is well known to users of all notebook
computers. For a long time, it was known as those great features that
worked more or less flawlessly on other Operating Systems, and Not At
All on Linux. That has changed quite a bit, especially in the last
year. At least one major distribution enables Suspend-to-Disk by
default and allows users to use Suspend-to-RAM (though with the caveat
that it may not work).

Perception

We still have some big problems with it, the largest of which is
perception. Many people believe, based on past experiences, that it's
unstable and it has a tendency to corrupt user's data and that the
code is unmanageable. The happy users will tell you otherwise. It
works reliably on many systems, and has even been ported to the
PowerPC by Ben. Both Pavel and Nigel assured the group that they've
received no reports of datacorruption in a long time.

Many kernel developers have a reluctance to test it or audit it, which
many believe is holding it back. Even after this author implored Kernel
Summit attendees last year to at least try it, it's unlikely that many
people have. It's unclear how to change people's perception, but the
PM Summit attendees realize that the key to its success is wider
adoption and acceptance.

Drivers

The majority of issues that arise with system suspend states are
related to drivers. The most serious issue today is with video drivers
when resuming from a Suspend-to-RAM state. On many systems, Linux is
responsible for reinitializing the video hardware and restoring it to
its previous state. Unfortunately, this a very difficult task,
considering the complexity of the video chipsets, and the documents
necessary to do so are rarely, if ever, distributed by the hardware
vendors.

Len Brown assured the group that Intel is putting pressure on BIOS
writers and system vendors with Intel chipsets to support Linux
especially with regard to power management. If this works out as well
as planned, it means that the BIOS will reinitialize the video chipset
when resuming, so Linux won't have to worry about it. However, this
will only be true for platforms with Intel video hardware.

For everything else, PM Summit attendees came to the conclusion that
there is little the PM core can, or should, do. It is the video
driver's responsibility to restore the device to a usable state. Just
because there are competing video drivers in the kernel, and still
more reside outside of the kernel, they shouldn't be treated
specially. Since there seems to be a general trend towards moving
video drivers out of the kernel (and into e.g. X), there was some
discussion about the proper way to support that using an in-kernel
video driver stub (since the kernel can't safely access the video
hardware even to print a character, it is better done early in the
process rather waiting for the switch back to userspace and trying to
suppress all console access).

When entering Suspend-to-RAM, a video driver should disable the
console. If it can reinitialize the card when resuming from RAM,
then it should do so. If there is an application or library in
userspace that can, or will, do so, it should create a kernel thread
to call call_usermode_helper() with the name of the program and wait
for it to complete. This userspace helper should be self-contained,
do its job quickly, and return to kernel space, where the kernel
thread should exit and the driver should re-enable the console.

Greg Kroah-Hartman mentioned that he had already volunteered to
implement the correct support for an ATI Radeon chipset. Most likely
this will serve as a positive example for other developers to follow.

Suspend2 and Software Suspend

There was agreement among the attendees that Nigel Cunningham's
Suspend-to-Disk patches "Suspend2" are stable and worthwhile to many
users. It was suggested that he begin the process of merging his
patches with Pavel Machek's Software Suspend. A lengthy discussion
followed about strategies for doing so and the philosophy of gradual
kernel development.

To briefly recap, Suspend2 is very robust and feature rich. Not only
does it include a reliable process freezer, it has the ability
to compress and encrypt the suspended image and includes a graphical
status bar. Although it apparently does receive positive reviews from
users, most kernel developers do not care about such eye candy. It was
suggested and agreed that he will split the patches (all 69 of them so
far) into functional groups, and push them separately. We should the
process freezer patches come first, which should also benefit the
existing suspend implementation in the meantime. Next, will most
likely be the new algorithmic core and eventually the plugin
architecture and graphical features. It was heavily stressed that he
and Pavel must work together and that the more effort that is put in
to making the patches smaller and simpler, the easier time it will be
to merge his work.

Other Issues

There were three other issues related to System Power Management that
were discussed at the PM Summit.

- Suspend flags. It was agreed that we need to pass different flags
  via the pm_message_t argument to individual drivers' suspend and
  resume methods.

- The 2.6.13 kernel will impose greater requirements on the suspend
  and resume methods of PCI drivers. They must now release their IRQ
  on suspend and reacquire it on resume. This is documented in
  Documentation/power/pci.txt, and is based on the recent ACPI changes
  to not save/restore the PCI IRQ Link objects from the ACPI
  namespace.

- There was a potential issue brought up about BIOS reserved
  pages. Pavel suspects that the suspend code should not save them
  because there have been some odd interactions with regard to ACPI
  when restoring them (since they may contain shared data which seems
  to be changing between the time that the system is turned on and the
  image is restored).


Runtime Power Management
-------------------------

The PM Summit attendees had hoped to spend a considerable amount of
time discussing Runtime Power Management. For better or worse, the
discussions had to be contained in just a couple of hours. This left
less time for brainstorming, but managed to condense the discussion
down to a list of commonly agreed upon items.

- The driver model needs a "bus instance" data type.

  This would be an object that is created for each bus present on the
  system, regardless of type of bus (PCI, USB, SCSI, etc). This will
  be used for a number of reasons, in this context for keeping track
  of the power states of each device.

- Drivers are responsible for knowing and tracking when a device is
  idle.

  How this happens is up to the driver, and probably going to be
  common across a device class (e.g. sound, networking). We need some
  good examples of this working to a) show others how to do it, and b)
  define the requirements for some common infrastructure (via struct
  device or struct class_device) to help this effort.

  When a driver tracks the "idleness" it can transition the device to
  a low-power state automatically after a certain amount of time. The
  amount of time and the exact power state to enter should be
  controlled via files in sysfs. We need a framework (some helpers) to
  export these attributes via sysfs, but it will be the responsibility
  of some early adopters to implement these things on their own.

  When a device is automatically powered down, the driver must resume
  it when requests come in. Whether this happens on open(), read() or
  socket() is up to the driver and most likely going to be common to
  the class.

- Drivers need to bubble their idleness up the device tree.

  When a device automatically suspends, it must somehow notify the bus
  it resides on (using the bus instance mentioned above). When all the
  devices on the bus are put into a low power state, the bus must go
  into a low-power state and notify *its* parent bus.

  This feature can save a lot of power of many laptop systems. USB is
  the "Holy Grail" of this area. It causes a lot of power to be
  consumed even when there are no USB devices being used (by raising
  IRQs and preventing the CPU to stay in a low-power state). However,
  USB is going to be difficult to convert to this mdel.

- We need an interface for userspace to power down a specific device
  and a sub-tree of devices.

  We also need an attribute exported for at least some devices that
  will specify whether or not the device should wake up automatically
  when a request comes in (or if it should wait until userspace
  specifically wake it up).

- We want a separate hierarchy for power management dependencies.

  This would be represented via a distinct object type and exported
  via sysfs. It would allow both runtime and system power management
  to accurately and easily traverse the electrical hierarchy, without
  having to have the drivers make a lot of special case checks to
  determine what device is the next to power down (which is impossible
  most of the time because the core cannot discern the power
  hierarchy).


In short, there's a lot to do. A lot of this work is in the Power
Management and Driver Model core code. This means that once it's
written, it should be correct and stable. However, this also means it
will take some time to get right and will require some heavy lifting
by a small number of individuals. The general sentiment of the Summit
was that everyone would like to see this work done but all of the
individuals present are already oversubscribed. It may be some time
before this work could even be started.


Embedded Systems and Power Management
-------------------------------------

Since there were no Summit attendees that currently work full time on
Embedded Systems, the attendees did not want to make assertions about
the different systems and power management schemes. However, the
Summit attendees chose to come to agreement on what they knew about
the Embedded state of things (even if was very little).

- The maintainers of the Driver Model and Power Management cores need
  the different Embedded camps to work together and come up with some
  common framework among themselves.

  There are several different power management infrastructures for
  embedded systems (CELF, DPM from MontaVista, etc). They each support
  a number of systems and have happy users. But, it's unclear whether
  they are compatible or conflict with one another.

  The Maintainers cannot determine this on their own and cannot merge
  all of the competing schemes.

- The Embedded camps should suffice with keeping their platform-
  specific power management code in the platform-specific code.

  It's unclear (and seemingly unlikely) that there is any core
  infrastructure changes that are necessary to better support them. If
  there is, the Embedded camps need to work together to clearly define
  what it is they need from the core.

- The Embedded camps need to review the changes for Runtime Power
  Management as they happen and suggest changes that can be made to
  better facilitate their effort.

  It is unreasonable to expect the Runtime Power Management
  implementors to accomodate every uniqe PM scheme. However, it is
  their responsibility to not implement code that will prevent some
  platform port from realizing its fullest potential by enforcing poor
  policy on the platform.

  It is the responsibility of people like Embeded developers to
  notifiy the implementors of these potential issues.


Conclusion
----------

The attendees of the Power Management Summit agreed that the session
was valuable to the progress of the project. For many of them, it was
the first time they had all sat down in a room together and talked
about the project. There were many Power Management topics that were
left untouched, including many that are in the forefront of many other
developers' and vendors minds. Most agree that it will take many days,
if not weeks, to discuss all of the issues, let alone implement all of
the necesssary infrastructure and features. More than anything, the PM
Summit set the stage for many future face-to-face interactions on the
topic in the future.



--===============039230361968212613==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============039230361968212613==--
