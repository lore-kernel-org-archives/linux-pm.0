From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: CPUfreq lockdep issue
Date: Thu, 18 Feb 2016 17:04:37 +0530
Message-ID: <20160218113437.GX2610@vireshk-i7>
References: <1455793609.9851.45.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34236 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945965AbcBRLev (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2016 06:34:51 -0500
Received: by mail-pa0-f44.google.com with SMTP id fy10so29500100pac.1
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2016 03:34:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1455793609.9851.45.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>

On 18-02-16, 13:06, Joonas Lahtinen wrote:
> Hi,
> 
> The Intel P-state driver has a lockdep issue as described below. It
> could in theory cause a deadlock if initialization and suspend were to
> be performed simultaneously. Conflicting calling paths are as follows:
> 
> intel_pstate_init(...)
> 	...cpufreq_online(...)
> 		down_write(&policy->rwsem); // Locks policy->rwsem
> 		...
> 		cpufreq_init_policy(policy);
> 			...intel_pstate_hwp_set();
> 				get_online_cpus(); // Temporarily locks cpu_hotplug.lock

Why is this one required?

> 		...
> 		up_write(&policy->rwsem);
> 
> pm_suspend(...)
> 	...disable_nonboot_cpus()
> 		_cpu_down()
> 			cpu_hotplug_begin(); // Locks cpu_hotplug.lock
> 			__cpu_notify(CPU_DOWN_PREPARE, ...);
> 				...cpufreq_offline_prepare();
> 					down_write(&policy->rwsem); // Locks policy->rwsem
> 
> Quickly looking at the code, some refactoring has to be done to fix the
> issue. I think it would a good idea to document some of the driver
> callbacks related to what locks are held etc. in order to avoid future
> situations like this.
> 
> Because get_online_cpus() is of recursive nature and the way it
> currently works, adding wider get_online_cpus() scope up around
> cpufreq_online() does not fix the issue because it only momentarily
> locks cpu_hotplug.lock and proceeds to do so again at next call.
> 
> Moving get_online_cpus() completely away from pstate_hwp_set() and
> assuring it is called higher in the call chain might be a viable
> solution. Then it could be made sure get_online_cpus() is not called
> while policy->rwsem is being held already.

I don't think that will be a good solution. So what you are
essentially saying is, take policy->rwsem after get_online_cpus()
only.

> Do you think that would be an appropriate way of fixing it?

At least I don't. Why do we need to call get_online_cpus()
intel-pstate governor ?

-- 
viresh
