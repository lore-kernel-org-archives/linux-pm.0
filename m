From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V10] powercap/drivers/idle_inject: Add an idle injection framework
Date: Wed, 04 Jul 2018 12:49:21 +0200
Message-ID: <2148928.GlOskIdrt7@aspire.rjw.lan>
References: <1530010416-30692-1-git-send-email-daniel.lezcano@linaro.org> <20180626110105.qqsrslavtfxuubcm@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180626110105.qqsrslavtfxuubcm@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rui Zhang <rui.zhang@intel.com>, Daniel Thompson <daniel.thompson@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, June 26, 2018 1:01:05 PM CEST Viresh Kumar wrote:
> On 26-06-18, 12:53, Daniel Lezcano wrote:
> > Initially, the cpu_cooling device for ARM was changed by adding a new
> > policy inserting idle cycles. The intel_powerclamp driver does a
> > similar action.
> > 
> > Instead of implementing idle injections privately in the cpu_cooling
> > device, move the idle injection code in a dedicated framework and give
> > the opportunity to other frameworks to make use of it.
> > 
> > The framework relies on the smpboot kthreads which handles via its
> > main loop the common code for hotplugging and [un]parking.
> > 
> > This code was previously tested with the cpu cooling device and went
> > through several iterations. It results now in split code and API
> > exported in the header file. It was tested with the cpu cooling device
> > with success.
> > 
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Cc: Javi Merino <javi.merino@kernel.org>
> > Cc: Leo Yan <leo.yan@linaro.org>
> > Cc: Kevin Wangtao <kevin.wangtao@linaro.org>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Rui Zhang <rui.zhang@intel.com>
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
> > ---
> > 
> > V10:
> >    - Remove set_freezable (Rafael J. Wysocki)
> >    - Reduce the prefixed names 'injection' by 'inject" (Rafael J. Wysocki)
> >    - Rename 'idle_injection_wakeup_fn()' to 'idle_inject_timer_fn()' (Rafael J. Wysocki)
> >    - Shorten label 'out_rollback_per_cpu' to 'out_rollback' (Rafael J. Wysocki)
> 
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

I've applied the patch, but I've rewrittent all of the comments in it.

Daniel, please check the result in linux-next and let me know if you see any
problems.

Thanks,
Rafael
