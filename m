From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH 1/2] acpi: Use syscore instead of pm_power_off_prepare
 to prepare for poweroff
Date: Sun, 12 Oct 2014 12:35:22 -0700
Message-ID: <543AD7FA.5060706@roeck-us.net>
References: <1413062057-11657-1-git-send-email-linux@roeck-us.net> <1413062057-11657-2-git-send-email-linux@roeck-us.net> <3090667.ydmQKSGePB@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47458 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbaJLTfe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 12 Oct 2014 15:35:34 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XdOvV-000po7-Qn
	for linux-pm@vger.kernel.org; Sun, 12 Oct 2014 19:35:33 +0000
In-Reply-To: <3090667.ydmQKSGePB@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>

On 10/12/2014 12:45 PM, Rafael J. Wysocki wrote:
> On Saturday, October 11, 2014 02:14:16 PM Guenter Roeck wrote:
>> The syscore shutdown callback seems to be perfectly suited to prepare for system
>> poweroff. Use it instead of pm_power_off_prepare.
>
> How much testing did that receive?
>

As I mentioned in patch 0/2, compile tested so far only. Before I start playing
with my servers, I wanted to get some feedback if the idea is worth pursuing
further or if I am missing something essential. _If_ it should be worth pursuing
I'll test it with some real systems (servers + laptops) before resubmitting,
and also add log messages for that testing to ensure that acpi_shutdown
is actually called.

Guenter

>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Len Brown <len.brown@intel.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/acpi/sleep.c | 21 ++++++++++++++++-----
>>   1 file changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
>> index 05a31b5..e03c74d 100644
>> --- a/drivers/acpi/sleep.c
>> +++ b/drivers/acpi/sleep.c
>> @@ -17,6 +17,7 @@
>>   #include <linux/interrupt.h>
>>   #include <linux/suspend.h>
>>   #include <linux/reboot.h>
>> +#include <linux/syscore_ops.h>
>>   #include <linux/acpi.h>
>>   #include <linux/module.h>
>>   #include <asm/io.h>
>> @@ -820,13 +821,23 @@ int acpi_suspend(u32 acpi_state)
>>   	return -EINVAL;
>>   }
>>
>> -static void acpi_power_off_prepare(void)
>> +static void acpi_shutdown(void)
>>   {
>> -	/* Prepare to power off the system */
>> -	acpi_sleep_prepare(ACPI_STATE_S5);
>> -	acpi_disable_all_gpes();
>> +	switch (system_state) {
>> +	case SYSTEM_POWER_OFF:
>> +		/* Prepare to power off the system */
>> +		acpi_sleep_prepare(ACPI_STATE_S5);
>> +		acpi_disable_all_gpes();
>> +		break;
>> +	default:
>> +		break;
>> +	}
>>   }
>>
>> +static struct syscore_ops acpi_syscore_ops = {
>> +	.shutdown = acpi_shutdown,
>> +};
>> +
>>   static void acpi_power_off(void)
>>   {
>>   	/* acpi_sleep_prepare(ACPI_STATE_S5) should have already been called */
>> @@ -850,7 +861,7 @@ int __init acpi_sleep_init(void)
>>
>>   	if (acpi_sleep_state_supported(ACPI_STATE_S5)) {
>>   		sleep_states[ACPI_STATE_S5] = 1;
>> -		pm_power_off_prepare = acpi_power_off_prepare;
>> +		register_syscore_ops(&acpi_syscore_ops);
>>   		pm_power_off = acpi_power_off;
>>   	}
>>
>>
>

