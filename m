From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 02/10] cpufreq: provide default frequency-invariance
 setter function
Date: Tue, 19 Sep 2017 11:39:17 -0700
Message-ID: <20170919183917.GC2792@ubuntu>
References: <20170825143206.30467-1-dietmar.eggemann@arm.com>
 <20170825143206.30467-3-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:47811 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751074AbdISSjU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Sep 2017 14:39:20 -0400
Received: by mail-pg0-f54.google.com with SMTP id d8so292938pgt.4
        for <linux-pm@vger.kernel.org>; Tue, 19 Sep 2017 11:39:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170825143206.30467-3-dietmar.eggemann@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>

On 25-08-17, 15:31, Dietmar Eggemann wrote:
> Frequency-invariant accounting support based on the ratio of current
> frequency and maximum supported frequency is an optional feature an arch
> can implement.
> 
> Since there are cpufreq drivers (e.g. cpufreq-dt) which can be build for
> different arch's a default implementation of the frequency-invariance
> setter function arch_set_freq_scale() is needed.
> 
> This default implementation is an empty weak function which will be
> overwritten by a strong function in case the arch provides one.
> 
> The setter function passes the cpumask of related (to the frequency
> change) cpus (online and offline cpus), the (new) current frequency and
> the maximum supported frequency.
> 
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 6 ++++++
>  include/linux/cpufreq.h   | 3 +++
>  2 files changed, 9 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
