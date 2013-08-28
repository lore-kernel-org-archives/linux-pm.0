From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: governors: Remove duplicate check of target freq
 in supported range
Date: Wed, 28 Aug 2013 11:05:19 +0530
Message-ID: <CAKohpokg3xqKRmDgzeL+dZc07x1KUZ=hKdx_YrVoDbi572N_sg@mail.gmail.com>
References: <521BA068.8030003@semaphore.gr>
	<CAKohpo=xBmpEv=oN1qEnq9RKhfjtc4wZayVYyVzjWOU8BnwVJQ@mail.gmail.com>
	<521CC9B8.2020801@semaphore.gr>
	<CAKohpo=XhHtRfsVrUZr0DQCK5L5zU_6DB4PBOA4QrJBvvcbe0Q@mail.gmail.com>
	<521CE317.20908@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <521CE317.20908@semaphore.gr>
Sender: linux-kernel-owner@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

 27 August 2013 23:04, Stratos Karafotis <stratosk@semaphore.gr> wrote:
> I'm sorry. Let me try to explain this better.

Don't be :)

> With my patch, dbs_info->requested_freq will not be capped within
> policy->min and policy->max in cs_check_cpu.
> So, temporarily it may have a value greater than policy->max
> or lower that policy->min.
> When we call __cpufreq_driver_target, the correct frequency will be selected
> because __cpufreq_driver_target takes care to adjust the
> target frequency within policy range.
> But, eventually, dbs_cpufreq_notifier will adjust dbs_info->requested
> within policy range, if needed.
>
> If we remove
>
>         if (dbs_info->requested_freq == policy->max)
>                 return;
> and
>
>         if (policy->cur == policy->min)
>                 return;
>
> request_freq will keep increasing or decreasing in each iteration and
> finally will overflow or underflow.
>
> Consider, for example, that in a CPU with policy->max = 1000MHz
> the current frequency is 950MHz. With a constant load above
> up_threshold, the requested_freq in first iteration will be 1000MHz
> and __cpufreq_driver_target will select 1000MHz freq.
>
> In second iteration, requested_freq will be 1050MHz, and
> __cpufreq_driver_target will select 1000MHz. dbs_cpufreq_notifier
> will adjust requested_freq back to 1000MHz.
>
> In next iterations, dbs_cpufreq_notifier will not be called, so we
> need the above check (dbs_info->requested_freq == policy->max) to
> prevent requested_freq to grow arbitrary.
>
> I hope my explanation was better now. :)

Yes, your initial patch is fine.
