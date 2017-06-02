From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] ACPI / sleep: Support power button wakeup from S2I on recent Dell laptops
Date: Sat, 03 Jun 2017 01:16:44 +0200
Message-ID: <2056967.5elYS6yIbS@aspire.rjw.lan>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan> <CAJZ5v0j_jA68cai4mV85DV7QTVh77BcrWv7mnotZ6XKtXO57Wg@mail.gmail.com> <CA+b4Kqf9YN0x+Sc6Lk28FLD8-iaHnjS74MQV2yMyS599fe5HTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CA+b4Kqf9YN0x+Sc6Lk28FLD8-iaHnjS74MQV2yMyS599fe5HTw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tom Lanyon <tom@oneshoeco.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <mario.limonciello@dell.com>
List-Id: linux-pm@vger.kernel.org

On Friday, June 02, 2017 11:06:49 AM Tom Lanyon wrote:
> On 2 June 2017 at 00:59, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > Quoting from my cover letter:
> >
> > "After this series there still is a concern regarding the possible increase of
> > power draw that may result from the processing of non-wakeup EC events while
> > suspended which is why the change only affects Dell XPS13 9360 and 9365
> > for now."
> >
> > So that is what happens, unfortunately, and we can't do much about it
> > at the moment.
> 
> OK, but at the moment this is a regression in functionality on those
> platforms. Without this patchset, I can successfully s2idle
> suspend/resume on an XPS 9365 (albeit with a little bit of awkward
> fiddling of the power button to resume). After the patchset, I can't
> realistically go into s2idle at all.

Well, if you think about s2idle as a state in which there's no activity in the
system at all, this is not how it is defined.  In fact, if there is a non-wakeup
edge-triggered interrupt occurring while suspended, for example, it will
cause the IRQ core to run a low-level handler for it even though the action
handler(s) won't be run, which is far from "no activity".

s2idle basically is a state in which all system components are (or at least
should be) in low-power states most of the time and user space has been
frozen and patch [3/3] in this series doesn't change that really, so I really
wouldn't call it a "regression in functionality".  [I guess the messages in the
log are somewhat confusing, but see below.]

Of course, it does increase the amount of activity in the system while
suspended which in turn causes more energy to be used and battery life to
shorten, so it may be regarded as a power regression.  Still, it really is a
tradeoff between functionality (power button wakeups working as expected)
and energy-efficiency and I know about a few people who actually prefer the
functionality to be there.

On top of that, there are a few things that can be optimized slightly.  For
instance, we generally run too much code when those EC wakeups happen,
we print too much to the log (even without debug enabled) etc, which also
should reduce the amout of energy that goes away and I have some patches
going in that direction.  Moreover, the messages printed to the logs are
not quite as accurate as they should be which needs to be fixed too.

What really matters is how much more energy the system uses after that patch
(or how much less time it will stay on battery) while suspended.  Can you please
try to estimate that for your system?

In any case, you have a point that there may be users wanting the systems
to use less energy while suspended to idle at the cost of semi-functional power
button wakeups, so I guess I'll add an acpi_sleep= kernel command line switch
to force-disable EC wakeups even on systems where they would be enabled by
default.

> > The only way to avoid that would be to reconfigure the EC during
> > suspend to stop generating non-wakeup events, but today we have no
> > reliable way to do that.
> 
> I thought I had read one one of the threads that this was possible in
> the same way that it is for Windows on these laptops.  What's missing
> to make this possible?

Let's say there is work in progress to make it possible to use that interface
in Linux, but it may not actually do everything we want it to do, so it may not
help much here on this particular laptop model.

Thanks,
Rafael

