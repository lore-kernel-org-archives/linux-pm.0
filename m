From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [Update][PATCH] cpufreq: Do not hold driver module references
 for additional policy CPUs
Date: Fri, 02 Aug 2013 17:05:27 +0530
Message-ID: <51FB997F.3090801@linux.vnet.ibm.com>
References: <2362640.pUofnXyzOi@vostro.rjw.lan> <51FAC46D.1000703@linux.vnet.ibm.com>	<1757496.qSuJuAun9Z@vostro.rjw.lan> <2298639.F0Qv2QqRnZ@vostro.rjw.lan> <CAKohpokbd=xX-DqVeEZOnGftZuE-54RDShpMJgFPskRc3CkZ5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:36211 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912Ab3HBLjN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Aug 2013 07:39:13 -0400
Received: from /spool/local
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Fri, 2 Aug 2013 21:23:03 +1000
In-Reply-To: <CAKohpokbd=xX-DqVeEZOnGftZuE-54RDShpMJgFPskRc3CkZ5w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM list <linux-pm@vger.kernel.org>, cpufreq@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>

On 08/02/2013 04:00 PM, Viresh Kumar wrote:
> On 2 August 2013 02:23, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> To remove that inconsistency make cpufreq_add_policy_cpu() execute
>> cpufreq_cpu_put() for the given policy before returning, which
>> decrements the driver module refcount so that it will be 0 after
>> __cpufreq_add_dev() returns.  Moreover, remove the cpufreq_cpu_get()
>> call from cpufreq_add_dev_symlink(), since both the policy refcount
>> and the driver module refcount are nonzero when it is called and they
>> don't need to be bumped up by it.
> 
> Sorry for creating so many problems but my concerns with this patch
> aren't yet over :(
> 
> Should we increment policy refcount or kobj refcount for every cpu it
> is used on? I think yes, that's probably the right way of doing it.
>

It depends on how you look at it. The number of CPUs in the policy
(cpumask_weight(policy)) itself serves as a refcount. We don't actually
need yet another refcount to manage things. Besides, not bumping
up the policy refcount for every CPU actually seems to simplify the
code and make it easier to understand, so why not do it? :-)
 
> And so we simply can't remove calls to cpufreq_cpu_get() from
> cpufreq_add_dev_symlink() routine and also from
> cpufreq_add_policy_cpu()..


Regards,
Srivatsa S. Bhat

