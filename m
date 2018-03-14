From: Ganesh Mahendran <opensource.ganesh@gmail.com>
Subject: Re: [PATCH v2] PM / wakeup: use seq_open() to show wakeup stats
Date: Wed, 14 Mar 2018 09:33:33 +0800
Message-ID: <CADAEsF__v8b01DAC9d8B93oJk3GiqEyfieSgM6kj9CfetXMqaQ@mail.gmail.com>
References: <1520239666-2964-1-git-send-email-opensource.ganesh@gmail.com> <CAHp75VeNco97BovnVTcd=RH9zsK_gO=jmPALytP-sTFjK5Cq0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VeNco97BovnVTcd=RH9zsK_gO=jmPALytP-sTFjK5Cq0Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi, Andy

2018-03-14 0:39 GMT+08:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
> On Mon, Mar 5, 2018 at 10:47 AM, Ganesh Mahendran
> <opensource.ganesh@gmail.com> wrote:
>> single_open() interface requires that the whole output must
>> fit into a single buffer. This will lead to timeout when
>> system memory is not in a good situation.
>>
>> This patch use seq_open() to show wakeup stats. This method
>> need only one page, so timeout will not be observed.
>
>> +       if (n == 0) {
>> +               seq_puts(m, "name\t\tactive_count\tevent_count\twakeup_count\t"
>> +                       "expire_count\tactive_since\ttotal_time\tmax_time\t"
>> +                       "last_change\tprevent_suspend_time\n");
>> +       }
>
> Can't you do this once at ->open() stage, for example?

We can not put this at ->open(). Because in seq_open(), the buffer is
not ready,
the seq buffer is allocated in seq_read().

Thanks.

>
>>  static int wakeup_sources_stats_open(struct inode *inode, struct file *file)
>>  {
>> -       return single_open(file, wakeup_sources_stats_show, NULL);
>> +       return seq_open_private(file, &wakeup_sources_stats_seq_ops, sizeof(int));
>>  }
>
> --
> With Best Regards,
> Andy Shevchenko
