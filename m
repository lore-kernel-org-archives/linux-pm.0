From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] PM / runtime: Rework pm_runtime_force_suspend/resume()
Date: Fri, 12 Jan 2018 02:55:22 +0100
Message-ID: <CAJZ5v0h+CojMA-MyGdDx69EZt-TOUqRsHG_PFap073vwgybpfQ@mail.gmail.com>
References: <4069324.Q7yJt6I4hJ@aspire.rjw.lan> <303007688.lvsDLFNCpe@aspire.rjw.lan>
 <CAPDyKFqePzeiSjR=yvCAtHfOv6vJLm3wdPifsseK1p4cyyB8qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:43941 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932297AbeALBzY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jan 2018 20:55:24 -0500
In-Reply-To: <CAPDyKFqePzeiSjR=yvCAtHfOv6vJLm3wdPifsseK1p4cyyB8qQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lukas Wunner <lukas@wunner.de>

On Tue, Jan 9, 2018 at 7:08 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 3 January 2018 at 12:06, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> One of the limitations of pm_runtime_force_suspend/resume() is that
>> if a parent driver wants to use these functions, all of its child
>> drivers have to do that too because of the parent usage counter
>> manipulations necessary to get the correct state of the parent during
>> system-wide transitions to the working state (system resume).
>
> I understand your point, however this isn't describing the full story,
> because there are a some more alternatives when
> pm_runtime_force_suspend|resume() works well, when used for parent
> devices. Let me clarify, just to make sure we get this correct.
>
> 1) If the child device isn't managed by runtime PM at all (it always
> has runtime PM disabled), pm_runtime_force_suspend|resume() can be
> used for the parent device. This works because the runtime PM status
> if the child remains in the default status, RPM_SUSPENDED.

Say the child is resumed every time during system-wide resume (which
is the only possibility for drivers that don't support runtime PM) and
it needs the parent to be accessible for that.

If the parent uses pm_runtime_force_suspend|resume(), the child needs
to bump up the usage counter of the parent during system-wide suspend
to prevent pm_runtime_force_resume() from leaving the parent in
suspend during the subsequent system-wide resume and that obviously is
not going to happen if the child driver doesn't support runtime PM.

Note that the $subject patch doesn't really change anything in that
respect, because the children counter of the parent will be zero (or
at least will not cover the child in question) then.

Of course, this means that it is only safe to use
pm_runtime_force_suspend|resume() in parent drivers if all of their
child drivers support runtime PM.

> 2) If, somehow, during system suspend/resume, the driver for the child
> make sure to synchronize the runtime PM status of the child device,
> according to the state of the HW, this should work too.

Not really.

Again, problematic is the case when the child is resumed during
system-wide resume and needs the parent to be accessible for that.

Note that the runtime PM status of the child doesn't matter for
pm_runtime_force_resume() running for the parent.  What matters in
there is the parent's usage counter alone.  If that usage counter is
not greater than 1, pm_runtime_force_resume() will leave the parent in
suspend and note that it must run before the child's system-wide
resume callbacks for the ordering between the parent resume and the
child resume to be correct.  This means that the parent will still be
suspended when the child's system-wide resume callbacks run and that
is a problem if the parent has to be accessible for them to succeed.

Thus the runtime PM status of the child has no bearing on whether or
not this is going to work.  The child has to bump up the parent's
usage counter during system-wide suspend to ensure that it will not be
left in suspend by the subsequent pm_runtime_force_resume() and that
practically requires the child driver to also use
pm_runtime_force_suspend|resume().

Now, the $subject patch changes the situation here for child drivers
that only resume their devices during system-wide resume if they were
"active" before the preceding system-wide suspend, because in that
case the children counter of the parent will be nonzero.  If the child
resumes during system-wide resume even though it was suspended before
the preceding system-wide suspend, pm_runtime_force_resume() running
for its parent won't realize that the parent needs to resume too even
after this patch.

I generally think that leaving devices in suspend during system-wide
resume is a very aggressive optimization and it should be done with
extra care.  It generally is not sufficient to rely on information
coming from the runtime PM framework to do that safely in all cases.
IMO it should only be done for drivers that explicitly expect it to be
done and only if all of the drivers depending on them also expect it
to be done.  Otherwise it always will be potentially unsafe.

Thanks,
Rafael
