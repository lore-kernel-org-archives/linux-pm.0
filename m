From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH][RFC] ACPI throttling: Save/restore tstate for each CPUs
 across suspend/resume
Date: Tue, 29 Nov 2016 02:50:08 +0100
Message-ID: <CAJZ5v0hAE_+pnpBkfOpr1fKTR2tJOBDyMwULCEstZrO_D4aJjw@mail.gmail.com>
References: <1479145444-29269-1-git-send-email-yu.c.chen@intel.com>
 <CAJZ5v0iMT4+qVdQ-8ev_NRavLNnLhr_+eEO9M=85WJC+zfDySw@mail.gmail.com> <36DF59CE26D8EE47B0655C516E9CE6405E63B74D@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE6405E63B74D@shsmsx102.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Rui Wang <ruwang@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, Matthew Garrett <mjg59@srcf.ucam.org>, "Zhang, Rui" <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 29, 2016 at 2:27 AM, Chen, Yu C <yu.c.chen@intel.com> wrote:
> Hi,
>> -----Original Message-----
>> From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf Of
>> Rafael J. Wysocki
>> Sent: Wednesday, November 23, 2016 7:03 AM

[cut]

>>
>> > +               work_on_cpu(cpu, tstate_pm_fn, &save);
>>
>> Does work_on_cpu() wait for the work to complete?
>>
> Yes, it might increase the suspend/resume time, a 'queue_work_on' might be better?

Not really, because you'd need to wait before doing the
put_online_cpus() anyway.

>> > +       put_online_cpus();
>> > +}
>> > +
>> > +static int tstate_suspend(struct notifier_block *nb,
>> > +                               unsigned long mode, void *_unused) {
>> > +       tstate_check(mode, true);
>> > +       return 0;
>> > +}
>> > +
>> > +static int tstate_resume(struct notifier_block *nb,
>> > +                               unsigned long mode, void *_unused) {
>> > +       tstate_check(mode, false);
>> > +       return 0;
>> > +}
>> > +
>> > +static int __init tstate_pm_init(void) {
>> > +       /*
>> > +        * tstate_suspend should save tstate after
>> > +        * thermal zone's update in thermal_pm_notify,
>> > +        * vice versa tstate_resume restore tstate before
>> > +        * thermal_pm_notify, thus the thermal framework
>> > +        * has a chance to re-adjust tstate according to the
>> > +        * temperature trend.
>> > +        */
>> > +       pm_notifier(tstate_suspend, -1);
>> > +       pm_notifier(tstate_resume, 1);
>>
>> I don't think this is going to do what you really want.
>>
>> Each of these notifiers is going to be invoked during both suspend and resume,
> Yes,
>
>> so I guess you only need one notifier?
>
> Here's my original thought:  tstate_suspend needs to be invoked after
>  thermal_pm_notify, which has a priority of '0',
> so the notifier of tstate_suspend should be lower than '0',
> thus '-1'. And the same for tstate_resume,
> it should be invoked before thermal_pm_notify,
> thus priority is '1' ?

If there's a dependency like that, it needs to be explicit.  That is,
thermal_pm_notify() needs to invoke your new code in the right order
with respect to what it does already.

Thanks,
Rafael
