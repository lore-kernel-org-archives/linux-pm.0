From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] clk: tegra: dfll: Properly protect OPP list
Date: Mon, 14 Sep 2015 12:54:05 -0700
Message-ID: <20150914195405.GB21561@codeaurora.org>
References: <1441893321-4563-1-git-send-email-thierry.reding@gmail.com>
 <20150910175144.GB15099@codeaurora.org>
 <20150911023527.GS5266@linux>
 <20150911113531.GA16323@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150911113531.GA16323@ulmo>
Sender: linux-clk-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, Tuomas Tynkkynen <ttynkkynen@nvidia.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09/11, Thierry Reding wrote:
> On Fri, Sep 11, 2015 at 08:05:27AM +0530, Viresh Kumar wrote:
> > On 10-09-15, 10:51, Stephen Boyd wrote:
> > > Don't we already have an rcu_read_lock() at the beginning of this
> > > function? I don't understand why we need to nest them in the same
> > > function.
> > 
> > +1
> 
> My bad, I wasn't looking closely enough. The second hunk can be dropped.
> 

Ok. I applied the first hunk to clk-fixes.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
