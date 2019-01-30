From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/7] cpufreq: dt: Register an Energy Model
Date: Wed, 30 Jan 2019 10:48:06 +0530
Message-ID: <20190130051806.fdsos27jaekkwgbs@vireshk-i7>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-3-quentin.perret@arm.com>
 <20190128193656.GI81583@google.com>
 <20190129052144.plicqu4vozh3l3ss@vireshk-i7>
 <20190129091546.tfh3lo4w4sosfuba@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190129091546.tfh3lo4w4sosfuba@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: Matthias Kaehlcke <mka@chromium.org>, rjw@rjwysocki.net, sudeep.holla@arm.com, liviu.dudau@arm.com, lorenzo.pieralisi@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, nm@ti.com, sboyd@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On 29-01-19, 09:15, Quentin Perret wrote:
> On Tuesday 29 Jan 2019 at 10:51:44 (+0530), Viresh Kumar wrote:
> > On 28-01-19, 11:36, Matthias Kaehlcke wrote:
> > > I think this patch will result in error messages at registration on
> > > platforms that use the cpufreq-dt driver and don't specify
> > > 'dynamic-power-coefficient' for the CPUs in the DT. Not sure if that's
> > > a problem as long as the cpufreq initialization succeeds regardless,
> > > it could be seen as a not-so-gentle nudge to add the values.
> > 
> > That wouldn't be acceptable.
> 
> Fair enough. What I can propose in this case is to have in PM_OPP a
> helper called 'dev_pm_opp_of_register_em()' or something like this. This
> function will check all prerequisites are present (we have the right
> values in DT, and so on) and then call (or not) em_register_perf_domain().
> Then we can make the CPUFreq drivers use that instead of calling
> em_register_perf_domain() directly.

That should be fine.

> That would also make it easy to implement Matthias' suggestion to not
> call em_register_perf_domain() if an EM is already present.

So you will track registration state within the OPP core for that ?
Sorry but that doesn't sound right. What's wrong with having an
unregister helper in energy-model to keep proper code flow everywhere
?

-- 
viresh
