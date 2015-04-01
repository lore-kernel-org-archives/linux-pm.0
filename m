From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/2] cpufreq: arm_big_little: check if the frequency is
 set correctly
Date: Wed, 01 Apr 2015 11:01:14 +0100
Message-ID: <551BC1EA.5030401@arm.com>
References: <1427718438-31098-1-git-send-email-sudeep.holla@arm.com> <CAKohponxEv3CjhVPAu2Ga5FeSSvtj_W6zGvL3oj2V247f94H=w@mail.gmail.com> <551951F4.9070804@arm.com> <20150331014854.25195.34023@quantum> <551A67CD.50602@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37456 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168AbbDAKAN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 1 Apr 2015 06:00:13 -0400
In-Reply-To: <551A67CD.50602@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mike.turquette@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>



On 31/03/15 10:24, Sudeep Holla wrote:
> On 31/03/15 02:48, Michael Turquette wrote:

[...]

>> clk_set_rate returns an error (and always has), so it seems to me that
>> this patch is unnecessary. bL_cpufreq_set_rate checks for an error from
>> clk_set_rate and handles it.
>>
>
> No that's not correct, may be I was not clear earlier. Let me explain
> with the stack trace.
>
> bL_cpufreq_set_target(returns 0 even when clock driver returned error)
>           |
>           V
> clk_set_rate(returns whatever it get from clk_core_set_rate_nolock)
>           |
>           V
> clk_core_set_rate_nolock(always return 0 after calling clk_change_rate)
>           |
>           V
> clk_change_rate(void function, so no return)
>           |
>           V
> clk->ops->set_rate(i.e. <clock_driver_set_rate>)
>
> Now for drivers/clk/clk.c IIUC, the return value from clk->ops->set_rate
> is not checked. Now if <clock_driver_set_rate> returns error when h/w
> fails to set the rate, I would like to know how the error returned by
> <clock_driver_set_rate> is returned and received by clk_set_rate.
> Correct me if I am missing anything in the above sequence.
>

Any input on this ? or am I taking non-sense here ?

Regards,
Sudeep
