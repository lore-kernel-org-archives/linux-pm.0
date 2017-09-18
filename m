From: Bo Yan <byan@nvidia.com>
Subject: Re: [PATCH] cpufreq: cpufreq_stats: make last_index signed int
Date: Mon, 18 Sep 2017 10:39:59 -0700
Message-ID: <961bce0a-5162-5e8d-3474-5b2161cf92c4@nvidia.com>
References: <1505506402-11497-1-git-send-email-byan@nvidia.com>
 <20170918015017.GC17030@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170918015017.GC17030@ubuntu>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09/17/2017 06:50 PM, Viresh Kumar wrote:
> On 15-09-17, 13:13, Bo Yan wrote:
>> It is possible for last_index to get a -1 if current frequency
>> is not found in the freq table when stats is created. If the
>> function "cpufreq_stats_update" is called before last_index is
>> updated with a valid value, the "-1" will be used as index to
>> update stats->time_in_state, triggering an exception.
> 
> No, that's not how it works AFAIK and if it did, then can you explain how your
> solution fixes it?
> 
> AFAIK, what happens right now is that stats->last_index eventually stores
> 2147483647 (uint max) and the exception comes while accessing that value.
> 
> While with your change, it will become -1 and accessing array[-1] is fine by C
> standards, though it is still the wrong thing to do as you are accessing
> something outside of the array.
> 
> We should just check last_index == -1 before calling cpufreq_stats_update(),
> which is already done by one of the callers.
> 

Currently, the "last_index" is being checked before 
cpufreq_stats_update(stats) inside function 
"cpufreq_stats_record_transition", so it's taken care of.

However, the function "show_time_in_state" also calls 
cpufreq_stats_update, the similar check should be done there too, like this:

diff --git a/drivers/cpufreq/cpufreq_stats.c 
b/drivers/cpufreq/cpufreq_stats.c
index e75880eb037d..15305b5ec322 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -62,7 +62,8 @@ static ssize_t show_time_in_state(struct 
cpufreq_policy *policy, char *buf)
         if (policy->fast_switch_enabled)
                 return 0;

-       cpufreq_stats_update(stats);
+       if ((int)stats->last_index >= 0)
+               cpufreq_stats_update(stats);
         for (i = 0; i < stats->state_num; i++) {
                 len += sprintf(buf + len, "%u %llu\n", 
stats->freq_table[i],
                         (unsigned long long)


This is only needed when policy->cur is not in frequency table when 
stats table is created, in which case, stats->last_index will get -1, 
then user does a "cat time_in_state" before any frequency transition.

Does this make sense?
