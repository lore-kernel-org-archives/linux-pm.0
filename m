From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 1/2] PM / arch: x86: Rework the MSR_IA32_ENERGY_PERF_BIAS handling
Date: Fri, 22 Mar 2019 17:27:43 +0100
Message-ID: <2431307.7efAn4P022@house>
References: <1637073.gl2OfxWTjI@aspire.rjw.lan> <1605148.8jT99SsvVP@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1605148.8jT99SsvVP@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Laura Abbott <labbott@fedoraproject.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Simon Schricker <sschricker@suse.de>, Borislav Petkov <bp@suse.de>, Hannes Reinecke <hare@suse.de>
List-Id: linux-pm@vger.kernel.org

Thanks Rafael for your quick look at and all the time you spend for this!

A /sys userspace knob will certainly not be enough for us.
You'll need a tool installed fixing this.
powertop on laptops or tuned on servers or a well hidden bootup quirk or 
whatsoever.

The patch I sent with this part:

+       if (acpi_gbl_FADT.preferred_profile == PM_PERFORMANCE_SERVER ||
+           acpi_gbl_FADT.preferred_profile == PM_ENTERPRISE_SERVER)
+               return;

and not touching the EBP value then should at least match most of
our users and OEMs who want a "performance" setting out of the box and
set this on purpose.

Even nicer would be compile option to not touch this at all.

On Thursday, March 21, 2019 11:18:01 PM CET Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 
...

> + *
> + * Second, on many systems the initial EPB value coming from the platform
> + * firmware is 0 ('performance') and at least on some of them that is
> because + * the platform firmware does not initialize EPB

Why does the CPU not initialize this value to 6?
That would allow OEMs/BIOS to also suggest an init value for the system.
We should try to get microcode people or whoever is in charge to initialize
this value "properly" if Intel thinks 6 is the correct init value.

> at all with the
> assumption that + * the OS will do that anyway.  That sometimes is
> problematic, as it may cause + * the system battery to drain too fast, for
> example, so it is better to adjust + * it on CPU bring-up and if the
> initial EPB value for a given CPU is 0, the + * kernel changes it to 6
> ('normal').

I have an idea to let the kernel more decide about such policies.
It's a nice example that it makes sense to let the kernel set default values.
But not unconditionally, according to what the system is intended to do.

I wanted to do this for quite some time.., I hopefully find the time and
motivation now.

Thanks Rafael.
Sorry for the somewhat rude sounding previous mail, that was not on purpose.
You helped me quite a lot in the past and you obviously still do.

         Thomas
