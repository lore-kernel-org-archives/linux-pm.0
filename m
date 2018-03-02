From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / wakeup: use seq_open() to show wakeup stats
Date: Fri, 2 Mar 2018 10:15:45 +0100
Message-ID: <CAJZ5v0i4nkg2mQ+8AejNavJmGVYZn3cbif3D5LW8VYpffvW73A@mail.gmail.com>
References: <1519966860-32519-1-git-send-email-opensource.ganesh@gmail.com> <CAJZ5v0hmj873=2qXtV_PzGEv-dRp-1KVuoC0mYO0AcOVt0e3hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hmj873=2qXtV_PzGEv-dRp-1KVuoC0mYO0AcOVt0e3hg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ganesh Mahendran <opensource.ganesh@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 2, 2018 at 9:58 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Mar 2, 2018 at 6:01 AM, Ganesh Mahendran
> <opensource.ganesh@gmail.com> wrote:
>> single_open() interface requires that the whole output must
>> fit into a single buffer. This will lead to timeout when
>> system memory is not in a good situation.
>
> Did you actually see this problem with this particular file or is it
> theoretical?
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

But generally, as Pavel points it out, even under srcu_read_lock()
things cannot be delayed indefinitely (at least for actions other than
freeing up more memory), so the entire approach appears to be flawed.
