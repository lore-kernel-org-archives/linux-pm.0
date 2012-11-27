From: =?UTF-8?B?UmFmYcWCIEJpbHNraQ==?= <rafalbilski@interia.pl>
Subject: Re: [PATCH] Longhaul: Disable driver by default
Date: Tue, 27 Nov 2012 23:38:01 +0000
Message-ID: <50B54ED9.3090704@interia.pl>
References: <1354054435-2459-1-git-send-email-rafalbilski@interia.pl> <1997813.IluQxocScm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1997813.IluQxocScm@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Dave Jones <davej@redhat.com>
List-Id: linux-pm@vger.kernel.org


> On Tuesday, November 27, 2012 10:13:55 PM Rafal Bilski wrote:
>> This is only solution I can think of. User decides if he wants this
>> driver on his machine. I don't have enough knowledge and time to find
>> the reason why same code works on some machines and doesn't on others
>> which use same, or very similar,  chipset and processor.
> I always have problems with patches like this one, because they are pretty much
> guaranteed to make someone complain.
>
> Is there any way to blacklist the affected machine you have?
>
> Rafael
No. Also problem seems to be larger than one machine. Also weirder.
One user claims his processor can't run below some frequency even
if it should be perfectly capable of doing so. System in question
freezes straight away. In past on good system I could change
frequency at least a couple of times without any protection. Just by
a chance. I tried to investigate "weird CPU 0 not listed by the BIOS"
message, but I have nothing. Also I seem to have far less time for
anything than in the past.

Sorry
Rafal

>
>
>> Signed-off-by: Rafal Bilski <rafalbilski@interia.pl>
>>
>> ---
>>   drivers/cpufreq/longhaul.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
>> index 53ddbc7..0bf5bd1 100644
>> --- a/drivers/cpufreq/longhaul.c
>> +++ b/drivers/cpufreq/longhaul.c
>> @@ -77,7 +77,7 @@ static unsigned int longhaul_index;
>>   static int scale_voltage;
>>   static int disable_acpi_c3;
>>   static int revid_errata;
>> -
>> +static int enable;
>>   
>>   /* Clock ratios multiplied by 10 */
>>   static int mults[32];
>> @@ -965,6 +965,10 @@ static int __init longhaul_init(void)
>>   	if (!x86_match_cpu(longhaul_id))
>>   		return -ENODEV;
>>   
>> +	if (!enable) {
>> +		printk(KERN_ERR PFX "Option \"enable\" not set. Aborting.\n");
>> +		return -ENODEV;
>> +	}
>>   #ifdef CONFIG_SMP
>>   	if (num_online_cpus() > 1) {
>>   		printk(KERN_ERR PFX "More than 1 CPU detected, "
>> @@ -1021,6 +1025,10 @@ MODULE_PARM_DESC(scale_voltage, "Scale voltage of processor");
>>    * such. */
>>   module_param(revid_errata, int, 0644);
>>   MODULE_PARM_DESC(revid_errata, "Ignore CPU Revision ID");
>> +/* By default driver is disabled to prevent incompatible
>> + * system freeze. */
>> +module_param(enable, int, 0644);
>> +MODULE_PARM_DESC(enable, "Enable driver");
>>   
>>   MODULE_AUTHOR("Dave Jones <davej@redhat.com>");
>>   MODULE_DESCRIPTION("Longhaul driver for VIA Cyrix processors.");
>>

