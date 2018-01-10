From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] ACPI / PM: Use Low Power S0 Idle on more systems
Date: Wed, 10 Jan 2018 23:25:00 +0100
Message-ID: <CAJZ5v0gg8Pn8AU8auPMT+DYVoUK6TmsRUfK+E8RWfThbLPQ+PQ@mail.gmail.com>
References: <4046497.JI7UjL75gC@aspire.rjw.lan> <12541194.33112yYDjW@aspire.rjw.lan>
 <1515590661.7000.855.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:33555 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751561AbeAJWZB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jan 2018 17:25:01 -0500
In-Reply-To: <1515590661.7000.855.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Valentin Manea <valy@mrs.ro>

On Wed, Jan 10, 2018 at 2:24 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Wed, 2018-01-10 at 13:26 +0100, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Some systems don't support the ACPI_LPS0_ENTRY and ACPI_LPS0_EXIT
>> functions in their Low Power S0 Idle _DSM, but still expect EC
>> events to be processed in the suspend-to-idle state for power button
>> wakeup (among other things) to work.  Surface Pro3 turns out to be
>> one of them.
>>
>> Fortunately, it still provides Low Power S0 Idle _DSM with the screen
>> on/off functions supported, so modify the ACPI suspend-to-idle to use
>> the Low Power S0 Idle code path for all systems supporting the
>> ACPI_LPS0_ENTRY and ACPI_LPS0_EXIT or the ACPI_LPS0_SCREEN_OFF and
>> ACPI_LPS0_SCREEN_ON functions in their Low Power S0 Idle _DSM.
>>
>> Potentially, that will cause more systems to use suspend-to-idle by
>> default, so some future corrections may be necessary if it leads
>> to issues, but let it remain more straightforward for now.
>
>> -#define ACPI_S2IDLE_FUNC_MASK        ((1 << ACPI_LPS0_ENTRY) | (1 <<
>> ACPI_LPS0_EXIT))
>> +#define ACPI_LPS0_SCREEN_MASK        ((1 << ACPI_LPS0_SCREEN_OFF) |
>> (1 << ACPI_LPS0_SCREEN_ON))
>
>> +#define ACPI_LPS0_S2I_MASK   ((1 << ACPI_LPS0_ENTRY) | (1 <<
>> ACPI_LPS0_EXIT))
>
> Just a nitpick: Can we leave S2IDLE instead of S2I?
> Would it make sense for potential code readers?

I wanted it to be shorter, but if that is a problem, I'd rather call
it PLATFORM than S2IDLE (as technically they are related to the
low-power mode of the platform).

I'll send an update shortly.
