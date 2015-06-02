From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] cpufreq/hotplug: Fix cpu-hotplug cpufreq race conditions
Date: Tue, 02 Jun 2015 12:26:32 +0530
Message-ID: <556D53A0.1050109@linux.vnet.ibm.com>
References: <20150601064031.2972.59208.stgit@perfhull-ltc.austin.ibm.com> <20150601071934.GC4242@linux> <556D3FAA.3080703@linux.vnet.ibm.com> <20150602053956.GD10443@linux> <556D4748.7040105@linux.vnet.ibm.com> <20150602061133.GE10443@linux> <556D4B32.3000407@linux.vnet.ibm.com> <20150602062724.GF10443@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150602062724.GF10443@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, ego@linux.vnet.ibm.com, paulus@samba.org, linux-kernel@vger.kernel.org, shilpa.bhat@linux.vnet.ibm.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/02/2015 11:57 AM, Viresh Kumar wrote:
> On 02-06-15, 11:50, Preeti U Murthy wrote:
>>  CPU0                        CPU1
>>
>> store*                     store*
>>
>> lock(policy 1)              lock(policy 2)
>> cpufreq_set_policy()       cpufreq_set_policy()
>> EXIT() :
>> dbs-data->usage_count--
>>
>> INIT()                      EXIT()
> 
> When will INIT() follow EXIT() in set_policy() for the same governor ?
> Maybe not, and so this sequence is hypothetical ?

Ah, yes, this will be hypothetical.
> 
>> dbs_data exists             dbs_data->usage_count -- = 0
>>                             kfree(dbs_data)
>> dbs-data->usage_count++
>> *NULL dereference*
> 
> But even if this happens, it should be handled with
> dbs_data->mutex_lock, which is used at other places already.

dbs_data->mutex_lock is used to serialize only START,STOP,LIMIT calls.
It does not serialize EXIT/INIT with these operations, but that is
understandable. We need to note that EXIT can proceed in parallel with
START/STOP/LIMIT operations which can result in null pointer
dereferences of dbs_data.

Yet again, this is due to the reason that you pointed out. One such case
is __cpufreq_remove_dev_finish(). It also drops policy locks before
calling into START/LIMIT. So this can proceed in parallel with an EXIT
operation from a store. So dbs_data->mutex does not help serialize these
two and START can refer a freed dbs_data. Consider the scenario today
where CPUFREQ_HAVE_GOVERNOR_PER_POLICY is set itself.

CPU0					CPU1

cpufreq_set_policy()

__cpufreq_governor
(CPUFREQ_GOV_POLICY_EXIT)
since the only usage
becomes 0.
				__cpufreq_remove_dev_finish()

free(dbs_data)			__cpufreq_governor
				(CPUFRQ_GOV_START)

				dbs_data->mutex <= NULL dereference

This is what we hit initially.

So we will need the policy wide lock even for those drivers that have a
governor per policy, before calls to __cpufreq_governor() in order to
avoid such scenarios. So, your patch at
https://git.linaro.org/people/viresh.kumar/linux.git/patch/57714d5b1778f2f610bcc5c74d85b29ba1cc1995
can lead to above races between different store operations themselves,
won't it ? An EXIT on one of the policy cpus, followed by a STOP on
another will lead to null dereference of dbs_data(For
GOVERNOR_PER_POLICY). Today stores are serialized through the policy lock.

Anyway, since taking the policy lock leads to ABBA deadlock and
releasing it can lead to races like above, shouldn't we try another
approach at serialization ?


Regards
Preeti U Murthy
> 
