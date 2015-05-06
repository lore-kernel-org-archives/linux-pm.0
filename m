From: Jin Qian <jinqian@android.com>
Subject: Re: [PATCH v2 1/3] power: validate wakeup source before activating it.
Date: Wed, 6 May 2015 15:11:48 -0700
Message-ID: <CA+yUs=yZ=Ngn3iqr31XQiVCNbULit737ALdg_Ezov3N8T_TnCA@mail.gmail.com>
References: <1430938267-14951-1-git-send-email-jinqian@android.com>
	<2043095.ifDvYKem54@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:34604 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbbEFWLu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2015 18:11:50 -0400
Received: by laat2 with SMTP id t2so17696462laa.1
        for <linux-pm@vger.kernel.org>; Wed, 06 May 2015 15:11:49 -0700 (PDT)
In-Reply-To: <2043095.ifDvYKem54@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Rafael,

I kept braces since checkpatch.pl didn't report error or warning. The
if condition has two lines, a brace make the statement more clear I
think.

I removed the format string since ws->name can be random strings if
the wakeup_source is not registered (i.e. using prepare functions).
It's not very useful to print name if we have stack dump from
WARN_ONCE.

Thanks,
jin

On Wed, May 6, 2015 at 3:00 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, May 06, 2015 11:51:07 AM Jin Qian wrote:
>> A rogue wakeup source not registered in wakeup_sources list is not visible
>> from wakeup_sources_stats_show. Check if the wakeup source is registered
>> properly by looking at the timer struct.
>>
>> Signed-off-by: Jin Qian <jinqian@android.com>
>> ---
>>  drivers/base/power/wakeup.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
>> index 7726200..aead738 100644
>> --- a/drivers/base/power/wakeup.c
>> +++ b/drivers/base/power/wakeup.c
>> @@ -351,6 +351,20 @@ int device_set_wakeup_enable(struct device *dev, bool enable)
>>  }
>>  EXPORT_SYMBOL_GPL(device_set_wakeup_enable);
>>
>> +/**
>> + * wakeup_source_not_registered - validate the given wakeup source.
>> + * @ws: Wakeup source to be validated.
>> + */
>> +static bool wakeup_source_not_registered(struct wakeup_source *ws)
>> +{
>> +     /*
>> +      * Use timer struct to check if the given source is initialized
>> +      * by wakeup_source_add.
>> +      */
>> +     return ws->timer.function != pm_wakeup_timer_fn ||
>> +                ws->timer.data != (unsigned long)ws;
>> +}
>> +
>>  /*
>>   * The functions below use the observation that each wakeup event starts a
>>   * period in which the system should not be suspended.  The moment this period
>> @@ -391,6 +405,11 @@ static void wakeup_source_activate(struct wakeup_source *ws)
>>  {
>>       unsigned int cec;
>>
>> +     if (WARN_ONCE(wakeup_source_not_registered(ws),
>> +                     "unregistered wakeup source\n")) {
>> +             return;
>> +     }
>
> The braces are not necessary and you can use format strings with WARN_ONCE()
> too IIRC.
>
>> +
>>       /*
>>        * active wakeup source should bring the system
>>        * out of PM_SUSPEND_FREEZE state
>>
>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
