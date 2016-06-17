From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RESEND PATCH v2 2/2] power/idle: enhance the precision of
 sleep_length
Date: Fri, 17 Jun 2016 13:50:50 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1606171346540.5839@nanos>
References: <1466154816-17900-1-git-send-email-zhaoyang.huang@spreadtrum.com> <1466154816-17900-2-git-send-email-zhaoyang.huang@spreadtrum.com> <alpine.DEB.2.11.1606171125460.5839@nanos> <CAN2waFuETjxzRwST_EGY4GhxFUZZsOPkysrcBsKCSmcp5hV+UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAN2waFuETjxzRwST_EGY4GhxFUZZsOPkysrcBsKCSmcp5hV+UQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, =?GB2312?Q?Zhaoyang_Huang_=28=BB=C6=B3=AF=D1=F4=29?= <zhaoyang.huang@spreadtrum.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 17 Jun 2016, Zhaoyang Huang wrote:
> On 17 June 2016 at 17:27, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Fri, 17 Jun 2016, Zhaoyang Huang wrote:
> >> There should be a gap between tick_nohz_idle_enter and
> >> tick_nohz_get_sleep_length when idle, which will cause the
> >> sleep_length is not very precised. Change it in this patch.
> >
> > What kind of imprecision are we talking about? Seconds, nanoseconds or
> > lightyears?
> >
> > Your changelog lacks any form of useful information.
> >
> sorry for the confusion. The imprecision can be caused by, for
> example, the callback function registered for CPU_PM_ENTER, which may
> consume a period of time within the 'idle' time. Besides, I also
> wonder why not calc the 'sleep_length' in the
> tick_nohz_get_sleep_length?  This value is calculated at very
> beginning of the idle in current approach.

You still are not explaining the amount of imprecision. What are you talking
about and is it really relevant in any way or are you just trying to solve an
acedemic issue?

Thanks,

	tglx
