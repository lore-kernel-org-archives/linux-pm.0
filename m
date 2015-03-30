From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/2] cpufreq: arm_big_little: check if the frequency is
 set correctly
Date: Mon, 30 Mar 2015 14:39:00 +0100
Message-ID: <551951F4.9070804@arm.com>
References: <1427718438-31098-1-git-send-email-sudeep.holla@arm.com> <CAKohponxEv3CjhVPAu2Ga5FeSSvtj_W6zGvL3oj2V247f94H=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60982 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752809AbbC3NiF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 30 Mar 2015 09:38:05 -0400
In-Reply-To: <CAKohponxEv3CjhVPAu2Ga5FeSSvtj_W6zGvL3oj2V247f94H=w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Mike Turquette <mike.turquette@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>



On 30/03/15 14:27, Viresh Kumar wrote:
> On 30 March 2015 at 17:57, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> The actual frequency is set through "clk_change_rate" which is void
>> function. If the underlying hardware fails and returns error, the error
>> is lost in the clk layer. In order to track such failures, we need to
>> read back the frequency(just the cached value as clk_recalc called after
>> clk->ops->set_rate gets the frequency)
>>
>> This patch adds check to see if the frequency is set correctly or if
>> they were any hardware failures and sends the appropriate errors to the
>> cpufreq core.
>>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   drivers/cpufreq/arm_big_little.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
>> index e1a6ba66a7f5..3fc676c63f91 100644
>> --- a/drivers/cpufreq/arm_big_little.c
>> +++ b/drivers/cpufreq/arm_big_little.c
>> @@ -186,6 +186,8 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
>>                  mutex_unlock(&cluster_lock[old_cluster]);
>>          }
>>
>> +       if (bL_cpufreq_get_rate(cpu) != new_rate)
>> +               return -EIO;
>>          return 0;
>>   }
>
> This doesn't look to me the right place for fixing this.
>

Yes I agree, after going through clk.c, I thought pre-/post- notifiers
are designed for such purpose. I tried using them but found it
unnecessary when it can be as simple as in this patch. However it's good
to hear from Mike as I seem to have assumed a lot here.

Regards,
Sudeep
