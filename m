From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 34/47] acpi: Register power-off handler with kernel
 power-off handler
Date: Mon, 27 Oct 2014 19:10:26 -0700
Message-ID: <544EFB12.1090901@roeck-us.net>
References: <1414425354-10359-1-git-send-email-linux@roeck-us.net> <1414425354-10359-35-git-send-email-linux@roeck-us.net> <5416859.0WlfjKo7zJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <5416859.0WlfjKo7zJ@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/27/2014 05:26 PM, Rafael J. Wysocki wrote:
> On Monday, October 27, 2014 08:55:41 AM Guenter Roeck wrote:
>> Register with kernel power-off handler instead of setting pm_power_off
>> directly. Register with high priority to reflect that the driver explicitly
>> overrides existing power-off handlers.
>
> Well, I'm still rather unconvinced that notifiers are particularly suitable for
> this purpose.
>
> Specifically ->
>

Fine.

>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Len Brown <lenb@kernel.org>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v3:
>> - Replace poweroff in all newly introduced variables and in text
>>    with power_off or power-off as appropriate
>> - Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
>> - Replace acpi: with ACPI: in log message
>> v2:
>> - Use define to specify poweroff handler priority
>> - Use pr_warn instead of pr_err
>>
>>   drivers/acpi/sleep.c | 15 +++++++++++++--
>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
>> index 05a31b5..7875b92 100644
>> --- a/drivers/acpi/sleep.c
>> +++ b/drivers/acpi/sleep.c
>> @@ -16,6 +16,8 @@
>>   #include <linux/device.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/suspend.h>
>> +#include <linux/notifier.h>
>> +#include <linux/pm.h>
>>   #include <linux/reboot.h>
>>   #include <linux/acpi.h>
>>   #include <linux/module.h>
>> @@ -827,14 +829,22 @@ static void acpi_power_off_prepare(void)
>>   	acpi_disable_all_gpes();
>>   }
>>
>> -static void acpi_power_off(void)
>> +static int acpi_power_off(struct notifier_block *this,
>> +			  unsigned long unused1, void *unused2)
>>   {
>
> -> Is there any reason why any notifier in the new chain would use the
> second argument for anything meaningful?  And the third argument for
> that matter?
>
>>   	/* acpi_sleep_prepare(ACPI_STATE_S5) should have already been called */
>>   	printk(KERN_DEBUG "%s called\n", __func__);
>>   	local_irq_disable();
>>   	acpi_enter_sleep_state(ACPI_STATE_S5);
>> +
>> +	return NOTIFY_DONE;
>
> Also is there any reason for any notifier in the new chain to return anything
> different from NOTIFY_DONE and if so, then what happens when anything else
> is returned?
>

As mentioned earlier, notifiers just come handy. That is all.

Having said that, I don't have a strong opinion either way. If you want me
to implement a priority based callback handler with a single argument,
just let me know and I'll be happy to implement it. It is not worth arguing
about.

Would something like

struct power_off_block {
	void (*power_off_call)(struct power_off_block *);
	struct power_off_block __rcu *next;
	int priority;
};

for the data structure be acceptable ? The power-off handler code would then
be something like

static void acpi_power_off(struct power_off_block *this)
{
}

ie quite similar to the current power-off handler code, with an added argument.
The API would, except for the structure argument, pretty much stay the same.

Thanks,
Guenter

