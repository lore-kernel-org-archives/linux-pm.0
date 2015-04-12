From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] x86/ACPI: Fix regression caused by 16ee7b3dcc56 & c50f13c672df7
Date: Sun, 12 Apr 2015 03:29:13 +0200
Message-ID: <4609072.Iu0n90PHbM@vostro.rjw.lan>
References: <55214A0D.9000404@xs4all.nl> <55272DCC.1010900@linux.intel.com> <552938F6.8020601@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58218 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750889AbbDLBEo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 11 Apr 2015 21:04:44 -0400
In-Reply-To: <552938F6.8020601@xs4all.nl>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jim Bos <jim876@xs4all.nl>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org

On Saturday, April 11, 2015 05:08:38 PM Jim Bos wrote:
> On 04/10/2015 03:56 AM, Jiang Liu wrote:
> > On 2015/4/10 0:41, Jim Bos wrote:
> >> On 04/09/2015 12:15 PM, Jiang Liu wrote:
> >>> On 2015/4/8 23:51, Jim Bos wrote:
> >>>> On 04/08/2015 07:26 AM, Jiang Liu wrote:
> >>>>> On 2015/4/8 0:49, Jim Bos wrote:
> >>>>>> On 04/07/2015 04:34 PM, Jiang Liu wrote:
> > <snip>
> >>> Hi Jim,
> >>> 	I'm really confused. I can't even explain why my previous
> >>> patch fixes the issue on AMD geode board now:(
> >>>
> >>> For the Dell laptop, seems you have:
> >>> 1) build a kernel with Local APIC and IOAPIC enabled
> >>> 2) lapic is disabled by BIOS, so there's no ACPI MADT(APIC)
> >>> table at all.
> >>> That means the laptop is working with 8259 PICs only.
> >>> There's little change between 3.16 and 4.0 related to 8259.
> >>>
> >>> For the AMD geode board, I still think original code is right.
> >>> I can't explain why the patch fix the issue.
> >>>
> >>> So could you please help to:
> >>> 1) Try to enable lapic on Dell laptop in BIOS
> >>> 2) Dump acpi tables and dmesg on AMD board
> >>>
> >>> If that still doesn't help, I will try to send you some
> >>> debug patches to gather more info.
> >>> Thanks!
> >>> Gerry
> >>>> _
> >>>> Jim
> >>>>
> >>>
> >>
> >> Gerry,
> >>
> >> As you mentioned your patch shouldn't make a difference, run some more
> >> tests, as it turns out:
> >> - geode system  broken on 3.16+ up to and including 3.19, however, on
> >> plain 4.0-rc6 it works!  Root cause appears to be there isn't an ACPI
> >> interrupt assigned in non-working kernels.
> >> - other system I got my hands on: Pentium(R) CPU G3220, broken on 3.19.0
> >> when boot parameter 'nosmp' is specified, again no acpi entry in
> >> /proc/interrupts,  working fine on 4.0-rc6
> >>
> >> So obviously between 3.19 and 4.0-rc6 something got fixed here!
> > Hi Jim,
> > Yes, the bugfix patch should be:
> > commit 1ea76fbadd66("x86/irq: Fix regression caused by commit b568b8601f05")
> > 
> >> The Dell laptop remains the only problem then on 4.0-rc6, there IS an
> >> acpi interrupt  (but firing once apparently).
> >> There isn't an option in BIOS to enable LAPIC, however, when specifying
> >> 'lapic' as boot parameter I got interesting result, still not working
> >> and /proc/interrups still shows XT-PIC.  Doing a diff between dmesg on
> >> 3.19 and 4.0-rc6 this pops out:
> >>
> >> -Local APIC disabled by BIOS -- you can enable it with "lapic"
> >> -APIC: disable apic facility
> >> -APIC: switched to apic NOOP
> >> +Local APIC disabled by BIOS -- reenabling.
> >> +Found and enabled local APIC!
> >>
> >> +Enabling APIC mode:  Flat.  Using 0 I/O APICs
> > What's the last know working kernel for Dell laptop?
> > Does it work as expected with v3.19 kernel?
> > Do you means this message is from plain v4.0-rc6 kernel?
> > Thanks!
> > Gerry
> > 
> >>
> >> Jim
> >>
> > 
> 
> Gerry, Rafael,
> 
> Ok, found it.
> It was very 'interesting' bisect, because there were 2 overlapping
> issues here.  On the Dell laptop some kernels there wasn't an ACPI
> interrupt at all or it fired once and then seemed to get stuck.
> Turns out that kernel version:
> 3.16: OK
> 3.17: Broken (no acpi interrupt)
> 3.18: actually fine
> 3.19: Broken
> 
> So started bisecting between 3.18 or 3.19, in the end found Rafael's
> patch which broke it:
> 
> ==
> commit c50f13c672df758b59e026c15b9118f3ed46edc4
> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Date:   Mon Dec 1 23:50:16 2014 +0100
> 
>     ACPICA: Save current masks of enabled GPEs after enable register writes
> ==
> 
> Reverting that patch on top of 4.0-rc7 (with some offsets and one
> trivial manual edit) and I finally got a working ACPI interrupt again!

That's unexpected.

Is system suspend/resume involved in the reproduction of the problem in any way?

In any case, does it help if you replace "enable_mask" with "enable_for_run"
in line 127 of drivers/acpi/acpica/hwgpe.c (without reverting the whole commit)?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
