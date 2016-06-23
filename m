From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RESEND PATCH v2 2/2] power/idle: enhance the precision of
 sleep_length
Date: Thu, 23 Jun 2016 09:01:27 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1606230859530.5839@nanos>
References: <1466154816-17900-1-git-send-email-zhaoyang.huang@spreadtrum.com> <1466154816-17900-2-git-send-email-zhaoyang.huang@spreadtrum.com> <alpine.DEB.2.11.1606171125460.5839@nanos> <CAN2waFuETjxzRwST_EGY4GhxFUZZsOPkysrcBsKCSmcp5hV+UQ@mail.gmail.com>
 <alpine.DEB.2.11.1606171346540.5839@nanos> <CAN2waFuLW0DPjJb=X-0kB9nVbB9aQoJ95EnVidPBpTBx3CYVvg@mail.gmail.com> <CAN2waFs2tQFYs-ZGvY2i1e+PSBAjNwn1+C6N_J3tm8BkvXXVcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:46389 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbcFWHDg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jun 2016 03:03:36 -0400
In-Reply-To: <CAN2waFs2tQFYs-ZGvY2i1e+PSBAjNwn1+C6N_J3tm8BkvXXVcQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, =?GB2312?Q?Zhaoyang_Huang_=28=BB=C6=B3=AF=D1=F4=29?= <zhaoyang.huang@spreadtrum.com>

On Wed, 22 Jun 2016, Zhaoyang Huang wrote:
> On 20 June 2016 at 09:14, Zhaoyang Huang <zhaoyang.huang@linaro.org> wrote:
> > On 17 June 2016 at 19:50, Thomas Gleixner <tglx@linutronix.de> wrote:
> >> On Fri, 17 Jun 2016, Zhaoyang Huang wrote:
> >>> On 17 June 2016 at 17:27, Thomas Gleixner <tglx@linutronix.de> wrote:
> >>> > On Fri, 17 Jun 2016, Zhaoyang Huang wrote:
> >>> >> There should be a gap between tick_nohz_idle_enter and
> >>> >> tick_nohz_get_sleep_length when idle, which will cause the
> >>> >> sleep_length is not very precised. Change it in this patch.
> >>> >
> >>> > What kind of imprecision are we talking about? Seconds, nanoseconds or
> >>> > lightyears?
> >>> >
> >>> > Your changelog lacks any form of useful information.
> >>> >
> >>> sorry for the confusion. The imprecision can be caused by, for
> >>> example, the callback function registered for CPU_PM_ENTER, which may
> >>> consume a period of time within the 'idle' time. Besides, I also
> >>> wonder why not calc the 'sleep_length' in the
> >>> tick_nohz_get_sleep_length?  This value is calculated at very
> >>> beginning of the idle in current approach.
> >>
> >> You still are not explaining the amount of imprecision. What are you talking
> >> about and is it really relevant in any way or are you just trying to solve an
> >> acedemic issue?
> >>
> >> Thanks,
> >>
> >>         tglx
> >>
> > Indeed, it is depends on how deep the idle state is. For example, the
> > lightest level for my current platform is 1100us, which sums up the
> > entry,exit and min time. However, there is a callback which do memory
> > management(merge the same page) in CPU_PM_ENTER will consume at least
> > 500us. In current approach, it cause 50% imprecision for this level of
> > idle state.
> Hi Thomas,
> Any further comments on that?

Yes. Why on earth do we have a 500us callback in the idle entry path? That's
just insane and needs to be fixed.

Thanks,

	tglx
