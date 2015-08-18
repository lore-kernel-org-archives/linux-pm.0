From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Patch v1] x86, ACPI, irq: Fix a regression caused by
Date: Tue, 18 Aug 2015 21:36:02 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1508182133010.3873@nanos>
References: <1439110710-26498-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1439110710-26498-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Nick Meier <nmeier@microsoft.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun, 9 Aug 2015, Jiang Liu wrote:
> Nick Meier reported a regression with HyperV that "
>   After rebooting the VM, the following messages are logged in syslog
>   when trying to load the tulip driver:
>     tulip: Linux Tulip drivers version 1.1.15 (Feb 27, 2007)
>     tulip: 0000:00:0a.0: PCI INT A: failed to register GSI
>     tulip: Cannot enable tulip board #0, aborting
>     tulip: probe of 0000:00:0a.0 failed with error -16
>   Errors occur in 3.19.0 kernel
>   Works in 3.17 kernel.
> "
> 
> According to the ACPI dump file posted by Nick at
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1440072
> 
> The ACPI MADT table includes an interrupt source overridden entry for
> ACPI SCI:
> [236h 0566  1]                Subtable Type : 02 <Interrupt Source Override>
> [237h 0567  1]                       Length : 0A
> [238h 0568  1]                          Bus : 00
> [239h 0569  1]                       Source : 09
> [23Ah 0570  4]                    Interrupt : 00000009
> [23Eh 0574  2]        Flags (decoded below) : 000D
>                                    Polarity : 1
>                                Trigger Mode : 3
> That means ACPI SCI interrupt(Interrupt : 00000009) works in
> level(Trigger Mode : 3), high(Polarity : 1) mode.
> 
> And in DSDT table, we have _PRT method to define PCI interrupts, which
> eventually goes to:
>         Name (PRSA, ResourceTemplate ()
>         {
>             IRQ (Level, ActiveLow, Shared, )
>                 {3,4,5,7,9,10,11,12,14,15}
>         })
>         Name (PRSB, ResourceTemplate ()
>         {
>             IRQ (Level, ActiveLow, Shared, )
>                 {3,4,5,7,9,10,11,12,14,15}
>         })
>         Name (PRSC, ResourceTemplate ()
>         {
>             IRQ (Level, ActiveLow, Shared, )
>                 {3,4,5,7,9,10,11,12,14,15}
>         })
>         Name (PRSD, ResourceTemplate ()
>         {
>             IRQ (Level, ActiveLow, Shared, )
>                 {3,4,5,7,9,10,11,12,14,15}
>         })
> which means it's also possible to use IRQ9 for PCI interrupt, but works
> in Level, ActiveLow mode. So it conflicts with ACPI SCI interrupt source
> overriddern.
>
> So implement a quirk to correct interrupt attribute for HyperV SCI
> interrupt. Nick reports the proposed patch fixes the regression as "
>   Applied the above proposed patch with the DMI values substituted.
>   The tulip driver loaded, and an address was assigned via DHCP.
> "
> Please refer to following links for more information:
> https://bugzilla.kernel.org/show_bug.cgi?id=101301
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1440072
> 
> Fixes: cd68f6bd53cf ("x86, irq, acpi: Get rid of special handling of GSI for ACPI SCI")

I have a hard time to understand WHY that particular patch actually
caused that regression, WHY the original code worked with this weird
ACPI table and WHY we are better off with a quirk for this case.

Can you please elaborate?

Thanks,

	tglx
