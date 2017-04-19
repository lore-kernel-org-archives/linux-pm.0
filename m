From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v6 2/5] ACPI: battery: Fix acpi_battery_exit on
 acpi_battery_init_async errors
Date: Wed, 19 Apr 2017 10:43:17 +0200
Message-ID: <aaaabcb5-421b-aa22-f5b5-a28fbbc2d5c6@redhat.com>
References: <20170418115842.16214-1-hdegoede@redhat.com>
 <20170418115842.16214-3-hdegoede@redhat.com>
 <CAJZ5v0g4h6zWg8FxoUhyshyVGpzbyi+4w7H95HHt9b9quv7anw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0g4h6zWg8FxoUhyshyVGpzbyi+4w7H95HHt9b9quv7anw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, Robert Moore <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 18-04-17 15:36, Rafael J. Wysocki wrote:
> On Tue, Apr 18, 2017 at 1:58 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> The acpi_lock_battery_dir() / acpi_bus_register_driver() calls in
>> acpi_battery_init_async() may fail. Check that they succeeded before
>> undoing them.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/acpi/battery.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
>> index 4ef1e46..b35fca4 100644
>> --- a/drivers/acpi/battery.c
>> +++ b/drivers/acpi/battery.c
>> @@ -67,6 +67,7 @@ MODULE_DESCRIPTION("ACPI Battery Driver");
>>  MODULE_LICENSE("GPL");
>>
>>  static async_cookie_t async_cookie;
>> +static bool battery_driver_registered;
>>  static int battery_bix_broken_package;
>>  static int battery_notification_delay_ms;
>>  static unsigned int cache_time = 1000;
>> @@ -1329,6 +1330,7 @@ static void __init acpi_battery_init_async(void *unused, async_cookie_t cookie)
>>         if (result < 0)
>>                 acpi_unlock_battery_dir(acpi_battery_dir);
>>  #endif
>> +       battery_driver_registered = (result == 0);
>
> Maybe
>
>       battery_driver_registered = !result;

I prefer == 0 here because we are checking for success (which is 0)
not for "not true".

Regards,

Hans



>
>>  }
>>
>>  static int __init acpi_battery_init(void)
>> @@ -1343,9 +1345,11 @@ static int __init acpi_battery_init(void)
>>  static void __exit acpi_battery_exit(void)
>>  {
>>         async_synchronize_cookie(async_cookie + 1);
>> -       acpi_bus_unregister_driver(&acpi_battery_driver);
>> +       if (battery_driver_registered)
>> +               acpi_bus_unregister_driver(&acpi_battery_driver);
>>  #ifdef CONFIG_ACPI_PROCFS_POWER
>> -       acpi_unlock_battery_dir(acpi_battery_dir);
>> +       if (acpi_battery_dir)
>> +               acpi_unlock_battery_dir(acpi_battery_dir);
>>  #endif
>>  }
>
> Thanks,
> Rafael
>
