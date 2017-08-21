From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] PM: docs: Describe high-level PM strategies and sleep states
Date: Mon, 21 Aug 2017 02:51:29 +0200
Message-ID: <CAJZ5v0isuXmwCKsQZtOCsseJa7MW=CiEXMhQVnFSu6SMYykUcA@mail.gmail.com>
References: <3053012.25nKXRPPaK@aspire.rjw.lan> <2269280.4Jsh6Gf7ai@aspire.rjw.lan>
 <20170820182326.GA29793@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:37568 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753439AbdHUAvb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Aug 2017 20:51:31 -0400
In-Reply-To: <20170820182326.GA29793@wunner.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Linux Documentation <linux-doc@vger.kernel.org>

On Sun, Aug 20, 2017 at 8:23 PM, Lukas Wunner <lukas@wunner.de> wrote:
> On Sun, Aug 20, 2017 at 06:05:05PM +0200, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Reorganize the power management part of admin-guide by adding a
>> description of major power management strategies supported by the
>> kernel (system-wide and working-state power management) to it and
>> dividing the rest of the material into the system-wide PM and
>> working-state PM chapters.
>>
>> On top of that, add a description of system sleep states to the
>> system-wide PM chapter.
>
> Found no typos and no factual inaccuracies, the only thing that
> irritated me a bit was the part about "working state" power
> management:
>
>> +The other strategy, referred to as the
>> +:doc:`working-state power management <working-state>`, is based on adjusting the
>> +power states of individual hardware components of the system, as needed, in the
>> +working state.  In consequence, if this strategy is in use, the working state
>> +of the system usually does not correspond to any particular physical
>> +configuration of it, but can be treated as a metastate covering a range of
>> +different power states of the system in which the individual components of it
>> +can be either ``active`` (in use) or ``inactive`` (idle).  If they are active,
>> +they have to be in power states allowing them to process data and to be accessed
>> +by software.  In turn, if they are inactive, they are expected to be in
>> +low-power states in which they may not be accessible.
>> +
>> +If all of the system components are active, the system as a whole is regarded as
>> +``runtime active`` and that situation typically corresponds to the maximum power
>> +draw (or maximum energy usage) of it.  If all of them are inactive, the system
>> +as a whole is regarded as ``runtime idle`` which may be very close to a sleep
>
> The code uses the terms pm_runtime_active() and pm_runtime_suspended(),
> not "runtime idle".

Well, the phrase "runtime idle" in the document is (quite clearly)
used with respect to the system as a whole, so I'm not sure how this
is related to the runtime PM framework.

> Taking the ->runtime_idle callback as guidance,
> "runtime idle" would mean that a component is runtime active, but idling

Well, no.  At least that wasn't the intention and now it turns out to
be confusing ...

->runtime_idle is for cases when the device looks idle to a piece of
the kernel code and then it can use this callback to request the
devices driver/bus type and so on to take care of this situation.

Also the prefix "runtime" is there to distinguish the callback from
the other callbacks, related to system suspend and hibernation, in the
same data type.

And, of course, "suspended" implies "idle", but not the other way
around, in general.

> and could thus be transitioned to runtime suspended state.  However above
> it says that if it's idle, it's already "in low-power states and may
> not be accessible".

No, it doesn't say that.  It talks about expectations which may not be
what actually happens.

> For someone reading this it may be difficult to
> reconcile it with the terminology used in the code.

Anyway, the point here is to note the difference between sleep states
and a completely idle system in the working state.

>
> Otherwise,
> Reviewed-by: Lukas Wunner <lukas@wunner.de>

Thanks!
