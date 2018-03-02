From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / wakeup: use seq_open() to show wakeup stats
Date: Fri, 2 Mar 2018 12:48:08 +0100
Message-ID: <CAJZ5v0jiR_T5=R6M3YKtOVQaxbJnp=6wsqu5NT+fjypNB6G-yg@mail.gmail.com>
References: <1519966860-32519-1-git-send-email-opensource.ganesh@gmail.com>
 <CAJZ5v0hmj873=2qXtV_PzGEv-dRp-1KVuoC0mYO0AcOVt0e3hg@mail.gmail.com> <CADAEsF-HzNxrCHMrGm_QR=9grUM3HJbycorsiBuggOh-hYjx-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADAEsF-HzNxrCHMrGm_QR=9grUM3HJbycorsiBuggOh-hYjx-g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ganesh Mahendran <opensource.ganesh@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 2, 2018 at 12:34 PM, Ganesh Mahendran
<opensource.ganesh@gmail.com> wrote:
> Hi, Rafael:
>
> 2018-03-02 16:58 GMT+08:00 Rafael J. Wysocki <rafael@kernel.org>:
>> On Fri, Mar 2, 2018 at 6:01 AM, Ganesh Mahendran
>> <opensource.ganesh@gmail.com> wrote:
>>> single_open() interface requires that the whole output must
>>> fit into a single buffer. This will lead to timeout when
>>> system memory is not in a good situation.
>>
>> Did you actually see this problem with this particular file or is it
>> theoretical?
>
> We got report of android watchdog timeout when memory situation
> is bad.

I see.

>>
>>> This patch use seq_open() to show wakeup stats. This method
>>> need only one page, so timeout will not be observed.
>>>
>>> Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
>>> ---
>>>  drivers/base/power/wakeup.c | 71 +++++++++++++++++++++++++++++++++++----------
>>>  1 file changed, 56 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
>>> index ea01621..c64609a 100644
>>> --- a/drivers/base/power/wakeup.c
>>> +++ b/drivers/base/power/wakeup.c
>>> @@ -1029,32 +1029,73 @@ static int print_wakeup_source_stats(struct seq_file *m,
>>>         return 0;
>>>  }
>>>
>>> +static void *wakeup_sources_stats_seq_start(struct seq_file *m,
>>> +                                       loff_t *pos)
>>> +{
>>> +       struct wakeup_source *ws;
>>> +       loff_t n = *pos;
>>> +
>>> +       if (n == 0) {
>>> +               seq_puts(m, "name\t\tactive_count\tevent_count\twakeup_count\t"
>>> +                       "expire_count\tactive_since\ttotal_time\tmax_time\t"
>>> +                       "last_change\tprevent_suspend_time\n");
>>> +       }
>>> +
>>> +       rcu_read_lock();
>>
>> The code running after this cannot sleep.  Use
>> srcu_read_lock(&wakeup_srcu) instead.
>
> wakeup_sources_stats_seq_[start | end] are called in seq_read().
> So rcu_read_unlock() will soon be called  in seq_read().

But you have to guarantee that the code between rcu_read_lock() and
rcu_read_unlock() will *never* sleep.

> I am not familar with rcu.

So you need to get familiar with it to make changes involving it.
Otherwise you may fall a victim of the Wizard's Second Rule.

> I refered to kmemleak.c which use seq_open()
> to show the stats.

I see.

You need to use srcu_read_lock(&wakeup_srcu) in this file anyway.
