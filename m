From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH] cpufreq/hotplug: Fix cpu-hotplug cpufreq race
 conditions
Date: Tue, 2 Jun 2015 11:41:33 +0530
Message-ID: <20150602061133.GE10443@linux>
References: <20150601064031.2972.59208.stgit@perfhull-ltc.austin.ibm.com>
 <20150601071934.GC4242@linux>
 <556D3FAA.3080703@linux.vnet.ibm.com>
 <20150602053956.GD10443@linux>
 <556D4748.7040105@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <556D4748.7040105@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, ego@linux.vnet.ibm.com, paulus@samba.org, linux-kernel@vger.kernel.org, shilpa.bhat@linux.vnet.ibm.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 02-06-15, 11:33, Preeti U Murthy wrote:
> No, dbs_data is a governor wide data structure and not a policy wide

Yeah, that's the common part which I was referring to. But normally
its just read for policies in START/STOP, they just update per-cpu
data for policy->cpus.

> one, which is manipulated in START/STOP calls for drivers where the
> CPUFREQ_HAVE_GOVERNOR_PER_POLICY is not set.
> 
> So even if we assume that we hold per-policy locks, the following race
> is still present. Assume that we have just two cpus which do not have a
> governor-per-policy set.
> 
> CPU0                        CPU1
> 
>  store*                     store*
> 
> lock(policy 1)              lock(policy 2)
> cpufreq_set_policy()       cpufreq_set_policy()
> EXIT() :
> dbs-data->usage_count--
> 
> INIT()
> dbs_data exists

You missed the usage_count++ here.

> so return
>                             EXIT()
>                             dbs_data->usage_count -- = 0
>                             kfree(dbs_data)

                                And so this shouldn't happen. Else we
                                are missing locking in governor's
                                code, rather than cpufreq.c

-- 
viresh
