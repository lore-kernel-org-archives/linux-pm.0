From: Ganesh Mahendran <opensource.ganesh@gmail.com>
Subject: Re: [PATCH] PM / wakeup: use seq_open() to show wakeup stats
Date: Fri, 2 Mar 2018 19:34:36 +0800
Message-ID: <CADAEsF-HzNxrCHMrGm_QR=9grUM3HJbycorsiBuggOh-hYjx-g@mail.gmail.com>
References: <1519966860-32519-1-git-send-email-opensource.ganesh@gmail.com> <CAJZ5v0hmj873=2qXtV_PzGEv-dRp-1KVuoC0mYO0AcOVt0e3hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hmj873=2qXtV_PzGEv-dRp-1KVuoC0mYO0AcOVt0e3hg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi, Rafael:

2018-03-02 16:58 GMT+08:00 Rafael J. Wysocki <rafael@kernel.org>:
> On Fri, Mar 2, 2018 at 6:01 AM, Ganesh Mahendran
> <opensource.ganesh@gmail.com> wrote:
>> single_open() interface requires that the whole output must
>> fit into a single buffer. This will lead to timeout when
>> system memory is not in a good situation.
>
> Did you actually see this problem with this particular file or is it
> theoretical?

We got report of android watchdog timeout when memory situation
is bad.

>
>> This patch use seq_open() to show wakeup stats. This method
>> need only one page, so timeout will not be observed.
>>
>> Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
>> ---
>>  drivers/base/power/wakeup.c | 71 +++++++++++++++++++++++++++++++++++----------
>>  1 file changed, 56 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
>> index ea01621..c64609a 100644
>> --- a/drivers/base/power/wakeup.c
>> +++ b/drivers/base/power/wakeup.c
>> @@ -1029,32 +1029,73 @@ static int print_wakeup_source_stats(struct seq_file *m,
>>         return 0;
>>  }
>>
>> +static void *wakeup_sources_stats_seq_start(struct seq_file *m,
>> +                                       loff_t *pos)
>> +{
>> +       struct wakeup_source *ws;
>> +       loff_t n = *pos;
>> +
>> +       if (n == 0) {
>> +               seq_puts(m, "name\t\tactive_count\tevent_count\twakeup_count\t"
>> +                       "expire_count\tactive_since\ttotal_time\tmax_time\t"
>> +                       "last_change\tprevent_suspend_time\n");
>> +       }
>> +
>> +       rcu_read_lock();
>
> The code running after this cannot sleep.  Use
> srcu_read_lock(&wakeup_srcu) instead.

wakeup_sources_stats_seq_[start | end] are called in seq_read().
So rcu_read_unlock() will soon be called  in seq_read().

I am not familar with rcu. I refered to kmemleak.c which use seq_open()
to show the stats.

Thanks for your review.

>
>> +       list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
>> +               if (n-- > 0)
>> +                       continue;
>> +               goto out;
>> +       }
>> +       ws = NULL;
>> +out:
>> +       return ws;
>> +}
>> +
>> +static void *wakeup_sources_stats_seq_next(struct seq_file *m,
>> +                                       void *v, loff_t *pos)
>> +{
>> +       struct wakeup_source *ws = v;
>> +       struct wakeup_source *next_ws = NULL;
>> +
>> +       ++(*pos);
>> +
>> +       list_for_each_entry_continue_rcu(ws, &wakeup_sources, entry) {
>> +               next_ws = ws;
>> +               break;
>> +       }
>> +
>> +       return next_ws;
>> +}
>> +
>> +static void wakeup_sources_stats_seq_stop(struct seq_file *m, void *v)
>> +{
>> +       rcu_read_unlock();
>> +}
>> +
>>  /**
>>   * wakeup_sources_stats_show - Print wakeup sources statistics information.
>>   * @m: seq_file to print the statistics into.
>>   */
>> -static int wakeup_sources_stats_show(struct seq_file *m, void *unused)
>> +static int wakeup_sources_stats_seq_show(struct seq_file *m, void *v)
>>  {
>> -       struct wakeup_source *ws;
>> -       int srcuidx;
>> +       struct wakeup_source *ws = v;
>>
>> -       seq_puts(m, "name\t\tactive_count\tevent_count\twakeup_count\t"
>> -               "expire_count\tactive_since\ttotal_time\tmax_time\t"
>> -               "last_change\tprevent_suspend_time\n");
>> -
>> -       srcuidx = srcu_read_lock(&wakeup_srcu);
>> -       list_for_each_entry_rcu(ws, &wakeup_sources, entry)
>> -               print_wakeup_source_stats(m, ws);
>> -       srcu_read_unlock(&wakeup_srcu, srcuidx);
>> -
>> -       print_wakeup_source_stats(m, &deleted_ws);
>> +       print_wakeup_source_stats(m, ws);
>>
>>         return 0;
>>  }
>>
>> +static const struct seq_operations wakeup_sources_stats_seq_ops = {
>> +       .start = wakeup_sources_stats_seq_start,
>> +       .next  = wakeup_sources_stats_seq_next,
>> +       .stop  = wakeup_sources_stats_seq_stop,
>> +       .show  = wakeup_sources_stats_seq_show,
>> +};
>> +
>>  static int wakeup_sources_stats_open(struct inode *inode, struct file *file)
>>  {
>> -       return single_open(file, wakeup_sources_stats_show, NULL);
>> +       return seq_open(file, &wakeup_sources_stats_seq_ops);
>>  }
>>
>>  static const struct file_operations wakeup_sources_stats_fops = {
>> @@ -1062,7 +1103,7 @@ static int wakeup_sources_stats_open(struct inode *inode, struct file *file)
>>         .open = wakeup_sources_stats_open,
>>         .read = seq_read,
>>         .llseek = seq_lseek,
>> -       .release = single_release,
>> +       .release = seq_release,
>>  };
>>
>>  static int __init wakeup_sources_debugfs_init(void)
>> --
>> 1.9.1
>>
