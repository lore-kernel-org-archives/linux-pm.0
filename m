From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / QoS: Fix device resume latency PM QoS
Date: Wed, 25 Oct 2017 18:28:01 +0200
Message-ID: <CAJZ5v0gY=d5jBBqpVH+radA2pEAP2SF1m-6PXMgDMgJB6Xdedg@mail.gmail.com>
References: <2245486.jYtPfSLF5g@aspire.rjw.lan> <20171024055409.GA5805@intel.com>
 <2465945.6cfLQGiipl@aspire.rjw.lan> <CAJZ5v0imdah_V1ErJsAUgh=vmsS3wtRsoRtgLQwxonGLzQrT-A@mail.gmail.com>
 <20171025072725.GB13327@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:55992 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbdJYQ2D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Oct 2017 12:28:03 -0400
In-Reply-To: <20171025072725.GB13327@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ramesh.thomas@intel.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Reinette Chatre <reinette.chatre@intel.com>, Alex Shi <alex.shi@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Wed, Oct 25, 2017 at 9:27 AM, Ramesh Thomas <ramesh.thomas@intel.com> wrote:
> On 2017-10-24 at 13:23:23 +0200, Rafael J. Wysocki wrote:
>> On Tue, Oct 24, 2017 at 10:49 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > On Tuesday, October 24, 2017 7:54:09 AM CEST Ramesh Thomas wrote:
>> >> On 2017-10-20 at 13:27:34 +0200, Rafael J. Wysocki wrote:
>> >> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >> >
>>
>> [cut]
>>
>> >> > @@ -63,10 +60,14 @@ static bool default_suspend_ok(struct de
>> >> >
>> >> >     spin_unlock_irqrestore(&dev->power.lock, flags);
>> >> >
>> >> > -   if (constraint_ns < 0)
>> >> > +   if (constraint_ns == 0)
>> >> >             return false;
>> >> >
>> >> > -   constraint_ns *= NSEC_PER_USEC;
>> >> > +   if (constraint_ns == PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
>> >> > +           constraint_ns = -1;
>> >> > +   else
>> >> > +           constraint_ns *= NSEC_PER_USEC;
>> >> > +
>> >> >     /*
>> >> >      * We can walk the children without any additional locking, because
>> >> >      * they all have been suspended at this point and their
>> >> > @@ -76,14 +77,19 @@ static bool default_suspend_ok(struct de
>> >> >             device_for_each_child(dev, &constraint_ns,
>> >> >                                   dev_update_qos_constraint);
>> >> >
>> >> > -   if (constraint_ns > 0) {
>> >> > -           constraint_ns -= td->suspend_latency_ns +
>> >> > -                           td->resume_latency_ns;
>> >> > -           if (constraint_ns == 0)
>> >> > -                   return false;
>> >> > +   if (constraint_ns < 0) {
>> >> > +           /* The children have no constraints. */
>> >> > +           td->effective_constraint_ns = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
>> >> > +           td->cached_suspend_ok = true;
>> >> > +   } else {
>> >> > +           constraint_ns -= td->suspend_latency_ns + td->resume_latency_ns;
>> >> > +           if (constraint_ns > 0) {
>> >> > +                   td->effective_constraint_ns = constraint_ns;
>> >> > +                   td->cached_suspend_ok = true;
>> >> > +           } else {
>> >> > +                   td->effective_constraint_ns = 0;
>> >>
>> >> Previously effective_constraint_ns was left as -1 if constraint_ns becomes 0
>> >> Not sure if this change is intentional.
>> >
>> > Yes, it is.
>> >
>> >> I think at dev_update_qos_constraint, this can cause to skip call to
>> >> dev_pm_qos_read_value.
>> >
>> > I need to double check that.
>>
>> If constraint_ns becomes 0 (or less) here, power cannot be removed
>> from the device, because it would add an unacceptable latency.
>>
>> Thus effective_constraint_ns has to be 0 for it to indicate that
>> situation.  If it was left at -1, it would mean "no requirement", but
>> that wouldn't be correct.
>>
>
> A negative value in effective_constraint_ns is used as trigger to read new
> resume latency constraints.

I guess you mean in __default_power_down_ok(), right?

That doesn't matter, because it covers the case when the device has
never been runtime-suspended: it started in the "suspended" state and
has never been made "active".

The case we are talking about is when default_suspend_ok() *was* run
and it returned "true", or the device would not have been suspended,
so __default_power_down_ok() would not have run for that domain at
all.  In that case effective_constraint has to be positive anyway,
because that is the only case when default_suspend_ok() returns
"true".

It matters in default_suspend_ok() itself, however, where the
constraints for the children are checked and -1 means "no
restriction".  So it still looks like the patch needs to be improved,
but that's because effective_constraint should not remain -1 if
constraint_ns is 0 (which it still does in one case).

Thanks,
Rafael
