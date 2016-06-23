From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RESEND PATCH v2 2/2] power/idle: enhance the precision of
 sleep_length
Date: Thu, 23 Jun 2016 10:35:45 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1606231033530.5839@nanos>
References: <1466154816-17900-1-git-send-email-zhaoyang.huang@spreadtrum.com> <1466154816-17900-2-git-send-email-zhaoyang.huang@spreadtrum.com> <alpine.DEB.2.11.1606171125460.5839@nanos> <CAN2waFuETjxzRwST_EGY4GhxFUZZsOPkysrcBsKCSmcp5hV+UQ@mail.gmail.com>
 <alpine.DEB.2.11.1606171346540.5839@nanos> <CAN2waFuLW0DPjJb=X-0kB9nVbB9aQoJ95EnVidPBpTBx3CYVvg@mail.gmail.com> <CAN2waFs2tQFYs-ZGvY2i1e+PSBAjNwn1+C6N_J3tm8BkvXXVcQ@mail.gmail.com> <alpine.DEB.2.11.1606230859530.5839@nanos>
 <CAN2waFuLRG1AsebmWey6N16v8AM7HDK6q=tV1su-gNWNjbC6hw@mail.gmail.com> <alpine.DEB.2.11.1606231016290.5839@nanos> <CAN2waFt8u7HX9GC0SMeRtc2AB3SN=yu7GLbVHY5O6DtK4GFZeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:46732 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbcFWIhy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jun 2016 04:37:54 -0400
In-Reply-To: <CAN2waFt8u7HX9GC0SMeRtc2AB3SN=yu7GLbVHY5O6DtK4GFZeQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Geng Ren <geng.ren@spreadtrum.com>, Alex Wang <alex.wang@spreadtrum.com>, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, =?GB2312?Q?Zhaoyang_Huang_=28=BB=C6=B3=AF=D1=F4=29?= <zhaoyang.huang@spreadtrum.com>

On Thu, 23 Jun 2016, Zhaoyang Huang wrote:
> On 23 June 2016 at 16:18, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Thu, 23 Jun 2016, Zhaoyang Huang wrote:
> >> On 23 June 2016 at 15:01, Thomas Gleixner <tglx@linutronix.de> wrote:
> >> Thomas, I agree with you, I have discussed the modification with the
> >> call back owner. However, I wonder if we can make the idle's framework
> >> to be more precised without the assumption of short CPU_PM_ENTER
> >> callbacks. Thank you!
> >
> > What's the point? To help people who put insanities into the idle code path?
> >
> > Thanks,
> >
> >         tglx
> >
> Hi, Thomas. If the entry,exit,min time of one idle state sums up to
> 500us in some platform, the 100us callback which should be common as
> caused by cache miss would also generate 20% imprecision. Don't you

A cache miss is causing a 100us callback? What are you talking about?

Thanks,

	tglx
