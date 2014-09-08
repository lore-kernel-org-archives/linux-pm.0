From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v9 6/8] drivers: cpuidle: CPU idle ARM64 driver
Date: Mon, 8 Sep 2014 17:08:39 +0100
Message-ID: <20140908160838.GA13778@arm.com>
References: <1409938498-17984-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1409938498-17984-7-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from [217.140.108.86] ([217.140.108.86]:60838 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751882AbaIJQYD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Sep 2014 12:24:03 -0400
Content-Disposition: inline
In-Reply-To: <1409938498-17984-7-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Will Deacon <Will.Deacon@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@kernel.o>

On Fri, Sep 05, 2014 at 06:34:55PM +0100, Lorenzo Pieralisi wrote:
> This patch implements a generic CPU idle driver for ARM64 machines.
> 
> It relies on the DT idle states infrastructure to initialize idle
> states count and respective parameters. Current code assumes the driver
> is managing idle states on all possible CPUs but can be easily
> generalized to support heterogenous systems and build cpumasks at
> runtime using MIDRs or DT cpu nodes compatible properties.
> 
> The driver relies on the arm64 CPU operations to call the idle
> initialization hook used to parse and save suspend back-end specific
> idle states information upon probing.
> 
> Idle state index 0 is always initialized as a simple wfi state, ie always
> considered present and functional on all ARM64 platforms.
> 
> Idle state indices higher than 0 trigger idle state entry by calling
> the cpu_suspend function, that triggers the suspend operation through
> the CPU operations suspend back-end hook. cpu_suspend passes the idle
> state index as a parameter so that the CPU operations suspend back-end
> can retrieve the required idle state data by using the idle state
> index to execute a look-up on its internal data structures.
> 
> Reviewed-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  drivers/cpuidle/Kconfig         |   5 ++
>  drivers/cpuidle/Kconfig.arm64   |  14 +++++
>  drivers/cpuidle/Makefile        |   4 ++
>  drivers/cpuidle/cpuidle-arm64.c | 133 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 156 insertions(+)
>  create mode 100644 drivers/cpuidle/Kconfig.arm64
>  create mode 100644 drivers/cpuidle/cpuidle-arm64.c

Daniel, do you have any preference for how this patch should go in? You
can either ack it so that I can take it via the arm64 tree or you take
it separately (though it doesn't make sense on its own without the arm64
infrastructure in place, we need a bit of synchronisation but it's not
something difficult).

Thanks.

-- 
Catalin
