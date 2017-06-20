From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 3/3] ACPI / sleep: EC-based wakeup from suspend-to-idle
 on recent Dell systems
Date: Tue, 20 Jun 2017 08:07:11 +0800
Message-ID: <CA+55aFwywLewxDenVcH1GxeigpS30B_+rvYh+=ff76EQpOcuOg@mail.gmail.com>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan> <3454366.uzaJljlWGm@aspire.rjw.lan>
 <3689795.xuIczRHZsl@aspire.rjw.lan> <2026371.DVJN39QYJi@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2026371.DVJN39QYJi@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <mario.limonciello@dell.com>, Tom Lanyon <tom@oneshoeco.com>, =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?= <jerome.debretagne@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 20, 2017 at 5:53 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> -> v2: Added acpi_sleep=no_ec_wakeup to prevent EC events from waking up
>           the system from s2idle on systems where they do that by default.

This seems a big hacky.

Is there no way to simply make acpi_ec_suspend() smarter while going
to sleep? Instead of just unconditionally disabling every EC GPE, can
we see that "this gpe is the power botton" somehow?

Disabling the power button event sounds fundamentally broken, and it
sounds like Windows doesn't do that. I doubt Windows has some hacky
whitelist. So I'd rather fix a deeper issue than have these kinds of
hacks, if at all possible.

                Linus
