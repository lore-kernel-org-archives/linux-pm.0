From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH] cpufreq/CPPC: Add MODULE_DEVICE_TABLE for cppc_cpufreq
 driver
Date: Mon, 14 Nov 2016 14:16:15 -0700
Message-ID: <9ed1a4bc-0e93-71e4-2224-a939f12ad08b@codeaurora.org>
References: <1476468023-6917-1-git-send-email-pprakash@codeaurora.org>
 <3532123.n0qt8sN7td@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33640 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753070AbcKNVQR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Nov 2016 16:16:17 -0500
In-Reply-To: <3532123.n0qt8sN7td@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, Hoan Tran <hotran@apm.com>, Christopher Covington <cov@codeaurora.org>, Al Stone <ahs3@redhat.com>


On 11/13/2016 5:21 PM, Rafael J. Wysocki wrote:
> On Friday, October 14, 2016 12:00:23 PM Prashanth Prakash wrote:
>> MODULE_DEVICE_TABLE is added so that CPPC cpufreq module can be
>> automatically loaded when we have a acpi processor device with
>> "ACPI0007" hid.
>>
>> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
>> ---
>>  drivers/cpufreq/cppc_cpufreq.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 4852d9e..e82bb3c 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -247,3 +247,10 @@ MODULE_DESCRIPTION("CPUFreq driver based on the ACPI CPPC v5.0+ spec");
>>  MODULE_LICENSE("GPL");
>>  
>>  late_initcall(cppc_cpufreq_init);
>> +
>> +static const struct acpi_device_id cppc_acpi_ids[] = {
>> +	{ACPI_PROCESSOR_DEVICE_HID, },
>> +	{}
>> +};
>> +
>> +MODULE_DEVICE_TABLE(acpi, cppc_acpi_ids);
> Applied.
Thanks Rafael!
