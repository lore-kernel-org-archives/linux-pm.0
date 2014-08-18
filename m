From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v7 6/8] drivers: cpuidle: CPU idle ARM64 driver
Date: Mon, 18 Aug 2014 15:21:53 +0100
Message-ID: <20140818142153.GH20043@localhost>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1407945127-27554-7-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1407945127-27554-7-git-send-email-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Tomasz Figa <t.figa@samsung.com>, Lina Iyer <lina.iyer@linaro.org>, Chander Kashyap <k.chander@samsung.com>, Vincent Guittot <vincent.guittot@linaro.org>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@kernel.org>, Antti Miettinen <ananaza@iki.fi>, Paul Walmsley <paul@pwsan.com>, Geoff Levand <geoff@infradead.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>, Amit Kucheria <amit.ku>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 13, 2014 at 04:52:05PM +0100, Lorenzo Pieralisi wrote:
> +static int __init arm64_idle_init(void)
> +{
> +	int i, ret;
> +	struct cpuidle_driver *drv = &arm64_idle_driver;
> +
> +	drv->cpumask = kzalloc(cpumask_size(), GFP_KERNEL);
> +	if (!drv->cpumask)
> +		return -ENOMEM;
> +
> +	cpumask_copy(drv->cpumask, cpu_possible_mask);
> +	/*
> +	 * Initialize idle states data, starting at index 1.
> +	 * This driver is DT only, if no DT idle states are detected (ret == 0)
> +	 * let the driver initialization fail accordingly since there is no
> +	 * reason to initialize the idle driver if only wfi is supported.
> +	 */
> +	ret = dt_init_idle_driver(drv, 1);
> +	if (ret <= 0)
> +		goto free_mem;
> +	/*
> +	 * Call arch CPU operations in order to initialize
> +	 * idle states suspend back-end specific data
> +	 */
> +	for_each_cpu(i, drv->cpumask) {
> +		ret = cpu_init_idle(i);
> +		if (ret)
> +			goto free_mem;
> +	}
> +
> +	for (i = 1; i < drv->state_count; i++)
> +		drv->states[i].enter = arm_enter_idle_state;

BTW, I've seen this pattern a few times already. Do you think it would
be useful to change the dt_init_idle_driver() API to take a function
pointer as argument and populate it there? The only drawback would be if
we want different functions based on the states that have been
populated (not sure whether we'll need the flexibility in the future).
Either way, my ack on this patch stands.

-- 
Catalin
