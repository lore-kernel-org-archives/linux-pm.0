From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 3/3] ACPI / sleep: EC-based wakeup from suspend-to-idle
 on recent Dell systems
Date: Tue, 20 Jun 2017 03:13:07 +0200
Message-ID: <CAJZ5v0iH-nv3Ziu+JhcERit1oykmYxkPZE6j6zswL-LssnhQbQ@mail.gmail.com>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan> <3454366.uzaJljlWGm@aspire.rjw.lan>
 <3689795.xuIczRHZsl@aspire.rjw.lan> <2026371.DVJN39QYJi@aspire.rjw.lan> <CA+55aFwywLewxDenVcH1GxeigpS30B_+rvYh+=ff76EQpOcuOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:33753 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752665AbdFTBNJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Jun 2017 21:13:09 -0400
In-Reply-To: <CA+55aFwywLewxDenVcH1GxeigpS30B_+rvYh+=ff76EQpOcuOg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <mario.limonciello@dell.com>, Tom Lanyon <tom@oneshoeco.com>, =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?= <jerome.debretagne@gmail.com>

On Tue, Jun 20, 2017 at 2:07 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Jun 20, 2017 at 5:53 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>
>> -> v2: Added acpi_sleep=no_ec_wakeup to prevent EC events from waking up
>>           the system from s2idle on systems where they do that by default.
>
> This seems a big hacky.
>
> Is there no way to simply make acpi_ec_suspend() smarter while going
> to sleep? Instead of just unconditionally disabling every EC GPE, can
> we see that "this gpe is the power botton" somehow?

Unfortunately, the connection between the GPE and the power button is
not direct.

The EC GPE handler has no idea that it will generate power button
events.  It simply executes an AML method doing that.

The AML method, in turn, executes Notify(power button device) and the
"power button device" driver has to register a notify handler that
will recognize and process the events.  It doesn't know in principle
where the events will come from, though.  They may come from the EC or
from a different GPE etc.

Neither the EC driver, nor the "power button device" driver can figure
out that the connection is there.

> Disabling the power button event sounds fundamentally broken, and it
> sounds like Windows doesn't do that. I doubt Windows has some hacky
> whitelist. So I'd rather fix a deeper issue than have these kinds of
> hacks, if at all possible.

My understanding is that Windows uses the ACPI_FADT_LOW_POWER_S0 flag.
It generally enables non-S3 suspend/resume when this flag is set and
it doesn't touch S3 then.  Keeping the EC GPE (and other GPEs for that
matter) enabled over suspend/resume is part of that if my
understanding is correct.

During suspend we generally disable all GPEs that are not expected to
generate wakeup events in order to avoid spurious wakeups, but we can
try to keep them enabled if ACPI_FADT_LOW_POWER_S0 is set.  That will
reduce the ugliness, but the cost may be more energy used while
suspended on some systems.

Thanks,
Rafael
