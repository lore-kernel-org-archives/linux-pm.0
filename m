From: Jin Qian <jinqian@android.com>
Subject: Re: [PATCH 2/3] power: increment wakeup_count when save_wakeup_count failed.
Date: Fri, 15 May 2015 18:08:32 -0700
Message-ID: <CA+yUs=ypmLV07LmGu90aLagy2S2yDxSABuByVKFh-ikiNad46Q@mail.gmail.com>
References: <1429750212-28659-1-git-send-email-jinqian@android.com>
	<1429750212-28659-3-git-send-email-jinqian@android.com>
	<6356516.qkiSo3Mux2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6356516.qkiSo3Mux2@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Some wakeup event happens every frequently between reading
wakeup_count and writing back wakeup_count.
They changed wakeup event count so writes fail and usespace doesn't
continue to suspend. However, such
occurrences are not counted in ws->wakeup_count. I spent quite
sometime finding out the problematic wakeup
event with inaccurate wakeup_count : )

Thanks,
jin


On Fri, May 15, 2015 at 5:34 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, April 22, 2015 05:50:11 PM Jin Qian wrote:
>> user-space aborts suspend attempt if writing wakeup_count failed.
>> Count the write failure towards wakeup_count.
>
> A use case, please?
>
>> Signed-off-by: Jin Qian <jinqian@android.com>
>> ---
>>  drivers/base/power/wakeup.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
>> index f24c622..bdb45f3 100644
>> --- a/drivers/base/power/wakeup.c
>> +++ b/drivers/base/power/wakeup.c
>> @@ -57,6 +57,8 @@ static LIST_HEAD(wakeup_sources);
>>
>>  static DECLARE_WAIT_QUEUE_HEAD(wakeup_count_wait_queue);
>>
>> +static ktime_t last_read_time;
>> +
>>  /**
>>   * wakeup_source_prepare - Prepare a new wakeup source for initialization.
>>   * @ws: Wakeup source to prepare.
>> @@ -771,10 +773,15 @@ void pm_wakeup_clear(void)
>>  bool pm_get_wakeup_count(unsigned int *count, bool block)
>>  {
>>       unsigned int cnt, inpr;
>> +     unsigned long flags;
>>
>>       if (block) {
>>               DEFINE_WAIT(wait);
>>
>> +             spin_lock_irqsave(&events_lock, flags);
>> +             last_read_time = ktime_get();
>> +             spin_unlock_irqrestore(&events_lock, flags);
>> +
>>               for (;;) {
>>                       prepare_to_wait(&wakeup_count_wait_queue, &wait,
>>                                       TASK_INTERRUPTIBLE);
>> @@ -806,6 +813,7 @@ bool pm_save_wakeup_count(unsigned int count)
>>  {
>>       unsigned int cnt, inpr;
>>       unsigned long flags;
>> +     struct wakeup_source *ws;
>>
>>       events_check_enabled = false;
>>       spin_lock_irqsave(&events_lock, flags);
>> @@ -813,6 +821,15 @@ bool pm_save_wakeup_count(unsigned int count)
>>       if (cnt == count && inpr == 0) {
>>               saved_count = count;
>>               events_check_enabled = true;
>> +     } else {
>> +             rcu_read_lock();
>> +             list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
>> +                     if (ws->active ||
>> +                         ktime_compare(ws->last_time, last_read_time) > 0) {
>> +                             ws->wakeup_count++;
>> +                     }
>> +             }
>> +             rcu_read_unlock();
>>       }
>>       spin_unlock_irqrestore(&events_lock, flags);
>>       return events_check_enabled;
>>
>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
