From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] acpi: utils: Add new acpi_dev_present helper
Date: Thu, 30 Mar 2017 22:04:42 +0200
Message-ID: <CAJZ5v0ikLr_RSXtqdAUwp2=86d4nAZb6WXKiVEqir5LwWTyY5g@mail.gmail.com>
References: <20170316161736.339-1-hdegoede@redhat.com> <20170316161736.339-2-hdegoede@redhat.com>
 <4029834.c3GWUpRlkb@aspire.rjw.lan> <20170329092638.GU2957@lahna.fi.intel.com>
 <1490806252.708.53.camel@linux.intel.com> <20170330083341.GA10207@h08.hostsharing.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170330083341.GA10207@h08.hostsharing.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Robert Moore <robert.moore@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 30, 2017 at 10:33 AM, Lukas Wunner <lukas@wunner.de> wrote:
> [cc += Robert Moore]
>
> Hi Hans,
>
> I'm the author of acpi_dev_found(), please in the future use git blame
> to determine relevant authors of existing code that should be cc'ed,
> I noticed your patch only now:
>
> On Thursday, March 16, 2017 05:17:35 PM Hans de Goede wrote:
>> acpi_dev_found just iterates over all acpi-ids and sees if one matches.
>> This means that it will return true for devices which are in the dsdt
>> but disabled (their _STA method returns 0).
>>
>> For some drivers it is useful to be able to check if a certain hid
>> is not only present in the namespace, but also actually present as in
>> acpi_device_is_present() will return true for the device. For example
>> because if a certain device is present then the driver will want to use
>> an extcon or IIO adc channel provided by that device.
>>
>> This commit adds a new acpi_dev_present helper which drivers can use
>> to this end.
>>
>> Arguably acpi_dev_present is what acpi_dev_found should have been, but
>> there are too many users to just change acpi_dev_found without the risk
>> of breaking something.
>
> I originally did submit an acpi_dev_present() function which was identical
> to what you've submitted now:
> http://www.spinics.net/lists/linux-acpi/msg61865.html
>
> However Robert Moore raised an objection that "Traversing the namespace
> over and over is truly brute force":
> http://www.spinics.net/lists/linux-acpi/msg61911.html
>
> For my use case, which was apple_gmux_present(), just detecting presence
> of the HID in the namespace was sufficient, I did not have the need to
> execute _STA.  Hence to address Robert Moore's concern I switched to
> simply traversing the acpi_bus_id_list.
>
> Rafael objected to the acpi_dev_present() name as it suggested that _STA
> is checked even though it wasn't, so I renamed the function to
> acpi_dev_found() with commit c68ae33e7fb4.
>
> The objection raised by Robert Moore applies to your patch as well since
> it is identical to my original patch.

Good point, actually.

> The return value of _STA seems to
> be cached in the "status" field of struct acpi_device, so you may
> be able to overcome Robert Moore's objection by calling bus_find_device()
> with a callback which contains the check in acpi_device_is_present().
> See drivers/firmware/efi/dev-path-parser.c for an example (parse_acpi_path()
> and match_acpi_dev()).  This is probably faster than acpi_get_devices()
> because it just traverses a list instead of walking the namespace and it
> avoids the call to _STA.  (Some devices just return a constant when _STA
> is called, others may take more time.)

Yes, that would be preferred.

Thanks,
Rafael
