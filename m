From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 2/7] PM / OPP: Mark cpumask as const in
 dev_pm_opp_set_sharing_cpus()
Date: Tue, 3 May 2016 07:27:49 +0530
Message-ID: <20160503015749.GK2855@vireshk-i7>
References: <cover.1461727086.git.viresh.kumar@linaro.org>
 <9a4fef0ecf8329541140de9bb6ccb393b2ec21db.1461727086.git.viresh.kumar@linaro.org>
 <20160503004357.GK3492@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160503004357.GK3492@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 02-05-16, 17:43, Stephen Boyd wrote:
> On 04/27, Viresh Kumar wrote:
> > dev_pm_opp_set_sharing_cpus() isn't supposed to update the cpumask
> > passed as its parameter, and so it should always have been marked
> > 'const'.
> > 
> > Do it now.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> 
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> I'm ignoring cpumask_var_t usage.

Yeah, this is already merged by Rafael and Arnd's patch applies over
it.

-- 
viresh
