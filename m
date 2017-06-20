From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 3/3] ACPI / sleep: EC-based wakeup from suspend-to-idle
 on recent Dell systems
Date: Tue, 20 Jun 2017 23:16:32 +0200
Message-ID: <CAJZ5v0j3YnsQw1g75Y_0FYp6NmqULnKYJqrqbdPJ9vmEaHbuFQ@mail.gmail.com>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan> <3454366.uzaJljlWGm@aspire.rjw.lan>
 <3689795.xuIczRHZsl@aspire.rjw.lan> <2026371.DVJN39QYJi@aspire.rjw.lan>
 <CA+55aFwywLewxDenVcH1GxeigpS30B_+rvYh+=ff76EQpOcuOg@mail.gmail.com>
 <CAJZ5v0iH-nv3Ziu+JhcERit1oykmYxkPZE6j6zswL-LssnhQbQ@mail.gmail.com> <CA+55aFy1=pVbkKLH4p8prioOQ_Qb43ojM=8d9GsgXYWkaEN93A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFy1=pVbkKLH4p8prioOQ_Qb43ojM=8d9GsgXYWkaEN93A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <mario.limonciello@dell.com>, Tom Lanyon <tom@oneshoeco.com>, =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?= <jerome.debretagne@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 20, 2017 at 4:00 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Jun 20, 2017 at 9:13 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> My understanding is that Windows uses the ACPI_FADT_LOW_POWER_S0 flag.
>> It generally enables non-S3 suspend/resume when this flag is set and
>> it doesn't touch S3 then.  Keeping the EC GPE (and other GPEs for that
>> matter) enabled over suspend/resume is part of that if my
>> understanding is correct.
>>
>> During suspend we generally disable all GPEs that are not expected to
>> generate wakeup events in order to avoid spurious wakeups, but we can
>> try to keep them enabled if ACPI_FADT_LOW_POWER_S0 is set.  That will
>> reduce the ugliness, but the cost may be more energy used while
>> suspended on some systems.
>
> I think trying to do something similar to what windows does is likely
> the right thing, since that is (sadly) the only thing that tends to
> get extensive testing still.
>
> Of course, different versions of Windows then probably do different
> things, but I guess ACPI_FADT_LOW_POWER_S0 ends up being a good sign
> of "new machine designed for windows 10", so it's probably a good
> thing to trigger that behavior on.
>
> So I suspect it's worth testing, particularly if we're going to be in
> the situation that a lot of machines are going to do this going
> forward (ie the "all Dell" may end up being more than just Dell too?
> Dell usually doesn't do particularly odd and out-of-the-norm design
> choices like some vendors do).

Well, involving the EC in power button events processing has not been
a common practice so far.

Anyway, I will replace this patch with something that ought to be more
in line with what Windows does.

Thanks,
Rafael
