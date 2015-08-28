From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] modify pl011 driver to work as wakeup source
Date: Fri, 28 Aug 2015 14:14:29 +0100
Message-ID: <55E05EB5.80501@arm.com>
References: <1439547886-5093-1-git-send-email-zhaoyang.huang@linaro.org>	<55CDC9D4.3020709@linaro.org>	<CAN2waFv+8KM_TCw=iy1BOn-KmYuZRVmr5jKAniJwCaxBjqXvNQ@mail.gmail.com>	<55DDC697.4080107@linaro.org>	<55DDDCFC.8070107@arm.com>	<CAN2waFtcVHoSX6QGZQFzJJ2fkYVk1mUsgMn1HYGGd-+TT-XMjw@mail.gmail.com>	<55DEEB96.5090908@arm.com>	<CAN2waFsMVEYHy4rb7qJX8Tgxs1d+EuAOXPpbn2SVEoQuXkt9DA@mail.gmail.com> <CAN2waFuNChUJcTbwM-yZPqzptQmRFW2Mhg1fA0VPEKRyT+9kFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52044 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751794AbbH1NOe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 28 Aug 2015 09:14:34 -0400
In-Reply-To: <CAN2waFuNChUJcTbwM-yZPqzptQmRFW2Mhg1fA0VPEKRyT+9kFg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhaoyang Huang <zhaoyang.huang@linaro.org>, "tony@atomide.com" <tony@atomide.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Serge Broslavsky <serge.broslavsky@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>



On 28/08/15 10:43, Zhaoyang Huang wrote:
> I would like loop Tony for more discussion.
>
> Hi Tony,
> I met a problem when using your latest API for setting wakeup source.
> The basic phenomenon is the ttyAMA0 can not wakeup the whole system even
> if the wakeup node of its </power/wakeup> has been set to be enabled. By
> doing some basic debug, I find that the corresponding isr was set to
> suspend even with above setting have been take effect.
>

I don't quite understand the issue you are facing, but for sure
IRQF_NO_SUSPEND is not the right way to fix this. Please read the
document, it clearly states ".. but does not guarantee that the
interrupt will wake the system from a suspended state, for such cases
it is necessary to use enable_irq_wake()".

dev_pm_set_wake_irq is just new alternative for enable_irq_wake.
I have tried this API with RTC and it works fine, so I don't see any
issue unless you are exploring something new in the code path you are
using this API. I even tried with UART though it was a hack.

So this patch is wrong and you also fails to explain why you need a
console as a wake up source, for just testing ?

Regards,
Sudeep
