From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/4] PM / core: Direct DPM_FLAG_SMART_SUSPEND optimization
Date: Tue, 19 Dec 2017 12:13:45 +0100
Message-ID: <CAJZ5v0hFP4zP+Q1znQ9ZnUTLunNaStmSR4-h-AqKn6UaF-d9Vw@mail.gmail.com>
References: <7742130.AaJQIxeI1n@aspire.rjw.lan> <252167445.OQUXi2Ca9Y@aspire.rjw.lan>
 <CAPDyKFpC0xLfGLqyWUZwnSVdeY9Ojs-JUtPzEkRr=KAuSXDfmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:42557 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbdLSLNr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Dec 2017 06:13:47 -0500
In-Reply-To: <CAPDyKFpC0xLfGLqyWUZwnSVdeY9Ojs-JUtPzEkRr=KAuSXDfmQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Tue, Dec 19, 2017 at 8:38 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 10 December 2017 at 01:00, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Make the PM core avoid invoking the "late" and "noirq" system-wide
>> suspend (or analogous) callbacks provided by device drivers directly
>> for devices with DPM_FLAG_SMART_SUSPEND set that are in runtime
>> suspend during the "late" and "noirq" phases of system-wide suspend
>> (or analogous) transitions.  That is only done for devices without
>> any middle-layer "late" and "noirq" suspend callbacks (to avoid
>> confusing the middle layer if there is one).
>>
>> The underlying observation is that runtime PM is disabled for devices
>> during the "late" and "noirq" system-wide suspend phases, so if they
>> remain in runtime suspend from the "late" phase forward, it doesn't
>> make sense to invoke the "late" and "noirq" callbacks provided by
>> the drivers for them (arguably, the device is already suspended and
>> in the right state).  Thus, if the remaining driver suspend callbacks
>> are to be invoked directly by the core, they can be skipped.
>>

It looks like I'm consistently failing to explain my point clearly enough. :-)

> As I have stated earlier, this isn't going to solve the general case,
> as the above change log seems to state.

Well, it doesn't say that or anything similar, at least to my eyes.

The observation is that if you have set DPM_FLAG_SMART_SUSPEND, then
you need to be prepared for your ->suspend_late and ->suspend_noirq to
be skipped (because the ACPI PM domain does that and you may happen to
work with it, for example) if the device is already suspended at the
beginning of the "late suspend" phase.  That's already documented.

Given the above, and the fact that there is not much to be done for a
suspended device in ->suspend_late and ->suspend_noirq, why can't the
core skip these callbacks too if there's no middle layer?

But the reason why I really need this is because
i2c-designware-platdrv can work both with the ACPI PM domain and
standalone and I need it to be handled consistently in both cases.

> I think we really need to do that, before adding yet another system suspend/resume optimization
> path in the PM core.

So what exactly is the technical argument in the above?

> The main reason is that lots of drivers have additional operations to
> perform, besides making sure that its device is put into a "runtime
> suspended state" during system suspend. In other words, skipping
> system suspend callbacks (and likewise for system resume) is to me the
> wrong solution to mitigate these problems.
>
>> This change really makes it possible for, say, platform device
>> drivers to re-use runtime PM suspend and resume callbacks by
>> pointing ->suspend_late and ->resume_early, respectively (and
>> possibly the analogous hibernation-related callback pointers too),
>> to them without adding any extra "is the device already suspended?"
>> type of checks to the callback routines, as long as they will be
>> invoked directly by the core.
>
> Certainly there are drivers that could start to deploying this
> solution, because at the moment they don't have any additional
> operations to perform at system suspend. But what about the rest,
> don't we care about them?

We do, somewhat. :-)

> Moreover, what happens when/if a driver that has deployed this
> solution, starts being used on a new SoC and then additional
> operations during system suspend becomes required (for example
> pinctrls that needs to be put in a system sleep state)? Then
> everything falls apart, doesn't it?

Then you runtime-resume the device in ->suspend() and the remaining
callbacks will run for you just fine.

And IMO running "late" and "noirq" system suspend callbacks on a
suspended device is super-fragile anyway as they generally need to
distinguish between the "suspended" and "not suspended" cases
consistently and what they do may affect the children or the parent of
the device in ways that are difficult to predict in general.  So, I'd
rather not do that in any case.

Thanks,
Rafael
