From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v4 5/6] drivers: cpuidle: CPU idle ARM64 driver
Date: Thu, 19 Jun 2014 10:30:12 +0100
Message-ID: <20140619093010.GD5401@e102568-lin.cambridge.arm.com>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1402503520-8611-6-git-send-email-lorenzo.pieralisi@arm.com>
 <53A205CE.4080201@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:53081 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757918AbaFSJaT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Jun 2014 05:30:19 -0400
In-Reply-To: <53A205CE.4080201@linaro.org>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@kernel.org>

On Wed, Jun 18, 2014 at 10:34:06PM +0100, Daniel Lezcano wrote:

[...]

> > +/*
> > + * arm_enter_idle_state - Programs CPU to enter the specified state
> > + *
> > + * dev: cpuidle device
> > + * drv: cpuidle driver
> > + * idx: state index
> > + *
> > + * Called from the CPUidle framework to program the device to the
> > + * specified target state selected by the governor.
> > + */
> > +static int arm_enter_idle_state(struct cpuidle_device *dev,
> > +				struct cpuidle_driver *drv, int idx)
> > +{
> > +	int ret;
> > +
> > +	if (!idx) {
> > +		cpu_do_idle();
> > +		return idx;
> > +	}
> > +
> > +	cpu_pm_enter();
> > +	/*
> > +	 * Pass idle state index to cpu_suspend which in turn will call
> > +	 * the CPU ops suspend protocol with idle index as a parameter.
> > +	 *
> > +	 * Some states would not require context to be saved and flushed
> > +	 * to DRAM, so calling cpu_suspend would not be stricly necessary.
> > +	 * When power domains specifications for ARM CPUs are finalized then
> > +	 * this code can be optimized to prevent saving registers if not
> > +	 * needed.
> > +	 */
> > +	ret = cpu_suspend(idx);
> > +
> > +	cpu_pm_exit();
> > +
> > +	return ret ? -1 : idx;
> 
> Is it sure cpu_suspend will return always 0 on success ?

Yes. Now, we have to define "success". On ARM32/64 success means
returning through cpu_resume, which can also happen if a CPU is soft
rebooted following a power down failure. It depends on how the
cpu_suspend back-end behaves on power down failure, if it just returns
or it soft-reboots the CPU. It is an implementation detail, do not think
it is a major problem at the moment.

> > +}
> > +
> > +struct cpuidle_driver arm64_idle_driver = {
> > +	.name = "arm64_idle",
> > +	.owner = THIS_MODULE,
> > +};
> > +
> > +static struct device_node *state_nodes[CPUIDLE_STATE_MAX] __initdata;
> > +
> > +/*
> > + * arm64_idle_init
> > + *
> > + * Registers the arm64 specific cpuidle driver with the cpuidle
> > + * framework. It relies on core code to parse the idle states
> > + * and initialize them using driver data structures accordingly.
> > + */
> > +static int __init arm64_idle_init(void)
> > +{
> > +	int i, ret;
> > +	const char *entry_method;
> > +	struct device_node *idle_states_node;
> > +	const struct cpu_suspend_ops *suspend_init;
> > +	struct cpuidle_driver *drv = &arm64_idle_driver;
> > +
> > +	idle_states_node = of_find_node_by_path("/cpus/idle-states");
> > +	if (!idle_states_node)
> > +		return -ENOENT;
> > +
> > +	if (of_property_read_string(idle_states_node, "entry-method",
> > +				    &entry_method)) {
> > +		pr_warn(" * %s missing entry-method property\n",
> > +			    idle_states_node->full_name);
> > +		of_node_put(idle_states_node);
> > +		ret = -EOPNOTSUPP;
> > +		goto put_node;
> > +	}
> > +
> > +	suspend_init = get_suspend_ops(entry_method);
> > +	if (!suspend_init) {
> > +		pr_warn("Missing suspend initializer\n");
> > +		ret = -EOPNOTSUPP;
> > +		goto put_node;
> > +	}
> > +
> > +	/*
> > +	 * State at index 0 is standby wfi and considered standard
> > +	 * on all ARM platforms. If in some platforms simple wfi
> > +	 * can't be used as "state 0", DT bindings must be implemented
> > +	 * to work around this issue and allow installing a special
> > +	 * handler for idle state index 0.
> > +	 */
> > +	drv->states[0].exit_latency = 1;
> > +	drv->states[0].target_residency = 1;
> > +	drv->states[0].flags = CPUIDLE_FLAG_TIME_VALID;
> > +	strncpy(drv->states[0].name, "ARM WFI", CPUIDLE_NAME_LEN);
> > +	strncpy(drv->states[0].desc, "ARM WFI", CPUIDLE_DESC_LEN);
> 
> Please do not copy the state name and desc strings, they will be 
> converted to 'const char *'.

Ok, I need to sync this code with those changes though.

> > +	drv->cpumask = (struct cpumask *) cpu_possible_mask;
> > +	/*
> > +	 * Start at index 1, request idle state nodes to be filled
> > +	 */
> > +	ret = of_init_idle_driver(drv, state_nodes, 1, true);
> > +	if (ret)
> > +		goto put_node;
> > +
> > +	if (suspend_init->init_fn(drv, state_nodes)) {
> > +		ret = -EOPNOTSUPP;
> > +		goto put_node;
> > +	}
> > +
> > +	for (i = 0; i < drv->state_count; i++)
> > +		drv->states[i].enter = arm_enter_idle_state;
> 
> May be s/arm/arm64/ ?

Well, yes, unless we go for a common arm/arm64 driver (see Rob's email),
with related pros and cons.

Let's make a decision on this asap, I do not think we are that far from
a common solution.

Thanks a lot,
Lorenzo

