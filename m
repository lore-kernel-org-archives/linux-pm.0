From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [Patch v2] x86, ACPI, irq: Add a quirk to override SCI polarity
 for HyperV
Date: Wed, 19 Aug 2015 14:26:13 +0800
Message-ID: <55D42185.1000709@linux.intel.com>
References: <alpine.DEB.2.11.1508182133010.3873@nanos>
 <1439963634-12006-1-git-send-email-jiang.liu@linux.intel.com>
 <CAJZ5v0g7F+BRMzc9-uuxHAK896B-hoOJ5AW7M4jGpowVG+hujw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0g7F+BRMzc9-uuxHAK896B-hoOJ5AW7M4jGpowVG+hujw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Nick Meier <nmeier@microsoft.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2015/8/19 14:04, Rafael J. Wysocki wrote:
> Hi,
> 
> On Wed, Aug 19, 2015 at 7:53 AM, Jiang Liu <jiang.liu@linux.intel.com> wrote:
>> Nick Meier reported a regression with HyperV that "
>>   After rebooting the VM, the following messages are logged in syslog
>>   when trying to load the tulip driver:
>>     tulip: Linux Tulip drivers version 1.1.15 (Feb 27, 2007)
>>     tulip: 0000:00:0a.0: PCI INT A: failed to register GSI
>>     tulip: Cannot enable tulip board #0, aborting
>>     tulip: probe of 0000:00:0a.0 failed with error -16
>>   Errors occur in 3.19.0 kernel
>>   Works in 3.17 kernel.
>> "
>>
>> According to the ACPI dump file posted by Nick at
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1440072
>>
>> The ACPI MADT table includes an interrupt source overridden entry for
>> ACPI SCI:
>> [236h 0566  1]                Subtable Type : 02 <Interrupt Source Override>
>> [237h 0567  1]                       Length : 0A
>> [238h 0568  1]                          Bus : 00
>> [239h 0569  1]                       Source : 09
>> [23Ah 0570  4]                    Interrupt : 00000009
>> [23Eh 0574  2]        Flags (decoded below) : 000D
>>                                    Polarity : 1
>>                                Trigger Mode : 3
>>
>> And in DSDT table, we have _PRT method to define PCI interrupts, which
>> eventually goes to:
>>         Name (PRSA, ResourceTemplate ()
>>         {
>>             IRQ (Level, ActiveLow, Shared, )
>>                 {3,4,5,7,9,10,11,12,14,15}
>>         })
>>         Name (PRSB, ResourceTemplate ()
>>         {
>>             IRQ (Level, ActiveLow, Shared, )
>>                 {3,4,5,7,9,10,11,12,14,15}
>>         })
>>         Name (PRSC, ResourceTemplate ()
>>         {
>>             IRQ (Level, ActiveLow, Shared, )
>>                 {3,4,5,7,9,10,11,12,14,15}
>>         })
>>         Name (PRSD, ResourceTemplate ()
>>         {
>>             IRQ (Level, ActiveLow, Shared, )
>>                 {3,4,5,7,9,10,11,12,14,15}
>>         })
>>
>> According to the MADT and DSDT tables above, IRQ 9 may be used for:
>> 1) ACPI SCI in level, high mode
>> 2) PCI legacy IRQ in level, low mode
>> So there's a possible conflict in polarity setting for IRQ 9.
>>
>> Prior to commit cd68f6bd53cf ("x86, irq, acpi: Get rid of special
>> handling of GSI for ACPI SCI"), ACPI SCI is handled specially and
>> there's no check for conflicts between ACPI SCI and PCI legagy IRQ.
>> And it seems that the HyperV hypervisor doesn't make use of the
>> polarity configuration in IOAPIC entry, so it just works.
> 
> That likely means the previous behavior was the same as (or at least
> analogous to) what happens on Windows which is what the firmware has
> been tested against and that's why the bug in it has not been caught.
> That in turn indicates that there may be more systems having this kind
> of problems, possibly from other vendors too, so I'm wondering if we
> can do something more generic than using a quirk here?
Hi Rafael,
	Good question. I was thought only virtual machines may generate
such fake ACPI tables with conflicting pin attribute settings. For bare
metal systems, I guess BIOS writers should report the correct hardware
configurations, otherwise wrong pin attributes may cause hardware
malfunction.
	If that's not the case, we may try to revert cd68f6bd53cf
instead.
Thanks!
Gerry
