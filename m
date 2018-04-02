From: Ganesh Mahendran <opensource.ganesh@gmail.com>
Subject: Re: [PATCH v2] PM / wakeup: use seq_open() to show wakeup stats
Date: Mon, 2 Apr 2018 09:33:30 +0800
Message-ID: <CADAEsF89WyoBA2vEadOUL6qeEQtGGMm5XFNpXRJh7FpZpJUneQ@mail.gmail.com>
References: <1520239666-2964-1-git-send-email-opensource.ganesh@gmail.com>
 <2654052.UvzeiuBsVA@aspire.rjw.lan> <CAMuHMdXqLmyJF6qhyzgnPeU=T0TyxDpsw1PD8BiYiSXCZeTz=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXqLmyJF6qhyzgnPeU=T0TyxDpsw1PD8BiYiSXCZeTz=g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

2018-03-30 19:00 GMT+08:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> On Fri, Mar 30, 2018 at 12:25 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Monday, March 5, 2018 9:47:46 AM CEST Ganesh Mahendran wrote:
>>> single_open() interface requires that the whole output must
>>> fit into a single buffer. This will lead to timeout when
>>> system memory is not in a good situation.
>>>
>>> This patch use seq_open() to show wakeup stats. This method
>>> need only one page, so timeout will not be observed.
>>>
>>> Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
>>> ----
>>> v2: use srcu_read_lock instead of rcu_read_lock
>>> ---
>>>  drivers/base/power/wakeup.c | 77 +++++++++++++++++++++++++++++++++++----------
>>>  1 file changed, 61 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
>>> index ea01621..3bcab7d 100644
>>> --- a/drivers/base/power/wakeup.c
>>> +++ b/drivers/base/power/wakeup.c
>>> @@ -1029,32 +1029,77 @@ static int print_wakeup_source_stats(struct seq_file *m,
>>>       return 0;
>>>  }
>>>
>>> -/**
>>> - * wakeup_sources_stats_show - Print wakeup sources statistics information.
>>> - * @m: seq_file to print the statistics into.
>>> - */
>>> -static int wakeup_sources_stats_show(struct seq_file *m, void *unused)
>>> +static void *wakeup_sources_stats_seq_start(struct seq_file *m,
>>> +                                     loff_t *pos)
>>>  {
>>>       struct wakeup_source *ws;
>>> -     int srcuidx;
>>> +     loff_t n = *pos;
>>> +     int *srcuidx = m->private;
>>>
>>> -     seq_puts(m, "name\t\tactive_count\tevent_count\twakeup_count\t"
>>> -             "expire_count\tactive_since\ttotal_time\tmax_time\t"
>>> -             "last_change\tprevent_suspend_time\n");
>>> +     if (n == 0) {
>>> +             seq_puts(m, "name\t\tactive_count\tevent_count\twakeup_count\t"
>>> +                     "expire_count\tactive_since\ttotal_time\tmax_time\t"
>>> +                     "last_change\tprevent_suspend_time\n");
>>> +     }
>>>
>>> -     srcuidx = srcu_read_lock(&wakeup_srcu);
>>> -     list_for_each_entry_rcu(ws, &wakeup_sources, entry)
>>> -             print_wakeup_source_stats(m, ws);
>>> -     srcu_read_unlock(&wakeup_srcu, srcuidx);
>>> +     *srcuidx = srcu_read_lock(&wakeup_srcu);
>>> +     list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
>>> +             if (n-- > 0)
>>> +                     continue;
>>> +             goto out;
>>> +     }
>>> +     ws = NULL;
>>> +out:
>>> +     return ws;
>>> +}
>>
>> Please clean up the above at least.
>>
>> If I'm not mistaken, you don't need the label and the goto here.
>
> The continue is also not needed, if the test condition is inverted.

Hi, Geert

We need to locate to the last read item. What is your suggestion here?

Thanks.

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
