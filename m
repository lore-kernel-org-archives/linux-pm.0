From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] PM / Domains: Remove redundant pm_runtime_get|put*()
 in pm_genpd_prepare()
Date: Mon, 25 Apr 2016 10:21:34 +0200
Message-ID: <CAPDyKFqtQhbaDw4_k7xc=mMHBda1fn55t7_9w+PKYQHzSdcTpw@mail.gmail.com>
References: <1461312955-8547-1-git-send-email-ulf.hansson@linaro.org>
	<1461312955-8547-2-git-send-email-ulf.hansson@linaro.org>
	<7h37qdxz5t.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34916 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663AbcDYIVg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2016 04:21:36 -0400
Received: by mail-wm0-f54.google.com with SMTP id e201so76766651wme.0
        for <linux-pm@vger.kernel.org>; Mon, 25 Apr 2016 01:21:35 -0700 (PDT)
In-Reply-To: <7h37qdxz5t.fsf@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On 22 April 2016 at 20:43, Kevin Hilman <khilman@baylibre.com> wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
>> The PM core increases the runtime PM usage count in the system PM prepare
>> phase.
>
> nit: increases/decreases ... prepare/complete
>
>> This makes some of the pm_runtime_get|put*() calls in
>> pm_gendp_prepare() redundant, so let's remove them.
>
> s/gendp/genpd/
>
> And also add pm_genpd_complete()

As a matter fact that isn't the case. There's no pm_runtime_put*() in
pm_genpd_complete().

Although, perhaps you were thinking about enabling/disabling of
runtime PM, as that is being done in pm_genpd_prepare() and
pm_genpd_complete(). I intend to change as well, but in a separate
patch.

>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Otherwise...
>
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
>

Thanks for reviewing, I will update the change log accordingly!

Kind regards
Uffe

>> ---
>>  drivers/base/power/domain.c | 10 ++--------
>>  1 file changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 4ce4ce0..60a3573 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -730,14 +730,11 @@ static int pm_genpd_prepare(struct device *dev)
>>        * at this point and a system wakeup event should be reported if it's
>>        * set up to wake up the system from sleep states.
>>        */
>> -     pm_runtime_get_noresume(dev);
>>       if (pm_runtime_barrier(dev) && device_may_wakeup(dev))
>>               pm_wakeup_event(dev, 0);
>>
>> -     if (pm_wakeup_pending()) {
>> -             pm_runtime_put(dev);
>> +     if (pm_wakeup_pending())
>>               return -EBUSY;
>> -     }
>>
>>       if (resume_needed(dev, genpd))
>>               pm_runtime_resume(dev);
>> @@ -751,10 +748,8 @@ static int pm_genpd_prepare(struct device *dev)
>>
>>       mutex_unlock(&genpd->lock);
>>
>> -     if (genpd->suspend_power_off) {
>> -             pm_runtime_put_noidle(dev);
>> +     if (genpd->suspend_power_off)
>>               return 0;
>> -     }
>>
>>       /*
>>        * The PM domain must be in the GPD_STATE_ACTIVE state at this point,
>> @@ -776,7 +771,6 @@ static int pm_genpd_prepare(struct device *dev)
>>               pm_runtime_enable(dev);
>>       }
>>
>> -     pm_runtime_put(dev);
>>       return ret;
>>  }
