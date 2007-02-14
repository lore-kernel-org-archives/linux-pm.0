From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re:
	=?iso-8859-15?q?=5BRFC=5D=5BPATCH=5D_PM=3A_Document_re?=
	=?iso-8859-15?q?quirements_for_basic_PM_support_in=09drivers?=
Date: Wed, 14 Feb 2007 22:24:22 +0100
Message-ID: <200702142224.25619.rjw@sisk.pl>
References: <200702130023.23418.rjw@sisk.pl>
	<1171324020.4081.94.camel@nigel.suspend2.net>
	<1171467700.16413.12.camel@Dogbert.NOE.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1171467700.16413.12.camel@Dogbert.NOE.nokia.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Igor Stoppa <igor.stoppa@nokia.com>
Cc: Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.osdl.org>, Alan <alan@lxorguk.ukuu.org.uk>, ext Nigel Cunningham <ncunningham@linuxmail.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 14 February 2007 16:41, Igor Stoppa wrote:
> On Tue, 2007-02-13 at 10:47 +1100, ext Nigel Cunningham wrote:
> > Hi.
> > =

> > On Tue, 2007-02-13 at 00:23 +0100, Rafael J. Wysocki wrote:
> > > Hi,
> > > =

> > > Here's my attempt to document the requirements with respect to the ba=
sic PM
> > > support in drivers and the testing of that.  Comments welcome.
> > > =

> > > Greetings,
> > > Rafael
> > > =

> > > ---
> > >  Documentation/SubmittingDrivers         |   10 ++
> > >  Documentation/power/drivers-testing.txt |  119 +++++++++++++++++++++=
+++++++++++
> > >  2 files changed, 129 insertions(+)
> > > =

> > > Index: linux-2.6.20-git4/Documentation/SubmittingDrivers
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- linux-2.6.20-git4.orig/Documentation/SubmittingDrivers
> > > +++ linux-2.6.20-git4/Documentation/SubmittingDrivers
> > > @@ -87,6 +87,16 @@ Clarity:	It helps if anyone can see how =

> > >  		driver that intentionally obfuscates how the hardware works
> > >  		it will go in the bitbucket.
> > >  =

> > > +PM support:	Since Linux is used on many portable and desktop systems=
, your
> > > +		driver is likely to be used on such a system and therefore it
> > > +		should support basic power management by implementing, if
> > > +		necessary, the .suspend and .resume methods used during the
> > > +		system-wide suspend and resume transitions.  You should verify
> > > +		that your driver correctly handles the suspend and resume, but
> > > +		if you are unable to ensure that, please at least define the
> > > +		.suspend method returning the -ENOSYS ("Function not
> > > +		implemented") error.
> > > +
> > >  Control:	In general if there is active maintainance of a driver by
> > >  		the author then patches will be redirected to them unless
> > >  		they are totally obvious and without need of checking.
> > > Index: linux-2.6.20-git4/Documentation/power/drivers-testing.txt
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- /dev/null
> > > +++ linux-2.6.20-git4/Documentation/power/drivers-testing.txt
> > > @@ -0,0 +1,119 @@
> > > +Testing suspend and resume support in drivers
> > > +	(C) 2007 Rafael J. Wysocki <rjw@sisk.pl>
> > > +
> > > +Unfortunately, to effectively test the support for the system-wide s=
uspend and
> > > +resume transitions in a driver, it is necessary to suspend and resum=
e a fully
> > > +functional system with this driver loaded.  Moreover, that should be=
 done many
> > > +times, preferably many times in a row, and separately for the suspen=
d to disk
> > > +(STD) and the suspend to RAM (STR) transitions, because each of thes=
e cases
> > > +involves different ordering of operations and different interactions=
 with the
> > > +machine's BIOS.
> > > +
> > > +Of course, for this purpose the test system has to be known to suspe=
nd and
> > > +resume without the driver being tested.  Thus, if possible, you shou=
ld first
> > > +resolve all suspend/resume-related problems in the test system befor=
e you start
> > > +testing the new driver.
> > > +
> > > +I. Preparing the test system
> > > +
> > > +1. To verify that the STD works, you can try to suspend in the "rebo=
ot" mode:
> > > +
> > > +# echo reboot > /sys/power/disk
> > > +# echo disk > /sys/power/state
> > > +
> > > +and the system should suspend, reboot, resume and get back to the co=
mmand prompt
> > > +where you have started the transition.  If that happens, the STD is =
most likely
> > > +to work correctly, but you can repeat the test a couple of times in =
a row for
> > > +confidence.  You should also test the "platform" and "shutdown" mode=
s of
> > =

> > I would say "you need to repeat the test at least a couple of times...",
> > perhaps adding something along the lines of "This is necessary because
> > some problems only show up on a second attempt at suspending and
> > resuming a driver. You can think of it as the driver coming back 'dazed
> > and confused' after the first cycle, and only being properly killed by
> > the second attempt."
> =

> "at least a couple of times" sounds very optimistic :-D

Usually two times are enough to trigger the problem in such cases.

> > =

> > > +suspend:
> > > +
> > > +# echo platform > /sys/power/disk
> > > +# echo disk > /sys/power/state
> > > +
> > > +or
> > > +
> > > +# echo shutdown > /sys/power/disk
> > > +# echo disk > /sys/power/state
> > > +
> > > +in which cases you will have to press the power button to make the s=
ystem
> > > +resume.  If that works, you are ready to test the STD with the new d=
river
> > > +loaded.  Otherwise, you have to identify what is wrong.
> > > +
> > > +a) To verify if there are any drivers that cause problems you can ru=
n the STD
> > > +in the test mode:
> > > +
> > > +# echo test > /sys/power/disk
> > > +# echo disk > /sys/power/state
> > > +
> > > +in which case the system should freeze tasks, suspend devices, disab=
le nonboot
> > > +CPUs (if any), wait for 5 seconds, enable nonboot CPUs, resume devic=
es, thaw
> > > +tasks and return to your command prompt.  If that fails, most likely=
 there is
