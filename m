From: <Mario.Limonciello@dell.com>
Subject: RE: [PATCH 3/5] ACPI / sleep: EC-based wakeup from suspend-to-idle on
 Dell systems
Date: Thu, 27 Apr 2017 14:47:59 +0000
Message-ID: <fbb003d3c4fb465b9c17b4698431c96c@ausx13mpc120.AMER.DELL.COM>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan>
 <3060629.nj3VExRueE@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from esa7.dell-outbound.iphmx.com ([68.232.153.96]:52981 "EHLO
        esa7.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933187AbdD0OsC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Apr 2017 10:48:02 -0400
In-Reply-To: <3060629.nj3VExRueE@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com, dvhart@infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, srinivas.pandruvada@linux.intel.com, tglx@linutronix.de, mika.westerberg@linux.intel.com

> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> Sent: Wednesday, April 26, 2017 4:24 PM
> To: Linux PM <linux-pm@vger.kernel.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Darren Hart
> <dvhart@infradead.org>; LKML <linux-kernel@vger.kernel.org>; Linux ACPI <=
linux-
> acpi@vger.kernel.org>; Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com>; Thomas Gleixner <tglx@linutronix.d=
e>;
> Mika Westerberg <mika.westerberg@linux.intel.com>; Limonciello, Mario
> <Mario_Limonciello@Dell.com>
> Subject: [PATCH 3/5] ACPI / sleep: EC-based wakeup from suspend-to-idle o=
n Dell
> systems
>=20
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> Some recent Dell laptops, including the XPS13 model numbers 9360 and
> 9365, cannot be woken up from suspend-to-idle by pressing the power
> button which is unexpected and makes that feature hardly usable on
> those systems.  However, on the 9365 ACPI S3 (suspend-to-RAM) is not
> expected to be used at all (these systems ship with Windows 10 using
> Modern Standby which never exercises the ACPI S3 path) and
> suspend-to-idle is the only viable system suspend mechanism in there.
>=20
> The reason why the power button wakeup from suspend-to-idle doesn't
> work on those systems is because their power button events are
> signaled by the EC (Embedded Controller), whose GPE (General Purpose
> Event) line is disabled during suspend-to-idle transitions in Linux.
> That is done on purpose, because in general the EC tends to generate
> tons of events for various reasons (battery and thermal updates and
> similar, for example) and all of them would kick the CPUs out of deep
> idle states while in suspend-to-idle, which would not be desirable.
>=20
> Of course, on the Dell systems in question the EC GPE must be enabled
> during suspend-to-idle transitions for the button press events to
> be signaled while suspended at all.  Fortunately, there is a way to
> tell the EC to stop generating the non-wakeup events, which is by
> using the _DSM object under the so called micro-PEP (uPEP) device
> provided to support Modern Standby in Windows 10.
>=20
> The expected way to use it is to invoke function 0 from it on system
> initialization, functions 3 and 5 during suspend transitions and
> functions 4 and 6 during resume transitions (to reverse the actions
> carried out by the former).  In particular, function 5 from the uPEP
> device _DSM causes the EC to become less verbose (so to speak) on the
> affected systems and then its GPE can be enabled as a wakeup source
> (then, on resume, function 6 switches it back to the "working state"
> mode).
>=20
> In support of the affected Dell systems, implement the uPEP device
> handling as described and allow the EC to generate system wakeup
> events if that device is present and behaves as expected.  Enable
> that for Dell only, as there are other systems out there in which
> the uPEP device is exposed in the ACPI tables and its _DSM appears
> to be functional, but it actually isn't, whereas Dell is committed
> to supporting it.
>=20

I am of course biased in that my priority is for this to work for Dell.
Dell is definitely committed to supporting this on any system with
the low power idle bit in the FADT set.

So I'm fine with the current proposed solution, but have you
dug into what actually breaks on this other system?  Does it actually
work with Modern Standby + the uPEP device on Windows 10?

To my understanding I would think any OEM that is enabling this
uPEP device it should be getting called by the Windows kernel
identically when entering resiliency phases.

This makes me wonder if it should be inverted and a blacklist
of platforms that the uPEP device doesn't work.
