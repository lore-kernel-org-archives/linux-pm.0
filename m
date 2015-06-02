From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] cpufreq/hotplug: Fix cpu-hotplug cpufreq race conditions
Date: Tue, 02 Jun 2015 11:50:34 +0530
Message-ID: <556D4B32.3000407@linux.vnet.ibm.com>
References: <20150601064031.2972.59208.stgit@perfhull-ltc.austin.ibm.com> <20150601071934.GC4242@linux> <556D3FAA.3080703@linux.vnet.ibm.com> <20150602053956.GD10443@linux> <556D4748.7040105@linux.vnet.ibm.com> <20150602061133.GE10443@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:45471 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814AbbFBGUl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jun 2015 02:20:41 -0400
Received: from /spool/local
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Tue, 2 Jun 2015 00:20:40 -0600
In-Reply-To: <20150602061133.GE10443@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, ego@linux.vnet.ibm.com, paulus@samba.org, linux-kernel@vger.kernel.org, shilpa.bhat@linux.vnet.ibm.com, linux-pm@vger.kernel.org

On 06/02/2015 11:41 AM, Viresh Kumar wrote:
> On 02-06-15, 11:33, Preeti U Murthy wrote:
>> No, dbs_data is a governor wide data structure and not a policy wide
> 
> Yeah, that's the common part which I was referring to. But normally
> its just read for policies in START/STOP, they just update per-cpu
> data for policy->cpus.
> 
>> one, which is manipulated in START/STOP calls for drivers where the
>> CPUFREQ_HAVE_GOVERNOR_PER_POLICY is not set.
>>
>> So even if we assume that we hold per-policy locks, the following race
>> is still present. Assume that we have just two cpus which do not have a
>> governor-per-policy set.
>>
>> CPU0                        CPU1
>>
>>  store*                     store*
>>
>> lock(policy 1)              lock(policy 2)
>> cpufreq_set_policy()       cpufreq_set_policy()
>> EXIT() :
>> dbs-data->usage_count--
>>
>> INIT()
>> dbs_data exists
> 
> You missed the usage_count++ here.

Ok, sorry about that. How about the below ?
> 
>> so return
>>                             EXIT()
>>                             dbs_data->usage_count -- = 0
>>                             kfree(dbs_data)
> 
>                                 And so this shouldn't happen. Else we
>                                 are missing locking in governor's
>                                 code, rather than cpufreq.c
> 
 CPU0                        CPU1

store*                     store*

lock(policy 1)              lock(policy 2)
cpufreq_set_policy()       cpufreq_set_policy()
EXIT() :
dbs-data->usage_count--

INIT()                      EXIT()
dbs_data exists             dbs_data->usage_count -- = 0
                            kfree(dbs_data)
dbs-data->usage_count++
*NULL dereference*

The point is there are potential race conditions. Its just a matter of
interleaving ?

Regards
Preeti U Murthy

