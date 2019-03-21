From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v12 2/4] PM / Domains: Add support for CPU devices to
 genpd
Date: Thu, 21 Mar 2019 10:54:15 +0100
Message-ID: <3ceca6d2-c780-49e4-5c90-566a7e8433ce@linaro.org>
References: <20190227195836.24739-1-ulf.hansson@linaro.org>
 <20190227195836.24739-3-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190227195836.24739-3-ulf.hansson@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 27/02/2019 20:58, Ulf Hansson wrote:
> To enable a device belonging to a CPU to be attached to a PM domain managed
> by genpd, let's do a few changes to it, as to make it convenient to manage
> the specifics around CPUs.
> 
> To be able to quickly find out what CPUs that are attached to a genpd,
> which typically becomes useful from a genpd governor as following changes
> is about to show, let's add a cpumask to the struct generic_pm_domain. At
> the point when a CPU device gets attached to a genpd, let's update the
> genpd's cpumask. Moreover, let's also propagate changes to the cpumask
> upwards in the topology to the master PM domains. In this way, the cpumask
> for a genpd hierarchically reflects all CPUs attached to the topology below
> it.
> 
> Finally, let's make this an opt-in feature, to avoid having to manage CPUs
> and the cpumask for a genpd that doesn't need it. For that reason, let's
> add a new genpd configuration bit, GENPD_FLAG_CPU_DOMAIN.
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
