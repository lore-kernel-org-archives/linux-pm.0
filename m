From: Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
Subject: Re: [PATCH] ACPI: processor: fix LPI when built as module
Date: Fri, 26 May 2017 12:21:57 +0200
Message-ID: <0d6edbd9-938c-a926-1480-c11de01ee38d@suse.com>
References: <20170519092837.30991-1-yousaf.kaukab@suse.com>
 <314aff9d-6c24-e533-ef08-c16bc0816474@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <314aff9d-6c24-e533-ef08-c16bc0816474@arm.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, catalin.marinas@arm.com, lorenzo.pieralisi@arm.com
List-Id: linux-pm@vger.kernel.org

On 5/23/17 3:08 PM, Sudeep Holla wrote:
> 
> 
> On 19/05/17 10:28, Mian Yousaf Kaukab wrote:
>> Low Power Idle(LPI) support added acpi_processor_ffh_lpi_probe() and
>> acpi_processor_ffh_lpi_enter() as __weak functions and arch code is
>> supposed to provide the actual callbacks. This breaks if
>> ACPI_PROCESSOR is configured as a module.
>>
>> Add CONFIG_ARCH_HAS_ACPI_LPI configuration option to fix this.
>>
> 
> Rafael didn't like the extra Kconfig option when I first posted
> LPI patches.
> 
>> Signed-off-by: Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
>> ---
>>   arch/arm64/Kconfig            | 1 +
>>   arch/arm64/kernel/cpuidle.c   | 2 ++
>>   drivers/acpi/Kconfig          | 3 +++
>>   drivers/acpi/processor_idle.c | 9 +++++++--
>>   4 files changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 848a34116c67..de2f2779cdf5 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -10,6 +10,7 @@ config ARM64
>>   	select ARCH_HAS_DEBUG_VIRTUAL
>>   	select ARCH_HAS_DEVMEM_IS_ALLOWED
>>   	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
>> +	select ARCH_HAS_ACPI_LPI if ACPI
>>   	select ARCH_HAS_ELF_RANDOMIZE
>>   	select ARCH_HAS_GCOV_PROFILE_ALL
>>   	select ARCH_HAS_GIGANTIC_PAGE if (MEMORY_ISOLATION && COMPACTION) || CMA
>> diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
>> index fd691087dc9a..002d9cb890bd 100644
>> --- a/arch/arm64/kernel/cpuidle.c
>> +++ b/arch/arm64/kernel/cpuidle.c
>> @@ -51,9 +51,11 @@ int acpi_processor_ffh_lpi_probe(unsigned int cpu)
>>   {
>>   	return arm_cpuidle_init(cpu);
>>   }
>> +EXPORT_SYMBOL(acpi_processor_ffh_lpi_probe);
>>   
>>   int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
>>   {
>>   	return CPU_PM_CPU_IDLE_ENTER(arm_cpuidle_suspend, lpi->index);
>>   }
>> +EXPORT_SYMBOL(acpi_processor_ffh_lpi_enter);
> 
> Won't these 2 export suffice ? [...]
No, they don't suffice.

> [...] I am just curious why that won't work.
I am not really sure. System.map shows the exported symbols as following:
ffff000008095898 T acpi_processor_ffh_lpi_probe
ffff0000080958f8 T acpi_processor_ffh_lpi_enter
ffff000008c19160 R __ksymtab_acpi_processor_ffh_lpi_enter
ffff000008c19170 R __ksymtab_acpi_processor_ffh_lpi_probe
ffff000008c357f0 r __kcrctab_acpi_processor_ffh_lpi_enter
ffff000008c357f8 r __kcrctab_acpi_processor_ffh_lpi_probe
ffff000008c4361b r __kstrtab_acpi_processor_ffh_lpi_enter
ffff000008c43638 r __kstrtab_acpi_processor_ffh_lpi_probe

and 'nm processor.ko' shows that they are defined as weak:

0000000000000d68 W acpi_processor_ffh_lpi_enter
0000000000000cc8 W acpi_processor_ffh_lpi_probe

But still weak symbols are happily used when the module is inserted.

> Will weak function definitions be still picked when built as modules ?
Yes.

BR,
Yousaf
