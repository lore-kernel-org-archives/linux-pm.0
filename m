From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] PM / runtime: Rework pm_runtime_force_suspend/resume()
Date: Fri, 12 Jan 2018 14:46:12 +0100
Message-ID: <CAPDyKFoJm7HL5kG6Jv7m3w0djaKG7W7g6tsL64dSSh_pRnAffQ@mail.gmail.com>
References: <4069324.Q7yJt6I4hJ@aspire.rjw.lan> <303007688.lvsDLFNCpe@aspire.rjw.lan>
 <CAPDyKFqePzeiSjR=yvCAtHfOv6vJLm3wdPifsseK1p4cyyB8qQ@mail.gmail.com> <CAJZ5v0h+CojMA-MyGdDx69EZt-TOUqRsHG_PFap073vwgybpfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0h+CojMA-MyGdDx69EZt-TOUqRsHG_PFap073vwgybpfQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lukas Wunner <lukas@wunner.de>
List-Id: linux-pm@vger.kernel.org

On 12 January 2018 at 02:55, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Tue, Jan 9, 2018 at 7:08 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 3 January 2018 at 12:06, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> One of the limitations of pm_runtime_force_suspend/resume() is that
>>> if a parent driver wants to use these functions, all of its child
>>> drivers have to do that too because of the parent usage counter
>>> manipulations necessary to get the correct state of the parent during
>>> system-wide transitions to the working state (system resume).
>>
>> I understand your point, however this isn't describing the full story,
>> because there are a some more alternatives when
>> pm_runtime_force_suspend|resume() works well, when used for parent
>> devices. Let me clarify, just to make sure we get this correct.
>>
>> 1) If the child device isn't managed by runtime PM at all (it always
>> has runtime PM disabled), pm_runtime_force_suspend|resume() can be
>> used for the parent device. This works because the runtime PM status
>> if the child remains in the default status, RPM_SUSPENDED.
>
> Say the child is resumed every time during system-wide resume (which
> is the only possibility for drivers that don't support runtime PM) and
> it needs the parent to be accessible for that.
>
> If the parent uses pm_runtime_force_suspend|resume(), the child needs
> to bump up the usage counter of the parent during system-wide suspend
> to prevent pm_runtime_force_resume() from leaving the parent in
> suspend during the subsequent system-wide resume and that obviously is
> not going to happen if the child driver doesn't support runtime PM.

My take on this, is that this isn't a system suspend/resume specific
issue, thus also not something that pm_runtime_force_suspend|resume()
should need need to care about.

The reason is why I think so is because, normally during runtime, the
runtime PM core don't prevent parents from being runtime suspended, in
case their children isn't managed by runtime PM. In other words, the
problem exists already and isn't specific to system suspend.

>
> Note that the $subject patch doesn't really change anything in that
> respect, because the children counter of the parent will be zero (or
> at least will not cover the child in question) then.
>
> Of course, this means that it is only safe to use
> pm_runtime_force_suspend|resume() in parent drivers if all of their
> child drivers support runtime PM.

I understand your concern, however, hopefully the about comment can address it!?

>
>> 2) If, somehow, during system suspend/resume, the driver for the child
>> make sure to synchronize the runtime PM status of the child device,
>> according to the state of the HW, this should work too.
>
> Not really.
>
> Again, problematic is the case when the child is resumed during
> system-wide resume and needs the parent to be accessible for that.
>
> Note that the runtime PM status of the child doesn't matter for
> pm_runtime_force_resume() running for the parent.  What matters in
> there is the parent's usage counter alone.  If that usage counter is
> not greater than 1, pm_runtime_force_resume() will leave the parent in
> suspend and note that it must run before the child's system-wide
> resume callbacks for the ordering between the parent resume and the
> child resume to be correct.  This means that the parent will still be
> suspended when the child's system-wide resume callbacks run and that
> is a problem if the parent has to be accessible for them to succeed.
>
> Thus the runtime PM status of the child has no bearing on whether or
> not this is going to work.  The child has to bump up the parent's
> usage counter during system-wide suspend to ensure that it will not be
> left in suspend by the subsequent pm_runtime_force_resume() and that
> practically requires the child driver to also use
> pm_runtime_force_suspend|resume().
>

Yeah, you are right!

I was thinking about the special case when the child driver has called
pm_runtime_get_sync() during ->probe(), then during system suspend it
puts the child device into low power state and updates the runtime PM
status of the child device, by using pm_runtime_set_suspended(). In
system resume the child driver then reverse those actions.

Anyway, let's forget about these cases, as they are rather specific.
Instead I think it's fair to say that currently:

"If the child device is managed by runtime PM, and the parent driver
wants to use pm_runtime_force_suspend|resume() for the parent device,
so must the child driver for the child device" - and subject patch
removes that artificial limitation.

> Now, the $subject patch changes the situation here for child drivers
> that only resume their devices during system-wide resume if they were
> "active" before the preceding system-wide suspend, because in that
> case the children counter of the parent will be nonzero.  If the child
> resumes during system-wide resume even though it was suspended before
> the preceding system-wide suspend, pm_runtime_force_resume() running
> for its parent won't realize that the parent needs to resume too even
> after this patch.
>
> I generally think that leaving devices in suspend during system-wide
> resume is a very aggressive optimization and it should be done with
> extra care.  It generally is not sufficient to rely on information
> coming from the runtime PM framework to do that safely in all cases.
> IMO it should only be done for drivers that explicitly expect it to be
> done and only if all of the drivers depending on them also expect it
> to be done.  Otherwise it always will be potentially unsafe.

That's true, but I think your concern is related to the case when the
child isn't managed by runtime PM, while the parent is?

In regards to $subject patch, I really think it replaces the crappy
magic I invented to try to deal with child devices, with something
correct and clever. I would really appreciate it getting applied.

Kind regards
Uffe
