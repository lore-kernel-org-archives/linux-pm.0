From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH 1/1] x86, acpi: Fix wrong checking condition in acpi_register_lapic().
Date: Tue, 23 Jul 2013 15:55:31 +0800
Message-ID: <51EE36F3.2010308@cn.fujitsu.com>
References: <1374543541-4451-1-git-send-email-tangchen@cn.fujitsu.com> <20130723073950.GB13710@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130723073950.GB13710@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: len.brown@intel.com, pavel@ucw.cz, rjw@sisk.pl, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 07/23/2013 03:39 PM, Ingo Molnar wrote:
>
> * Tang Chen<tangchen@cn.fujitsu.com>  wrote:
>
>> We wanted to check if the acpi id is out of range. It should be:
>> 	if (id>= (MAX_LOCAL_APIC)).
>
> Does this have any practical impact, or can it wait until v3.12?

I haven't tested out any impact now, just found it when reading the code.
We can wait until v3.12.

>
>> Signed-off-by: Tang Chen<tangchen@cn.fujitsu.com>
>> ---
>>   arch/x86/kernel/acpi/boot.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
>> index d81a972..2a15ae7 100644
>> --- a/arch/x86/kernel/acpi/boot.c
>> +++ b/arch/x86/kernel/acpi/boot.c
>> @@ -199,7 +199,7 @@ static void __cpuinit acpi_register_lapic(int id, u8 enabled)
>>   {
>>   	unsigned int ver = 0;
>>
>> -	if (id>= (MAX_LOCAL_APIC-1)) {
>> +	if (id>= (MAX_LOCAL_APIC)) {
>
> The parentheses are now superfluous.

Oh, yes. I'll send a new version without the parentheses.

Thanks.
