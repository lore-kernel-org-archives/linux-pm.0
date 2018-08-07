From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v3 01/14] sched/core: uclamp: extend sched_setattr to
 support utilization clamping
Date: Tue, 7 Aug 2018 14:35:50 +0200
Message-ID: <20180807123550.GA3062@localhost.localdomain>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-2-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180806163946.28380-2-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 06/08/18 17:39, Patrick Bellasi wrote:

[...]

> @@ -4218,6 +4245,13 @@ static int __sched_setscheduler(struct task_struct *p,
>  			return retval;
>  	}
>  
> +	/* Configure utilization clamps for the task */
> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP) {
> +		retval = __setscheduler_uclamp(p, attr);
> +		if (retval)
> +			return retval;
> +	}
> +

IIUC, this is available to root and non-root users. In the latter case,
how do we cope with the fact that some user might occupy all the
available clamping groups configured for the system?

Best,

- Juri
