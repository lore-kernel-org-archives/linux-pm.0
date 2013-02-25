From: Nathan Zimmer <nzimmer@sgi.com>
Subject: Re: [PATCH v4 2/2] cpufreq: Convert the cpufreq_driver_lock to use
 the rcu
Date: Mon, 25 Feb 2013 14:07:31 -0600
Message-ID: <512BC483.8010101@sgi.com>
References: <51265E0F.6090209@sgi.com> <1361550275-5716-1-git-send-email-nzimmer@sgi.com> <1361550275-5716-3-git-send-email-nzimmer@sgi.com> <CAKohpom9q93cVD61qeht2WXgA=no64dwXowtMHS0wCy0k6qxXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpom9q93cVD61qeht2WXgA=no64dwXowtMHS0wCy0k6qxXw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 02/22/2013 09:39 PM, Viresh Kumar wrote:
> Hi Nathan,
>
> Sorry for pointing out this so late but i still feel we are missing something
> really important.
>
> On 22 February 2013 21:54, Nathan Zimmer <nzimmer@sgi.com> wrote:
>
>> -       read_lock_irqsave(&cpufreq_driver_lock, flags);
>> +       rcu_read_lock();
>> +       freqs->flags = rcu_dereference(cpufreq_driver)->flags;
>>          policy = per_cpu(cpufreq_cpu_data, freqs->cpu);
>> -       read_unlock_irqrestore(&cpufreq_driver_lock, flags);
>> +       rcu_read_unlock();
>> -       write_lock_irqsave(&cpufreq_driver_lock, flags);
>> +       spin_lock_irqsave(&cpufreq_driver_lock, flags);
>>          for_each_cpu(j, policy->cpus) {
>>                  per_cpu(cpufreq_cpu_data, j) = policy;
>>                  per_cpu(cpufreq_policy_cpu, j) = policy->cpu;
>>          }
>> -       write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>> +       spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
> Look at how we are protecting cpufreq_cpu_data here. rcu_read_[un]lock()
> only marks the start/end of critical section. How are we sure here that
> cpufreq_cpu_data is not read simultaneously when we are updating it?
>
> rcu lock/unlock only works for cpufreq_driver pointer only and not for
> this data. We still need the same locking for for cpufreq_cpu_data.
>
> What do you say?

That would include putting the lock around the  __cpufreq_cpu_get.
But I do think your right.

Perhaps a better way at this point is to have one lock for 
cpufreq_cpu_data, and a second with the rcu to protect cpufreq_driver.


