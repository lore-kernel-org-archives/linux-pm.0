From: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v4 3/9] arm64/acpi: Create arch specific cpu to acpi id
 helper
Date: Mon, 20 Nov 2017 11:09:47 -0600
Message-ID: <7a435753-7058-7941-6c83-b21df54fa9de@arm.com>
References: <20171109210311.25655-1-jeremy.linton@arm.com>
 <20171109210311.25655-4-jeremy.linton@arm.com>
 <20171120170634.GB31395@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171120170634.GB31395@e107155-lin>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, devel@acpica.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 11/20/2017 11:06 AM, Sudeep Holla wrote:
> On Thu, Nov 09, 2017 at 03:03:05PM -0600, Jeremy Linton wrote:
>> Its helpful to be able to lookup the acpi_processor_id
>> associated with a logical cpu. Provide an arm64
>> helper to do this.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   arch/arm64/include/asm/acpi.h | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
>> index 59cca1d6ec54..408e7989d3a2 100644
>> --- a/arch/arm64/include/asm/acpi.h
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -86,6 +86,10 @@ static inline bool acpi_has_cpu_in_madt(void)
>>   }
>>   
>>   struct acpi_madt_generic_interrupt *acpi_cpu_get_madt_gicc(int cpu);
>> +static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
>> +{
>> +	return	acpi_cpu_get_madt_gicc(cpu)->uid;
>> +}
> 
> If I followed the series correctly, this function is used in 2/9 already.
> So this needs to be moved down in the series to avoid build failure during
> bisection.

I don't believe there is a bisection failure here because the code using 
this routine is not yet being compiled until the 4/9.
