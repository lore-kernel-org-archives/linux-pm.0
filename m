From: Ganesh Mahendran <opensource.ganesh@gmail.com>
Subject: Re: [PATCH v3] PM / wakeup: use seq_open() to show wakeup stats
Date: Wed, 2 May 2018 10:26:41 +0800
Message-ID: <CADAEsF_onq=H65ZUi2kC7b_WmEpdvMLdLcBPn8bqDQP_DPyEjQ@mail.gmail.com>
References: <1524653971-10425-1-git-send-email-opensource.ganesh@gmail.com> <20180429143002.GC13475@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180429143002.GC13475@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux PM <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi, Pavel

Thanks for your review.

2018-04-29 22:30 GMT+08:00 Pavel Machek <pavel@ucw.cz>:
> On Wed 2018-04-25 18:59:31, Ganesh Mahendran wrote:
>> single_open() interface requires that the whole output must
>> fit into a single buffer. This will lead to timeout when
>> system memory is not in a good situation.
>>
>> This patch use seq_open() to show wakeup stats. This method
>> need only one page, so timeout will not be observed.
>
> Sounds like magic.

I did not explain clearly here.

If we use single_open() to open the file, a single buffer(physical
continious) will be allocated
to store the whole data of file /sys/kernel/debug/wakeup_sources.
When memory situation is not good(fragments...), long time may be used
to allocate
such buffer which may cause android watchdog timeout.

>
>> -static int wakeup_sources_stats_show(struct seq_file *m, void *unused)
>> +static void *wakeup_sources_stats_seq_start(struct seq_file *m,
>> +                                     loff_t *pos)
>>  {
> ...
>> -     srcuidx = srcu_read_lock(&wakeup_srcu);
>> -     list_for_each_entry_rcu(ws, &wakeup_sources, entry)
>> -             print_wakeup_source_stats(m, ws);
>> -     srcu_read_unlock(&wakeup_srcu, srcuidx);
>> +     *srcuidx = srcu_read_lock(&wakeup_srcu);
>> +     list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
>> +             if (n-- <= 0)
>> +                     return ws;
>> +     }
>> +
>> +     return NULL;
>> +}
> ...
>> +static void wakeup_sources_stats_seq_stop(struct seq_file *m, void *v)
>> +{
>> +     int *srcuidx = m->private;
>> +
>> +     srcu_read_unlock(&wakeup_srcu, *srcuidx);
>> +}
>
> But you are holding srcu_lock over return to userspace, and somehow I
> don't think that's permitted?

In seq_read(), the m->op->[start | stop] will be invoked as a pair.
So the srcu_lock will not be hold and return to userspace.

Thanks.

>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
