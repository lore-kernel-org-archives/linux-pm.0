From: Jin Qian <jinqian@android.com>
Subject: Re: [PATCH 1/3] power: validate wakeup source before activating it.
Date: Mon, 27 Apr 2015 11:01:58 -0700
Message-ID: <CA+yUs=zhTRV+8Yw7=TyNAg6yhh_onL7+s8fcivuF1voQ+aymBw@mail.gmail.com>
References: <1429750212-28659-1-git-send-email-jinqian@android.com>
	<1429750212-28659-2-git-send-email-jinqian@android.com>
	<20150425201225.GB3008@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150425201225.GB3008@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This is a rare case.

My thought is to prevent a rogue wakeup source from preventing system
suspend, which is very difficult to find out if the wakeup source is
not registered and not visible in /d/wakeup_sources. On the other
hand, if the wakeup source failed to activate, it's much easier to be
noticed considering we deal with particular wakeup source. I can make
the pr_err BUG_ON or WARN_ON if they're more noticeable.

Thanks,
jin

On Sat, Apr 25, 2015 at 1:12 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Wed 2015-04-22 17:50:10, Jin Qian wrote:
>> A rogue wakeup source not registered in wakeup_sources list is not visible
>> from wakeup_sources_stats_show. Check if the wakeup source is registered
>> properly by looking at the timer function.
>
> How often does that happen?
>
> Will people on your systems actually notice that pr_err()?
>                                                                 Pavel
>
>> Signed-off-by: Jin Qian <jinqian@android.com>
>> ---
>>  drivers/base/power/wakeup.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
>> index 7726200..f24c622 100644
>> --- a/drivers/base/power/wakeup.c
>> +++ b/drivers/base/power/wakeup.c
>> @@ -14,6 +14,7 @@
>>  #include <linux/suspend.h>
>>  #include <linux/seq_file.h>
>>  #include <linux/debugfs.h>
>> +#include <linux/types.h>
>>  #include <trace/events/power.h>
>>
>>  #include "power.h"
>> @@ -351,6 +352,19 @@ int device_set_wakeup_enable(struct device *dev, bool enable)
>>  }
>>  EXPORT_SYMBOL_GPL(device_set_wakeup_enable);
>>
>> +/**
>> + * validate_wakeup_source - validate the given wakeup source.
>> + * @ws: Wakeup source to be validated.
>> + */
>> +static bool validate_wakeup_source(struct wakeup_source *ws)
>> +{
>> +     /*
>> +      * Use timer function to check if the given source is initialized
>> +      * by wakeup_source_add.
>> +      */
>> +     return ws->timer.function == pm_wakeup_timer_fn;
>> +}
>> +
>>  /*
>>   * The functions below use the observation that each wakeup event starts a
>>   * period in which the system should not be suspended.  The moment this period
>> @@ -391,6 +405,11 @@ static void wakeup_source_activate(struct wakeup_source *ws)
>>  {
>>       unsigned int cec;
>>
>> +     if (!validate_wakeup_source(ws)) {
>> +             pr_err("unregistered wakeup source: %s\n", ws->name);
>> +             return;
>> +     }
>> +
>>       /*
>>        * active wakeup source should bring the system
>>        * out of PM_SUSPEND_FREEZE state
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
