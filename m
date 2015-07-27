From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/7] cpufreq: Drop cpufreq_policy_restore()
Date: Mon, 27 Jul 2015 20:18:54 +0530
Message-ID: <20150727144854.GD18535@linux>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan>
 <3874727.Jpay9zgokc@vostro.rjw.lan>
 <1831805.k1h8RcvUky@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1831805.k1h8RcvUky@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On 27-07-15, 16:03, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notice that when cpufreq_policy_restore() is called, its per-CPU
> cpufreq_cpu_data variable has been already dereferenced and if that
> variable is not NULL, the policy local pointer in cpufreq_add_dev()
> contains its value.
> 
> Therefore it is not necessary to dereference it again and the
> policy pointer can be used directly.  Moreover, if that pointer
> is not NULL, the policy is inactive (or the previous check would
> have made us return from cpufreq_add_dev()) so the restoration
> code from cpufreq_policy_restore() can be moved to that point
> in cpufreq_add_dev().
> 
> Do that and drop cpufreq_policy_restore().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   44 +++++++++++---------------------------------
>  1 file changed, 11 insertions(+), 33 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
