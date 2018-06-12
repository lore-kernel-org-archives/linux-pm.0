From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V6] powercap/drivers/idle_injection: Add an idle
 injection framework
Date: Tue, 12 Jun 2018 16:23:01 +0200
Message-ID: <20180612142301.GR12217@hirez.programming.kicks-ass.net>
References: <1528804816-32636-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1528804816-32636-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: viresh.kumar@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rui Zhang <rui.zhang@intel.com>, Daniel Thompson <daniel.thompson@linaro.org>, Andrea Parri <andrea.parri@amarulasolutions.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 12, 2018 at 02:00:11PM +0200, Daniel Lezcano wrote:
> +static void idle_injection_last_man(struct idle_injection_device *ii_dev)
> +{
> +	unsigned int run_duration_ms;
> +
> +	run_duration_ms = READ_ONCE(ii_dev->run_duration_ms);
> +	if (run_duration_ms) {
> +		hrtimer_start(&ii_dev->timer, ms_to_ktime(run_duration_ms),
> +			      HRTIMER_MODE_REL_PINNED);

What's the point of PINNED here? AFAICT this gets called from a
different CPU every time.

> +		return;
> +	}
> +
> +	complete(&ii_dev->stop_complete);
> +}
