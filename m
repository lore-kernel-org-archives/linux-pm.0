From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] PM / QoS: Fix device resume latency PM QoS
Date: Thu, 26 Oct 2017 10:44:42 +0200
Message-ID: <CAJZ5v0hUFbALE_3RtWycnJgdpKB-E8P7V2ETEvDaPO_=jyZB4Q@mail.gmail.com>
References: <2245486.jYtPfSLF5g@aspire.rjw.lan> <2465945.6cfLQGiipl@aspire.rjw.lan>
 <CAJZ5v0imdah_V1ErJsAUgh=vmsS3wtRsoRtgLQwxonGLzQrT-A@mail.gmail.com>
 <1948004.bU45lK7TsE@aspire.rjw.lan> <20171025071625.GA13327@intel.com> <20171026020020.GB18264@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171026020020.GB18264@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ramesh.thomas@intel.com
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Reinette Chatre <reinette.chatre@intel.com>, Alex Shi <alex.shi@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 26, 2017 at 4:00 AM, Ramesh Thomas <ramesh.thomas@intel.com> wrote:
> On 2017-10-25 at 00:16:25 -0700, Ramesh Thomas wrote:
>> On 2017-10-24 at 13:35:05 +0200, Rafael J. Wysocki wrote:
>> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >
>>
>> [cut]
>>
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
>> If the resume latency constraint was increased after this,
>> default_power_down_ok may not consider the new value. default_suspend_ok needs
>> to get called first if the new value is to be read.
>>
>> This is because dev_pm_qos_read_value will get called only if
>> effective_constraint_ns has a negative value. default_suspend_ok initializes
>> effective_constraint_ns with -1 before doing the calculations.
>> default_power_down_ok does not initialize it to -1 and uses
>> the existing value.
>>
>> A comment in default_power_down_ok implies it is not necessary to call
>> default_suspend_ok before calling default_power_down_ok. In that case,
>> default_power_down_ok should be able to get the new latency constraint value.
>>
>
> The design expects default_suspend_ok would always be called before
> default_power_down_ok if the device was made "active" after start. Changes
> to resume latency constraint will not be considered if it happened between
> suspend and power down of a device. However, that is the design and not a
> behavior introduced by this patch.
>
> Acked-by: Ramesh Thomas <ramesh.thomas@intel.com>

Cool, thanks!

I'll go ahead and push this to Linus, then.

Thanks,
Rafael
