From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
Date: Wed, 6 Jun 2018 18:47:34 +0200
Message-ID: <20180606164734.GC15894@localhost.localdomain>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180521142505.6522-4-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Quentin,

On 21/05/18 15:24, Quentin Perret wrote:

[...]

> +#ifdef CONFIG_ENERGY_MODEL

[...]

> +struct em_data_callback {
> +	/**
> +	 * active_power() - Provide power at the next capacity state of a CPU
> +	 * @power	: Active power at the capacity state (modified)
> +	 * @freq	: Frequency at the capacity state (modified)
> +	 * @cpu		: CPU for which we do this operation
> +	 *
> +	 * active_power() must find the lowest capacity state of 'cpu' above
> +	 * 'freq' and update 'power' and 'freq' to the matching active power
> +	 * and frequency.
> +	 *
> +	 * Return 0 on success.
> +	 */
> +	int (*active_power) (unsigned long *power, unsigned long *freq, int cpu);
> +};

[...]

> +#else
> +struct em_freq_domain;
> +struct em_data_callback;

This doesn't compile for CONFIG_ENERGY_MODEL=n:

drivers/cpufreq/cpufreq-dt.c:164:9: error: variable 'em_cb' has initializer but incomplete type                                                          
  struct em_data_callback em_cb = { &dev_pm_opp_of_estimate_power };                       
           ^~~~~~~~~~~~~~~~

Guess you need some sort of macro to init the struct (w/o introducing
ifdeffery into drivers code)?

Best,

- Juri
