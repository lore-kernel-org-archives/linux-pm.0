From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 6/7] cpufreq: intel_pstate: Trivial code cleanup
Date: Mon, 09 Jun 2014 14:22:42 -0700
Message-ID: <1402348962.3142.32.camel@joe-AO725>
References: <5396208F.6070400@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5396208F.6070400@semaphore.gr>
Sender: linux-kernel-owner@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2014-06-10 at 00:01 +0300, Stratos Karafotis wrote:
> Remove unnecessary braces.

[]

> @@ -204,20 +203,16 @@ static inline void intel_pstate_busy_pid_reset(struct cpudata *cpu)

>  static inline void intel_pstate_reset_all_pid(void)
>  {
>  	unsigned int cpu;
> -	for_each_online_cpu(cpu) {
> +
> +	for_each_online_cpu(cpu)
>  		if (all_cpu_data[cpu])
>  			intel_pstate_busy_pid_reset(all_cpu_data[cpu]);
> -	}

It's pretty traditional to keep the braces here
as it generally makes it clearer for the reader.

	for (...) {
		if (foo)
			bar();
	}

is generally used over

	for (...)
		if (foo)
			bar();

Just like using

	if (foo) {
		/* commment */
		bar();
	}

> @@ -748,15 +744,14 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
[]
> -	pr_info("Intel pstate controlling: cpu %d\n", cpunum);
> +	pr_info("Intel pstate controlling: CPU %d\n", cpunum);

cpu is very slightly preferred lower case.

$ git grep -E -i '^[^"]*"[^"]*\bcpu\b'|grep -w -i -o cpu | sort |uniq -c | sort -rn
   2705 cpu
   2084 CPU
     17 Cpu
