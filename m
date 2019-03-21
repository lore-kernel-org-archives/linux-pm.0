From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v12 3/4] cpuidle: Export the next timer/tick expiration
 for a CPU
Date: Thu, 21 Mar 2019 11:04:08 +0100
Message-ID: <209bb2d7-a7cd-cc27-7d96-35b596b7bab2@linaro.org>
References: <20190227195836.24739-1-ulf.hansson@linaro.org>
 <20190227195836.24739-4-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190227195836.24739-4-ulf.hansson@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 27/02/2019 20:58, Ulf Hansson wrote:
> To be able to predict the sleep duration for a CPU that is entering idle,
> knowing when the next timer/tick is going to expire, is extremely useful.
> Both the teo and the menu cpuidle governors already makes use of this
> information, while selecting an idle state.
> 
> Moving forward, the similar prediction needs to be done, but for a group of
> idle CPUs rather than for a single idle CPU. Following changes implements a
> new genpd governor, which needs this.
> 
> Support this, by sharing a new function called
> tick_nohz_get_next_hrtimer(), which returns the next hrtimer or the next
> tick, whatever that expires first.
> 
> Additionally, when cpuidle is about to invoke the ->enter() callback, then
> call tick_nohz_get_next_hrtimer() and store its return value in the per CPU
> struct cpuidle_device, as to make it available outside cpuidle.
> 
> Do note, at the point when cpuidle calls tick_nohz_get_next_hrtimer(), the
> governor's ->select() callback has already made a decision whether to stop
> the tick or not. In this way, tick_nohz_get_next_hrtimer() actually returns
> the next timer expiration, whatever origin.
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
