From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/3] ACPI / sleep: Support power button wakeup from S2I on
 recent Dell laptops
Date: Thu, 1 Jun 2017 16:59:48 +0200
Message-ID: <CAJZ5v0j_jA68cai4mV85DV7QTVh77BcrWv7mnotZ6XKtXO57Wg@mail.gmail.com>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan> <3454366.uzaJljlWGm@aspire.rjw.lan>
 <1496313803.28981.45.camel@linux.intel.com> <CA+b4KqcxKNaHMTEG3KQOQ98OFmwS+R8PLdfyZB1tastH5m0XVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+b4KqcxKNaHMTEG3KQOQ98OFmwS+R8PLdfyZB1tastH5m0XVQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Lanyon <tom@oneshoeco.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <mario.limonciello@dell.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On Thu, Jun 1, 2017 at 1:50 PM, Tom Lanyon <tom@oneshoeco.com> wrote:
> [resend as text/plain]
>
> On Thu, 2017-06-01 at 01:23 +0200, Rafael J. Wysocki wrote:
>> Hi All,
>>
>> This is a follow-up for a patch series posted some time ago:
>>
>> http://marc.info/?l=linux-kernel&m=149324246701378&w=2
>
> I've applied Rafael's s2idle-dell-test branch to 4.12.0-rc3 and tested
> on a Dell 9365 and, whilst it's significantly improved, it's not yet
> working correctly.
>
> Previously I could suspend (s2idle and deep), but it took an awkward
> ~8 second press of the power button to get it to resume, and I could
> never get resume to work when triggering suspend/resume via close/open
> of the lid.
>
> With this patchset applied, I can suspend (s2idle) and a momentary
> press of the power button resumes successfully.  I can also use the
> lid switch to both suspend and resume successfully.
>
> However, the EC events appear to trigger the machine to wake very
> frequently whilst it's supposed to be suspended. This is visible via
> the kernel messages at the end of this mail (leaving it in a suspended
> state for a few hours resulted in many thousands of these messages),
> and the high power draw witnessed.
>
> Let me know if there's anything I can do to help debug further.

Quoting from my cover letter:

"After this series there still is a concern regarding the possible increase of
power draw that may result from the processing of non-wakeup EC events while
suspended which is why the change only affects Dell XPS13 9360 and 9365
for now."

So that is what happens, unfortunately, and we can't do much about it
at the moment.

The only way to avoid that would be to reconfigure the EC during
suspend to stop generating non-wakeup events, but today we have no
reliable way to do that.

Thanks,
Rafael
