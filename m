From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 0/8] PM / OPP: Multiple regulator support
Date: Mon, 24 Oct 2016 09:56:59 +0530
Message-ID: <20161024042659.GD24749@vireshk-i7>
References: <cover.1476952750.git.viresh.kumar@linaro.org>
 <CAJZ5v0jNJBDKq+ccHKRA6JGAOXV0qT0-k1mwAcBkCv-7JtzACw@mail.gmail.com>
 <CAKohpon8f-7ppaFsb+wZH4Dj527HXRF73E8taYN9QfcojjJa3g@mail.gmail.com>
 <41a8b4a1-94d3-e086-a328-495f69815d1c@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <41a8b4a1-94d3-e086-a328-495f69815d1c@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 23-10-16, 20:08, Dave Gerlach wrote:
> Overall this series looks good to me apart from a few small things. Most
> importantly I was able to get a working implementation using two regulators
> on ti dra7xx platform with proper sequencing built on top of this series. We
> have cpu regulator and Adaptive body bias (abb) regulator that must be
> scaled in a certain order before or after clock scaling and I was able to
> implement a rough custom set_rate to perform this and ran some dvfs stress
> tests that all worked fine.

Thanks for testing it buddy.

> First comment, I think the platform specific set_rate is a good place to
> hook in for adaptive voltage scaling as well. I was able to implement TI
> Class0 AVS in the same code by using the requested transition voltage as a
> reference and programming AVS voltage using that, along with scaling the
> additional regulators in sequence (the original multi regulator
> functionality). 

Hmm, interesting..

> I would think some people would want to use this even with
> single regulator platforms, no?

Maybe, but I would like to see such user code first. It may be possible to
handle much of AVS stuff in core so that everyone isn't required to do it.

> This raises some concerns about dependencies/probe sequencing. Right now we
> just need to make sure the cpufreq-dt driver probes after we have called
> _set_regulators, but if our platform code fails cpufreq-dt currently will
> treat this as no regulator needed for the platform and operate without one,
> which will likely hang the system. Is there a good way to to guarantee this
> doesn't happen? My main concern is that if we plan to provide a platform
> specific set-rate function, we should have a way to indicate this and
> prevent things from progressing if it isn't yet ready.
> 
> Again, overall I think it solves the multi regulator problem, and it works
> well for AVS as well. For the series:
> 
> Tested-by: Dave Gerlach <d-gerlach@ti.com>

Thanks.

For the concern you shared about, does the below patch fix it ? I will include
that in V3 then.

-------------------------8<-------------------------

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 24 Oct 2016 09:45:30 +0530
Subject: [PATCH] PM / OPP: Don't assume platform doesn't have regulators

If the regulators aren't set explicitly by the platform, the OPP core
assumes that the platform doesn't have any regulator and uses the
clk-only callback.

If the platform failed to register a regulator with the core, then this
can turn out to be a dangerous assumption as the OPP core will try to
change clk without changing regulators.

Handle that properly by making sure that the DT didn't had any entries
for supply voltages as well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index b69908b74ed6..fb4250532180 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -737,7 +737,17 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 
 	/* Only frequency scaling */
 	if (!regulators) {
-		rcu_read_unlock();
+		/*
+		 * DT contained supply ratings? Consider platform failed to set
+		 * regulators.
+		 */
+		if (unlikely(opp->supplies[0].u_volt)) {
+			rcu_read_unlock();
+			dev_err(dev, "%s: Regulator not registered with OPP core\n",
+				__func__);
+			return -EINVAL;
+		}
+
 		return _generic_opp_set_rate_clk_only(dev, clk, old_freq, freq);
 	}
 
-- 
viresh
