From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 2/2] cpufreq: Convert the cpufreq_driver_lock to use
 the rcu
Date: Sat, 23 Feb 2013 09:09:31 +0530
Message-ID: <CAKohpom9q93cVD61qeht2WXgA=no64dwXowtMHS0wCy0k6qxXw@mail.gmail.com>
References: <51265E0F.6090209@sgi.com>
	<1361550275-5716-1-git-send-email-nzimmer@sgi.com>
	<1361550275-5716-3-git-send-email-nzimmer@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1361550275-5716-3-git-send-email-nzimmer@sgi.com>
Sender: cpufreq-owner@vger.kernel.org
To: Nathan Zimmer <nzimmer@sgi.com>
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Nathan,

Sorry for pointing out this so late but i still feel we are missing something
really important.

On 22 February 2013 21:54, Nathan Zimmer <nzimmer@sgi.com> wrote:

> -       read_lock_irqsave(&cpufreq_driver_lock, flags);
> +       rcu_read_lock();
> +       freqs->flags = rcu_dereference(cpufreq_driver)->flags;
>         policy = per_cpu(cpufreq_cpu_data, freqs->cpu);
> -       read_unlock_irqrestore(&cpufreq_driver_lock, flags);
> +       rcu_read_unlock();

> -       write_lock_irqsave(&cpufreq_driver_lock, flags);
> +       spin_lock_irqsave(&cpufreq_driver_lock, flags);
>         for_each_cpu(j, policy->cpus) {
>                 per_cpu(cpufreq_cpu_data, j) = policy;
>                 per_cpu(cpufreq_policy_cpu, j) = policy->cpu;
>         }
> -       write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> +       spin_unlock_irqrestore(&cpufreq_driver_lock, flags);

Look at how we are protecting cpufreq_cpu_data here. rcu_read_[un]lock()
only marks the start/end of critical section. How are we sure here that
cpufreq_cpu_data is not read simultaneously when we are updating it?

rcu lock/unlock only works for cpufreq_driver pointer only and not for
this data. We still need the same locking for for cpufreq_cpu_data.

What do you say?
