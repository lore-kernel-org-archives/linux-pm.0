From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH] cpufreq: Do not hold driver module references for
 additional policy CPUs
Date: Fri, 02 Aug 2013 00:31:23 +0530
Message-ID: <51FAB083.5050900@linux.vnet.ibm.com>
References: <2362640.pUofnXyzOi@vostro.rjw.lan> <1864010.r8gSosnm8c@vostro.rjw.lan> <51FAA3B9.7040009@linux.vnet.ibm.com> <1656801.jLHjvytfNU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1656801.jLHjvytfNU@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, cpufreq@vger.kernel.org, Lists linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-pm@vger.kernel.org

On 08/02/2013 12:31 AM, Rafael J. Wysocki wrote:
> On Thursday, August 01, 2013 11:36:49 PM Srivatsa S. Bhat wrote:
>> Its the cpufreq_cpu_get() hidden away in cpufreq_add_dev_symlink(). With
>> that taken care of, everything should be OK. Then we can change the
>> synchronization part to avoid using refcounts.
> 
> So I actually don't see why cpufreq_add_dev_symlink() needs to call
> cpufreq_cpu_get() at all, since the policy refcount is already 1 at the
> point it is called and the bumping up of the driver module refcount is
> pointless.
> 

Hmm, yes, it seems so.

> However, if I change that I also need to change the piece of code that
> calls the complementary cpufreq_cpu_put() and I kind of cannot find it.
> 

... I guess that's because you are looking at the code with your patch
applied (and your patch removed that _put()) ;-)

Its this part in __cpufreq_remove_dev():

1303         } else {
1304 
1305                 if (!frozen) {
1306                         pr_debug("%s: removing link, cpu: %d\n", __func__, cpu);
1307                         cpufreq_cpu_put(data);
1308                 }
1309 

 
Regards,
Srivatsa S. Bhat
