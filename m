From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / QoS: Fix device resume latency PM QoS
Date: Tue, 24 Oct 2017 13:23:23 +0200
Message-ID: <CAJZ5v0imdah_V1ErJsAUgh=vmsS3wtRsoRtgLQwxonGLzQrT-A@mail.gmail.com>
References: <2245486.jYtPfSLF5g@aspire.rjw.lan> <20171024055409.GA5805@intel.com>
 <2465945.6cfLQGiipl@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:44113 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932148AbdJXLX0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Oct 2017 07:23:26 -0400
In-Reply-To: <2465945.6cfLQGiipl@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ramesh.thomas@intel.com, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Reinette Chatre <reinette.chatre@intel.com>, Alex Shi <alex.shi@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Tue, Oct 24, 2017 at 10:49 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, October 24, 2017 7:54:09 AM CEST Ramesh Thomas wrote:
>> On 2017-10-20 at 13:27:34 +0200, Rafael J. Wysocki wrote:
>> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >

[cut]

>> > @@ -63,10 +60,14 @@ static bool default_suspend_ok(struct de
>> >
>> >     spin_unlock_irqrestore(&dev->power.lock, flags);
>> >
>> > -   if (constraint_ns < 0)
>> > +   if (constraint_ns == 0)
>> >             return false;
>> >
>> > -   constraint_ns *= NSEC_PER_USEC;
>> > +   if (constraint_ns == PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
>> > +           constraint_ns = -1;
>> > +   else
>> > +           constraint_ns *= NSEC_PER_USEC;
>> > +
>> >     /*
>> >      * We can walk the children without any additional locking, because
>> >      * they all have been suspended at this point and their
>> > @@ -76,14 +77,19 @@ static bool default_suspend_ok(struct de
>> >             device_for_each_child(dev, &constraint_ns,
>> >                                   dev_update_qos_constraint);
>> >
>> > -   if (constraint_ns > 0) {
>> > -           constraint_ns -= td->suspend_latency_ns +
>> > -                           td->resume_latency_ns;
>> > -           if (constraint_ns == 0)
>> > -                   return false;
>> > +   if (constraint_ns < 0) {
>> > +           /* The children have no constraints. */
>> > +           td->effective_constraint_ns = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
>> > +           td->cached_suspend_ok = true;
>> > +   } else {
>> > +           constraint_ns -= td->suspend_latency_ns + td->resume_latency_ns;
>> > +           if (constraint_ns > 0) {
>> > +                   td->effective_constraint_ns = constraint_ns;
>> > +                   td->cached_suspend_ok = true;
>> > +           } else {
>> > +                   td->effective_constraint_ns = 0;
>>
>> Previously effective_constraint_ns was left as -1 if constraint_ns becomes 0
>> Not sure if this change is intentional.
>
> Yes, it is.
>
>> I think at dev_update_qos_constraint, this can cause to skip call to
>> dev_pm_qos_read_value.
>
> I need to double check that.

If constraint_ns becomes 0 (or less) here, power cannot be removed
from the device, because it would add an unacceptable latency.

Thus effective_constraint_ns has to be 0 for it to indicate that
situation.  If it was left at -1, it would mean "no requirement", but
that wouldn't be correct.

Thanks,
Rafael
