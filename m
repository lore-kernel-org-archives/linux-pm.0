From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v3 05/14] sched/cpufreq: uclamp: add utilization clamping
 for FAIR tasks
Date: Wed, 15 Aug 2018 17:30:43 +0200
Message-ID: <012b7e15-888c-a200-c34b-4fac0f8ab8b9@arm.com>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-6-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180806163946.28380-6-patrick.bellasi@arm.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 08/06/2018 06:39 PM, Patrick Bellasi wrote:

[...]

> +#else /* CONFIG_UCLAMP_TASK */
> +static inline unsigned int uclamp_value(unsigned int cpu, int clamp_id)
> +{
> +	return uclamp_none(clamp_id);
> +}

Looks like that uclamp_value() is not used outside CONFIG_UCLAMP_TASK areas.
