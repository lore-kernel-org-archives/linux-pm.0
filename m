From: Jin Qian <jinqian@android.com>
Subject: Re: [PATCH 1/1] power: validate wakeup source before activating it.
Date: Fri, 15 May 2015 18:28:17 -0700
Message-ID: <CA+yUs=zjdEShJ=qg15b_CVtWSA1_wMXoc+fzm5psUZRQdN6Mrg@mail.gmail.com>
References: <1430951216-3003-1-git-send-email-jinqian@android.com>
	<1816596.LjGsP0DkBO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1816596.LjGsP0DkBO@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

The latest version is in [PATCHv3 1/3] power: validate wakeup source
before activating it. I changed WARN_ONCE back to WARN since if
multiple drivers activating uninitialized wakeup_sources, only the
first driver will by flagged. We lost alert for other drivers. The
warning should really happen during driver development. Hope this is
ok.

Thanks,
jin

On Thu, May 14, 2015 at 5:22 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, May 06, 2015 03:26:56 PM Jin Qian wrote:
>> A rogue wakeup source not registered in wakeup_sources list is not visible
>> from wakeup_sources_stats_show. Check if the wakeup source is registered
>> properly by looking at the timer struct.
>>
>> Signed-off-by: Jin Qian <jinqian@android.com>
>> ---
>>  drivers/base/power/wakeup.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
>> index 7726200..7b5ad9a 100644
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
>> @@ -391,6 +405,10 @@ static void wakeup_source_activate(struct wakeup_source *ws)
>>  {
>>       unsigned int cec;
>>
>> +     if (WARN_ONCE(wakeup_source_not_registered(ws),
>> +                     "unregistered wakeup source\n"))
>> +             return;
>> +
>>       /*
>>        * active wakeup source should bring the system
>>        * out of PM_SUSPEND_FREEZE state
>
> Queued up for 4.2, thanks!
>
>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
