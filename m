From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.21-rc5-git 0/3] x86_pc and ACPI support
	/sys/devices/.../wakeup
Date: Wed, 18 Apr 2007 09:33:07 -0700
Message-ID: <200704180933.07601.david-b__49956.5420476303$1176914272$gmane$org@pacbell.net>
References: <200704051248.40745.david-b@pacbell.net>
	<1176889866.5376.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1176889866.5376.34.camel@localhost.localdomain>
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
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 18 April 2007 2:51 am, Zhang Rui wrote:
> Hi, David,
> =

> On Thu, 2007-04-05 at 12:48 -0700, David Brownell wrote:
> > Following are three patches for basic driver model wakeup flag support =
on
> > PCs.  I think the first two are nearly mergable.  The third previously =
broke
> > powerpc, so it's likely not yet mergeable ... the issue was arch-specif=
ic
> > differences in PCI initialization, someone else will need to solve them.
> > =

> > The patches are:
> > =

> >  - Define a platform_enable_wakeup() PM hook and use it with PCI.  (This
> >    might help OLPC with its non-RTC events...)
> > =

> >  - Make ACPI init and use driver model wakeup flags for the (motherboar=
d)
> >    devices in its table ... and implement that new platform hook.  Now
> >    /proc/acpi/wakeup is almost purely informative.
> =

> Yes.
> But /proc/acpi/wakeup is exporting the wrong information then.

I'd say it's always exported the wrong information ... and
since those /proc files are going away, this there's no
strong need to continue following that path.

The literal meaning hasn't changed:  it still reflects the
value of the acpi_device.wakeup.state.enabled flag.  This
version of the patch avoided changing that meaning, to make
the compatibility story simpler.

But managing that ACPI flag through that procfs file has never
related well to what has been needed, or how non-ACPI systems
(e.g. without GPEs) behave.


> I.e. when a physical device is set to may_wakeup, the corresponding
> GPE will be enabled before entering a system sleep state.

The GPE is not always enabled when device_may_wakeup(dev)
returns true.  When drivers aren't set up to handle wakeups,
they won't make requests that boil down to enabling GPEs.

What /proc/acpi/wakeup shows in those cases is the state
of what I called "manual overrides".  Drivers that aren't
wakeup-aware will use those settings ... same as always.
(Unless userspace disables wakeup for that device through
the driver model.)


Wakeup-aware drivers will manage their GPEs directly, by
calling pci_enable_wake() -- or whatever -- according to
what device_may_wakeup(dev) tells them to do.

It's always been strange that /proc/acpi/wakeup flags just
ignored pci_enable_wake() directions from drivers.  From the
driver perspective, those flags have been sadly divorced from
what they needed to do ... I count that as a bug, so that
these two patches are a bugfix for pci_enable_wake() in the
context of ACPI.


> But we always get status of the ACPI device is disabled
> via /proc/acpi/wakeup, even if they could be enabled in
> acpi_platform_enable_wakeup when suspending.

If a driver enables wakeup earlier, then it would be
displayed earlier.  But of course, pci_enable_wake()
and similar wakeup control logic mostly triggers when
a system leaves (or reenters) the S0 state(*).

You're overlooking the flip side.  Previously, that
flag would be shown as "enabled" even when drivers
requested that their device NOT be a wakeup source.
Surely that has been equally wrong...

- Dave

(*) The separate issue of wanting devices enter e.g. a
    D3hot state to save power when the system is in S0,
    and then rely on wake events, still remains.
