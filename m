From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 3/3] ACPI / sleep: EC-based wakeup from suspend-to-idle
 on recent Dell systems
Date: Tue, 20 Jun 2017 01:46:07 +0200
Message-ID: <CAJZ5v0ix2z4MKf3rYiHEQiqr9u00LMPAZ-6hA=LBocUg7SLfJQ@mail.gmail.com>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan> <3454366.uzaJljlWGm@aspire.rjw.lan>
 <3689795.xuIczRHZsl@aspire.rjw.lan> <2026371.DVJN39QYJi@aspire.rjw.lan> <1AE640813FDE7649BE1B193DEA596E886CED1B22@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:36269 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752541AbdFSXqI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Jun 2017 19:46:08 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CED1B22@SHSMSX101.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <mario.limonciello@dell.com>, Tom Lanyon <tom@oneshoeco.com>, =?UTF-8?Q?J=C3=A9r=3Fme_de_Bretagne?= <jerome.debretagne@gmail.com>

On Tue, Jun 20, 2017 at 1:37 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
> Hi, Rafael
>
>> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Rafael J.
>> Wysocki
>> Subject: [PATCH v2 3/3] ACPI / sleep: EC-based wakeup from suspend-to-idle on recent Dell systems
>>
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Some recent Dell laptops, including the XPS13 model numbers 9360 and
>> 9365, cannot be woken up from suspend-to-idle by pressing the power
>> button which is unexpected and makes that feature less usable on
>> those systems.  Moreover, on the 9365 ACPI S3 (suspend-to-RAM) is
>> not expected to be used at all (the OS these systems ship with never
>> exercises the ACPI S3 path) and suspend-to-idle is the only viable
>> system suspend mechanism in there.
>>
>> The reason why the power button wakeup from suspend-to-idle doesn't
>> work on those systems is because their power button events are
>> signaled by the EC (Embedded Controller), whose GPE (General Purpose
>> Event) line is disabled during suspend-to-idle transitions in Linux.
>> That is done on purpose, because in general the EC tends to generate
>> tons of events for various reasons (battery and thermal updates and
>> similar, for example) and all of them would kick the CPUs out of deep
>> idle states while in suspend-to-idle, which effectively would defeat
>> its purpose.
>>
>> Of course, on the Dell systems in question the EC GPE must be enabled
>> during suspend-to-idle transitions for the button press events to
>> be signaled while suspended at all.  For this reason, add a DMI
>> switch to the ACPI system suspend infrastructure to treat the EC
>> GPE as a wakeup one on the affected Dell systems.  In case the
>> users would prefer not to do that after all, add a new kernel
>> command line switch, acpi_sleep=no_ec_wakeup, to disable that new
>> behavior.
>>

[cut]

>>
>> Index: linux-pm/drivers/acpi/sleep.c
>> ===================================================================
>> --- linux-pm.orig/drivers/acpi/sleep.c
>> +++ linux-pm/drivers/acpi/sleep.c
>> @@ -160,6 +160,23 @@ static int __init init_nvs_nosave(const
>>       return 0;
>>  }
>>
>> +/* If set, it is allowed to use the EC GPE to wake up the system. */
>> +static bool ec_gpe_wakeup_allowed __initdata = true;
>> +
>> +void __init acpi_disable_ec_gpe_wakeup(void)
>> +{
>> +     ec_gpe_wakeup_allowed = false;
>> +}
>> +
>> +/* If set, the EC GPE will be configured to wake up the system. */
>> +static bool ec_gpe_wakeup;
>> +
>> +static int __init init_ec_gpe_wakeup(const struct dmi_system_id *d)
>> +{
>> +     ec_gpe_wakeup = ec_gpe_wakeup_allowed;
>> +     return 0;
>> +}
>> +
>>  static struct dmi_system_id acpisleep_dmi_table[] __initdata = {
>>       {
>>       .callback = init_old_suspend_ordering,
>> @@ -343,6 +360,26 @@ static struct dmi_system_id acpisleep_dm
>>               DMI_MATCH(DMI_PRODUCT_NAME, "80E3"),
>>               },
>>       },
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
> I have a concern here.
>
> ACPI spec has already defined a mechanism to statically
> Mark GPEs as wake-capable and enable it, it is done via
> _PRW. We may call it a "static wakeup GPE" mechanism.
>
> Now the problem might be on some platforms, _PRW cannot be
> prepared unconditionally. And the platform designers wants
> a "dynamic wakeup GPE" mechanism to dynamically
> mark/enable GPEs as wakeup GPE after having done some
> platform specific behaviors (ex., after/before
> saving/restoring some firmware configurations).
>
> From this point of view, can we prepare several APIs in
> sleep.c to allow dynamically mark/enable wakeup GPEs and
> export EC information via a new API from ec.c, ex.,
> acpi_ec_get_attributes(), or just publish struct acpi_ec
> and first_ec in acpi_ec.h to the other drivers.
> So that all such kinds of platforms drivers can use both
> interfaces to dynamically achieve this, which can help
> to avoid introducing quirk tables here.

I'm not sure how this is related to the patch.

Thanks,
Rafael
