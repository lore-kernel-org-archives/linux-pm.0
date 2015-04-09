From: Jim Bos <jim876@xs4all.nl>
Subject: Re: [PATCH] x86/ACPI: Fix regression caused by 16ee7b3dcc56
Date: Thu, 09 Apr 2015 18:41:13 +0200
Message-ID: <5526ABA9.1000700@xs4all.nl>
References: <55214A0D.9000404@xs4all.nl> <1428417244-32416-1-git-send-email-jiang.liu@linux.intel.com> <55240A82.30101@xs4all.nl> <5524BBEA.5040701@linux.intel.com> <55254E6E.6000705@xs4all.nl> <5526513C.9090200@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lb3-smtp-cloud2.xs4all.net ([194.109.24.29]:50457 "EHLO
	lb3-smtp-cloud2.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755704AbbDIQlT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Apr 2015 12:41:19 -0400
In-Reply-To: <5526513C.9090200@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org

On 04/09/2015 12:15 PM, Jiang Liu wrote:
> On 2015/4/8 23:51, Jim Bos wrote:
>> On 04/08/2015 07:26 AM, Jiang Liu wrote:
>>> On 2015/4/8 0:49, Jim Bos wrote:
>>>> On 04/07/2015 04:34 PM, Jiang Liu wrote:
>>>>> Hi Jim,
>>>>> 	Could you please help to test this patch against v4.0-rc6?
>>>>> Thanks!
>>>>> Gerry
>>>>>
>>>>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>>>>> ---
>>>>>  arch/x86/kernel/acpi/boot.c |   10 +++++++---
>>>>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
>>>>> index 803b684676ff..f7f1fe7cd1b0 100644
>>>>> --- a/arch/x86/kernel/acpi/boot.c
>>>>> +++ b/arch/x86/kernel/acpi/boot.c
>>>>> @@ -403,10 +403,14 @@ static int mp_config_acpi_gsi(struct device *dev, u32 gsi, int trigger,
>>>>>  static int mp_register_gsi(struct device *dev, u32 gsi, int trigger,
>>>>>  			   int polarity)
>>>>>  {
>>>>> -	int irq, node;
>>>>> +	int i, irq, node;
>>>>>  
>>>>> -	if (acpi_irq_model != ACPI_IRQ_MODEL_IOAPIC)
>>>>> -		return gsi;
>>>>> +	if (acpi_irq_model != ACPI_IRQ_MODEL_IOAPIC) {
>>>>> +		for (i = 0; i < nr_legacy_irqs(); i++)
>>>>> +			if (isa_irq_to_gsi[i] == gsi)
>>>>> +				return i;
>>>>> +		return -1;
>>>>> +	}
>>>>>  
>>>>>  	trigger = trigger == ACPI_EDGE_SENSITIVE ? 0 : 1;
>>>>>  	polarity = polarity == ACPI_ACTIVE_HIGH ? 0 : 1;
>>>>>
>>>>
>>>> Jiang,
>>>>
>>>> It definitely seems to be an improvement, using Virtualbox guest with
>>>> your patch applied acpi-events work for all combinations (smp/nosmp
>>>> with/without I/O APIC assigned to the guest).
>>>>
>>>> However, on the Dell laptop it still doesn't work.  To be sure I built a
>>>> 3.16 kernel on this laptop and acpi_event power-button lid close/open
>>>> are working just fine.
>>>>
>>>> Attached config + dmesg + cat /proc/interrupt for the working 3.16 case
>>>> and still not working 4.0-rc6+patch case.
>>> Hi Jim,
>>> 	According to the attached files, you are building a UP kernel
>>> with IOAPIC enabled. This configuration works well on my HP laptop.
>>> And according to file IRQs from 4.0-rc6, it shows:
>>>  9:          1    XT-PIC  acpi
>>> That means kernel has received one ACPI SCI interrupt, but no
>>> following-on ACPI SCI interrupts, I can't figure out the root cause yet.
>>>
>>> So could you please help to dump ACPI tables from your dell laptop by
>>> using acpidump utility?
>>> Thanks!
>>> Gerry
>>>
>>>>
>>>> Thanks,
>>>> Jim
>>>>
>>
>> Gerry,
>>
>> Attached acpidump (binary files and regular dump).
>> I just tested 4.0-rc6+your_patch on another single core system, AMD
>> geode board, and that works fine now!
>> So indeed it seems there is something special about the dell laptop as
>> that's the only system, I've available here, which still has an issue.
> Hi Jim,
> 	I'm really confused. I can't even explain why my previous
> patch fixes the issue on AMD geode board now:(
> 
> For the Dell laptop, seems you have:
> 1) build a kernel with Local APIC and IOAPIC enabled
> 2) lapic is disabled by BIOS, so there's no ACPI MADT(APIC)
> table at all.
> That means the laptop is working with 8259 PICs only.
> There's little change between 3.16 and 4.0 related to 8259.
> 
> For the AMD geode board, I still think original code is right.
> I can't explain why the patch fix the issue.
> 
> So could you please help to:
> 1) Try to enable lapic on Dell laptop in BIOS
> 2) Dump acpi tables and dmesg on AMD board
> 
> If that still doesn't help, I will try to send you some
> debug patches to gather more info.
> Thanks!
> Gerry
>> _
>> Jim
>>
> 

Gerry,

As you mentioned your patch shouldn't make a difference, run some more
tests, as it turns out:
- geode system  broken on 3.16+ up to and including 3.19, however, on
plain 4.0-rc6 it works!  Root cause appears to be there isn't an ACPI
interrupt assigned in non-working kernels.
- other system I got my hands on: Pentium(R) CPU G3220, broken on 3.19.0
when boot parameter 'nosmp' is specified, again no acpi entry in
/proc/interrupts,  working fine on 4.0-rc6

So obviously between 3.19 and 4.0-rc6 something got fixed here!

The Dell laptop remains the only problem then on 4.0-rc6, there IS an
acpi interrupt  (but firing once apparently).
There isn't an option in BIOS to enable LAPIC, however, when specifying
'lapic' as boot parameter I got interesting result, still not working
and /proc/interrups still shows XT-PIC.  Doing a diff between dmesg on
3.19 and 4.0-rc6 this pops out:

-Local APIC disabled by BIOS -- you can enable it with "lapic"
-APIC: disable apic facility
-APIC: switched to apic NOOP
+Local APIC disabled by BIOS -- reenabling.
+Found and enabled local APIC!

+Enabling APIC mode:  Flat.  Using 0 I/O APICs

Jim

