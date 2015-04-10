From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [PATCH] x86/ACPI: Fix regression caused by 16ee7b3dcc56
Date: Fri, 10 Apr 2015 09:56:28 +0800
Message-ID: <55272DCC.1010900@linux.intel.com>
References: <55214A0D.9000404@xs4all.nl> <1428417244-32416-1-git-send-email-jiang.liu@linux.intel.com> <55240A82.30101@xs4all.nl> <5524BBEA.5040701@linux.intel.com> <55254E6E.6000705@xs4all.nl> <5526513C.9090200@linux.intel.com> <5526ABA9.1000700@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:65283 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753356AbbDJB4f (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 9 Apr 2015 21:56:35 -0400
In-Reply-To: <5526ABA9.1000700@xs4all.nl>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jim Bos <jim876@xs4all.nl>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org

On 2015/4/10 0:41, Jim Bos wrote:
> On 04/09/2015 12:15 PM, Jiang Liu wrote:
>> On 2015/4/8 23:51, Jim Bos wrote:
>>> On 04/08/2015 07:26 AM, Jiang Liu wrote:
>>>> On 2015/4/8 0:49, Jim Bos wrote:
>>>>> On 04/07/2015 04:34 PM, Jiang Liu wrote:
<snip>
>> Hi Jim,
>> 	I'm really confused. I can't even explain why my previous
>> patch fixes the issue on AMD geode board now:(
>>
>> For the Dell laptop, seems you have:
>> 1) build a kernel with Local APIC and IOAPIC enabled
>> 2) lapic is disabled by BIOS, so there's no ACPI MADT(APIC)
>> table at all.
>> That means the laptop is working with 8259 PICs only.
>> There's little change between 3.16 and 4.0 related to 8259.
>>
>> For the AMD geode board, I still think original code is right.
>> I can't explain why the patch fix the issue.
>>
>> So could you please help to:
>> 1) Try to enable lapic on Dell laptop in BIOS
>> 2) Dump acpi tables and dmesg on AMD board
>>
>> If that still doesn't help, I will try to send you some
>> debug patches to gather more info.
>> Thanks!
>> Gerry
>>> _
>>> Jim
>>>
>>
> 
> Gerry,
> 
> As you mentioned your patch shouldn't make a difference, run some more
> tests, as it turns out:
> - geode system  broken on 3.16+ up to and including 3.19, however, on
> plain 4.0-rc6 it works!  Root cause appears to be there isn't an ACPI
> interrupt assigned in non-working kernels.
> - other system I got my hands on: Pentium(R) CPU G3220, broken on 3.19.0
> when boot parameter 'nosmp' is specified, again no acpi entry in
> /proc/interrupts,  working fine on 4.0-rc6
> 
> So obviously between 3.19 and 4.0-rc6 something got fixed here!
Hi Jim,
Yes, the bugfix patch should be:
commit 1ea76fbadd66("x86/irq: Fix regression caused by commit b568b8601f05")

> The Dell laptop remains the only problem then on 4.0-rc6, there IS an
> acpi interrupt  (but firing once apparently).
> There isn't an option in BIOS to enable LAPIC, however, when specifying
> 'lapic' as boot parameter I got interesting result, still not working
> and /proc/interrups still shows XT-PIC.  Doing a diff between dmesg on
> 3.19 and 4.0-rc6 this pops out:
> 
> -Local APIC disabled by BIOS -- you can enable it with "lapic"
> -APIC: disable apic facility
> -APIC: switched to apic NOOP
> +Local APIC disabled by BIOS -- reenabling.
> +Found and enabled local APIC!
> 
> +Enabling APIC mode:  Flat.  Using 0 I/O APICs
What's the last know working kernel for Dell laptop?
Does it work as expected with v3.19 kernel?
Do you means this message is from plain v4.0-rc6 kernel?
Thanks!
Gerry

> 
> Jim
> 
