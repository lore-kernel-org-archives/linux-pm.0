From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: trace frequency limits change
Date: Mon, 23 Jul 2018 08:31:27 +0530
Message-ID: <20180723030127.7v5aymf246gfsf5x@vireshk-i7>
References: <20180720222114.200311-1-joel@joelfernandes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180720222114.200311-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, Ruchi Kandoi <kandoiruchi@google.com>, Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-pm@vger.kernel.org

On 20-07-18, 15:21, Joel Fernandes wrote:
> From: Ruchi Kandoi <kandoiruchi@google.com>
> 
> systrace used for tracing for Android systems has carried a patch for
> many years in the Android tree that traces when the cpufreq limits
> change.  With the help of this information, systrace can know when the
> policy limits change and can visually display the data. Lets add
> upstream support for the same.
> 
> Signed-off-by: Ruchi Kandoi <kandoiruchi@google.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> v1->v2: Minor changes suggested by Viresh
> 
>  Documentation/trace/events-power.rst |  1 +
>  drivers/cpufreq/cpufreq.c            |  1 +
>  include/trace/events/power.h         | 25 +++++++++++++++++++++++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/Documentation/trace/events-power.rst b/Documentation/trace/events-power.rst
> index a77daca75e30..2ef318962e29 100644
> --- a/Documentation/trace/events-power.rst
> +++ b/Documentation/trace/events-power.rst
> @@ -27,6 +27,7 @@ cpufreq.
>  
>    cpu_idle		"state=%lu cpu_id=%lu"
>    cpu_frequency		"state=%lu cpu_id=%lu"
> +  cpu_frequency_limits	"min=%lu max=%lu cpu_id=%lu"
>  
>  A suspend event is used to indicate the system going in and out of the
>  suspend mode:
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index b0dfd3222013..4fd935df101e 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2236,6 +2236,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>  
>  	policy->min = new_policy->min;
>  	policy->max = new_policy->max;
> +	trace_cpu_frequency_limits(policy->min, policy->max, policy->cpu);
>  
>  	policy->cached_target_freq = UINT_MAX;
>  
> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> index 908977d69783..f5bec45108b6 100644
> --- a/include/trace/events/power.h
> +++ b/include/trace/events/power.h
> @@ -148,6 +148,31 @@ DEFINE_EVENT(cpu, cpu_frequency,
>  	TP_ARGS(frequency, cpu_id)
>  );
>  
> +TRACE_EVENT(cpu_frequency_limits,
> +
> +	TP_PROTO(unsigned int min_freq, unsigned int max_freq,
> +		unsigned int cpu_id),
> +
> +	TP_ARGS(min_freq, max_freq, cpu_id),
> +
> +	TP_STRUCT__entry(
> +		__field(u32, min_freq)
> +		__field(u32, max_freq)
> +		__field(u32, cpu_id)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->min_freq = min_freq;
> +		__entry->max_freq = max_freq;
> +		__entry->cpu_id = cpu_id;
> +	),
> +
> +	TP_printk("min=%lu max=%lu cpu_id=%lu",
> +		  (unsigned long)__entry->min_freq,
> +		  (unsigned long)__entry->max_freq,
> +		  (unsigned long)__entry->cpu_id)
> +);
> +
>  TRACE_EVENT(device_pm_callback_start,
>  
>  	TP_PROTO(struct device *dev, const char *pm_ops, int event),

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
