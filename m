From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: Re: [PATCH] fix intel_pstate to update MSR values when changing
 governors
Date: Tue, 17 Nov 2015 17:45:11 -0800
Message-ID: <564BD827.6030803@linux.intel.com>
References: <1445043101-19079-1-git-send-email-alexandra.yates@linux.intel.com>
 <CAJZ5v0j0es9FEp1kFxbrHfnK1c55LzgP326fsqU8qYYpjN=26Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:52537 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754240AbbKRBmN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 17 Nov 2015 20:42:13 -0500
In-Reply-To: <CAJZ5v0j0es9FEp1kFxbrHfnK1c55LzgP326fsqU8qYYpjN=26Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: kristen@linux.intel.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, root <root@skl-s-fedora22.jf.intel.com>

On 10/16/2015 06:15 PM, Rafael J. Wysocki wrote:
> Hi,
>
> On Sat, Oct 17, 2015 at 2:51 AM, Alexandra Yates
> <alexandra.yates@linux.intel.com> wrote:
>> From: root <root@skl-s-fedora22.jf.intel.com>
>>
>> When changing from powersave to performance governors
>> Intel_pstate fails to update the MSR values that reflect the
>> max_perf_pct to 100%. For instance:
>>
>> Governor        MSR     max_perf_pct
>> =========       ====    ============
>> Powersave       2828    100%
>> Powersave       2028    80%
>> Performance     2028    100% <-
>>
>> The arrow shows the culprit. At this point the  MSR should
>> reflect the max_perf_pct that is 100% that corresponds MSR 2828
>> the maximum performance for the Performance governor.
>> Instead it holds back the MSR value previously set
>> by the Powersave governor 2028.
>>
>> Signed-off-by: root <root@skl-s-fedora22.jf.intel.com>
>
Sorry about this I sent the patch against an internal tree.
Won't happen again.

> It looks like you need to update your git configuration.
>
> More to the point, I wonder if this commit addresses the problem your seeing:
>

I tested only with the following patch in question and it doesn't fix 
the error for the MSR values on SKL.  I'm resending my patch rebased to 
linux-pm, including a better explanation on what the error is and what 
is fixing.

> http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=51443fbf3d2cde16011b994252c8004ebcd66fb0
>
>> ---
>>   drivers/cpufreq/intel_pstate.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
>> index cde38c8..992dbb5 100644
>> --- a/drivers/cpufreq/intel_pstate.c
>> +++ b/drivers/cpufreq/intel_pstate.c
>> @@ -1239,6 +1239,8 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>>              policy->max >= policy->cpuinfo.max_freq) {
>>                  pr_debug("intel_pstate: set performance\n");
>>                  limits = &performance_limits;
>> +               if (hwp_active)
>> +                       intel_pstate_hwp_set();
>>                  return 0;
>>          }
>>
>> --
>
> Thanks,
> Rafael
>

-- 
Thank you,
<Alexandra>
