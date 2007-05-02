From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Wed, 2 May 2007 15:42:24 +0200
Message-ID: <200705021542.24988.rjw@sisk.pl>
References: <20070425072350.GA6866@ucw.cz> <200705020002.55331.rjw@sisk.pl>
	<8f8ff01d0705012213j54f15c4er2897731336b1ddb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <8f8ff01d0705012213j54f15c4er2897731336b1ddb5@mail.gmail.com>
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
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Pekka Enberg <penberg@cs.helsinki.fi>, linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

Hi,

On Wednesday, 2 May 2007 07:13, Alexey Starikovskiy wrote:
> Rafael,
>=20
> On resume ACPI expects
> boot kernel do pm_prepare().
> resumed kernel do pm_finish() before device_resume().

Well, lets analyse what pm_prepare() actually does.  If my understading o=
f
the code in there and the ACPI spec [1] is correct, it does the following=
:

(1) Sets the firmware waking vector (doesn't matter for hibernation)
(2) Prepares the wake-up devices for a state transition, by calling their=
 _PSW
methods ("to enable wake" according to the spec)
(3) Disables the GPEs that cannot wake up the system
(4) Runs the _PTS and _GTS methods
(5) Runs the _SST method
(6) Disables all GPEs

Now, there's a couple of problems with that regardless of what it's used =
for,
as far as I can see:

a) The spec (in Section 7.2) says that (2) should be done *after* the _PT=
S
method is called

b) The spec (Section 7.3.2) says:

"This [_PTS] method is called after OSPM has notified native device drive=
rs of
the sleep state transition and before the OSPM has had a chance to fully
prepare the system for a sleep state transition."

We don't seem to be doing this.  Moreover, Section 15.1.6 of the spec say=
 that
"OSPM places all device drivers into their respective Dx state" *before* =
_PTS
is executed, so it doesn't look like _PTS should be executed before
device_suspend().

c) According to the spec (Section 15.1.6) "OSPM saves any other processor=
=E2=80=99s
context (other than the local processor) to memory" *after* executing _PT=
S,
but *before* _GTS is executed, but we do this after _GTS is executed.
Moreover, the waking vector should be written into FACS after the "other
processor=E2=80=99s context" has been saved, but *before* _GTS is execute=
d.

d) The spec (Section 7.3.3) says literally this:

" _GTS allows ACPI system firmware to perform any required system specifi=
c
functions prior to entering a system sleep state. OSPM will set the sleep
enable (SLP_EN) bit in the PM1 control register immediately following the
execution of the _GTS control method without performing any other physica=
l I/O
or allowing any interrupt servicing."

However, in our code _GTS is executed *waaay* before setting the SLP_EN b=
it
in PM1, which only happens in acpi_enter_sleep_state() called from
acpi_pm_enter(), *after* we've executed device_suspend() with IRQs enable=
d
and, in the hibernation case, called device_resume() and saved the image
(oh, dear).

e) It implicitly follows from d) that _SST should be executed before _GTS
and after we run device_suspend().

f) I'm not sure if the disabling of all GPEs before device_suspend() is
actually a good idea.

Next, we can consider acpi_pm_finish().  Again, if my understading of the=
 code
in there and the ACPI spec [1] is correct, it does the following:

(7) Sets SLP_EN and SLP_TYPE to state S0
(8) Executes the _SST method (Waking)
(9) Executes the _BFS (Back From Sleep) method
(10) Executes the _WAK method
(11) Enables the runtime GPEs
(12) Enables the power button
(13) Executes the _SST method (Working)
(14) Disables the wake-up capability of devices
(15) Resets the firmware waking vector (doesn't matter for hibernation)

Now, there seems to be nothing wrong with that *if* it's executed while
resuming from RAM, for example, but it doesn't seem to be suitable for us=
ing
in such a way as we do this in the resume-during-hibernation code path.

Consider a hibernation (aka suspend to disk) transition (ie. an operation=
 in
which we snapshot the system memory, save the image and shut the system d=
own).

Currently, we call acpi_pm_prepare(PM_SUSPEND_DISK) and run device_suspen=
d(),
which seems to be in many ways agaist the ACPI spec.  The spec, as I unde=
rstand
it, indicates that we should run device_suspend() first and then execute =
the
_PTS method.  We shouldn't, however, execute either _GTS, or _SST just ye=
t.

Next, we suspend sysdevs etc., and create the memory snapshot.  We want
to be able to save it, so w call acpi_pm_finish(), which causes _BFS and =
_WAK
to be executed *after* _GTS, which is clearly against the spec (might thi=
s be the
reason why (7) is sometimes necessary?).  Moreover, calling _BFS at this =
stage
makes no sense, IMHO, since there hasn't been any transition (the system =
has
not slept).  What I think we should do at this point is to execute _WAK o=
nly,
which means "power transition aborted" to the firmware, and continue with
device_resume().

Next, we save the image and now we'd like to put the system to "sleep", s=
o
we use acpi_pm_enter(PM_SUSPEND_DISK), but we shouldn't do that, since th=
e
power transition has been aborted by _WAK in acpi_pm_finish()!  Thus we s=
hould
start the transition again, run device_suspend(), execute _PTS, do (2) an=
d (3),
save the "other processor's context" etc., execute _SST(S4), execute _GTS=
 and
set SLP_EN in PM1 etc.

When we restore the system state from a hibernation image, the "boot kern=
el" is
first started.  It loads the image into memory, calls
device_suspend(PMSG_PRETHAW), suspends sysdevs etc., and replaces itself =
with
the "resumed kernel".  It doesn't call acpi_pm_prepare(), which I think i=
s
right, because it doesn't want to start any power transition, not even a
fake one.  Now, the "resumed kernel" takes control, resumes sysdevs and c=
alls
acpi_pm_finish(), which seems to be about OK, except that I'm not sure if=
 _BFS
should be executed in that case (the ACPI spec seems to assume that the
hibernation image will be loaded into memory by a boot loader).

Concluding, it seems to me that the "restore" code path is correct, but t=
he
"hibernate" code path is not and should be reworked.  Also, it seems that
acpi_pm_prepare() and acpi_pm_enter() should be fixed for the s2ram case
either (_PTS should be executed after device_suspend() and _GTS should
be executed in acpi_pm_enter(), right before the transition is completed).

Greetings,
Rafael


[1] Advanced Configuration and Power Interface Specification, Revision 3.=
0,
September 2, 2004
