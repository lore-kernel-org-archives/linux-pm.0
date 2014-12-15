From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: 3.18: lockdep problems in cpufreq
Date: Mon, 15 Dec 2014 09:26:59 +0530
Message-ID: <CAKohpok6ieJYgusMh+WFCQT8d5_QVgGczmQyD79UPz4hdYU1Dg@mail.gmail.com>
References: <20141214213655.GA11285@n2100.arm.linux.org.uk>
	<7573578.UE8ufgjWuX@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:57244 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbaLOD5A (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 14 Dec 2014 22:57:00 -0500
Received: by mail-oi0-f48.google.com with SMTP id u20so7508577oif.21
        for <linux-pm@vger.kernel.org>; Sun, 14 Dec 2014 19:56:59 -0800 (PST)
In-Reply-To: <7573578.UE8ufgjWuX@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, yadi.brar@samsung.com
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

On 15 December 2014 at 03:53, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Sunday, December 14, 2014 09:36:55 PM Russell King - ARM Linux wrote:
>> Here's a nice Christmas present one of my iMX6 machines gave me tonight.
>> I haven't begun to look into it.

Is the culprit this one?

Fixes: 2dcd851fe4b4 ("thermal: cpu_cooling: Update always cpufreq
policy with thermal constraints")

As this is what it changed:

@@ -316,21 +312,28 @@ static int cpufreq_thermal_notifier(struct
notifier_block *nb,
 {
        struct cpufreq_policy *policy = data;
        unsigned long max_freq = 0;
+       struct cpufreq_cooling_device *cpufreq_dev;

-       if (event != CPUFREQ_ADJUST || notify_device == NOTIFY_INVALID)
+       if (event != CPUFREQ_ADJUST)
                return 0;

-       if (cpumask_test_cpu(policy->cpu, &notify_device->allowed_cpus))
-               max_freq = notify_device->cpufreq_val;
-       else
-               return 0;
+       mutex_lock(&cooling_cpufreq_lock);
+       list_for_each_entry(cpufreq_dev, &cpufreq_dev_list, node) {
+               if (!cpumask_test_cpu(policy->cpu,
+                                       &cpufreq_dev->allowed_cpus))
+                       continue;
+
+               if (!cpufreq_dev->cpufreq_val)
+                       cpufreq_dev->cpufreq_val = get_cpu_frequency(
+                                       cpumask_any(&cpufreq_dev->allowed_cpus),
+                                       cpufreq_dev->cpufreq_state);

-       /* Never exceed user_policy.max */
-       if (max_freq > policy->user_policy.max)
-               max_freq = policy->user_policy.max;
+               max_freq = cpufreq_dev->cpufreq_val;

-       if (policy->max != max_freq)
-               cpufreq_verify_within_limits(policy, 0, max_freq);
+               if (policy->max != max_freq)
+                       cpufreq_verify_within_limits(policy, 0, max_freq);
+       }
+       mutex_unlock(&cooling_cpufreq_lock);

        return 0;
 }


>> ======================================================
>> [ INFO: possible circular locking dependency detected ]
>> 3.18.0+ #1453 Not tainted
>> -------------------------------------------------------
>> rc.local/770 is trying to acquire lock:
>>  (cooling_cpufreq_lock){+.+.+.}, at: [<c04abfc4>] cpufreq_thermal_notifier+0x34/0xfc
>>
>> but task is already holding lock:
>>  ((cpufreq_policy_notifier_list).rwsem){++++.+}, at: [<c0042f04>]  __blocking_notifier_call_chain+0x34/0x68
>>
>> which lock already depends on the new lock.
>
> Well, that's for Viresh.

Maybe not as the rework I have done is queued for this merge window.
I was afraid really after reading the "offenders" discussion on IRC :)

Cc'd Yadwinder as well who wrote this patch.
