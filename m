From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V3] PM: In kernel power management domain_pm created for
 async schedules
Date: Wed, 13 Dec 2017 23:26:27 +0100
Message-ID: <CAJZ5v0j2RPzdCzAp3ofjpmnFhMUym691TBS54OvQpw=fidS9Ew@mail.gmail.com>
References: <20171206120714epcms5p70081d5bc518c3bb5f9cca4f56b203abf@epcms5p7>
 <20171206141238.GB11339@kroah.com> <CGME20171206120714epcms5p70081d5bc518c3bb5f9cca4f56b203abf@epcms5p7>
 <3785462.Nrr6Y8ermz@aspire.rjw.lan> <20171213084612epcms5p7755822fff34c87907de2236923e82305@epcms5p7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36314 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750992AbdLMW03 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Dec 2017 17:26:29 -0500
In-Reply-To: <20171213084612epcms5p7755822fff34c87907de2236923e82305@epcms5p7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: vikas.bansal@samsung.com
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Dec 13, 2017 at 9:46 AM, Vikas Bansal <vikas.bansal@samsung.com> wrote:
>
> Sender : Rafael J. Wysocki <rjw@rjwysocki.net>
> Date   : 2017-12-06 19:48 (GMT+5:30)
>
>> On Wednesday, December 6, 2017 3:12:38 PM CET gregkh@linuxfoundation.org wrote:
>> > On Wed, Dec 06, 2017 at 12:07:14PM +0000, Vikas Bansal wrote:
>> > > Description:
>> >
>> > Why is this here?
>> >
>> > >
>> > > If there is a driver in system which starts creating async schedules
>> > > just after resume (Same as our case, in which we faced issue).
>> > > Then async_synchronize_full API in PM cores starts waiting for completion
>> > > of async schedules created by that driver (Even though those are in a domain).
>> > > Because of this kernel resume time is increased (We faces the same issue)
>> > > and whole system is delayed.
>> > > This problem can be solved by creating a domain for
>> > > async schedules in PM core (As we solved in our case).
>> > > Below patch is for solving this problem.
>> >
>> > Very odd formatting.
>> >
>> > >
>> > > Changelog:
>> > > 1. Created Async domain domain_pm.
>> > > 2. Converted async_schedule to async_schedule_domain.
>> > > 3. Converted async_synchronize_full to async_synchronize_full_domain
>> >
>> > I'm confused.  Have you read kernel patch submissions?  Look at how they
>> > are formatted.  The documentation in the kernel tree should help you out
>> > a lot here.
>> >
>> > Also, this is not v1, it has changed from the previous version.  Always
>> > describe, in the correct way, the changes from previous submissions.
>
> Setting the correct version and chaging the formatting.
>
>> >
>> >
>> > >
>> > >
>> > >
>> > > Signed-off-by: Vikas Bansal <vikas.bansal@samsung.com>
>> > > Signed-off-by: Anuj Gupta <anuj01.gupta@samsung.com>
>> > > ---
>> > >  drivers/base/power/main.c |   27 +++++++++++++++------------
>> > >  1 file changed, 15 insertions(+), 12 deletions(-)
>> > >
>> > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>> > > index db2f044..042b034 100644
>> > > --- a/drivers/base/power/main.c
>> > > +++ b/drivers/base/power/main.c
>> > > @@ -39,6 +39,7 @@
>> > >  #include "power.h"
>> > >
>> > >  typedef int (*pm_callback_t)(struct device *);
>> > > +static ASYNC_DOMAIN(domain_pm);
>> > >
>> > >  /*
>> > >   * The entries in the dpm_list list are in a depth first order, simply
>> > > @@ -615,7 +616,8 @@ void dpm_noirq_resume_devices(pm_message_t state)
>> > >                  reinit_completion(&dev->power.completion);
>> > >                  if (is_async(dev)) {
>> > >                          get_device(dev);
>> > > -                        async_schedule(async_resume_noirq, dev);
>> > > +                        async_schedule_domain(async_resume_noirq, dev,
>> >
>> > Always run your patches through scripts/checkpatch.pl so you do you not
>> > get grumpy maintainers telling you to use scripts/checkpatch.pl
>> >
>> > Stop.  Take some time.  Redo the patch in another day or so, and then
>> > resend it later, _AFTER_ you have addressed the issues.  Don't rush,
>> > there is no race here.
>>
>> Also it is not clear to me if this fixes a mainline kernel issue,
>> because the changelog mentions a driver doing something odd, but it
>> doesn't say which one it is and whether or not it is in the tree.
>
> No, this driver is not part of mainline yet.

So please submit it along with the driver that needs it, whenever that
one is ready.

Thanks,
Rafael
