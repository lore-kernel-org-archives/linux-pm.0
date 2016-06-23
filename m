From: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Subject: Re: [RESEND PATCH v2 2/2] power/idle: enhance the precision of sleep_length
Date: Thu, 23 Jun 2016 16:34:28 +0800
Message-ID: <CAN2waFt8u7HX9GC0SMeRtc2AB3SN=yu7GLbVHY5O6DtK4GFZeQ@mail.gmail.com>
References: <1466154816-17900-1-git-send-email-zhaoyang.huang@spreadtrum.com>
 <1466154816-17900-2-git-send-email-zhaoyang.huang@spreadtrum.com>
 <alpine.DEB.2.11.1606171125460.5839@nanos> <CAN2waFuETjxzRwST_EGY4GhxFUZZsOPkysrcBsKCSmcp5hV+UQ@mail.gmail.com>
 <alpine.DEB.2.11.1606171346540.5839@nanos> <CAN2waFuLW0DPjJb=X-0kB9nVbB9aQoJ95EnVidPBpTBx3CYVvg@mail.gmail.com>
 <CAN2waFs2tQFYs-ZGvY2i1e+PSBAjNwn1+C6N_J3tm8BkvXXVcQ@mail.gmail.com>
 <alpine.DEB.2.11.1606230859530.5839@nanos> <CAN2waFuLRG1AsebmWey6N16v8AM7HDK6q=tV1su-gNWNjbC6hw@mail.gmail.com>
 <alpine.DEB.2.11.1606231016290.5839@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:36438 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbcFWIe3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jun 2016 04:34:29 -0400
Received: by mail-yw0-f172.google.com with SMTP id b72so65446664ywa.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Jun 2016 01:34:29 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1606231016290.5839@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Geng Ren <geng.ren@spreadtrum.com>, Alex Wang <alex.wang@spreadtrum.com>, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, =?UTF-8?B?Wmhhb3lhbmcgSHVhbmcgKOm7hOacnemYsyk=?= <zhaoyang.huang@spreadtrum.com>

On 23 June 2016 at 16:18, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 23 Jun 2016, Zhaoyang Huang wrote:
>> On 23 June 2016 at 15:01, Thomas Gleixner <tglx@linutronix.de> wrote:
>> Thomas, I agree with you, I have discussed the modification with the
>> call back owner. However, I wonder if we can make the idle's framework
>> to be more precised without the assumption of short CPU_PM_ENTER
>> callbacks. Thank you!
>
> What's the point? To help people who put insanities into the idle code path?
>
> Thanks,
>
>         tglx
>
Hi, Thomas. If the entry,exit,min time of one idle state sums up to
500us in some platform, the 100us callback which should be common as
caused by cache miss would also generate 20% imprecision. Don't you
think it is a case we should deal with?
