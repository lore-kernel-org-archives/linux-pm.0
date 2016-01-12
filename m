From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 09/19] cpufreq: fix warning for
 show_scaling_available_governors unlocked access to cpufreq_governor_list
Date: Tue, 12 Jan 2016 15:43:15 +0530
Message-ID: <20160112101315.GA1084@ubuntu>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-10-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1452533760-13787-10-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On 11-01-16, 17:35, Juri Lelli wrote:
> show_scaling_available_governors iterates through cpufreq_governor_list
> without holding cpufreq_governor_mutex; this generates the following
> warning:
> 
> [  700.910381] ------------[ cut here ]------------
> [  700.924282] WARNING: CPU: 2 PID: 1756 at kernel/drivers/cpufreq/cpufreq.c:700 show_scaling_available_governors+0x6f/0xb8()
> [  700.965473] Modules linked in:
> [  700.974637] CPU: 2 PID: 1756 Comm: cat Tainted: G        W       4.4.0-rc2+ #299
> [  700.996813] Hardware name: ARM-Versatile Express
> [  701.010674] [<c0014215>] (unwind_backtrace) from [<c0010e25>] (show_stack+0x11/0x14)
> [  701.033905] [<c0010e25>] (show_stack) from [<c02eca5d>] (dump_stack+0x55/0x78)
> [  701.055561] [<c02eca5d>] (dump_stack) from [<c00202cd>] (warn_slowpath_common+0x59/0x84)
> [  701.079839] [<c00202cd>] (warn_slowpath_common) from [<c002030f>] (warn_slowpath_null+0x17/0x1c)
> [  701.106182] [<c002030f>] (warn_slowpath_null) from [<c03b7bef>] (show_scaling_available_governors+0x6f/0xb8)
> [  701.135656] [<c03b7bef>] (show_scaling_available_governors) from [<c03b7dc3>] (show+0x27/0x38)
> [  701.161488] [<c03b7dc3>] (show) from [<c015469f>] (sysfs_kf_seq_show+0x5f/0xa0)
> [  701.183409] [<c015469f>] (sysfs_kf_seq_show) from [<c01536a7>] (kernfs_seq_show+0x1b/0x1c)
> [  701.208188] [<c01536a7>] (kernfs_seq_show) from [<c011a6d5>] (seq_read+0x129/0x33c)
> [  701.231161] [<c011a6d5>] (seq_read) from [<c00ff7c7>] (__vfs_read+0x1b/0x84)
> [  701.252300] [<c00ff7c7>] (__vfs_read) from [<c010000f>] (vfs_read+0x5f/0xb0)
> [  701.273436] [<c010000f>] (vfs_read) from [<c0100099>] (SyS_read+0x39/0x68)
> [  701.294049] [<c0100099>] (SyS_read) from [<c000df21>] (ret_fast_syscall+0x1/0x1a)
> [  701.316484] ---[ end trace 5dd15744a4da127c ]---

FWIW, I would suggest you to use cpufreq-dt for Juno instead of
arm_bL. I have asked Sudeep to do it earlier, but perhaps he was busy.

> Fix this by locking cpufreq_governor_mutex before for_each_governor().
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index d065435..d91fdb8 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -694,7 +694,7 @@ static ssize_t show_scaling_available_governors(struct cpufreq_policy *policy,
>  		goto out;
>  	}
>  
> -	lockdep_assert_held(&cpufreq_governor_mutex);
> +	mutex_lock(&cpufreq_governor_mutex);
>  	for_each_governor(t) {
>  		if (i >= (ssize_t) ((PAGE_SIZE / sizeof(char))
>  		    - (CPUFREQ_NAME_LEN + 2)))
> @@ -702,6 +702,7 @@ static ssize_t show_scaling_available_governors(struct cpufreq_policy *policy,
>  		i += scnprintf(&buf[i], CPUFREQ_NAME_PLEN, "%s ", t->name);
>  	}
>  out:
> +	mutex_unlock(&cpufreq_governor_mutex);
>  	i += sprintf(&buf[i], "\n");
>  	return i;
>  }

Just move this patch before before the patch that added the
lockdep-assert and we wouldn't be required to add the
lockdep_assert_held() in the first place.

-- 
viresh
