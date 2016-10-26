From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 7/8] PM / OPP: Allow platform specific custom
 opp_set_rate() callbacks
Date: Wed, 26 Oct 2016 11:37:43 +0530
Message-ID: <20161026060743.GK9162@vireshk-i7>
References: <cover.1476952750.git.viresh.kumar@linaro.org>
 <4786e1f0958441b03e6d91ce21817898574c45ed.1476952750.git.viresh.kumar@linaro.org>
 <20161025190114.GV26139@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161025190114.GV26139@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, Viresh Kumar <vireshk@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org

On 25-10-16, 12:01, Stephen Boyd wrote:
> On 10/20, Viresh Kumar wrote:
> > The generic opp_set_rate() handler isn't sufficient for platforms with
> > complex DVFS.  For example, some TI platforms have multiple regulators
> > for a CPU device. The order in which various supplies need to be
> > programmed is only known to the platform code and its best to leave it
> > to it.
> > 
> > This patch implements APIs to register platform specific opp_set_rate()
> > callback.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> 
> Overall it looks ok, but I'd prefer set_opp instead of set_rate.

Done.

-- 
viresh
