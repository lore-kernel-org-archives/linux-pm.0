From: Saravana Kannan <skannan@codeaurora.org>
Subject: Bug in cpufreq_update_util hook handling?
Date: Wed, 21 Jun 2017 17:24:51 -0700
Message-ID: <594B0E53.7020208@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58700 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbdFVAYx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jun 2017 20:24:53 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>

cpufreq_add_update_util_hook() registers the "data" and we are using 
RCUs to store "data".

When we need to send util updates, scheduler calls cpufreq_update_util() 
that just uses a rcu_dereference_sched() to access the data pointer.

When the governor is stopped, to unregister the hook, it calls 
cpufreq_remove_update_util_hook() and calls synchronize_sched(). The 
assumption that the governor is making (and is allowed to make) is that 
after synchronize_sched() all references to "data" and "func" are no 
longer used (since cpufreq_remove_update_util_hook is supposed to 
replace data with NULL).

I'm no RCU, expert, if I understand it right, if we don't use 
"rcu_read_lock()" and "rcu_read_unlock()" in cpufreq_update_util(), then 
the scheduler can continue calling into the governor hooks after the 
governor has stopped.

rcu_read_lock();
data = rcu_dereference_sched(*per_cpu_ptr(&cpufreq_update_util_data,
				cpu_of(rq)));
if (data)
	data->func(data, sched_clock(), flags);
rcu_read_unlock();

Is my understanding right? Is my suggest fix acceptable? I can send a 
patch for it if it's acceptable.

On a separate note, I think the synchronize_sched() should be inside 
cpufreq_remove_update_util_hook(). I can't think of any reason any 
caller (governor) would want to allow access to the old "data" pointer 
after unregistering the hooks. Also, the user of the hooks shouldn't 
have to know whether the we use RCU or spinlock or whatever locking to 
protect the data we pass into the add/remove functions. That doesn't 
seem like a good abstractions -- especially for simple add/remove functions.

Thanks,
Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
