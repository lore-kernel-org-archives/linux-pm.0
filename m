From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpufreq: Remove cpufreq_rwsem
Date: Thu, 23 Jul 2015 22:59:53 +0200
Message-ID: <3827470.2xPx8lfogL@vostro.rjw.lan>
References: <1437560730-31756-1-git-send-email-bigeasy@linutronix.de> <20150722155911.GB8704@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150722155911.GB8704@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, July 22, 2015 05:59:11 PM Sebastian Andrzej Siewior wrote:
> cpufreq_rwsem was introduced in commit 6eed9404ab3c4 ("cpufreq: Use
> rwsem for protecting critical sections) in order to replace
> try_module_get() on the cpu-freq driver. That try_module_get() worked
> well until the refcount was so heavily used that module removal became
> more or less impossible.
> 
> Though when looking at the various (undocumented) protection
> mechanisms in that code, the randomly sprinkeled around cpufreq_rwsem
> locking sites are superfluous.
> 
> The policy, which is acquired in cpufreq_cpu_get() and released in
> cpufreq_cpu_put() is sufficiently protected already.
> 
>   cpufreq_cpu_get(cpu)
>     /* Protects against concurrent driver removal */
>     read_lock_irqsave(&cpufreq_driver_lock, flags);
>     policy = per_cpu(cpufreq_cpu_data, cpu);
>     kobject_get(&policy->kobj);
>     read_unlock_irqrestore(&cpufreq_driver_lock, flags);
> 
> The reference on the policy serializes versus module unload already:
> 
>   cpufreq_unregister_driver()
>     subsys_interface_unregister()
>       __cpufreq_remove_dev_finish()
>         per_cpu(cpufreq_cpu_data) = NULL;
> 	cpufreq_policy_put_kobj()
> 
> If there is a reference held on the policy, i.e. obtained prior to the
> unregister call, then cpufreq_policy_put_kobj() will wait until that
> reference is dropped. So once subsys_interface_unregister() returns
> there is no policy pointer in flight and no new reference can be
> obtained. So that rwsem protection is useless.
> 
> The other usage of cpufreq_rwsem in show()/store() of the sysfs
> interface is redundant as well because sysfs already does the proper
> kobject_get()/put() pairs.
> 
> That leaves CPU hotplug versus module removal. The current
> down_write() around the write_lock() in cpufreq_unregister_driver() is
> silly at best as it protects actually nothing.
> 
> The trivial solution to this is to prevent hotplug across
> cpufreq_unregister_driver completely.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Makes sense.

Queued up for 4.3, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
