From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/4] power: supply: axp288_fuel_gauge: Unregister
 duplicate ACPI battery supply
Date: Tue, 11 Apr 2017 15:51:03 +0200
Message-ID: <CAJZ5v0ih8UfsJH1uUjjeRPqo7-vrBR8ayc2q84qWcJ9y5QF-nw@mail.gmail.com>
References: <20170316161601.32267-1-hdegoede@redhat.com> <20170316161601.32267-4-hdegoede@redhat.com>
 <6382698.NuYXpb6L7h@aspire.rjw.lan> <0ed23626-b6b2-a42e-2a1d-762c8c833f7b@redhat.com>
 <CAJZ5v0h466y6hBy_-12AEgcpAUXEA7cZkNwXZwvsHnjWtoqFeg@mail.gmail.com>
 <eb52c4b4-fc3c-b11b-edef-a35c6bb0d82d@redhat.com> <CAJZ5v0i7TN+iJLR_SeaCrpKJ13g1_bQ-G54cugAF9Dm4=pifAg@mail.gmail.com>
 <0c1cc4fc-d127-54d1-334b-9a569354d2a3@redhat.com> <c62e0707-7415-9473-98cb-3741c4f258ff@redhat.com>
 <cb6ff75e-3ee8-fa34-82c2-ff1338c0048e@redhat.com> <c937143c-f112-7d49-dc11-1577d987b309@redhat.com>
 <CAJZ5v0i0pZwBvd1WFYxGh9grbDyRkYWoLY7VSn3+mbLZdmQnxw@mail.gmail.com> <2796ccd7-333c-848c-1409-2a76fb498d94@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <2796ccd7-333c-848c-1409-2a76fb498d94@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 11, 2017 at 11:18 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 10-04-17 22:01, Rafael J. Wysocki wrote:
>>
>> On Mon, Apr 10, 2017 at 8:13 PM, Hans de Goede <hdegoede@redhat.com>
>> wrote:
>

[cut]

>
> The reason I changed my mind on the blacklist approach and went
> from unregistering on native-power-supply register to the blacklist
> is because some users where seeing a ton of ACPI errors from the
> ACPI battery driver trying to use the broken ACPI battery dev in
> the DTSD before the native PMIC driver loaded and unregistered
> the battery dev. So I really believe the blacklist is the right
> approach.

Fair enough.

> I just got confirmation from the user that the regression on the
> Dell 5855 was indeed a false positive.
>
> So from my pov we are good to go with v5 of patch 1 of this
> set and v2 (also send as v3 and v4 but unchanged) of patches
> 2-4 of this set.

OK, but please resend the patches you're happy with afresh and let me
know what is superseded by them, so that I don't have to carry out any
research on that.

Thanks,
Rafael
