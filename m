From: Ganesh Mahendran <opensource.ganesh@gmail.com>
Subject: Re: [PATCH v2] PM / wakeup: use seq_open() to show wakeup stats
Date: Wed, 25 Apr 2018 19:01:16 +0800
Message-ID: <CADAEsF_tThkn=hZYaFZ5VaeK6vZKce0j_8T4BpxeGFefRKO+Nw@mail.gmail.com>
References: <1520239666-2964-1-git-send-email-opensource.ganesh@gmail.com>
 <2654052.UvzeiuBsVA@aspire.rjw.lan> <CAMuHMdXqLmyJF6qhyzgnPeU=T0TyxDpsw1PD8BiYiSXCZeTz=g@mail.gmail.com>
 <CADAEsF89WyoBA2vEadOUL6qeEQtGGMm5XFNpXRJh7FpZpJUneQ@mail.gmail.com> <CAMuHMdV42sNybiCv7kE+AjKCr1P4Zdw66S1xRxA+d-86nrNQMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdV42sNybiCv7kE+AjKCr1P4Zdw66S1xRxA+d-86nrNQMw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

2018-04-02 14:46 GMT+08:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> Hi Ganesh,
>
> On Mon, Apr 2, 2018 at 3:33 AM, Ganesh Mahendran
> <opensource.ganesh@gmail.com> wrote:
>> 2018-03-30 19:00 GMT+08:00 Geert Uytterhoeven <geert@linux-m68k.org>:
>>> On Fri, Mar 30, 2018 at 12:25 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>> On Monday, March 5, 2018 9:47:46 AM CEST Ganesh Mahendran wrote:
>>>>> single_open() interface requires that the whole output must
>>>>> fit into a single buffer. This will lead to timeout when
>>>>> system memory is not in a good situation.
>>>>>
>>>>> This patch use seq_open() to show wakeup stats. This method
>>>>> need only one page, so timeout will not be observed.
>
>>>>> --- a/drivers/base/power/wakeup.c
>>>>> +++ b/drivers/base/power/wakeup.c
>>>>> @@ -1029,32 +1029,77 @@ static int print_wakeup_source_stats(struct seq_file *m,
>>>>>       return 0;
>>>>>  }
>>>>>
>>>>> -/**
>>>>> - * wakeup_sources_stats_show - Print wakeup sources statistics information.
>>>>> - * @m: seq_file to print the statistics into.
>>>>> - */
>>>>> -static int wakeup_sources_stats_show(struct seq_file *m, void *unused)
>>>>> +static void *wakeup_sources_stats_seq_start(struct seq_file *m,
>>>>> +                                     loff_t *pos)
>>>>>  {
>
>>>>> +     list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
>>>>> +             if (n-- > 0)
>>>>> +                     continue;
>>>>> +             goto out;
>>>>> +     }
>>>>> +     ws = NULL;
>>>>> +out:
>>>>> +     return ws;
>>>>> +}
>>>>
>>>> Please clean up the above at least.
>>>>
>>>> If I'm not mistaken, you don't need the label and the goto here.
>>>
>>> The continue is also not needed, if the test condition is inverted.
>>
>> Hi, Geert
>>
>> We need to locate to the last read item. What is your suggestion here?
>
> I didn't mean to get rid of that logic, but to reorganize the code to make it
> simpler:
>
>         list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
>                 if (n-- <= 0)
>                         return ws;
>         }

I send a v3 patch.
Thanks for your review.

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
