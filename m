From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v6 2/7] drivers: cpuidle: implement DT based idle states
 infrastructure
Date: Wed, 23 Jul 2014 18:19:50 +0100
Message-ID: <20140723171950.GA21746@e102568-lin.cambridge.arm.com>
References: <1405958786-17243-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1405958786-17243-3-git-send-email-lorenzo.pieralisi@arm.com>
 <53CFDDD1.5030002@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <53CFDDD1.5030002@linaro.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Tomasz Figa <t.figa@samsung.com>, Chander Kashyap <chander.kashyap@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Nicolas Pitre <nico@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@kernel.org>, Antti Miettinen <ananaza@iki.fi>, Paul Walmsley <paul@pwsan.com>, Geoff Levand <geoff@infradead.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 23, 2014 at 05:07:45PM +0100, Daniel Lezcano wrote:
> On 07/21/2014 06:06 PM, Lorenzo Pieralisi wrote:
> > On most common ARM systems, the low-power states a CPU can be put into are
> > not discoverable in HW and require device tree bindings to describe
> > power down suspend operations and idle states parameters.
> >
> > In order to enable DT based idle states and configure idle drivers, this
> > patch implements the bulk infrastructure required to parse the device tree
> > idle states bindings and initialize the corresponding CPUidle driver states
> > data.
> >
> > The parsing API accepts a start index that defines the first idle state
> > that should be initialized by the parsing code in order to give new and
> > legacy driver flexibility over which states should be parsed using the
> > new DT mechanism.
> >
> > The idle states list is obtained from the first cpu in the driver
> > cpumask, which implicitly means the parsing code expects idle states
> > (and related list of phandles) to be the same for all CPUs in the
> > CPUidle driver mask. The kernel does not check this assumption, it must
> > be enforced by the bootloader to ensure correct system behaviour.
> >
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> This patch looks good for me but I have a couple of questions below.
> 
> > ---
> >   drivers/cpuidle/Kconfig          |   8 +++
> >   drivers/cpuidle/Makefile         |   1 +
> >   drivers/cpuidle/dt_idle_states.c | 138 +++++++++++++++++++++++++++++++++++++++
> >   drivers/cpuidle/dt_idle_states.h |   5 ++
> >   4 files changed, 152 insertions(+)
> >   create mode 100644 drivers/cpuidle/dt_idle_states.c
> >   create mode 100644 drivers/cpuidle/dt_idle_states.h
> >
> > diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> > index 1b96fb9..414e7a96 100644
> > --- a/drivers/cpuidle/Kconfig
> > +++ b/drivers/cpuidle/Kconfig
> > @@ -30,6 +30,14 @@ config CPU_IDLE_GOV_MENU
> >   	bool "Menu governor (for tickless system)"
> >   	default y
> >
> > +config DT_IDLE_STATES
> > +        bool "Idle states DT support"
> > +	depends on ARM || ARM64
> > +	help
> > +	 Allows the CPU idle framework to initialize CPU idle drivers
> > +	 state data by using DT provided nodes compliant with idle states
> > +	 device tree bindings.
> > +
> 
> Wouldn't make sense to make this as an hidden option and let the 
> different drivers to set DT_IDLE_STATES if they depend on it ?

Yes, it would :)

[...]

> > +/**
> > + * dt_init_idle_driver() - Parse the DT idle states and initialize the
> > + *			   idle driver states array
> > + *
> > + * @drv:	  Pointer to CPU idle driver to be initialized
> > + * @start_idx:    First idle state index to be initialized
> > + *
> > + * On success the states array in the cpuidle driver contains
> > + * initialized entries in the states array, starting from index start_idx.
> > + *
> > + * Return:
> > + *	0 on success
> > + *	<0 on failure
> > + */
> > +int dt_init_idle_driver(struct cpuidle_driver *drv, unsigned int start_idx)
> > +{
> > +	unsigned int i, state_idx = start_idx;
> > +	struct cpuidle_state *idle_state;
> > +	struct device_node *state_node, *cpu_node;
> > +
> > +
> > +	if (state_idx >= CPUIDLE_STATE_MAX)
> > +		return -EINVAL;
> > +	/*
> > +	 * We get the idle states for the first logical cpu in the
> > +	 * driver mask. The kernel does not check idle states on all
> > +	 * cpus in the driver mask, they are assumed to be the same
> > +	 * by default.
> > +	 */
> > +	cpu_node = of_cpu_device_node_get(cpumask_first(drv->cpumask));
> > +
> > +	for (i = 0; ; i++) {
> > +		int err;
> > +
> > +		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
> > +		if (!state_node)
> > +			break;
> > +
> > +		if (state_idx == CPUIDLE_STATE_MAX) {
> > +			pr_warn("State index reached static CPU idle driver states array size\n");
> > +			break;
> > +		}
> > +
> > +		idle_state = &drv->states[state_idx++];
> > +		err = init_state_node(idle_state, state_node);
> > +		if (err)
> 
> As the init_state_node error traces are in pr_debug level, a pr_err 
> would help here IMO.

I think I agree, since at this point we have an idle state phandle and
we verified that the node it points at contains invalid bindings, so it is
fair to flag this up.

I will add it.

Thanks !
Lorenzo
