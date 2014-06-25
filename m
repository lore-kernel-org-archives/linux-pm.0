From: Geoff Levand <geoff@infradead.org>
Subject: Re: [PATCH v5 5/8] drivers: cpuidle: CPU idle ARM64 driver
Date: Wed, 25 Jun 2014 13:34:23 -0700
Message-ID: <1403728463.11749.52.camel@smoke>
References: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com>
	 <1403705421-17597-6-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:58615 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755531AbaFYUe1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jun 2014 16:34:27 -0400
In-Reply-To: <1403705421-17597-6-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Paul Walmsley <paul@pwsan.com>, Vincent Guittot <vincent.guittot@linaro.org>, Kevin Hilman <khilman@linaro.org>, Nicolas Pitre <nico@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Amit Kucheria <amit.kucheria@linaro.org>, Chander Kashyap <chander.kashyap@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Rob Herring <robh+dt@kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Mark Brown <broonie@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Grant Likely <grant.likely@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Antti Miettinen <ananaza@iki.fi>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm>

Hi Lorenzo,

On Wed, 2014-06-25 at 15:10 +0100, Lorenzo Pieralisi wrote:
> This patch implements a generic CPU idle driver for ARM64 machines.

...

> +typedef int (*suspend_init_fn)(struct cpuidle_driver *,
> +			       struct device_node *[]);
> +
> +struct cpu_suspend_ops {
> +	const char *id;
> +	suspend_init_fn init_fn;
> +};
> +
> +static const struct cpu_suspend_ops suspend_operations[] __initconst = {
> +	{"arm,psci", psci_dt_register_idle_states},
> +	{}

With this we'll have two completely independent mechanisms for
interacting with the cpu ops, this struct cpu_suspend_ops, and the
struct cpu_operations.  This doesn't seem good.

I feel we need to fix the cpu ops to include some way to operate on the
operation method to do initialization, shutdown, etc.  At present,
cpu_operations only has a mechanism to operate on the individual cpus.

-Geoff

