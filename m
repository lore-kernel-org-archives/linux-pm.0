From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V6] powercap/drivers/idle_injection: Add an idle
 injection framework
Date: Tue, 12 Jun 2018 14:59:31 +0200
Message-ID: <20180612125930.GP12217@hirez.programming.kicks-ass.net>
References: <1528804816-32636-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1528804816-32636-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: viresh.kumar@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rui Zhang <rui.zhang@intel.com>, Daniel Thompson <daniel.thompson@linaro.org>, Andrea Parri <andrea.parri@amarulasolutions.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 12, 2018 at 02:00:11PM +0200, Daniel Lezcano wrote:
> +struct idle_injection_device {

remove this:
> +	cpumask_var_t cpumask;

> +	struct hrtimer timer;
> +	struct completion stop_complete;
> +	unsigned int idle_duration_ms;
> +	unsigned int run_duration_ms;
> +	atomic_t count;

add:
	unsigned long cpumask[0];
> +};


> +static struct idle_injection_device *ii_dev_alloc(void)
> +{
> +	struct idle_injection_device *ii_dev;
> +
> +	ii_dev = kzalloc(sizeof(*ii_dev), GFP_KERNEL);

use:

	sizeof(*ii_dev) + cpumask_size()

> +	if (!ii_dev)
> +		return NULL;
> +

delete:

> +	if (!alloc_cpumask_var(&ii_dev->cpumask, GFP_KERNEL)) {
> +		kfree(ii_dev);
> +		return NULL;
> +	}
> +
> +	return ii_dev;
> +}

And use:

	to_cpumask(ii_dev->cpumask)
