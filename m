From: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v3 2/7] ACPI: Enable PPTT support on ARM64
Date: Wed, 18 Oct 2017 12:38:46 -0500
Message-ID: <889154d0-ed39-1621-83ee-1084674ee963@arm.com>
References: <20171012194856.13844-1-jeremy.linton@arm.com>
 <20171012194856.13844-3-jeremy.linton@arm.com>
 <20171018164723.GA15924@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171018164723.GA15924@red-moon>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On 10/18/2017 11:47 AM, Lorenzo Pieralisi wrote:
> On Thu, Oct 12, 2017 at 02:48:51PM -0500, Jeremy Linton wrote:
>> Now that we have a PPTT parser, in preparation for its use
>> on arm64, lets build it.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   arch/arm64/Kconfig         | 1 +
>>   drivers/acpi/Makefile      | 1 +
>>   drivers/acpi/arm64/Kconfig | 3 +++
>>   3 files changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 0df64a6a56d4..68c9d1289735 100644
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
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> index 90265ab4437a..c92a0c937551 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -85,6 +85,7 @@ obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
>>   obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
>>   obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
>>   obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
>> +obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
>>   
>>   # processor has its own "processor." module_param namespace
>>   processor-y			:= processor_driver.o
>> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
>> index 5a6f80fce0d6..74b855a669ea 100644
>> --- a/drivers/acpi/arm64/Kconfig
>> +++ b/drivers/acpi/arm64/Kconfig
>> @@ -7,3 +7,6 @@ config ACPI_IORT
>>   
>>   config ACPI_GTDT
>>   	bool
>> +
>> +config ACPI_PPTT
>> +	bool
>> \ No newline at end of file
> 
> I do not understand the logic. Why should we have a Kconfig option
> in drivers/acpi/arm64 for code in drivers/acpi ?
> 
> AFAIK PPTT is not an ACPI ARM64 specific binding.

Weird hu? Originally I had the whole shebang in arm64 because the x86 
(or whatever) bindings have not been written. My assumption is that once 
that part had been provided it could be moved.

The config is sort of an artifact and "easier" to move than the whole 
file. But, as Hanjun has also been complaining about it I've agreed to 
move it to the "correct" location but keep it in the arm64 wrapper. Of 
course I think that is a bit strange too, but whatever...

Once the arm64 side of things are all wrapped up (and I can come up for 
some air) I willing to help with bindings on other architectures if 
anyone is truly interested.  But, I view that whole exercise as more a 
"bug" fixing one than providing any real benefit at this point.