> > > +a driver that fails to either suspend or resume (in the latter case =
the system
> > > +may hang or be unstable after the test, so please take that into con=
sideration).
> > > +To find this driver, you can carry out a binary search according to =
the rules:
> > > +- if the test fails, unload a half of the drivers currently loaded a=
nd repeat
> > > +(that would probably involve rebooting the system, so always note wh=
at drivers
> > > +have been loaded before the test),
> > > +- if the test succeeds, load a half of the drivers you have unloaded=
 most
> > > +recently and repeat.
> > > +
> > > +Once you have found the failing driver (there can be more than just =
one of
> > > +them), you have to unload it every time before the STD transition.  =
In that case
> > > +please make sure to report the problem with the driver.
> > =

> > It is also possible that a cycle can still fail after you have unloaded
> > all modules. In that case, you would want to look in your kernel
> > configuration for possibilities that can be modularised (testing again
> > with them as modules), and possibly also try boot time options such as
> > noapic or noacpi.
> =

> The first step, imho, would be to identify all the peripherals requiired
> for a barebone configuration to run (i.e. serial console) and verify
> that at least those can reliably go through several suspend/resume
> cycles. Then the dicotomic approach can be used.

I think in most configurations init=3D/bin/bash loads the minimal set of dr=
ivers
needed.  If anyone has certain special need, he will certainly figure out
what to do. :-)

> > =

> > > +
> > > +b) If the test mode of STD works, you can boot the system with "init=
=3D/bin/bash"
> > > +and attempt to suspend in the "reboot", "shutdown" and "platform" mo=
des.  If
> > > +that does not work, there probably is a problem with one of the low =
level
> > > +drivers and you generally cannot do much about it except for reporti=
ng it
> > > +(fortunately, that does not happen very often these days).  Otherwis=
e, there is
> > =

> > Oh. Perhaps some of the suggestions from above belong here?
> > =

> > > +a problem with a modular driver and you can find it by loading a hal=
f of the
> > > +modules you normally use and binary searching in accordance with the=
 algorithm:
> > > +- if there are n modules loaded and the attempt to suspend and resum=
e fails,
> > > +unload n/2 of the modules and try again (that would probably involve=
 rebooting
> > > +the system),
> > > +- if there are n modules loaded and the attempt to suspend and resum=
e succeeds,
> > > +load n/2 modules more and try again.
> > > +
> > > +Again, if you find the offending module(s), it(they) must be unloade=
d every time
> > > +before the STD transition, and please report the problem with it(the=
m).
> > > +
> > > +2. To verify that the STR works, it is generally more convenient to =
use the
> > > +s2ram tool available from http://suspend.sf.net and documented at
> > > +http://en.opensuse.org/s2ram .  However, before doing that it is rec=
ommended to
> > > +carry out the procedure described in section 1.
> > > +
> > > +Assume you have resolved the problems with the STD and you have foun=
d some
> > > +failing drivers.  These drivers are also likely to fail during the S=
TR or
> > > +during the resume, so it is better to unload them every time before =
the STR
> > > +transition.  Now, you can follow the instructions at
> > > +http://en.opensuse.org/s2ram to test the system, but if it does not =
work
> > > +"out of the box", you may need to boot it with "init=3D/bin/bash" an=
d test
> > > +s2ram in the minimal configuration.  In that case, you may be able t=
o search
> > > +for failing drivers by following the procedure analogous to the one =
described in
> > > +1b).  If you find some failing drivers, you will have to unload them=
 every time
> > > +before the STR transition (ie. before you run s2ram), and please rep=
ort the
> > > +problem with them.
> > > +
> > > +II. Testing the driver
> > > +
> > > +Once you have resolved the suspend/resume-related problems with your=
 test system
> > > +without the new driver, you are ready to test it:
> Why not first get the driver working against the barebone configuration?

You can start from the barebone and go towards more complete configurations=
 or
start with a more-or-less complete system and simplify the configuration if
there are problems.  Anyway, however, you need to test against the complete
system eventually, I think.

Greetings,
Rafael
