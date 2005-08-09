From: Ingo Molnar <mingo@elte.hu>
Subject: Re: PowerOP 2/3: Intel Centrino support
Date: Tue, 9 Aug 2005 09:59:19 +0200
Message-ID: <20050809075919.GA18309@elte.hu>
References: <20050809025419.GC25064@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-bounces+glkc-cpufreq=m.gmane.org@lists.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20050809025419.GC25064@slurryseal.ddns.mvista.com>
List-Unsubscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@lists.linux.org.uk>
List-Help: <mailto:cpufreq-request@lists.linux.org.uk?subject=help>
List-Subscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=subscribe>
Sender: cpufreq-bounces@lists.linux.org.uk
Errors-To: cpufreq-bounces+glkc-cpufreq=m.gmane.org@lists.linux.org.uk
To: Todd Poynor <tpoynor@mvista.com>
Cc: cpufreq@lists.linux.org.uk, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


* Todd Poynor <tpoynor@mvista.com> wrote:

> +static int
> +powerop_centrino_get_point(struct powerop_point *point)
> +{
> +	unsigned l, h;
> +	unsigned cpu_freq;
> +
> +	rdmsr(MSR_IA32_PERF_STATUS, l, h);
> +	if (unlikely((cpu_freq = ((l >> 8) & 0xff) * 100) == 0)) {
> +		/*
> +		 * On some CPUs, we can see transient MSR values (which are
> +		 * not present in _PSS), while CPU is doing some automatic
> +		 * P-state transition (like TM2). Get the last freq set 
> +		 * in PERF_CTL.
> +		 */
> +		rdmsr(MSR_IA32_PERF_CTL, l, h);
> +		cpu_freq = ((l >> 8) & 0xff) * 100;
> +	}
> +
> +	point->param[POWEROP_CPU + smp_processor_id()] = cpu_freq;
> +	point->param[POWEROP_V + smp_processor_id()] = ((l & 0xff) * 16) + 700;
> +	return 0;
> +}

doesnt seem to be SMP-safe, nor PREEMPT-safe. You probably want to do 
the locking in the highlevel functions.

	Ingo
