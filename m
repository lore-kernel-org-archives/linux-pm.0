From: Tom Lanyon <tom@oneshoeco.com>
Subject: Re: [PATCH 0/3] ACPI / sleep: Support power button wakeup from S2I on
 recent Dell laptops
Date: Thu, 1 Jun 2017 21:50:26 +1000
Message-ID: <CA+b4KqcxKNaHMTEG3KQOQ98OFmwS+R8PLdfyZB1tastH5m0XVQ@mail.gmail.com>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan> <3454366.uzaJljlWGm@aspire.rjw.lan>
 <1496313803.28981.45.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1496313803.28981.45.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <mario.limonciello@dell.com>
List-Id: linux-pm@vger.kernel.org

[resend as text/plain]

On Thu, 2017-06-01 at 01:23 +0200, Rafael J. Wysocki wrote:
> Hi All,
>
> This is a follow-up for a patch series posted some time ago:
>
> http://marc.info/?l=linux-kernel&m=149324246701378&w=2

I've applied Rafael's s2idle-dell-test branch to 4.12.0-rc3 and tested
on a Dell 9365 and, whilst it's significantly improved, it's not yet
working correctly.

Previously I could suspend (s2idle and deep), but it took an awkward
~8 second press of the power button to get it to resume, and I could
never get resume to work when triggering suspend/resume via close/open
of the lid.

With this patchset applied, I can suspend (s2idle) and a momentary
press of the power button resumes successfully.  I can also use the
lid switch to both suspend and resume successfully.

However, the EC events appear to trigger the machine to wake very
frequently whilst it's supposed to be suspended. This is visible via
the kernel messages at the end of this mail (leaving it in a suspended
state for a few hours resulted in many thousands of these messages),
and the high power draw witnessed.

Let me know if there's anything I can do to help debug further.

Tom

[   43.669798] PM: Syncing filesystems ... done.
[   43.675412] PM: Preparing system for sleep (freeze)
[   43.695469] Freezing user space processes ... (elapsed 0.001 seconds) done.
[   43.696769] OOM killer disabled.
[   43.696770] Freezing remaining freezable tasks ... (elapsed 0.001
seconds) done.
[   43.697914] PM: Suspending system (freeze)
[   43.910325] wlan0: deauthenticating from 9c:1c:12:c7:c2:f1 by local
choice (Reason: 3=DEAUTH_LEAVING)
[   44.112944] psmouse serio1: Failed to disable mouse on isa0060/serio1
[   45.721790] PM: suspend of devices complete after 1811.701 msecs
[   45.739769] PM: late suspend of devices complete after 17.956 msecs
[   45.742599] ACPI : EC: interrupt blocked
[   45.744774] xhci_hcd 0000:00:14.0: System wakeup enabled by ACPI
[   45.776254] PM: noirq suspend of devices complete after 34.702 msecs
[   45.776256] PM: suspend-to-idle
[   47.029237] Suspended for 0.327 seconds
[   47.029335] PM: resume from suspend-to-idle
[   47.029587] ACPI : EC: interrupt unblocked
[   47.064470] xhci_hcd 0000:00:14.0: System wakeup disabled by ACPI
[   47.065268] PM: noirq resume of devices complete after 35.894 msecs
[   47.066264] ACPI : EC: interrupt blocked
[   47.079210] xhci_hcd 0000:00:14.0: System wakeup enabled by ACPI
[   47.112461] PM: noirq suspend of devices complete after 47.019 msecs
[   47.112538] ACPI : EC: interrupt unblocked
[   47.147672] xhci_hcd 0000:00:14.0: System wakeup disabled by ACPI
[   47.148516] PM: noirq resume of devices complete after 36.051 msecs
[   47.149610] ACPI : EC: interrupt blocked
[   47.161002] xhci_hcd 0000:00:14.0: System wakeup enabled by ACPI
[   47.192546] PM: noirq suspend of devices complete after 43.955 msecs
[   47.192551] PM: suspend-to-idle
[   48.374756] Suspended for 1.836 seconds
[   48.374870] PM: resume from suspend-to-idle
[   48.375284] ACPI : EC: interrupt unblocked
