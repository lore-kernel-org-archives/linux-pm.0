From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] cpufreq: Fix a circular lock dependency problem
Date: Mon, 23 Jul 2018 21:16:27 +0200
Message-ID: <20180723191627.GJ2494@hirez.programming.kicks-ass.net>
References: <1532368179-15263-1-git-send-email-longman@redhat.com>
 <1532368179-15263-3-git-send-email-longman@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1532368179-15263-3-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Waiman Long <longman@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 23, 2018 at 01:49:39PM -0400, Waiman Long wrote:
>  drivers/cpufreq/cpufreq.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index b0dfd32..9cf02d7 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -922,8 +922,22 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
>  	struct cpufreq_policy *policy = to_policy(kobj);
>  	struct freq_attr *fattr = to_attr(attr);
>  	ssize_t ret = -EINVAL;
> +	int retries = 3;
>  
> -	cpus_read_lock();
> +	/*
> +	 * cpus_read_trylock() is used here to work around a circular lock
> +	 * dependency problem with respect to the cpufreq_register_driver().
> +	 * With a simple retry loop, the chance of not able to get the
> +	 * read lock is extremely small.
> +	 */
> +	while (!cpus_read_trylock()) {
> +		if (retries-- <= 0)
> +			return -EBUSY;
> +		/*
> +		 * Sleep for about 50ms and retry again.
> +		 */
> +		msleep(50);
> +	}

That's atrocious.
