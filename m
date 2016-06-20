From: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Subject: Re: [RESEND PATCH v2 2/2] power/idle: enhance the precision of sleep_length
Date: Mon, 20 Jun 2016 09:14:58 +0800
Message-ID: <CAN2waFuLW0DPjJb=X-0kB9nVbB9aQoJ95EnVidPBpTBx3CYVvg@mail.gmail.com>
References: <1466154816-17900-1-git-send-email-zhaoyang.huang@spreadtrum.com>
 <1466154816-17900-2-git-send-email-zhaoyang.huang@spreadtrum.com>
 <alpine.DEB.2.11.1606171125460.5839@nanos> <CAN2waFuETjxzRwST_EGY4GhxFUZZsOPkysrcBsKCSmcp5hV+UQ@mail.gmail.com>
 <alpine.DEB.2.11.1606171346540.5839@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:33403 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbcFTBO7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 19 Jun 2016 21:14:59 -0400
Received: by mail-yw0-f177.google.com with SMTP id v77so5796255ywg.0
        for <linux-pm@vger.kernel.org>; Sun, 19 Jun 2016 18:14:59 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1606171346540.5839@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, =?UTF-8?B?Wmhhb3lhbmcgSHVhbmcgKOm7hOacnemYsyk=?= <zhaoyang.huang@spreadtrum.com>

On 17 June 2016 at 19:50, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 17 Jun 2016, Zhaoyang Huang wrote:
>> On 17 June 2016 at 17:27, Thomas Gleixner <tglx@linutronix.de> wrote:
>> > On Fri, 17 Jun 2016, Zhaoyang Huang wrote:
>> >> There should be a gap between tick_nohz_idle_enter and
>> >> tick_nohz_get_sleep_length when idle, which will cause the
>> >> sleep_length is not very precised. Change it in this patch.
>> >
>> > What kind of imprecision are we talking about? Seconds, nanoseconds or
>> > lightyears?
>> >
>> > Your changelog lacks any form of useful information.
>> >
>> sorry for the confusion. The imprecision can be caused by, for
>> example, the callback function registered for CPU_PM_ENTER, which may
>> consume a period of time within the 'idle' time. Besides, I also
>> wonder why not calc the 'sleep_length' in the
>> tick_nohz_get_sleep_length?  This value is calculated at very
>> beginning of the idle in current approach.
>
> You still are not explaining the amount of imprecision. What are you talking
> about and is it really relevant in any way or are you just trying to solve an
> acedemic issue?
>
> Thanks,
>
>         tglx
>
Indeed, it is depends on how deep the idle state is. For example, the
lightest level for my current platform is 1100us, which sums up the
entry,exit and min time. However, there is a callback which do memory
management(merge the same page) in CPU_PM_ENTER will consume at least
500us. In current approach, it cause 50% imprecision for this level of
idle state.
