From: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v5 3/9] ACPI: Enable PPTT support on ARM64
Date: Fri, 5 Jan 2018 15:58:26 -0600
Message-ID: <f0f8c79a-2ff2-abe9-4a16-79485f0a1e2c@arm.com>
References: <20171201222330.18863-1-jeremy.linton@arm.com>
 <20171201222330.18863-4-jeremy.linton@arm.com>
 <20171213172647.GA3316@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171213172647.GA3316@red-moon>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 12/13/2017 11:26 AM, Lorenzo Pieralisi wrote:
> On Fri, Dec 01, 2017 at 04:23:24PM -0600, Jeremy Linton wrote:
>> Now that we have a PPTT parser, in preparation for its use
>> on arm64, lets build it.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   arch/arm64/Kconfig    | 1 +
>>   drivers/acpi/Kconfig  | 3 +++
>>   drivers/acpi/Makefile | 1 +
>>   3 files changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index a93339f5178f..e62fd1e08c1f 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -7,6 +7,7 @@ config ARM64
>>   	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>>   	select ACPI_MCFG if ACPI
>>   	select ACPI_SPCR_TABLE if ACPI
>> +	select ACPI_PPTT if ACPI
>>   	select ARCH_CLOCKSOURCE_DATA
>>   	select ARCH_HAS_DEBUG_VIRTUAL
>>   	select ARCH_HAS_DEVMEM_IS_ALLOWED
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index 46505396869e..df7aebf0af0e 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -545,6 +545,9 @@ config ACPI_CONFIGFS
>>   
>>   if ARM64
>>   source "drivers/acpi/arm64/Kconfig"
>> +
>> +config ACPI_PPTT
>> +	bool
> 
> We need to make a choice here. Either PPTT is considered ARM64 only and
> we move code and config to drivers/acpi/arm64/Kconfig or we leave it in
> drivers/acpi/pptt.c and we add a Kconfig entry in drivers/acpi/Kconfig
> (and we make pptt.c compile on !ARM64 - which is what it should be given
> that there is nothing ARM64 specific in it).

No one else has expressed and opinion about this here..

So i'm not sure what to think.

OTOH a lot of people didn't like it when I had it in the arm64 
directory, which was my original opinion. It seems other people thought 
that at some point in the future other ACPI platforms would want to use 
it so putting it in the arm64 directory was a mistake.

So, I'm leaning towards leaving it like it is, under the assumption that 
when someone puts in the effort to verify it on another ACPI platform 
they can move the config option up 6 lines. In the meantime I don't 
think it should be enabled on platforms where it hasn't been tested or 
is basically blocked (cpu_cacheinfo->cpu_map_populated) from executing 
or there isn't currently any benefit.

Hence I'm planning on leaving it as is until I get further clarity.


> 
> Lorenzo
> 
>>   endif
>>   
>>   config TPS68470_PMIC_OPREGION
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> index 41954a601989..b6056b566df4 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -87,6 +87,7 @@ obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
>>   obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
>>   obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
>>   obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
>> +obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
>>   
>>   # processor has its own "processor." module_param namespace
>>   processor-y			:= processor_driver.o
>> -- 
>> 2.13.5
>>

