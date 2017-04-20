From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v7 0/5] ACPI: new acpi_dev_present helper + ac and battery
 blacklist patches
Date: Thu, 20 Apr 2017 12:38:43 +0200
Message-ID: <CAJZ5v0hm6JyMRF-RhPXye0uFfV0Uxyev+NWVKzn4v2dGt4Y-TA@mail.gmail.com>
References: <20170419120212.24949-1-hdegoede@redhat.com> <CAJZ5v0i1oFMaqRF85TzvEM_ZHAe+rUUXqRruy7aHY_PwGcCw0w@mail.gmail.com>
 <20170419203340.GI2619@lahna.fi.intel.com> <1492676409.24567.92.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:34591 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753843AbdDTKio (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2017 06:38:44 -0400
In-Reply-To: <1492676409.24567.92.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Lukas Wunner <lukas@wunner.de>, Robert Moore <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>

On Thu, Apr 20, 2017 at 10:20 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Wed, 2017-04-19 at 23:33 +0300, Mika Westerberg wrote:
>> On Wed, Apr 19, 2017 at 09:37:50PM +0200, Rafael J. Wysocki wrote:
>> > On Wed, Apr 19, 2017 at 2:02 PM, Hans de Goede <hdegoede@redhat.com>
>> > wrote:
>> > > Hi Rafael,
>> > >
>> > > This is a new version of my acpi_dev_present helper + ac and
>> > > battery
>> > > blacklist patches, new compared to the v5 resend of the latest
>> > > version of all these patches are some changes to the first,
>> > > third and fourth patch as requested by Andy Shevchenko.
>> > >
>> > > This set also includes a power-supply patch, which depends on the
>> > > new acpi_dev_present helper and has an Ack from Sebastian Reichel
>> > > (the power-supply maintainer) for being merged through the ACPI
>> > > tree because of that dependency.
>> > >
>> > > These patches obsolete:
>> > > -earlier versions of patches with the same title
>> > > -"ACPI: battery: Add acpi_battery_unregister() function"
>> > > -"ACPI: ac: Add acpi_ac_unregister() function"
>> > > -"power: supply: axp288_fuel_gauge: Unregister duplicate ACPI
>> > > battery supply"
>> > > -"power: supply: axp288_charger: Unregister duplicate ACPI ac
>> > > supply"
>> >
>> > Andy, Mika, any concerns about anything this series?
>>
>> No concerns from my side.
>
> Neither from mine.

OK, so series applied, thanks!
