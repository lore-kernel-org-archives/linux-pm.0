From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: ACPI code in platform mode hibernation code paths (was:
	Re: [PATCH] swsusp: do not use pm_ops)
Date: Wed, 2 May 2007 21:26:46 +0200
Message-ID: <200705022126.47897.rjw__28622.0575253994$1178152569$gmane$org@sisk.pl>
References: <20070425072350.GA6866@ucw.cz> <200705021542.24988.rjw@sisk.pl>
	<8f8ff01d0705020711r630b8b92sdd2cd9316eb39edc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <8f8ff01d0705020711r630b8b92sdd2cd9316eb39edc@mail.gmail.com>
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
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

[Added linux-acpi to the CC list, should be there from the start]

On Wednesday, 2 May 2007 16:11, Alexey Starikovskiy wrote:
> Rafael,
> 
> > Concluding, it seems to me that the "restore" code path is correct, but the
> > "hibernate" code path is not and should be reworked.  Also, it seems that
> > acpi_pm_prepare() and acpi_pm_enter() should be fixed for the s2ram case
> > either (_PTS should be executed after device_suspend() and _GTS should
> > be executed in acpi_pm_enter(), right before the transition is completed).
> 
> Current implementation is not fully up-to spec, so we may try to get
> it closer to, I agree.

Okay.  Since we're trying to separate the hibernation code from the
suspend code anyway, we can use the opportunity to introduce some new
callbacks for the hibernation and/or redefine the existing ones.

The spec suggests that we need the following callbacks:

(1) prepare() - called after device_suspend(), execute _PTS and disable GPEs
(2) cancel() - called at any time after prepare() if there's an error, execute
    _WAK and enable run-time GPEs
(3) enter() - called after the image has been saved, execute _GTS and do what's
    currently done in pm_enter()
(4) finish() - called after the image has been restored, do what's currently
    done in pm_finish()

[At least, the execution of _GTS in pm_prepare() seems to be dangerous at first
sight.]

We also might need a callback that will be run before device_suspend() to
invoke some ACPI-related magic needed at that point, but I have no idea what
it would have to do. :-)

> > When we restore the system state from a hibernation image, the "boot kernel" is
> > first started.  It loads the image into memory, calls
> > device_suspend(PMSG_PRETHAW), suspends sysdevs etc., and replaces itself with
> > the "resumed kernel".  It doesn't call acpi_pm_prepare(), which I think is
> > right, because it doesn't want to start any power transition, not even a
> > fake one.  Now, the "resumed kernel" takes control, resumes sysdevs and calls

> Currently call to prepare() is needed to stop ACPI devices to send
> GPEs to ACPI drivers.

Does it mean that we need to call pm_prepare() (or an equivalent function)
before device_suspend()?  If that's the case, then which part of pm_prepare()
is essential here?

> If you remove it, Acer laptops will resume without ACPI interrupt at
> all (with all problems from it).

A recent discussion on the LKML lead to the conclusion that for the
hibernation we shouldn't use .suspend() callbacks before snapshotting the
system memory.  Instead, we should use some other callbacks to quiesce devices,
create the snapshot, reactivate devices, save the image and carry out the
actual power transition after that.  Would something like this be viable from
the ACPI point of view?

> > acpi_pm_finish(), which seems to be about OK, except that I'm not sure if _BFS
> > should be executed in that case (the ACPI spec seems to assume that the
> > hibernation image will be loaded into memory by a boot loader).
> 
> > Next, we suspend sysdevs etc., and create the memory snapshot.  We want
> > to be able to save it, so w call acpi_pm_finish(), which causes _BFS and _WAK
> > to be executed *after* _GTS, which is clearly against the spec (might this be the
> > reason why (7) is sometimes necessary?).  Moreover, calling _BFS at this stage
> > makes no sense, IMHO, since there hasn't been any transition (the system has
> > not slept).  What I think we should do at this point is to execute _WAK only,
> > which means "power transition aborted" to the firmware, and continue with
> > device_resume().
> 
> But I don't get your idea about executing _finish() between _prepare()
> and _enter()...
> _finish is executed only if _prepare() fails, so we are rolling back,

Well, no.  Please have a look at the code in kernel/power/disk.c.

Should we remove it from the nonerror code paths?

> or it is executed after we loaded the image and transfered execution
> to it, so again -- we are going from _prepare() state to running
> state...

Currently that's not the case.

Greetings,
Rafael
