From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/2] cpufreq: arm_big_little: check if the frequency is
 set correctly
Date: Tue, 31 Mar 2015 10:24:29 +0100
Message-ID: <551A67CD.50602@arm.com>
References: <1427718438-31098-1-git-send-email-sudeep.holla@arm.com> <CAKohponxEv3CjhVPAu2Ga5FeSSvtj_W6zGvL3oj2V247f94H=w@mail.gmail.com> <551951F4.9070804@arm.com> <20150331014854.25195.34023@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34810 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752058AbbCaJXc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 31 Mar 2015 05:23:32 -0400
In-Reply-To: <20150331014854.25195.34023@quantum>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mike.turquette@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>



On 31/03/15 02:48, Michael Turquette wrote:
> Quoting Sudeep Holla (2015-03-30 06:39:00)
>> On 30/03/15 14:27, Viresh Kumar wrote:
>>> On 30 March 2015 at 17:57, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>> The actual frequency is set through "clk_change_rate" which is void
>>>> function. If the underlying hardware fails and returns error, the error
>>>> is lost in the clk layer. In order to track such failures, we need to
>>>> read back the frequency(just the cached value as clk_recalc called after
>>>> clk->ops->set_rate gets the frequency)

[...]
>>>
>>> This doesn't look to me the right place for fixing this.
>>>
>>
>> Yes I agree, after going through clk.c, I thought pre-/post- notifiers
>> are designed for such purpose. I tried using them but found it
>> unnecessary when it can be as simple as in this patch. However it's good
>> to hear from Mike as I seem to have assumed a lot here.
>
> Viresh & Sudeep,
>
> clk_set_rate returns an error (and always has), so it seems to me that
> this patch is unnecessary. bL_cpufreq_set_rate checks for an error from
> clk_set_rate and handles it.
>

No that's not correct, may be I was not clear earlier. Let me explain
with the stack trace.

bL_cpufreq_set_target(returns 0 even when clock driver returned error)
         |
         V
clk_set_rate(returns whatever it get from clk_core_set_rate_nolock)
         |
         V
clk_core_set_rate_nolock(always return 0 after calling clk_change_rate)
         |
         V
clk_change_rate(void function, so no return)
         |
         V
clk->ops->set_rate(i.e. <clock_driver_set_rate>)

Now for drivers/clk/clk.c IIUC, the return value from clk->ops->set_rate
is not checked. Now if <clock_driver_set_rate> returns error when h/w
fails to set the rate, I would like to know how the error returned by
<clock_driver_set_rate> is returned and received by clk_set_rate.
Correct me if I am missing anything in the above sequence.

In the current state of code, one can use notifier(basically
POST_RATE_CHANGE is called only if the clock rate changes), but since
the clk_recalc reads back the clock rate, I found this patch is simpler
compared to the notifiers.

Regards,
Sudeep
