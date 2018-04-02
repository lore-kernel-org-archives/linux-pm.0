From: Ganesh Mahendran <opensource.ganesh@gmail.com>
Subject: Re: [PATCH v2] PM / wakeup: use seq_open() to show wakeup stats
Date: Mon, 2 Apr 2018 09:31:33 +0800
Message-ID: <CADAEsF-BCTYM5a2ywwHv1WkMbghKyw5z=y51Qu8DMCVeax9BwA@mail.gmail.com>
References: <1520239666-2964-1-git-send-email-opensource.ganesh@gmail.com> <2654052.UvzeiuBsVA@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2654052.UvzeiuBsVA@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

2018-03-30 18:25 GMT+08:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
> On Monday, March 5, 2018 9:47:46 AM CEST Ganesh Mahendran wrote:
>> single_open() interface requires that the whole output must
>> fit into a single buffer. This will lead to timeout when
>> system memory is not in a good situation.
>>
>> This patch use seq_open() to show wakeup stats. This method
>> need only one page, so timeout will not be observed.
>>
>> Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
>> ----
>> v2: use srcu_read_lock instead of rcu_read_lock
>> ---
>>  drivers/base/power/wakeup.c | 77 +++++++++++++++++++++++++++++++++++----------
>>  1 file changed, 61 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
>> index ea01621..3bcab7d 100644
>> --- a/drivers/base/power/wakeup.c
>> +++ b/drivers/base/power/wakeup.c
>> @@ -1029,32 +1029,77 @@ static int print_wakeup_source_stats(struct seq_file *m,
>>       return 0;
>>  }
>>
>> -/**
>> - * wakeup_sources_stats_show - Print wakeup sources statistics information.
>> - * @m: seq_file to print the statistics into.
>> - */
>> -static int wakeup_sources_stats_show(struct seq_file *m, void *unused)
>> +static void *wakeup_sources_stats_seq_start(struct seq_file *m,
>> +                                     loff_t *pos)
>>  {
>>       struct wakeup_source *ws;
>> -     int srcuidx;
>> +     loff_t n = *pos;
>> +     int *srcuidx = m->private;
>>
>> -     seq_puts(m, "name\t\tactive_count\tevent_count\twakeup_count\t"
>> -             "expire_count\tactive_since\ttotal_time\tmax_time\t"
>> -             "last_change\tprevent_suspend_time\n");
>> +     if (n == 0) {
>> +             seq_puts(m, "name\t\tactive_count\tevent_count\twakeup_count\t"
>> +                     "expire_count\tactive_since\ttotal_time\tmax_time\t"
>> +                     "last_change\tprevent_suspend_time\n");
>> +     }
>>
>> -     srcuidx = srcu_read_lock(&wakeup_srcu);
>> -     list_for_each_entry_rcu(ws, &wakeup_sources, entry)
>> -             print_wakeup_source_stats(m, ws);
>> -     srcu_read_unlock(&wakeup_srcu, srcuidx);
>> +     *srcuidx = srcu_read_lock(&wakeup_srcu);
>> +     list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
>> +             if (n-- > 0)
>> +                     continue;
>> +             goto out;
>> +     }
>> +     ws = NULL;
>> +out:
>> +     return ws;
>> +}
>
> Please clean up the above at least.

Hi, Rafael

When length of file "wakeup_sources" is larger than 1 page,
wakeup_sources_stats_seq_start()
may be called more then 1 time if the user space wants to read all of the file.
So we need to locate to last read item, if it is not the first time to
read the file.

We can see the same logic in kmemleak_seq_start().

Thanks.

>
> If I'm not mistaken, you don't need the label and the goto here.
>
