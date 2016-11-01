From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 2/2] PM / sleep: don't suspend parent when async child
 suspend_{noirq,late} fails
Date: Tue, 1 Nov 2016 00:04:28 -0600
Message-ID: <CAKdAkRS+uUrx72DLKuyDiUMkKzxMTRXx5Pv1JBky6T8huv4Fhg@mail.gmail.com>
References: <1476923170-111986-2-git-send-email-briannorris@chromium.org>
 <1477584334-39956-1-git-send-email-briannorris@chromium.org> <8017823.VJuZzSqtaY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:36807 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161464AbcKAGEa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Nov 2016 02:04:30 -0400
In-Reply-To: <8017823.VJuZzSqtaY@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Brian Norris <briannorris@chromium.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lkml <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Chuansheng Liu <chuansheng.liu@intel.com>

On Mon, Oct 31, 2016 at 10:25 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, October 27, 2016 09:05:34 AM Brian Norris wrote:
>> Consider two devices, A and B, where B is a child of A, and B utilizes
>> asynchronous suspend (it does not matter whether A is sync or async). If
>> B fails to suspend_noirq() or suspend_late(), or is interrupted by a
>> wakeup (pm_wakeup_pending()), then it aborts and sets the async_error
>> variable. However, device A does not (immediately) check the async_error
>> variable; it may continue to run its own suspend_noirq()/suspend_late()
>> callback. This is bad.
>>
>> We can resolve this problem by checking the async_error flag after
>> waiting for children to suspend, using the same logic for the noirq and
>> late suspend cases as we already do for __device_suspend().
>>
>> It's easy to observe this erroneous behavior by, for example, forcing a
>> device to sleep a bit in its suspend_noirq() (to ensure the parent is
>> waiting for the child to complete), then return an error, and watch the
>> parent suspend_noirq() still get called. (Or similarly, fake a wakeup
>> event at the right (or is it wrong?) time.)
>>
>> Fixes: de377b397272 ("PM / sleep: Asynchronous threads for suspend_late")
>> Fixes: 28b6fd6e3779 ("PM / sleep: Asynchronous threads for suspend_noirq")
>> Reported-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> Signed-off-by: Brian Norris <briannorris@chromium.org>
>> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> ---
>> v2: s/early/late/ in commit message
>>
>>  drivers/base/power/main.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>> index c58563581345..eaf6b53463a5 100644
>> --- a/drivers/base/power/main.c
>> +++ b/drivers/base/power/main.c
>> @@ -1040,6 +1040,9 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
>>
>>       dpm_wait_for_children(dev, async);
>>
>> +     if (async_error)
>> +             goto Complete;
>> +
>
> This is a second chech for async_error in this routine and is the first one
> really needed after adding this?

There is really no point in waiting for children to be suspended if
error has already been signalled; that's what first check achieves.
The 2nd check ensures that we abort suspend if any of the children
failed to suspend.

I'd say both checks are needed (well, 1st is helpful, 2nd is essential).

>
>>       if (dev->pm_domain) {
>>               info = "noirq power domain ";
>>               callback = pm_noirq_op(&dev->pm_domain->ops, state);
>> @@ -1187,6 +1190,9 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
>>
>>       dpm_wait_for_children(dev, async);
>>
>> +     if (async_error)
>> +             goto Complete;
>> +
>
> Same question.
>
>>       if (dev->pm_domain) {
>>               info = "late power domain ";
>>               callback = pm_late_early_op(&dev->pm_domain->ops, state);
>>
>
> Thanks,
> Rafael
>

Thanks.

-- 
Dmitry
