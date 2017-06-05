From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/3] ACPI / sleep: EC-based wakeup from suspend-to-idle on
 recent Dell systems
Date: Mon, 5 Jun 2017 22:51:17 +0200
Message-ID: <CAJZ5v0hGoMU1S1Xq1wiwBbxbgA6R862C0v8EiC7M=GvASBnPBw@mail.gmail.com>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan> <3454366.uzaJljlWGm@aspire.rjw.lan>
 <2944956.jYmHlBxMl3@aspire.rjw.lan> <806f96fe75d84268a570b702490c686c@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <806f96fe75d84268a570b702490c686c@ausx13mpc120.AMER.DELL.COM>
Sender: linux-acpi-owner@vger.kernel.org
To: Mario Limonciello <Mario.Limonciello@dell.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 5, 2017 at 5:18 PM,  <Mario.Limonciello@dell.com> wrote:
>> +     /*
>> +      * Enable the EC to wake up the system from suspend-to-idle to allow
>> +      * power button events to it wake up.
>> +      */
>> +     {
>> +      .callback = init_ec_gpe_wakeup,
>> +      .ident = "Dell XPS 13 9360",
>> +      .matches = {
>> +             DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>> +             DMI_MATCH(DMI_PRODUCT_NAME, "XPS 13 9360"),
>> +             },
>> +     },
>> +     {
>> +      .callback = init_ec_gpe_wakeup,
>> +      .ident = "Dell XPS 13 9365",
>> +      .matches = {
>> +             DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>> +             DMI_MATCH(DMI_PRODUCT_NAME, "XPS 13 9365"),
>> +             },
>> +     },
>>       {},
>>  };
>>
>
> Although the XPS 9360 and XPS 9365 are currently the only Dell products on
> the market that do the wakeup this way, this is part of Dell's BIOS and EC
> codebase.  As other Dell products start to ship Windows 10 with Modern Standby
> and (eventually) Linux with Suspend-to-Idle I'd expect this list to be growing.

Well, if init_ec_gpe_wakeup() was enabled on all Dell systems at this
point, it would affect all previous generations of them too and that
might not be desirable.

Thanks,
Rafael
