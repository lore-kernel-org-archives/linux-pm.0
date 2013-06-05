From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Cpufreq userspace governor start/stop issue
Date: Wed, 5 Jun 2013 11:47:04 +0530
Message-ID: <CAKohpokg2ajii1gfH-6O8JPs4tWEMxwFVr0saeBauZXaNZCZYw@mail.gmail.com>
References: <CAFgnuDd_6z+g2m8QAfZBaCnwUYUPWB6Dku_3KvmTJ4mOrcOa6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAFgnuDd_6z+g2m8QAfZBaCnwUYUPWB6Dku_3KvmTJ4mOrcOa6Q@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Xiaoguang Chen <chenxg.marvell@gmail.com>
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Lists linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-pm@vger.kernel.org

On 5 June 2013 08:54, Xiaoguang Chen <chenxg.marvell@gmail.com> wrote:
> Hi, Guys

Hi Xiaoguang,

> I met another question for cpufreq governor. When hotplug out one cpu,
> cpufreq will remove the cpu device and also call governor stop, if
> there are more than 1 cpu and cpu0 is the root for cpufreq, other cpus
> are linked to cpu0. then policy->cpu is 0 always.

Not really.. There are situations when this will not hold true..
If you hot-unplug cpu0, then next cpu in line, i.e. cpu 1, will become
policy->cpu :)

> in userspace governor, when governor stop is called, it will set
> per_cpu(cpu_is_managed, cpu) = 0

To make it clear, cpu_is_managed isn't telling which cpu is managing
'cpu' but if governor is enabled for cpu 'cpu' or not.

> but the cpu is policy->cpu which is 0 always.
>
>        case CPUFREQ_GOV_STOP:
>                 mutex_lock(&userspace_mutex);
>                 cpus_using_userspace_governor--;
>                 if (cpus_using_userspace_governor == 0) {
>                         cpufreq_unregister_notifier(
>                                         &userspace_cpufreq_notifier_block,
>                                         CPUFREQ_TRANSITION_NOTIFIER);
>                 }
>
>                 per_cpu(cpu_is_managed, cpu) = 0;
>                 per_cpu(cpu_min_freq, cpu) = 0;
>                 per_cpu(cpu_max_freq, cpu) = 0;
>                 per_cpu(cpu_set_freq, cpu) = 0;
>                 pr_debug("managing cpu %u stopped\n", cpu);
>                 mutex_unlock(&userspace_mutex);
>                 break;
>
>
> also in userspace governor store_setspeed function cpufreq_set will
> retun error if per_cpu(cpu_is_managed, cpu) is 0 which means it will
> not change frequency .
>
> static int cpufreq_set(struct cpufreq_policy *policy, unsigned int freq)
> {
> int ret = -EINVAL;
>
> pr_debug("cpufreq_set for cpu %u, freq %u kHz\n", policy->cpu, freq);
>
> mutex_lock(&userspace_mutex);
> if (!per_cpu(cpu_is_managed, policy->cpu))
> goto err;
>
> per_cpu(cpu_set_freq, policy->cpu) = freq;
> ...........
>
>
>
> So consider below case:
> 1) cpu0 tries to hotplug cpu3, it calls userspace governor stop
> function, it should stop cpu3's userspace governor, but it actually
> set cpu0's per_cpu(cpu_is_managed, cpu) to 0.
> 2) cpu0 tries to change cpu freuqency through userspace governor, but
> it will never succeed since cpufreq_set will return err if cpu0'
> percpu variable cpu_is_managed is 0.
> 3) unless there is another cpu hotplug in operation, in which it calls
> governor start and set cpu_is_managed to 1, then the frequency change
> will go on and doesn't report error.
>
> The reason here is policy->cpu is always 0 if we use managed policy
> for all cpus. but we can't see which cpu's governor want's to
> start/stop in userspace goveror. we can only get the information from
> struct policy, but this policy doesn't include the exact cpu that
> wants to do governor start/stop.
>
>
> Any suggestions for this issue?

Hmm.. the problem is bigger than what you observed..
I am starting to cleanup userspace governor now and will cc you
for my patches. Please test them and give your Tested-by :)
