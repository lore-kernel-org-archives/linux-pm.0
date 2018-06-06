From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V5] powercap/drivers/idle_injection: Add an idle
 injection framework
Date: Wed, 6 Jun 2018 14:23:57 +0200
Message-ID: <20180606122357.GN12258@hirez.programming.kicks-ass.net>
References: <1528190208-22915-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1528190208-22915-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rui Zhang <rui.zhang@intel.com>, Daniel Thompson <daniel.thompson@linaro.org>, "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 05, 2018 at 11:16:40AM +0200, Daniel Lezcano wrote:
> +	atomic_t idle_duration_ms;
> +	atomic_t run_duration_ms;

> +	idle_duration_ms = atomic_read(&ii_dev->idle_duration_ms);

> +	run_duration_ms = atomic_read(&ii_dev->run_duration_ms);

> +	atomic_set(&ii_dev->run_duration_ms, run_duration_ms);
> +	atomic_set(&ii_dev->idle_duration_ms, idle_duration_ms);

> +	*run_duration_ms = atomic_read(&ii_dev->run_duration_ms);
> +	*idle_duration_ms = atomic_read(&ii_dev->idle_duration_ms);

> +	if (!atomic_read(&ii_dev->idle_duration_ms))

> +	if (!atomic_read(&ii_dev->run_duration_ms))

What is the point of atomic_t here ?!
