From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [PATCH] x86/ACPI: Fix regression caused by 16ee7b3dcc56
Date: Wed, 08 Apr 2015 13:26:02 +0800
Message-ID: <5524BBEA.5040701@linux.intel.com>
References: <55214A0D.9000404@xs4all.nl> <1428417244-32416-1-git-send-email-jiang.liu@linux.intel.com> <55240A82.30101@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55240A82.30101@xs4all.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Jim Bos <jim876@xs4all.nl>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2015/4/8 0:49, Jim Bos wrote:
> On 04/07/2015 04:34 PM, Jiang Liu wrote:
>> Hi Jim,
>> 	Could you please help to test this patch against v4.0-rc6?
>> Thanks!
>> Gerry
>>
>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>> ---
>>  arch/x86/kernel/acpi/boot.c |   10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
>> index 803b684676ff..f7f1fe7cd1b0 100644
>> --- a/arch/x86/kernel/acpi/boot.c
>> +++ b/arch/x86/kernel/acpi/boot.c
>> @@ -403,10 +403,14 @@ static int mp_config_acpi_gsi(struct device *dev, u32 gsi, int trigger,
>>  static int mp_register_gsi(struct device *dev, u32 gsi, int trigger,
>>  			   int polarity)
>>  {
>> -	int irq, node;
>> +	int i, irq, node;
>>  
>> -	if (acpi_irq_model != ACPI_IRQ_MODEL_IOAPIC)
>> -		return gsi;
>> +	if (acpi_irq_model != ACPI_IRQ_MODEL_IOAPIC) {
>> +		for (i = 0; i < nr_legacy_irqs(); i++)
>> +			if (isa_irq_to_gsi[i] == gsi)
>> +				return i;
>> +		return -1;
>> +	}
>>  
>>  	trigger = trigger == ACPI_EDGE_SENSITIVE ? 0 : 1;
>>  	polarity = polarity == ACPI_ACTIVE_HIGH ? 0 : 1;
>>
> 
> Jiang,
> 
> It definitely seems to be an improvement, using Virtualbox guest with
> your patch applied acpi-events work for all combinations (smp/nosmp
> with/without I/O APIC assigned to the guest).
> 
> However, on the Dell laptop it still doesn't work.  To be sure I built a
> 3.16 kernel on this laptop and acpi_event power-button lid close/open
> are working just fine.
> 
> Attached config + dmesg + cat /proc/interrupt for the working 3.16 case
> and still not working 4.0-rc6+patch case.
Hi Jim,
	According to the attached files, you are building a UP kernel
with IOAPIC enabled. This configuration works well on my HP laptop.
And according to file IRQs from 4.0-rc6, it shows:
 9:          1    XT-PIC  acpi
That means kernel has received one ACPI SCI interrupt, but no
following-on ACPI SCI interrupts, I can't figure out the root cause yet.

So could you please help to dump ACPI tables from your dell laptop by
using acpidump utility?
Thanks!
Gerry

> 
> Thanks,
> Jim
> 
> 
> 
> 
> 
> 
> 
