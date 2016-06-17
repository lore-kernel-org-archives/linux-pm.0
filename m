From: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Subject: Re: [RESEND PATCH v2 2/2] power/idle: enhance the precision of sleep_length
Date: Fri, 17 Jun 2016 19:18:30 +0800
Message-ID: <CAN2waFuETjxzRwST_EGY4GhxFUZZsOPkysrcBsKCSmcp5hV+UQ@mail.gmail.com>
References: <1466154816-17900-1-git-send-email-zhaoyang.huang@spreadtrum.com>
 <1466154816-17900-2-git-send-email-zhaoyang.huang@spreadtrum.com> <alpine.DEB.2.11.1606171125460.5839@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1606171125460.5839@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, =?UTF-8?B?Wmhhb3lhbmcgSHVhbmcgKOm7hOacnemYsyk=?= <zhaoyang.huang@spreadtrum.com>
List-Id: linux-pm@vger.kernel.org

On 17 June 2016 at 17:27, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 17 Jun 2016, Zhaoyang Huang wrote:
>> There should be a gap between tick_nohz_idle_enter and
>> tick_nohz_get_sleep_length when idle, which will cause the
>> sleep_length is not very precised. Change it in this patch.
>
> What kind of imprecision are we talking about? Seconds, nanoseconds or
> lightyears?
>
> Your changelog lacks any form of useful information.
>
> Thanks,
>
>         tglx
>
>
sorry for the confusion. The imprecision can be caused by, for
example, the callback function registered for CPU_PM_ENTER, which may
consume a period of time within the 'idle' time. Besides, I also
wonder why not calc the 'sleep_length' in the
tick_nohz_get_sleep_length?  This value is calculated at very
beginning of the idle in current approach.
