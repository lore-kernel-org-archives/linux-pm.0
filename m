From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 3/4] power: supply: axp288_fuel_gauge: Unregister
 duplicate ACPI battery supply
Date: Sat, 1 Apr 2017 15:22:54 +0200
Message-ID: <5d35214e-68ea-3abc-c5b9-ce44d592b541@redhat.com>
References: <20170316161601.32267-1-hdegoede@redhat.com>
 <CAJZ5v0i7TN+iJLR_SeaCrpKJ13g1_bQ-G54cugAF9Dm4=pifAg@mail.gmail.com>
 <0c1cc4fc-d127-54d1-334b-9a569354d2a3@redhat.com>
 <1577850.bTAv4lXM9l@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1577850.bTAv4lXM9l@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 01-04-17 00:30, Rafael J. Wysocki wrote:
> On Friday, March 31, 2017 11:57:47 AM Hans de Goede wrote:
>> Hi,
>
> Hi,
>
> [cut]
>
>>>
>>> Anyway, I'd prefer blacklists in the battery and ac drivers to be honest.
>>
>> As I explained in my reply to the discussion around the first patch that
>> is somewhat hard to do and requires encoding knowledge in those drivers
>> which really does not belong there:
>>
>> "The problem is that Intel re-uses HIDs between generations and
>> for the Whiskey Cove PMIC we want to not use the ACPI battery
>> and ac drivers on Cherry Trail (where they are known to be
>> broken) but things are different on Apollo Lake. Yet both
>> use the same HID for their companion Whiskey Cove PMIC even
>> though they are 2 completely different revisions of the PMIC
>> (e.g. one uses i2c the other does not).
>>
>> The 2 native drivers have code to detect which revision they
>> are dealing with and exit with -ENODEV if it is not the
>> revision they were written for, but this means that simple
>> HID blacklisting will not work. So IMHO the decision to
>> unregister the  ACPI battery / ac interface really belongs
>> in the native driver as that has all the nitty gritty detail
>> needed to make that decision."
>
> Do the native drivers bind to platform devices?

No, (yes, but not really) they are i2c drivers, but for cells of
mfd i2c devices, so under the hood they bind to platform devices.

Regards,

Hans
