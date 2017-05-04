From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/5] ACPI / sleep: EC-based wakeup from suspend-to-idle on Dell systems
Date: Thu, 04 May 2017 16:23:30 +0200
Message-ID: <2575390.Ukje8MD5v5@aspire.rjw.lan>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan> <5667544.hrarxH2qbq@aspire.rjw.lan> <1AE640813FDE7649BE1B193DEA596E886CE9D3AE@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CE9D3AE@SHSMSX101.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "dvhart@infradead.org" <dvhart@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, May 04, 2017 07:58:53 AM Zheng, Lv wrote:
> Hi,
> 
> > -----Original Message-----
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Rafael J.
> > Wysocki
> > Sent: Friday, April 28, 2017 6:26 AM
> > To: Mario.Limonciello@dell.com
> > Cc: linux-pm@vger.kernel.org; andriy.shevchenko@linux.intel.com; dvhart@infradead.org; linux-
> > kernel@vger.kernel.org; linux-acpi@vger.kernel.org; srinivas.pandruvada@linux.intel.com;
> > tglx@linutronix.de; mika.westerberg@linux.intel.com
> > Subject: Re: [PATCH 3/5] ACPI / sleep: EC-based wakeup from suspend-to-idle on Dell systems
> > 
> > On Thursday, April 27, 2017 02:47:59 PM Mario.Limonciello@dell.com wrote:
> > > > -----Original Message-----
> > > > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > > > Sent: Wednesday, April 26, 2017 4:24 PM
> > > > To: Linux PM <linux-pm@vger.kernel.org>
> > > > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Darren Hart
> > > > <dvhart@infradead.org>; LKML <linux-kernel@vger.kernel.org>; Linux ACPI <linux-
> > > > acpi@vger.kernel.org>; Srinivas Pandruvada
> > > > <srinivas.pandruvada@linux.intel.com>; Thomas Gleixner <tglx@linutronix.de>;
> > > > Mika Westerberg <mika.westerberg@linux.intel.com>; Limonciello, Mario
> > > > <Mario_Limonciello@Dell.com>
> > > > Subject: [PATCH 3/5] ACPI / sleep: EC-based wakeup from suspend-to-idle on Dell
> > > > systems
> > > >
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > Some recent Dell laptops, including the XPS13 model numbers 9360 and
> > > > 9365, cannot be woken up from suspend-to-idle by pressing the power
> > > > button which is unexpected and makes that feature hardly usable on
> > > > those systems.  However, on the 9365 ACPI S3 (suspend-to-RAM) is not
> > > > expected to be used at all (these systems ship with Windows 10 using
> > > > Modern Standby which never exercises the ACPI S3 path) and
> > > > suspend-to-idle is the only viable system suspend mechanism in there.
> > > >
> > > > The reason why the power button wakeup from suspend-to-idle doesn't
> > > > work on those systems is because their power button events are
> > > > signaled by the EC (Embedded Controller), whose GPE (General Purpose
> > > > Event) line is disabled during suspend-to-idle transitions in Linux.
> > > > That is done on purpose, because in general the EC tends to generate
> > > > tons of events for various reasons (battery and thermal updates and
> > > > similar, for example) and all of them would kick the CPUs out of deep
> > > > idle states while in suspend-to-idle, which would not be desirable.
> > > >
> > > > Of course, on the Dell systems in question the EC GPE must be enabled
> > > > during suspend-to-idle transitions for the button press events to
> > > > be signaled while suspended at all.  Fortunately, there is a way to
> > > > tell the EC to stop generating the non-wakeup events, which is by
> > > > using the _DSM object under the so called micro-PEP (uPEP) device
> > > > provided to support Modern Standby in Windows 10.
> > > >
> > > > The expected way to use it is to invoke function 0 from it on system
> > > > initialization, functions 3 and 5 during suspend transitions and
> > > > functions 4 and 6 during resume transitions (to reverse the actions
> > > > carried out by the former).  In particular, function 5 from the uPEP
> > > > device _DSM causes the EC to become less verbose (so to speak) on the
> > > > affected systems and then its GPE can be enabled as a wakeup source
> > > > (then, on resume, function 6 switches it back to the "working state"
> > > > mode).
> > > >
> > > > In support of the affected Dell systems, implement the uPEP device
> > > > handling as described and allow the EC to generate system wakeup
> > > > events if that device is present and behaves as expected.  Enable
> > > > that for Dell only, as there are other systems out there in which
> > > > the uPEP device is exposed in the ACPI tables and its _DSM appears
> > > > to be functional, but it actually isn't, whereas Dell is committed
> > > > to supporting it.
> > > >
> > >
> > > I am of course biased in that my priority is for this to work for Dell.
> > > Dell is definitely committed to supporting this on any system with
> > > the low power idle bit in the FADT set.
> > >
> > > So I'm fine with the current proposed solution, but have you
> > > dug into what actually breaks on this other system?  Does it actually
> > > work with Modern Standby + the uPEP device on Windows 10?
> > >
> > > To my understanding I would think any OEM that is enabling this
> > > uPEP device it should be getting called by the Windows kernel
> > > identically when entering resiliency phases.
> > >
> > > This makes me wonder if it should be inverted and a blacklist
> > > of platforms that the uPEP device doesn't work.
> > 
> > For now I'd prefer to only do it on platforms where the benefit is clear.
> > 
> > The next step may be to extend it to the other ones, but let's avoid making
> > what is problem mitigation really depend on things that may or may not
> > work elsewhere to start with.
> 
> Then is it possible to invoke acpi_mark_gpe_for_wake() (and maybe also acpi_unmark_gpe_for_wake()) right after invoking uPEP functions?
> So that such platform specific stuffs won't go into ec.c.

I'm not sure ATM, but it should be doable in theory.

Let me try that approach, but it will need to be re-tested then, obviously.

Thanks,
Rafael
