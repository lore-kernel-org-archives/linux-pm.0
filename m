From: Pavan Kondeti <pkondeti@codeaurora.org>
Subject: Re: [RFC PATCH v3 10/10] arch_topology: Start Energy Aware Scheduling
Date: Tue, 19 Jun 2018 14:48:41 +0530
Message-ID: <20180619091841.GD9208@codeaurora.org>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-11-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180521142505.6522-11-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, May 21, 2018 at 03:25:05PM +0100, Quentin Perret wrote:

<snip>

> +static void start_eas_workfn(struct work_struct *work);
> +static DECLARE_WORK(start_eas_work, start_eas_workfn);
> +
>  static int
>  init_cpu_capacity_callback(struct notifier_block *nb,
>  			   unsigned long val,
> @@ -204,6 +209,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
>  		free_raw_capacity();
>  		pr_debug("cpu_capacity: parsing done\n");
>  		schedule_work(&parsing_done_work);
> +		schedule_work(&start_eas_work);
>  	}
>  
>  	return 0;
> @@ -249,6 +255,19 @@ static void parsing_done_workfn(struct work_struct *work)
>  	free_cpumask_var(cpus_to_visit);
>  }
>  
> +static void start_eas_workfn(struct work_struct *work)
> +{
> +	/* Make sure the EM knows about the updated CPU capacities. */
> +	rcu_read_lock();
> +	em_rescale_cpu_capacity();
> +	rcu_read_unlock();
> +
> +	/* Inform the scheduler about the EM availability. */
> +	cpus_read_lock();
> +	rebuild_sched_domains();
> +	cpus_read_unlock();
> +}

Rebuilding the sched domains is unnecessary for the platform that don't have
energy-model. In fact, we can completely avoid scheduling this work.

There seems to be a sysfs interface exposed by this driver to change cpu_scale.
Should we worry about it? I don't know what is the usecase for changing the
cpu_scale from user space.

Are we expecting that the energy-model is populated by this time? If it is
not, should not we build the sched domains again after the energy-model is
populated?

Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
