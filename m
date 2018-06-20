From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V9] powercap/drivers/idle_injection: Add an idle
 injection framework
Date: Wed, 20 Jun 2018 10:04:15 +0530
Message-ID: <20180620043415.57yvgzlye4l7wdqy@vireshk-i7>
References: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rui Zhang <rui.zhang@intel.com>, Daniel Thompson <daniel.thompson@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 19-06-18, 15:23, Daniel Lezcano wrote:
> Initially, the cpu_cooling device for ARM was changed by adding a new
> policy inserting idle cycles. The intel_powerclamp driver does a
> similar action.
> 
> Instead of implementing idle injections privately in the cpu_cooling
> device, move the idle injection code in a dedicated framework and give
> the opportunity to other frameworks to make use of it.
> 
> The framework relies on the smpboot kthreads which handles via its
> main loop the common code for hotplugging and [un]parking.
> 
> This code was previously tested with the cpu cooling device and went
> through several iterations. It results now in split code and API
> exported in the header file. It was tested with the cpu cooling device
> with success.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Javi Merino <javi.merino@kernel.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Kevin Wangtao <kevin.wangtao@linaro.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Rui Zhang <rui.zhang@intel.com>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
> ---
> 
> V9:
>    - Unconditionnally reset the should_run flag for all kthreads
>      belonging to the cpumask and remove the park() callback (Viresh Kumar)
>    - Fix up the typos in the comments (Viresh Kumar)

Looks great now. Can't think of any more races :)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
