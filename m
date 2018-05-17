From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH RFC] schedutil: Allow cpufreq requests to be made even
 when kthread kicked
Date: Thu, 17 May 2018 09:00:26 +0200
Message-ID: <20180517070026.GA22493@localhost.localdomain>
References: <20180516224518.109891-1-joel@joelfernandes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180516224518.109891-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Luca Abeni <luca.abeni@santannapisa.it>, Joel Fernandes <joelaf@google.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Joel,

On 16/05/18 15:45, Joel Fernandes (Google) wrote:

[...]

> @@ -382,13 +391,24 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
>  static void sugov_work(struct kthread_work *work)
>  {
>  	struct sugov_policy *sg_policy = container_of(work, struct sugov_policy, work);
> +	unsigned int freq;
> +	unsigned long flags;
> +
> +	/*
> +	 * Hold sg_policy->update_lock shortly to handle the case where:
> +	 * incase sg_policy->next_freq is read here, and then updated by
> +	 * sugov_update_shared just before work_in_progress is set to false
> +	 * here, we may miss queueing the new update.
> +	 */
> +	raw_spin_lock_irqsave(&sg_policy->update_lock, flags);
> +	freq = sg_policy->next_freq;
> +	sg_policy->work_in_progress = false;
> +	raw_spin_unlock_irqrestore(&sg_policy->update_lock, flags);

OK, we queue the new request up, but still we need to let this kthread
activation complete and then wake it up again to service the request
already queued, right? Wasn't what Claudio proposed (service back to
back requests all in the same kthread activation) better from an
overhead pow?

Also, I assume that there's no problem kicking the irq_work thing while
the kthread that it's going to be woken up it's already running?

>  
>  	mutex_lock(&sg_policy->work_lock);
> -	__cpufreq_driver_target(sg_policy->policy, sg_policy->next_freq,
> +	__cpufreq_driver_target(sg_policy->policy, freq,
>  				CPUFREQ_RELATION_L);
>  	mutex_unlock(&sg_policy->work_lock);
> -
> -	sg_policy->work_in_progress = false;
>  }

Best,

- Juri
