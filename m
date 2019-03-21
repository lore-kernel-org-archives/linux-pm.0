From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v12 4/4] PM / Domains: Add genpd governor for CPUs
Date: Thu, 21 Mar 2019 12:41:39 +0100
Message-ID: <89b2583d-672c-4264-a627-d0b606c3d076@linaro.org>
References: <20190227195836.24739-1-ulf.hansson@linaro.org>
 <20190227195836.24739-5-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190227195836.24739-5-ulf.hansson@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 27/02/2019 20:58, Ulf Hansson wrote:
> As it's now perfectly possible that a PM domain managed by genpd contains
> devices belonging to CPUs, we should start to take into account the
> residency values for the idle states during the state selection process.
> The residency value specifies the minimum duration of time, the CPU or a
> group of CPUs, needs to spend in an idle state to not waste energy entering
> it.
> 
> To deal with this, let's add a new genpd governor, pm_domain_cpu_gov, that
> may be used for a PM domain that have CPU devices attached or if the CPUs
> are attached through subdomains.
> 
> The new governor computes the minimum expected idle duration time for the
> online CPUs being attached to the PM domain and its subdomains. Then in the
> state selection process, trying the deepest state first, it verifies that
> the idle duration time satisfies the state's residency value.
> 
> It should be noted that, when computing the minimum expected idle duration
> time, we use the information about the next timer/tick that is stored in
> the per CPU variable, cpuidle_devices, for the related CPUs. Future wise,
> this deserves to be improved, as there are obviously more reasons to why a
> CPU may be woken up from idle.
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
