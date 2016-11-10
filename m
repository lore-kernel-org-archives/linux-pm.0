From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 2/2] PM / sleep: don't suspend parent when async child
 suspend_{noirq,late} fails
Date: Thu, 10 Nov 2016 01:08:56 +0100
Message-ID: <CAJZ5v0hpcH2-UYtFC5kPc1n-O40fTPwzoCgbboOqfYMOGDXj7Q@mail.gmail.com>
References: <1476923170-111986-2-git-send-email-briannorris@chromium.org>
 <8017823.VJuZzSqtaY@vostro.rjw.lan> <CAKdAkRS+uUrx72DLKuyDiUMkKzxMTRXx5Pv1JBky6T8huv4Fhg@mail.gmail.com>
 <50971906.K6xak2t6Z6@vostro.rjw.lan> <20161102050706.GA49402@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36805 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751427AbcKJAI5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Nov 2016 19:08:57 -0500
In-Reply-To: <20161102050706.GA49402@google.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lkml <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Chuansheng Liu <chuansheng.liu@intel.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Wed, Nov 2, 2016 at 6:07 AM, Brian Norris <briannorris@chromium.org> wrote:
> + more genpd folks
>
> On Wed, Nov 02, 2016 at 04:51:08AM +0100, Rafael J. Wysocki wrote:
>> On Tuesday, November 01, 2016 12:04:28 AM Dmitry Torokhov wrote:
>> > On Mon, Oct 31, 2016 at 10:25 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > > On Thursday, October 27, 2016 09:05:34 AM Brian Norris wrote:
>> > >> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>> > >> index c58563581345..eaf6b53463a5 100644
>> > >> --- a/drivers/base/power/main.c
>> > >> +++ b/drivers/base/power/main.c
>> > >> @@ -1040,6 +1040,9 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
>> > >>
>> > >>       dpm_wait_for_children(dev, async);
>> > >>
>> > >> +     if (async_error)
>> > >> +             goto Complete;
>> > >> +
>> > >
>> > > This is a second chech for async_error in this routine and is the first one
>> > > really needed after adding this?
>> >
>> > There is really no point in waiting for children to be suspended if
>> > error has already been signalled; that's what first check achieves.
>> > The 2nd check ensures that we abort suspend if any of the children
>> > failed to suspend.
>> >
>> > I'd say both checks are needed (well, 1st is helpful, 2nd is essential).
>>
>> OK, fair enough.
>
> Sort of agreed, although I'm still not sure how helpful the 1st one is;
> kinda serves to complicate things, for little real benefit IMO (you
> don't save much time by "not waiting" -- either the child quickly
> notices the same error and complete()'s quickly, or else you're going to
> wait for that child in the end anyway).
>
> I think it's also important to ask why we do this optimization in the
> {late,noirq} cases, but we don't do this in __device_suspend(). As
> demonstrated by the $subject bug, I think we would yield fewer bugs by
> sharing code structure (if not the code itself) among the similar
> phases.
>
> I'm happy for you to take my current patch, of course, but I think some
> further effort on making this consistent might be warranted. Either put
> all of these short-circuit checks after the wait_for_children(), or else
> add the same short-circuit for the missing case (__device_suspend()).
> i.e., this (untested) patch:
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index e44944f4be77..2932a5bd892f 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1027,6 +1027,8 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
>         TRACE_DEVICE(dev);
>         TRACE_SUSPEND(0);
>
> +       dpm_wait_for_children(dev, async);
> +
>         if (async_error)
>                 goto Complete;
>
> @@ -1038,8 +1040,6 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
>         if (dev->power.syscore || dev->power.direct_complete)
>                 goto Complete;
>
> -       dpm_wait_for_children(dev, async);
> -
>         if (dev->pm_domain) {
>                 info = "noirq power domain ";
>                 callback = pm_noirq_op(&dev->pm_domain->ops, state);
> @@ -1174,6 +1174,8 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
>
>         __pm_runtime_disable(dev, false);
>
> +       dpm_wait_for_children(dev, async);
> +
>         if (async_error)
>                 goto Complete;
>
> @@ -1185,8 +1187,6 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
>         if (dev->power.syscore || dev->power.direct_complete)
>                 goto Complete;
>
> -       dpm_wait_for_children(dev, async);
> -
>         if (dev->pm_domain) {
>                 info = "late power domain ";
>                 callback = pm_late_early_op(&dev->pm_domain->ops, state);
>
> ---
>
> I can test this and send it in proper form if that looks preferable.

It does to me as per the discussion at the LPC.

Are you still going to submit it?

Thanks,
Rafael
