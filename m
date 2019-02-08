From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
Date: Fri, 8 Feb 2019 11:00:53 +0000
Message-ID: <20190208110053.GA7913@e107155-lin>
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
 <20190207122227.19873-1-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190207122227.19873-1-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dave Gerlach <d-gerlach@ti.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 07, 2019 at 01:22:25PM +0100, Marek Szyprowski wrote:
> Dear All,
>
> This is a scenario that triggers the above issue:
>

[...]

> 1. system disables non-boot cpu's at the end of system suspend procedure,
> 2. this in turn deinitializes cpufreq drivers for the disabled cpus,
> 3. early in the system resume procedure all cpus are got back to online
>    state,
> 4. this in turn causes cpufreq to be initialized for the newly onlined
>    cpus,
> 5. cpufreq-dt acquires all its resources (clocks, regulators) during
>    ->init() callback,

This is strictly not just restricted to cpufreq-dt, but to any driver
supporting multiple policies. So we need a generic fix not just
cpufreq-dt specific.

--
Regards,
Sudeep
